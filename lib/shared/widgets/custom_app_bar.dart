import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:go_router/go_router.dart';
import 'package:mafuriko/gen/gen.dart';

class AppBackAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AppBackAppBar({
    super.key,
    required this.title,
    this.route,
    this.bottom,
    this.hideBackIcon,
  });

  final String title;
  final String? route;
  final PreferredSizeWidget? bottom;
  final bool? hideBackIcon;

  @override
  Size get preferredSize =>
      Size.fromHeight(bottom != null ? 95.h : kToolbarHeight.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      titleSpacing: 2,
      leadingWidth: 70.w,
      leading: hideBackIcon == true
          ? SizedBox()
          : InkWell(
              overlayColor: const WidgetStatePropertyAll(Colors.transparent),
              onTap: () {
                Navigator.pop(context, 0);
              },
              child: Container(
                width: 10.w,
                height: 20.h,
                padding: EdgeInsets.symmetric(horizontal: 13.w),
                child: Padding(
                  padding: EdgeInsets.only(left: 1.w),
                  child: Icon(Icons.arrow_back_ios, size: 20.h),
                ),
              ),
            ),
      title: InkWell(
        overlayColor: const WidgetStatePropertyAll(Colors.transparent),
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Text(
          title,
          style: TextStyle(
            color: AppColor.primary,
            fontSize: 16.sp,
            fontFamily: AppFonts.nunito,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      bottom: bottom,
    );
  }
}
