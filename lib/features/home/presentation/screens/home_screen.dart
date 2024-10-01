import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import 'package:mafuriko/features/home/presentation/components/home_sections.dart';
import 'package:mafuriko/features/home/presentation/widgets/home_widget.dart';
import 'package:mafuriko/features/maps/presentation/bloc/map_bloc.dart';
import 'package:mafuriko/features/send/presentation/bloc/alert_bloc.dart';
import 'package:mafuriko/gen/colors.gen.dart';
import 'package:mafuriko/shared/helpers/network_info.dart';

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

    _connectionSubscription = net.onStatusChange.listen((status) {
      if (_previousStatus != status && _previousStatus != null) {
        // Afficher le SnackBar seulement si l'état a changé
        if (status == InternetStatus.connected) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.r)),
                ),
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.fromLTRB(8.w, 0, 8.w, 12.h),
                backgroundColor: Colors.green[300],
                content: const Text(
                  'Vous êtes de nouveau connecté',
                  style: TextStyle(
                    color: AppColor.white,
                  ),
                ),
              ),
            );
          }

          // Si connecté, déclencher les événements des Blocs
          final mapBloc = context.read<MapBloc>();
          final alertBloc = context.read<AlertBloc>();

          if (!mapBloc.isClosed && mapBloc.state.position == null) {
            mapBloc.add(LoadUserLocationEvent());
          }

          if (alertBloc.state.alerts.isEmpty) {
            alertBloc.add(const FetchAlerts());
          }
        } else {
          // Gérer l'absence de connexion Internet ici
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.r)),
                ),
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.fromLTRB(8.w, 0, 8.w, 12.h),
                backgroundColor: Colors.redAccent,
                content: const Text('Pas de connexion Internet'),
              ),
            );
          }
        }

        // Mettre à jour l'état de connexion précédent
        _previousStatus = status;
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _connectionSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          controller: _scrollController,
          // physics: FixedExtentScrollPhysics(),
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
                    const ActuSection(),
                    SizedBox(height: 32.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
