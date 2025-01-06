import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mafuriko/core/common/entities/user_entity.dart';
import 'package:mafuriko/features/authentication/presentation/blocs/bloc/auth_bloc.dart';
import 'package:mafuriko/features/send/domain/entities/alert_entity.dart';
// import 'package:mafuriko/core/routes/constant_path.dart';
import 'package:mafuriko/features/send/presentation/bloc/alert_bloc.dart';

import 'package:mafuriko/features/send/presentation/components/empty_history.dart';
import 'package:mafuriko/features/send/presentation/components/history_view.dart';
import 'package:mafuriko/features/send/presentation/components/send_view.dart';
import 'package:mafuriko/gen/gen.dart';
import 'package:mafuriko/shared/widgets/custom_app_bar.dart';

class SendScreen extends StatefulWidget {
  const SendScreen({super.key});

  @override
  State<SendScreen> createState() => _SendScreenState();
}

class _SendScreenState extends State<SendScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: 2,
        vsync: this); // Ajustez la longueur selon le nombre d'onglets
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: BlocListener<AlertBloc, AlertState>(
        listener: (context, state) {
          if (state is SuccessAlert && state.reqType == AlertReq.sendAlert) {
            _tabController.animateTo(1);
          }
          // TODO: implement listener
        },
        child: Scaffold(
          appBar: AppBackAppBar(
            title: 'Envoi',
            hideBackIcon: true,
            // route: Paths.home,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(0.h),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10.r)),
                child: Container(
                  height: 40.h,
                  margin: EdgeInsets.symmetric(horizontal: 30.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.r)),
                    color: const Color(0x197A4419),
                  ),
                  child: TabBar(
                    controller: _tabController,
                    indicatorSize: TabBarIndicatorSize.tab,
                    dividerColor: Colors.transparent,
                    indicator: BoxDecoration(
                      color: AppColor.primary,
                      borderRadius: BorderRadius.all(Radius.circular(10.r)),
                    ),
                    labelColor: Colors.white,
                    labelStyle: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: AppFonts.nunito,
                      fontWeight: FontWeight.w400,
                    ),
                    unselectedLabelColor: AppColor.primary,
                    tabs: const [
                      Tab(
                        text: 'Créer nouveau',
                      ),
                      Tab(
                        text: 'Historique',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          body: BlocBuilder<AlertBloc, AlertState>(
            builder: (context, state) {
              AuthState authState = context.watch<AuthBloc>().state;
              late UserEntity user;
              if (authState is AuthSuccess) {
                user = authState.user;
              }

              List<AlertEntity> ownAlerts = [];
              for (var element in state.alerts) {
                if (user.fullName == '') {
                  if (element.postBy == '${user.userEmail?.split("@").first}') {
                    ownAlerts.add(element);
                  }
                } else {
                  if (element.postBy == '${user.fullName}') {
                    ownAlerts.add(element);
                  }
                }
              }
              return TabBarView(
                controller: _tabController,
                children: [
                  const SendView(),
                  if (ownAlerts.isEmpty)
                    EmptyHistory(tabController: _tabController)
                  else
                    RefreshIndicator(
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
                      child: const HistoryView(),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
