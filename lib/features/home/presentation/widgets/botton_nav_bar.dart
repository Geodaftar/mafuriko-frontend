import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mafuriko/gen/gen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({
    super.key,
    this.index = 0,
    required this.onTap,
  });

  final int index;
  final Function(int)? onTap;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColor.white,
      selectedItemColor: AppColor.primary,
      unselectedItemColor: const Color(0xFFA3A3A3),
      currentIndex: widget.index,
      useLegacyColorScheme: false,
      onTap: widget.onTap,
      selectedLabelStyle: TextStyle(
        fontSize: 12.sp,
        fontFamily: AppFonts.nunito,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.32.sp,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 12.sp,
        fontFamily: AppFonts.nunito,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.32.sp,
      ),
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            AppImages.icons.homeIcon.path,
            height: 25.h,
            colorFilter: ColorFilter.mode(
              widget.index == 0 ? AppColor.primary : const Color(0xFFA3A3A3),
              BlendMode.srcIn,
            ),
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            AppImages.icons.mapIcon.path,
            height: 25.h,
            colorFilter: ColorFilter.mode(
              widget.index == 1 ? AppColor.primary : const Color(0xFFA3A3A3),
              BlendMode.srcIn,
            ),
          ),
          label: 'Map',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.file_upload_outlined),
          label: 'Send',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.bubble_chart_outlined),
          label: 'Prédiction',
        ),
      ],
    );
  }
}
