import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mafuriko/core/routes/constant_path.dart';
import 'package:mafuriko/features/authentication/presentation/blocs/bloc/auth_bloc.dart';
import 'package:mafuriko/gen/gen.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      toolbarHeight: 65.h,
      surfaceTintColor: AppColor.white,
      leading: Padding(
        padding: EdgeInsets.only(left: 16.w, top: 10.h, bottom: 10.h),
        child: CircleAvatar(
          backgroundImage: AssetImage(AppImages.icons.avatar3.path),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.only(left: 60.w),
        title: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello 👋',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontFamily: AppFonts.urbanist,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.12.sp,
                  ),
                ),
                Text(
                  '${(state as AuthSuccess).user.userName}',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: AppFonts.nunito,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.15.sp,
                  ),
                ),
              ],
            );
          },
        ),
      ),
      actions: [
        InkWell(
          onTap: () {
            context.push('/${Paths.initialPath}');
            context.read<AuthBloc>().add(LogOutEvent());
          },
          child: Container(
            width: 26.w,
            height: 30.h,
            margin: EdgeInsets.only(right: 16.w),
            child: SvgPicture.asset(AppImages.icons.bellNotification.path),
          ),
        ),
      ],
    );
  }
}
