import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mafuriko/core/routes/constant_path.dart';
import 'package:mafuriko/features/authentication/presentation/blocs/bloc/auth_bloc.dart';
import 'package:mafuriko/features/home/presentation/widgets/home_widget.dart';
import 'package:mafuriko/features/send/domain/entities/alert_entity.dart';
import 'package:mafuriko/features/send/presentation/bloc/alert_bloc.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  String alertStatus(String status) {
    switch (status) {
      case 'success':
        return 'Validé';
      case 'pending':
        return 'En attente';
      case 'Re':
        return 'Rejeté';
      default:
        return 'not given';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.h),
      child: BlocBuilder<AlertBloc, AlertState>(
        builder: (context, state) {
          final user = (context.watch<AuthBloc>().state as AuthSuccess).user;
          List<AlertEntity> ownAlerts = [];
          for (var element in state.alerts) {
            if (element.postBy == '${user.fullName}') {
              ownAlerts.add(element);
            }
          }
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              if (index >= ownAlerts.length) {
                return Container(); // Ou un widget de remplacement
              }
              return Padding(
                padding: EdgeInsets.only(top: 20.w),
                child: InkWell(
                  onTap: () => context.pushNamed(
                    Paths.alertDetailScreen,
                    extra: ownAlerts[index],
                  ),
                  child: AlertWithMoreDetailCard(
                    floodDescription: ownAlerts[index].floodDescription ??
                        'Description non disponible',
                    floodScene: ownAlerts[index].floodScene?.toUpperCase() ??
                        'Scène non disponible',
                    postAt: ownAlerts[index].postAt,
                    image: ownAlerts[index].image,
                    pos: ownAlerts[index].floodLocation,
                    postedBy: 'Moi',
                    isHistoryView: true,
                    status: alertStatus(ownAlerts[index].status.toString()),
                  ),
                ),
              );
            },
            itemCount: ownAlerts.length,
          );
        },
      ),
    );
  }
}
