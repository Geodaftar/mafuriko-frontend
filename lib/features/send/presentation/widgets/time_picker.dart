import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mafuriko/gen/gen.dart';
import 'package:numberpicker/numberpicker.dart';

class NumberPage extends StatefulWidget {
  const NumberPage(
      {super.key,
      this.hour = 0,
      this.minute = 0,
      required this.hourChanged,
      required this.minuteChanged});
  final int hour;
  final int minute;

  final void Function(int val) hourChanged;
  final void Function(int val) minuteChanged;

  @override
  State<NumberPage> createState() => _NumberPageState();
}

class _NumberPageState extends State<NumberPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Régler le temps',
              style: TextStyle(
                color: AppColor.primaryGray,
                fontSize: 19.24.sp,
                fontFamily: AppFonts.inter,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 20.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 10.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  NumberPicker(
                    minValue: 0,
                    maxValue: 23,
                    value: widget.hour,
                    zeroPad: true,
                    infiniteLoop: true,
                    itemWidth: 80,
                    itemHeight: 60,
                    onChanged: widget.hourChanged,
                    textStyle: TextStyle(
                      color: AppColor.primaryGray,
                      fontSize: 19.24.sp,
                      fontFamily: AppFonts.inter,
                      fontWeight: FontWeight.w500,
                    ),
                    selectedTextStyle: TextStyle(
                      color: AppColor.primary,
                      fontSize: 19.24.sp,
                      fontFamily: AppFonts.inter,
                      fontWeight: FontWeight.w600,
                    ),
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Color(0xFF8B8B8B),
                        ),
                        bottom: BorderSide(
                          color: Color(0xFF8B8B8B),
                        ),
                      ),
                    ),
                  ),
                  NumberPicker(
                    minValue: 0,
                    maxValue: 59,
                    value: widget.minute,
                    zeroPad: true,
                    infiniteLoop: true,
                    itemWidth: 80,
                    itemHeight: 60,
                    onChanged: widget.minuteChanged,
                    textStyle: TextStyle(
                      color: AppColor.primaryGray,
                      fontSize: 19.24.sp,
                      fontFamily: AppFonts.inter,
                      fontWeight: FontWeight.w500,
                    ),
                    selectedTextStyle: TextStyle(
                      color: AppColor.primary,
                      fontSize: 19.24.sp,
                      fontFamily: AppFonts.inter,
                      fontWeight: FontWeight.w600,
                    ),
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Color(0xFF8B8B8B),
                        ),
                        bottom: BorderSide(
                          color: Color(0xFF8B8B8B),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
