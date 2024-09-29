import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:mafuriko/core/routes/constant_path.dart';
import 'package:mafuriko/features/home/presentation/widgets/cards.dart';
import 'package:mafuriko/features/send/presentation/bloc/alert_bloc.dart';
import 'package:mafuriko/gen/gen.dart';
import 'package:mafuriko/shared/widgets/custom_app_bar.dart';

class AlertsListScreen extends StatelessWidget {
  const AlertsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBackAppBar(title: 'Alertes'),
      body: BlocBuilder<AlertBloc, AlertState>(
        builder: (context, state) {
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
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.only(bottom: 20.w),
                child: InkWell(
                  onTap: () => context.pushNamed(
                    Paths.alertDetailScreen,
                    extra: state.alerts[index],
                  ),
                  child: AlertWithMoreDetailCard(
                    floodDescription: state.alerts[index].floodDescription,
                    floodScene: state.alerts[index].floodScene,
                    postAt: state.alerts[index].postAt,
                    image: state.alerts[index].image,
                  ),
                ),
              );
            },
            itemCount: state.alerts.length,
          );
        },
      ),
    );
  }
}
