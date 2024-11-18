import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      child: Scaffold(
        appBar: AppBackAppBar(
          title: 'Envoi',
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
            final user = (context.watch<AuthBloc>().state as AuthSuccess).user;
            List<AlertEntity> ownAlerts = [];
            for (var element in state.alerts) {
              if (element.postBy == '${user.fullName}') {
                ownAlerts.add(element);
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
    );
  }
}
