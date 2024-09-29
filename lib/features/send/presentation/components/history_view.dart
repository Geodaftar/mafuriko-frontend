import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mafuriko/core/routes/constant_path.dart';
import 'package:mafuriko/features/home/presentation/widgets/home_widget.dart';
import 'package:mafuriko/features/send/presentation/bloc/alert_bloc.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.h),
      child: BlocBuilder<AlertBloc, AlertState>(
        builder: (context, state) {
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.only(top: 20.w),
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
