import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mafuriko/features/home/presentation/widgets/cards.dart';
import 'package:mafuriko/gen/gen.dart';

class ServiceSection extends StatelessWidget {
  const ServiceSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Services',
            style: TextStyle(
              color: AppColor.secondaryGray,
              fontSize: 16.sp,
              fontFamily: AppFonts.nunito,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ServiceCard(
                icon: Icons.cloudy_snowing,
                title: 'Bulletin météo',
                description:
                    'Un bulletin météo à jour auquel vous pouvez faire confiance au bout de vos doigts.',
              ),
              ServiceCard(
                icon: Icons.warning_amber_rounded,
                title: 'Vérification de la zone',
                description:
                    'Obtenez une mise à jour en temps réel sur la zone dangereuse',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
