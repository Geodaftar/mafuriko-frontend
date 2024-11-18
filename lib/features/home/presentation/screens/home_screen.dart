import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import 'package:mafuriko/features/home/presentation/components/home_sections.dart';
import 'package:mafuriko/features/home/presentation/widgets/home_widget.dart';
import 'package:mafuriko/features/maps/presentation/bloc/map_bloc.dart';
import 'package:mafuriko/features/send/presentation/bloc/alert_bloc.dart';
import 'package:mafuriko/gen/colors.gen.dart';
import 'package:mafuriko/shared/helpers/network_info.dart';
// import 'package:nb_utils/nb_utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  late final NetworkInfoImpl net;
  StreamSubscription<InternetStatus>? _connectionSubscription;

  InternetStatus? _previousStatus = InternetStatus.connected;

  @override
  void initState() {
    super.initState();

    // Initialiser la vérification de la connexion réseau
    net = NetworkInfoImpl(InternetConnection());
    final alertBloc = context.read<AlertBloc>();

    // needInternet(() {
    //   alertBloc.add(const FetchAlerts());
    // });

    final mapBloc = context.read<MapBloc>();
    if (!mapBloc.isClosed && mapBloc.state.position == null) {
      mapBloc.add(LoadUserLocationEvent());
    }
    net.isConnected.then((isConnected) {
      final alertBloc = context.read<AlertBloc>();
      if (isConnected && alertBloc.state.alerts.isEmpty) {
        // Si connecté, effectuer un appel FetchAlerts

        alertBloc.add(const FetchAlerts());
      } else if (!isConnected) {
        alertBloc.add(const FetchAlerts());
      }
    });

    _connectionSubscription = net.onStatusChange.listen((status) {
      if (_previousStatus != status && _previousStatus != null) {
        // Afficher le SnackBar seulement si l'état a changé
        if (status == InternetStatus.connected) {
          // if (mounted) {
          //   showDialog(
          //     context: context,
          //     builder: (context) {
          //       WidgetsBinding.instance.addPostFrameCallback((_) {
          //         Future.delayed(const Duration(milliseconds: 1300), () {
          //           if (Navigator.of(context).canPop()) {
          //             Navigator.of(context).pop(); // Ferme la boîte de dialogue
          //           }
          //         });
          //       });
          //       return AlertDialog(
          //         icon: CircleAvatar(
          //           radius: 25,
          //           child: Icon(
          //             Icons.wifi_rounded,
          //             color: Colors.green[300],
          //           ),
          //         ),
          //         content: const Column(
          //           mainAxisSize: MainAxisSize.min,
          //           children: [
          //             Text(
          //               'Vous êtes de nouveau connecté',
          //               style: TextStyle(
          //                   // color: AppColor.white,
          //                   ),
          //             ),
          //           ],
          //         ),
          //       );
          //     },
          //   );

          // showSnackBar(
          //   SnackBar(
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.all(Radius.circular(8.r)),
          //     ),
          //     behavior: SnackBarBehavior.floating,
          //     margin: EdgeInsets.fromLTRB(8.w, 0, 8.w, 12.h),
          //     backgroundColor: Colors.green[300],
          // content: const Text(
          //   'Vous êtes de nouveau connecté',
          //   style: TextStyle(
          //     color: AppColor.white,
          //   ),
          // ),
          //   ),
          // );
          // }

          // Si connecté, déclencher les événements des Blocs
          final alertBloc = context.read<AlertBloc>();

          if (alertBloc.state.alerts.isEmpty) {
            alertBloc.add(const FetchAlerts());
          }
        } else {
          needInternet(() {
            alertBloc.add(const FetchAlerts());
          });
          // Gérer l'absence de connexion Internet ici
          // if (mounted) {
          // showDialog(
          //   context: context,
          //   builder: (context) {
          //     WidgetsBinding.instance.addPostFrameCallback((_) {
          //       Future.delayed(const Duration(milliseconds: 1300), () {
          //         if (Navigator.of(context).canPop()) {
          //           Navigator.of(context).pop(); // Ferme la boîte de dialogue
          //         }
          //       });
          //     });
          //     return AlertDialog(
          //       icon: CircleAvatar(
          //         radius: 25,
          //         child: Icon(
          //           Icons.wifi_off_rounded,
          //           color: Colors.red[400],
          //         ),
          //       ),
          //       content: const Column(
          //         mainAxisSize: MainAxisSize.min,
          //         children: [
          //           Text(
          //             'Pas de connexion Internet',
          //             style: TextStyle(
          //                 // color: AppColor.white,
          //                 ),
          //           ),
          //         ],
          //       ),
          //     );
          //   },
          // );

          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.all(Radius.circular(8.r)),
          //     ),
          //     behavior: SnackBarBehavior.floating,
          //     margin: EdgeInsets.fromLTRB(8.w, 0, 8.w, 12.h),
          //     backgroundColor: Colors.redAccent,
          //     content: const Text('Pas de connexion Internet'),
          //   ),
          // );
          // }
        }

        // Mettre à jour l'état de connexion précédent
        _previousStatus = status;
      }
    });
  }

  @override
  void dispose() {
    _connectionSubscription?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          color: AppColor.primary,
          onRefresh: () async {
            await Future.delayed(
              const Duration(milliseconds: 2500),
              () {
                context.read<AlertBloc>().add(const FetchAlerts());
              },
            );
            return;
          },
          child: CustomScrollView(
            controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              const HomeAppBar(),
              SliverPadding(
                padding: EdgeInsets.only(left: 18.w),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    children: [
                      const ReportCount(),
                      const MapSection(),
                      const AlertsSection(),
                      // const ActuSection(),
                      SizedBox(height: 32.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void needInternet(VoidCallback action, {VoidCallback? failedAction}) async {
  var r = await NetworkInfoImpl(InternetConnection()).isConnected;
  if (r) {
    action();
  } else {
    // EasyLoading.dismiss();
    if (failedAction != null) {
      failedAction();
    }
    EasyLoading.showToast("Vérifiez votre connexion internet",
        toastPosition: EasyLoadingToastPosition.center);
    // EasyLoading.dismiss();
  }
}
