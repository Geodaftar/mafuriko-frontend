import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mafuriko/features/home/presentation/widgets/cards.dart';
import 'package:nb_utils/nb_utils.dart';

class ActuSection extends StatelessWidget {
  const ActuSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(right: 5.w),
          child: const Section(title: 'Actualités partenaires'),
        ),
        HorizontalList(
          itemBuilder: (BuildContext context, int index) {
            return PartnerCard(
              margin: EdgeInsets.only(left: index == 0 ? 0 : 16.w),
            );
          },
          itemCount: 5,
        ),
      ],
    );
  }
}
