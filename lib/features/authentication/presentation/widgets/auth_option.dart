import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mafuriko/gen/gen.dart';

class OptionAuth extends StatelessWidget {
  const OptionAuth({
    super.key,
    required this.message,
    required this.option,
    required this.path,
  });

  final String message;
  final String option;
  final String path;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(padding: EdgeInsets.zero),
        onPressed: () {
          context.pushNamed(path);
        },
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              '$message ',
              style: TextStyle(
                color: const Color(0xFF6F6F6F),
                fontSize: 14.sp,
                fontFamily: AppFonts.lato,
                fontWeight: FontWeight.w400,
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: AppColor.primary,
                  ),
                ),
              ),
              child: Text(
                option,
                style: TextStyle(
                  color: AppColor.primary,
                  fontSize: 14.sp,
                  fontFamily: AppFonts.lato,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ));
  }
}
