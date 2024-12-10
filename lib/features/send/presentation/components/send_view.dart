import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:mafuriko/core/constant_secret.dart';
import 'package:mafuriko/features/home/presentation/cubit/navigation_cubit.dart';
import 'package:mafuriko/features/home/presentation/screens/home_screen.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:mafuriko/features/authentication/presentation/blocs/bloc/auth_bloc.dart';
import 'package:mafuriko/features/maps/presentation/bloc/map_bloc.dart';
import 'package:mafuriko/features/send/presentation/bloc/alert_bloc.dart';
import 'package:mafuriko/features/send/presentation/widgets/button_fields.dart';
import 'package:mafuriko/features/send/presentation/widgets/time_picker.dart';
import 'package:mafuriko/features/send/presentation/widgets/upload_card.dart';
import 'package:mafuriko/gen/gen.dart';
import 'package:mafuriko/shared/helpers/image_pick_helper.dart';
import 'package:mafuriko/shared/widgets/app_form_field.dart';
import 'package:mafuriko/shared/widgets/buttons.dart';
import 'package:mafuriko/shared/widgets/pop_up.dart';
import 'package:weather/weather.dart';

class SendView extends StatefulWidget {
  const SendView({super.key});

  @override
  State<SendView> createState() => _SendViewState();
}

class _SendViewState extends State<SendView> {
  DateTime? _selectedDay;
  DateTime? _selectedHour;

  String weather = "";
  String temp = "";

  final WeatherFactory _wf =
      WeatherFactory(Secrets.weatherKey, language: Language.FRENCH);

  final List<String> categories = [
    'Inondation',
    // 'Effondrement',
    // 'Eboulement',
    // 'Montée d\'eau',
  ];

  String? selectedCategory = 'Inondation';
  final FocusNode _localizationFocus = FocusNode();
  final TextEditingController _localizationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final FocusNode _descriptionFocus = FocusNode();

  final FilesPicker picker = FilesPicker();
  XFile? image;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final position = context.read<MapBloc>().state.position;
    if (position != null) {
      _wf.currentWeatherByLocation(position.latitude, position.longitude).then(
        (value) {
          setState(() {
            temp = '${value.temperature?.celsius?.roundToDouble()}';
            weather = value.weatherDescription.toString();
          });
          print(
              "weather fetched: ${value.temperature?.celsius?.roundToDouble()}");
          print("weather fetched: ${value.weatherDescription}");
        },
      );
    }

    _selectedDay = DateTime.now();
    _selectedHour = DateTime.now();
  }

  @override
  void dispose() {
    _localizationController.dispose();
    _descriptionController.dispose();
    _localizationFocus.dispose();
    _descriptionFocus.dispose();

    super.dispose();
  }

  DateTime? hour;
  void _showHourPicker(BuildContext context) {
    showDialog(
      // barrierColor: Colors.transparent,
      context: context,
      builder: (context) => Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 24.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(11.r),
          side: const BorderSide(color: Color(0xFF8B8B8B)),
        ),
        clipBehavior: Clip.hardEdge,
        child: Container(
          width: 330.w,
          height: 352.89.h,
          color: AppColor.red,
          child: CustomHourPicker(
            hour: _selectedHour?.hour ?? DateTime.now().hour,
            minute: _selectedHour?.minute ?? DateTime.now().minute,
            onSaved: () {
              // if (_selectedHour == null) {
              //   // Si aucune heure n'est sélectionnée, on prend l'heure actuelle
              //   setState(() {
              //     _selectedHour = DateTime.now();
              //   });
              // }

              // Fermer le picker et passer la valeur de l'heure sélectionnée (ou actuelle)
              setState(() {
                _selectedHour = hour ?? DateTime.now();
              });
              Navigator.pop(context, _selectedHour);
            },
            onCancelled: () {
              setState(() {
                _selectedHour;
              });
              Navigator.pop(context, _selectedHour);
            },
            hourChanged: (val) {
              // setState(() {
              hour = DateTime(
                _selectedDay?.year ?? DateTime.now().year,
                _selectedDay?.month ?? DateTime.now().month,
                _selectedDay?.day ?? DateTime.now().day,
                val,
                _selectedHour?.minute ?? DateTime.now().minute,
              );
              // });
            },
            minuteChanged: (val) {
              // setState(() {
              hour = DateTime(
                _selectedDay?.year ?? DateTime.now().year,
                _selectedDay?.month ?? DateTime.now().month,
                _selectedDay?.day ?? DateTime.now().day,
                _selectedHour?.hour ?? DateTime.now().hour,
                val,
              );
              // });
            },
          ),
        ),
      ),
    );
  }

  DateTime? date;
  void _showDatePicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 24.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Container(
            padding: EdgeInsets.all(16.w),
            width: 320.w,
            child: CustomDatePicker(
              onSaved: () {
                // if (_selectedDay == null) {
                //   setState(() {
                //     _selectedDay = DateTime.now();
                //   });
                //   // Navigator.pop(context, _selectedDay);
                // }
                setState(() {
                  _selectedDay = date ?? DateTime.now();
                });
                Navigator.pop(context, _selectedDay);
              },
              selectedDay: _selectedDay ?? DateTime.now(),
              onDaySelected: (selectedDay, focusedDay) {
                if (!isSameDay(_selectedDay, selectedDay)) {
                  date = selectedDay;
                  // _selectedDay = date;
                  // setState(() {});
                  // Navigator.pop(context, _selectedDay);
                }
              },
            ),
          ),
        );
      },
    );
  }

  bool isValid() {
    return _localizationController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AlertBloc, AlertState>(
      listener: (context, state) {
        if (state is SuccessAlert && state.reqType == AlertReq.sendAlert) {
          PopUp.successAlertSend(
            context,
            title: 'Réussi',
            description:
                'Données chargées avec succès. Revenir à la page de données',
            action: () {
              // _descriptionController.clear();
              // selectedCategory = null;
              // image = null;
              // setState(() {});
              // Navigator.pop(context);
              //context.read<NavigationCubit>().updateIndex(0);
            },
          );
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: SingleChildScrollView(
          clipBehavior: Clip.none,
          child: Column(
            children: [
              SizedBox(height: 32.h),
              BlocBuilder<MapBloc, MapState>(
                builder: (context, state) {
                  if (state is MapLoading) {
                    return AppFormField(
                      label: 'Localisation',
                      hint: 'Cocodie, Abidjan',
                      focus: _localizationFocus..unfocus(),
                      controller: _localizationController
                        ..text = 'localisation loading...',
                      onValidate: (val) {
                        if (val != null && val.isEmpty) {
                          return "Veuillez remplir ce champ";
                        }
                        return null;
                      },
                    );
                  } else if (state is MapError) {
                    return AppFormField(
                        label: 'Localisation',
                        hint: 'Cocodie, Abidjan',
                        focus: _localizationFocus..unfocus(),
                        controller: _localizationController
                          ..text = state.message,
                        onValidate: (val) {
                          if (val != null && val.isEmpty) {
                            return "Veuillez remplir ce champ";
                          }
                          return null;
                        });
                  }
                  return AppFormField(
                      label: 'Localisation',
                      hint: 'Cocodie, Abidjan',
                      focus: _localizationFocus..unfocus(),
                      controller: _localizationController
                        ..text = '${state.place?[2].name}',
                      onValidate: (val) {
                        if (val != null && val.isEmpty) {
                          return "Veuillez remplir ce champ";
                        }
                        return null;
                      });
                },
              ),
              AppFormFieldDescription(
                controller: _descriptionController,
                focus: _descriptionFocus,
                label: 'Description de l’inondation',
                hint: 'Décrire l’inondation et le contexte approprié',
              ),
              CustomDropdownButtonField(
                title: 'Choisir une catégorie',
                hint: 'Choisir une catégorie',
                val: selectedCategory,
                items: categories
                    .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: TextStyle(
                              fontSize: 14.sp,
                            ),
                          ),
                        ))
                    .toList(),
                validator: (value) {
                  if (value == null) {
                    return 'veuillez s\'il vous plaît choisir une catégorie';
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    selectedCategory = value.toString();
                  });
                },
              ),
              SizedBox(height: 24.h),
              PopActionButtonField(
                title: 'Date',
                value: _selectedDay == null
                    ? ''
                    : DateFormat('dd MMMM yyyy', 'fr').format(_selectedDay!),
                hint: 'sélectionner la date',
                onTap: () => _showDatePicker(context),
              ),
              SizedBox(height: 24.h),
              PopActionButtonField(
                title: "L'heure",
                value: _selectedHour == null
                    ? ''
                    : DateFormat("HH'H'mm", 'fr').format(_selectedHour!),
                hint: 'sélectionner la date',
                onTap: () => _showHourPicker(context),
              ),
              SizedBox(height: 24.h),
              UploaderImageCard(
                image: image,
                onTap: () async {
                  final data = await picker.fromCamera();

                  setState(() {
                    image = data;
                  });
                },
              ),
              SizedBox(height: 45.h),
              BlocBuilder<MapBloc, MapState>(
                builder: (context, mapState) {
                  return BlocBuilder<AlertBloc, AlertState>(
                    builder: (context, state) {
                      if (state is AlertLoading) {
                        return Center(
                          child: SizedBox(
                            width: 30.w,
                            height: 30.h,
                            child: const CircularProgressIndicator(),
                          ),
                        );
                      }
                      final uid =
                          (context.watch<AuthBloc>().state as AuthSuccess)
                              .user
                              .id;
                      return PrimaryExpandedButton(
                        title: 'Envoyer',
                        onTap: () {
                          if (_localizationController.text.isNotEmpty) {
                            print({
                              'weather': weather,
                              'temperature': temp,
                            });
                            needInternet(() {
                              context.read<AlertBloc>().add(
                                    PostAlert(
                                      uid: uid.toString(),
                                      sceneName:
                                          _localizationController.text.trim(),
                                      floodLocation: LatLng(
                                          mapState.position!.latitude,
                                          mapState.position!.longitude),
                                      floodDescription:
                                          _descriptionController.text.trim(),
                                      floodIntensity: 'forte',
                                      category:
                                          selectedCategory ?? 'Inondation',
                                      floodImage: image,
                                      weather: weather,
                                      temperature: temp,
                                    ),
                                  );
                            });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'Formulaire invalide. Veuillez saisir la localisation et la catégorie')),
                            );
                          }
                        },
                      );
                    },
                  );
                },
              ),
              SizedBox(height: 47.h),
            ],
          ),
        ),
      ),
    );
  }
}
