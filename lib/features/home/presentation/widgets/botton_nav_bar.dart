import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:go_router/go_router.dart';
// import 'package:mafuriko/core/routes/constant_path.dart';
import 'package:mafuriko/features/home/presentation/cubit/navigation_cubit.dart';
import 'package:mafuriko/gen/gen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, int>(
      builder: (context, currentIndex) {
        return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColor.white,
          selectedItemColor: AppColor.primary,
          unselectedItemColor: const Color(0xFFA3A3A3),
          currentIndex: currentIndex,
          useLegacyColorScheme: false,
          onTap: (value) {
            context.read<NavigationCubit>().updateIndex(value);
          },
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
                  currentIndex == 0
                      ? AppColor.primary
                      : const Color(0xFFA3A3A3),
                  BlendMode.srcIn,
                ),
              ),
              label: 'Accueil',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AppImages.icons.mapIcon.path,
                height: 25.h,
                colorFilter: ColorFilter.mode(
                  currentIndex == 1
                      ? AppColor.primary
                      : const Color(0xFFA3A3A3),
                  BlendMode.srcIn,
                ),
              ),
              label: 'Carte',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.file_upload_outlined),
              label: 'Envoyé',
            ),
            // const BottomNavigationBarItem(
            //   icon: Icon(Icons.bubble_chart_outlined),
            //   label: 'Prédiction',
            // ),
          ],
        );
      },
    );
  }
}
