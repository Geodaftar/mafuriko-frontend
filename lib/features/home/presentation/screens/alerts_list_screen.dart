import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mafuriko/core/routes/constant_path.dart';
import 'package:mafuriko/features/home/presentation/widgets/cards.dart';
import 'package:mafuriko/gen/gen.dart';

class AlertsListScreen extends StatelessWidget {
  const AlertsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBackAppBar(title: 'Alertes'),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(bottom: 20.w),
            child: InkWell(
              onTap: () => context.pushNamed(Paths.alertDetailScreen),
              child: const AlertWithMoreDetailCard(),
            ),
          );
        },
        itemCount: 5,
      ),
    );
  }
}

class AppBackAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AppBackAppBar({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Size get preferredSize => Size.fromHeight(70.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      titleSpacing: 2,
      leadingWidth: 70.w,
      leading: InkWell(
        overlayColor: const WidgetStatePropertyAll(Colors.transparent),
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Container(
          width: 10.w,
          height: 20.h,
          padding: EdgeInsets.symmetric(horizontal: 13.w),
          child: Padding(
            padding: EdgeInsets.only(left: 15.w),
            child: SvgPicture.asset(AppImages.icons.arrowBack.path),
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
    );
  }
}
