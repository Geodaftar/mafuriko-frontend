import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:mafuriko/core/routes/constant_path.dart';
import 'package:mafuriko/features/home/presentation/widgets/cards.dart';
import 'package:mafuriko/features/send/domain/entities/alert_entity.dart';
import 'package:mafuriko/features/send/presentation/bloc/alert_bloc.dart';
import 'package:mafuriko/gen/gen.dart';

class AlertsSection extends StatelessWidget {
  const AlertsSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(right: 5.w),
          child: Section(title: 'Alertes', route: Paths.alertsScreen),
        ),
        BlocBuilder<AlertBloc, AlertState>(
          builder: (context, state) {
            if (state is FailureAlert) {
              return SizedBox(
                width: .8.sw,
                height: 120.h,
                child: Center(
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
            } else if (state is AlertLoading) {
              return HorizontalList(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.only(right: 16.w),
                    child: const AlertSkeletonCard(),
                  );
                },
                itemCount: 4,
              );
            } else if (state is SuccessAlert && state.alerts.isEmpty) {
              return const Center(
                child: Text('empty'),
              );
            }

            List<AlertEntity> floodAlerts = [];
            for (var alert in state.alerts) {
              if (alert.status == 'success') {
                floodAlerts.add(alert);
              }
            }

            return HorizontalList(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              itemBuilder: (BuildContext context, int index) {
                floodAlerts.sort((a, b) =>
                    b.postAt.toString().compareTo(a.postAt.toString()));

                return InkWell(
                  onTap: () => context.pushNamed(
                    Paths.alertDetailScreen,
                    extra: floodAlerts[index],
                  ),
                  child: AlertCard(
                    image: floodAlerts[index].image,
                    floodScene: floodAlerts[index].floodScene?.toUpperCase(),
                    floodDescription: floodAlerts[index].floodDescription,
                    postAt: floodAlerts[index].postAt,
                    postedBy: floodAlerts[index].postBy,
                    pos: floodAlerts[index].floodLocation,
                    margin: EdgeInsets.only(right: 16.w),
                  ),
                );
              },
              itemCount: floodAlerts.length <= 5 ? floodAlerts.length : 5,
            );
          },
        )
      ],
    );
  }
}
