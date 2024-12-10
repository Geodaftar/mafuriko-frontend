import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:mafuriko/core/routes/constant_path.dart';
import 'package:mafuriko/features/home/presentation/widgets/cards.dart';
import 'package:mafuriko/features/send/domain/entities/alert_entity.dart';
import 'package:mafuriko/features/send/presentation/bloc/alert_bloc.dart';
import 'package:mafuriko/gen/gen.dart';
import 'package:mafuriko/shared/widgets/custom_app_bar.dart';

class AlertsListScreen extends StatelessWidget {
  const AlertsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBackAppBar(title: 'Alertes'),
      body: RefreshIndicator(
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
        child: BlocBuilder<AlertBloc, AlertState>(
          builder: (context, state) {
            if (state is AlertLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is FailureAlert) {
              return Center(
                child: SizedBox(
                  width: .8.sw,
                  height: 120.h,
                  child: Padding(
                    padding: EdgeInsets.only(right: 16.w),
                    child: Text(
                      state.message.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: AppFonts.inter,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ),
              );
            } else if (state is SuccessAlert && state.alerts.isEmpty) {
              return const Center(
                child: Text('empty'),
              );
            }
            List<AlertEntity> floodAlerts = [];
            for (var alert in state.alerts) {
              if (alert.status == 'success') {
                print(alert);
                floodAlerts.add(alert);
              }
            }

            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                floodAlerts.sort((a, b) =>
                    b.postAt.toString().compareTo(a.postAt.toString()));
                //print(floodAlerts.first.postBy);
                return Padding(
                  padding: EdgeInsets.only(bottom: 20.w),
                  child: InkWell(
                    onTap: () => context.pushNamed(
                      Paths.alertDetailScreen,
                      extra: floodAlerts[index],
                    ),
                    child: AlertWithMoreDetailCard(
                      floodDescription: floodAlerts[index].floodDescription,
                      floodScene: floodAlerts[index].floodScene,
                      postAt: floodAlerts[index].postAt,
                      image: floodAlerts[index].image,
                      postedBy: floodAlerts[index].postBy,
                      pos: floodAlerts[index].floodLocation,
                    ),
                  ),
                );
              },
              itemCount: floodAlerts.length,
            );
          },
        ),
      ),
    );
  }
}
