import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:mafuriko/features/send/presentation/widgets/time_picker.dart';
import 'package:mafuriko/gen/gen.dart';
import 'package:mafuriko/shared/helpers/image_pick_helper.dart';
import 'package:mafuriko/shared/widgets/pop_up.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:mafuriko/features/maps/presentation/bloc/map_bloc.dart';
import 'package:mafuriko/features/send/presentation/bloc/alert_bloc.dart';
import 'package:mafuriko/features/send/presentation/widgets/button_fields.dart';
import 'package:mafuriko/features/send/presentation/widgets/upload_card.dart';
import 'package:mafuriko/shared/widgets/app_form_field.dart';
import 'package:mafuriko/shared/widgets/buttons.dart';

class SendView extends StatefulWidget {
  const SendView({super.key});

  @override
  State<SendView> createState() => _SendViewState();
}

class _SendViewState extends State<SendView> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  late DateTime _toDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  final List<String> categories = [
    'Inondation',
    'Effondrement',
    'Eboulement',
    'Montée d\'eau',
  ];

  String? selectedCategory;

  final FocusNode _localizationFocus = FocusNode();
  final TextEditingController _localizationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final FocusNode _descriptionFocus = FocusNode();

  final FilesPicker picker = FilesPicker();
  XFile? image;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _toDay = DateTime.now();
  }

  @override
  void dispose() {
    _localizationController.dispose();
    _descriptionController.dispose();
    _localizationFocus.dispose();
    _descriptionFocus.dispose();

    super.dispose();
  }

  void _showHourPicker(BuildContext context) {
    showDialog(
      barrierColor: Colors.transparent,
      context: context,
      builder: (context) => Center(
        child: Container(
          width: 330.w,
          height: 332.89.h,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: AppColor.white,
            border: Border.all(color: const Color(0xFF8B8B8B)),
            borderRadius: BorderRadius.circular(11.r),
          ),
          child: NumberPage(
            hour: _toDay.hour,
            minute: _toDay.minute,
            hourChanged: (val) {
              setState(() {
                _toDay.copyWith(hour: val);
              });
            },
            minuteChanged: (val) {
              setState(() {
                _toDay.copyWith(minute: val);
              });
            },
          ),
        ),
      ),
    );
  }

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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TableCalendar(
                  firstDay: DateTime.utc(2000, 1, 1),
                  lastDay: DateTime.utc(2024, 12, 31),
                  focusedDay: _focusedDay,
                  locale: 'fr',
                  rowHeight: 38.h,
                  calendarFormat: _calendarFormat,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  onDaySelected: (selectedDay, focusedDay) {
                    if (!isSameDay(_selectedDay, selectedDay)) {
                      setState(() {
                        _focusedDay = focusedDay;
                        _selectedDay = selectedDay;
                      });
                    }
                  },
                  onPageChanged: (focusedDay) => _focusedDay = focusedDay,
                  calendarStyle: CalendarStyle(
                    todayDecoration: BoxDecoration(
                      color: const Color(0xFFF8E9DD),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(5.r),
                      border: Border.all(color: Colors.brown, width: 1.5.w),
                    ),
                    selectedDecoration: BoxDecoration(
                      color: Colors.brown,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                    todayTextStyle: const TextStyle(
                      color: Colors.brown,
                    ),
                    cellMargin: EdgeInsets.zero,
                    cellPadding: EdgeInsets.zero,
                    tablePadding: EdgeInsets.zero,
                  ),
                  headerStyle: const HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                  ),
                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Annuler',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 143.21.w,
                      child: PrimaryExpandedButton(
                        onTap: () {
                          Navigator.pop(context, _selectedDay);
                        },
                        title: 'Choisir une date',
                      ),
                    ),
                  ],
                ),
              ],
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
        if (state is SuccessAlert) {
          PopUp.successAlertSend(
            context,
            title: 'Réussi',
            description:
                'Données chargées avec succès. Revenir à la page de données',
            action: () {
              _descriptionController.clear();
              selectedCategory = null;
              image = null;
              setState(() {});
              context.pop();
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
                    );
                  } else if (state is MapError) {
                    return AppFormField(
                      label: 'Localisation',
                      hint: 'Cocodie, Abidjan',
                      focus: _localizationFocus..unfocus(),
                      controller: _localizationController
                        ..text = '${state.message}',
                    );
                  }
                  return AppFormField(
                    label: 'Localisation',
                    hint: 'Cocodie, Abidjan',
                    focus: _localizationFocus..unfocus(),
                    controller: _localizationController
                      ..text = '${state.place?[2].name}',
                  );
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
                value: DateFormat('dd MMMM yyyy', 'fr').format(_selectedDay),
                hint: 'sélectionner la date',
                onTap: () => _showDatePicker(context),
              ),
              SizedBox(height: 24.h),
              PopActionButtonField(
                title: "L'heure",
                value: DateFormat("hh'H'mm", 'fr').format(_toDay),
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
                      return PrimaryExpandedButton(
                        title: 'Envoyer',
                        onTap: () {
                          context.read<AlertBloc>().add(
                                PostAlert(
                                  sceneName:
                                      _localizationController.text.trim(),
                                  floodLocation: LatLng(
                                      mapState.position!.latitude,
                                      mapState.position!.longitude),
                                  floodDescription:
                                      _descriptionController.text.trim(),
                                  floodIntensity: 'forte',
                                  category: selectedCategory ?? 'Inondation',
                                  floodImage: image,
                                ),
                              );
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
