import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mafuriko/gen/gen.dart';

class BackAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BackAppBar({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      titleSpacing: 2,
      leadingWidth: 40.w,
      leading: InkWell(
        overlayColor: const WidgetStatePropertyAll(Colors.transparent),
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Padding(
          padding: EdgeInsets.only(left: 15.w),
          child: SvgPicture.asset(AppImages.icons.arrowBack.path),
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
            fontSize: 14.sp,
            fontFamily: AppFonts.inter,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
