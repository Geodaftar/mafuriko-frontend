import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:mafuriko/core/routes/constant_path.dart';
import 'package:mafuriko/features/authentication/presentation/blocs/bloc/auth_bloc.dart';
import 'package:mafuriko/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:mafuriko/gen/gen.dart';

import 'package:mafuriko/shared/widgets/pop_up.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FocusNode _buttonFocusNode = FocusNode(debugLabel: 'Menu Button');

  @override
  void dispose() {
    _buttonFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => context.pushReplacementNamed(Paths.home),
          child: const Icon(Icons.arrow_back_ios),
        ),
        actions: [MenuPlus(buttonFocusNode: _buttonFocusNode)],
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

                // ! remove the notification params from the features list
                // ListTile(
                //   leading: AppImages.icons.notifications.svg(),
                //   title: Text(
                //     'Notifications',
                //     style: TextStyle(
                //       color: Colors.black,
                //       fontSize: 14.sp,
                //       fontFamily: AppFonts.nunito,
                //       fontWeight: FontWeight.w400,
                //       letterSpacing: 0.25.sp,
                //     ),
                //   ),
                //   onTap: () => context.goNamed(Paths.notificationSettings),
                // ),
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
          // Container(
          //   decoration: ShapeDecoration(
          //     color: Colors.white,
          //     shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(8.r)),
          //     shadows: const [
          //       BoxShadow(
          //         color: Color(0x3F000000),
          //         blurRadius: 4,
          //         offset: Offset(0, 1),
          //         spreadRadius: 0,
          //       )
          //     ],
          //   ),
          //   margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 18.h),
          //   // color: Colors.white,
          //   child: Column(
          //     children: [
          //       ListTile(
          //         leading: AppImages.icons.contactsLine.svg(),
          //         title: Text(
          //           "Support d'aide",
          //           style: TextStyle(
          //             color: Colors.black,
          //             fontSize: 14.sp,
          //             fontFamily: AppFonts.nunito,
          //             fontWeight: FontWeight.w400,
          //             letterSpacing: 0.25.sp,
          //           ),
          //         ),
          //       ),
          //       ListTile(
          //         leading: AppImages.icons.chatQuoteLine.svg(),
          //         title: Text(
          //           'Contactez-nous',
          //           style: TextStyle(
          //             color: Colors.black,
          //             fontSize: 14.sp,
          //             fontFamily: AppFonts.nunito,
          //             fontWeight: FontWeight.w400,
          //             letterSpacing: 0.25.sp,
          //           ),
          //         ),
          //       ),
          //       ListTile(
          //         leading: AppImages.icons.lock2Line.svg(),
          //         title: Text(
          //           'Politique de confidentialité',
          //           style: TextStyle(
          //             color: Colors.black,
          //             fontSize: 14.sp,
          //             fontFamily: AppFonts.nunito,
          //             fontWeight: FontWeight.w400,
          //             letterSpacing: 0.25.sp,
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // 100.verticalSpace
        ],
      ),
    );
  }
}

class MenuPlus extends StatelessWidget {
  const MenuPlus({
    super.key,
    required FocusNode buttonFocusNode,
  }) : _buttonFocusNode = buttonFocusNode;

  final FocusNode _buttonFocusNode;

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      style: MenuStyle(
        // minimumSize: WidgetStatePropertyAll(Size.fromWidth(100.w)),
        backgroundColor: const WidgetStatePropertyAll(AppColor.white),
        padding: const WidgetStatePropertyAll(EdgeInsets.zero),
        fixedSize: WidgetStatePropertyAll(Size(160.w, 55)),
        elevation: const WidgetStatePropertyAll(0),
        alignment: Alignment.bottomRight,
      ),
      menuChildren: [
        MenuItemButton(
          onPressed: () {
            PopUp.disconnectReq(context);
          },
          leadingIcon: const Icon(
            Icons.exit_to_app,
            color: AppColor.red,
          ),
          style: MenuItemButton.styleFrom(
            alignment: Alignment.center,
            backgroundColor: AppColor.white,
          ),
          child: Text(
            'Déconnexion',
            style: TextStyle(
              fontFamily: AppFonts.inter,
              fontWeight: FontWeight.w400,
              fontSize: 14.sp,
              color: AppColor.red,
            ),
          ),
        ),
        // MenuItemButton(
        //   child: ListTile(
        //     leading: Icon(Icons.exit_to_app),
        //     title: Text('Déconnexion'),
        //   ),
        // ),
      ],
      builder: (_, controller, child) {
        return IconButton(
          focusNode: _buttonFocusNode,
          onPressed: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
          icon: const Icon(Icons.more_vert),
        );
      },
    );
  }
}

class ProfileSection extends StatefulWidget {
  const ProfileSection({
    super.key,
  });

  @override
  State<ProfileSection> createState() => _ProfileSectionState();
}

class _ProfileSectionState extends State<ProfileSection> {
  void showCustomBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 280.h,
          decoration: BoxDecoration(
              color: Colors.white,
              border: const Border(top: BorderSide(width: .3)),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.r),
                topRight: Radius.circular(15.r),
              )),
          child: Column(
// mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(height: 28.h),
              Text(
                'Profile',
                style: TextStyle(
                    fontFamily: AppFonts.montserrat,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600),
              ),
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
                margin: EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.h),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.photo),
                      title: Text(
                        'Galerie',
                        style: TextStyle(
                            fontFamily: AppFonts.montserrat, fontSize: 15.sp),
                      ),
                      onTap: () {
                        context.read<ProfileBloc>().add(
                            const UpdateProfileImageEvent(method: 'gallery'));
                        context.pop();
                      },
                    ),
                    Divider(indent: 15.w, endIndent: 15.w),
                    ListTile(
                      leading: const Icon(Icons.camera),
                      title: Text(
                        'Caméra',
                        style: TextStyle(
                          fontFamily: AppFonts.montserrat,
                          fontSize: 15.sp,
                        ),
                      ),
                      onTap: () {
                        context.read<ProfileBloc>().add(
                            const UpdateProfileImageEvent(method: 'camera'));
                        context.pop();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

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
                        child: BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                            if (state is AuthFailure) {
                              return Container(
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
                              );
                            }
                            if (state is AuthSuccess) {
                              return Container(
                                width: 154.15.w,
                                height: 154.15.h,
                                decoration: ShapeDecoration(
                                  shape: const CircleBorder(),
                                  image: DecorationImage(
                                    image: state.user.image != ''
                                        ? NetworkImage(
                                            state.user.image!,
                                          )
                                        : AssetImage(
                                            AppImages.icons.avatar3.path,
                                          ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            }
                            return Container(
                              width: 154.15.w,
                              height: 154.15.h,
                              decoration: const ShapeDecoration(
                                shape: CircleBorder(),
                                color: Color(0xFFFFAB91),
                              ),
                              child: const CircularProgressIndicator.adaptive(),
                            );
                          },
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
                              showCustomBottomSheet(context);
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
                      state.user.userName ?? '',
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
                      state.user.userEmail ?? 'userEmail',
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
