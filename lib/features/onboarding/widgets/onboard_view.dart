import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mafuriko/gen/fonts.gen.dart';

class OnboardView extends StatelessWidget {
  const OnboardView({super.key, required this.img, required this.desc});

  final String img;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(height: .06.sh),
        Container(
          margin: EdgeInsets.only(
            bottom: .06.sh,
          ),
          child: Image.asset(
            fit: BoxFit.cover,
            img,
          ),
        ),
        Text(
          desc,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: const Color(0xFF434343),
            fontSize: 20.spMin,
            fontFamily: AppFonts.nunito,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
