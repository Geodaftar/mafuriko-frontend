import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mafuriko/core/routes/constant_path.dart';
import 'package:mafuriko/features/home/presentation/widgets/cards.dart';
import 'package:nb_utils/nb_utils.dart';

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
        HorizontalList(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          itemBuilder: (BuildContext context, int index) {
            return AlertCard(
              margin: EdgeInsets.only(left: index == 0 ? 0 : 16.w),
            );
          },
          itemCount: 5,
        ),
      ],
    );
  }
}
