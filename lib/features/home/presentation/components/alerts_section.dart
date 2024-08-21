import 'package:flutter/material.dart';
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
        Section(title: 'Alertes', route: Paths.alertsScreen),
        HorizontalList(
          itemBuilder: (BuildContext context, int index) {
            return const AlertCard();
          },
          itemCount: 5,
        ),
      ],
    );
  }
}
