import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mafuriko/gen/gen.dart';

class ReportCount extends StatelessWidget {
  const ReportCount({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 16.h, 18.w, 16.h),
      padding: EdgeInsets.all(10.dm),
      decoration: ShapeDecoration(
        color: AppColor.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7.r),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Nombre de rapports reçus ',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontFamily: AppFonts.nunito,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(width: 10.w),
          Text(
            '268',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontFamily: AppFonts.nunito,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
