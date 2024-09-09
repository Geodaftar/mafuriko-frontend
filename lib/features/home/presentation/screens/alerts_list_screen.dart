import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:mafuriko/core/routes/constant_path.dart';
import 'package:mafuriko/features/home/presentation/widgets/cards.dart';
import 'package:mafuriko/shared/widgets/custom_app_bar.dart';

class AlertsListScreen extends StatelessWidget {
  const AlertsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBackAppBar(title: 'Alertes'),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(bottom: 20.w),
            child: InkWell(
              onTap: () => context.pushNamed(Paths.alertDetailScreen),
              child: const AlertWithMoreDetailCard(),
            ),
          );
        },
        itemCount: 5,
      ),
    );
  }
}
