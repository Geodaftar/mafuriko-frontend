import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mafuriko/core/routes/constant_path.dart';
import 'package:mafuriko/features/authentication/presentation/blocs/bloc/auth_bloc.dart';
import 'package:mafuriko/gen/gen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => context.pushReplacementNamed(Paths.home),
          child: const Icon(Icons.arrow_back_ios),
        ),
        backgroundColor: const Color(0xFFFAF1E9),
        scrolledUnderElevation: 0,
      ),
      body: ListView(
        children: [
          const ProfileSection(),
          SizedBox(height: 10.h),
          Container(
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              shadows: const [
                BoxShadow(
                  color: Color(0x3F000000),
                  blurRadius: 4,
                  offset: Offset(0, 1),
                  spreadRadius: 0,
                )
              ],
            ),
            margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 18.h),
            // elevation: 8,
            // color: Colors.white,
            child: Column(
              children: [
                ListTile(
                  leading: AppImages.icons.profileLine.svg(),
                  title: Text(
                    'Informations personnelles',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.sp,
                      fontFamily: AppFonts.nunito,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.25.sp,
                    ),
                  ),
                  onTap: () => context.goNamed(Paths.persoInfos),
                ),
                ListTile(
                  leading: AppImages.icons.notifications.svg(),
                  title: Text(
                    'Notifications',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.sp,
                      fontFamily: AppFonts.nunito,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.25.sp,
                    ),
                  ),
                  onTap: () => context.goNamed(Paths.notificationSettings),
                ),
                ListTile(
                  onTap: () => context.goNamed(Paths.modifyPassword),
                  leading: AppImages.icons.pass.svg(),
                  title: Text(
                    'Changer le mot de passe',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.sp,
                      fontFamily: AppFonts.nunito,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.25.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r)),
              shadows: const [
                BoxShadow(
                  color: Color(0x3F000000),
                  blurRadius: 4,
                  offset: Offset(0, 1),
                  spreadRadius: 0,
                )
              ],
            ),
            margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 18.h),
            // color: Colors.white,
            child: Column(
              children: [
                ListTile(
                  leading: AppImages.icons.contactsLine.svg(),
                  title: Text(
                    "Support d'aide",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.sp,
                      fontFamily: AppFonts.nunito,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.25.sp,
                    ),
                  ),
                ),
                ListTile(
                  leading: AppImages.icons.chatQuoteLine.svg(),
                  title: Text(
                    'Contactez-nous',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.sp,
                      fontFamily: AppFonts.nunito,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.25.sp,
                    ),
                  ),
                ),
                ListTile(
                  leading: AppImages.icons.lock2Line.svg(),
                  title: Text(
                    'Politique de confidentialité',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.sp,
                      fontFamily: AppFonts.nunito,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.25.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
          100.verticalSpace
        ],
      ),
    );
  }
}

class ProfileSection extends StatelessWidget {
  const ProfileSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
          clipper: RPSCustomClipper(),
          child: Container(
            height: .25.sh,
            color: const Color(0xFFFAF1E9),
            // child: Row(
            //   children: [
            //     Icon(Icons.arrow_back_ios),
            //   ],
            // ),
          ),
        ),
        SizedBox(height: .28.sh),
        Align(
          heightFactor: 1.47.h,
          alignment: Alignment.bottomCenter,
          // bottom: 0,
          // left: 113.w,
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return Column(
                children: [
                  Stack(
                    children: [
                      SizedBox(height: 160.h, width: 160.w),
                      Positioned(
                        child: Container(
                          width: 154.15.w,
                          height: 154.15.h,
                          decoration: ShapeDecoration(
                            shape: const CircleBorder(),
                            image: DecorationImage(
                              image: AssetImage(
                                AppImages.icons.avatar3.path,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          decoration: ShapeDecoration(
                            shape: CircleBorder(
                                side: BorderSide(
                              width: 5.w,
                              color: Colors.white,
                            )),
                            color: const Color(0xFFF5F5F5),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.edit_outlined,
                                color: Colors.black),
                            onPressed: () {
                              // Add edit functionality here
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  if (state is AuthSuccess)
                    Text(
                      state.user.userName ?? 'Mamadou Krouma',
                      style: TextStyle(
                        color: AppColor.primaryGray,
                        fontSize: 20.sp,
                        fontFamily: AppFonts.nunito,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  SizedBox(height: 8.h),
                  if (state is AuthSuccess)
                    Text(
                      state.user.userEmail ?? 'Mamadou.k@geodadftar.com',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: AppFonts.nunito,
                        color: AppColor.primaryGray,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class RPSCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(
        0, size.height - 60); // Move to a lower point for a rounder curve
    path.quadraticBezierTo(
        size.width / 2, size.height + 60, size.width, size.height - 60);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
