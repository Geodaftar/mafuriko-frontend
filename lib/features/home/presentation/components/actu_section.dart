import 'package:flutter/material.dart';
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
        const Section(title: 'Actualités partenaires'),
        HorizontalList(
          itemBuilder: (BuildContext context, int index) {
            return const PartnerCard();
          },
          itemCount: 5,
        ),
      ],
    );
  }
}
