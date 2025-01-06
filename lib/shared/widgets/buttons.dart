import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mafuriko/gen/colors.gen.dart';
import 'package:mafuriko/gen/fonts.gen.dart';

class PrimaryExpandedButton extends StatelessWidget {
  const PrimaryExpandedButton({
    super.key,
    required this.title,
    this.onTap,
  });
  final VoidCallback? onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: onTap,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontFamily: AppFonts.inter,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class PopDialogueButton extends StatelessWidget {
  const PopDialogueButton({
    super.key,
    required this.onTap,
    required this.title,
    this.backgroundColor = AppColor.primary,
  });

  final Color backgroundColor;
  final String title;

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.zero,
      height: 37.h,
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.23.r),
      ),
      elevation: 0,
      highlightElevation: 0,
      onPressed: onTap,
      child: Text(
        title,
        style: TextStyle(
          color: backgroundColor != AppColor.primary
              ? AppColor.primaryGray
              : Colors.white,
          fontSize: 15.57.sp,
          fontFamily: AppFonts.nunito,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
