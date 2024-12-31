import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mafuriko/core/routes/constant_path.dart';
import 'package:mafuriko/features/authentication/presentation/blocs/bloc/auth_bloc.dart';
import 'package:mafuriko/gen/gen.dart';
import 'package:mafuriko/shared/widgets/buttons.dart';

class PopUp {
  static Future<void> success(BuildContext context,
      {required String title,
      required String description,
      required VoidCallback action}) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actionsPadding: EdgeInsets.fromLTRB(50.w, 33.h, 50.w, 43.h),
          contentPadding: EdgeInsets.fromLTRB(50.w, 18.h, 50.w, 0),
          alignment: Alignment.center,
          title: Text(
            title,
            style: TextStyle(
              color: AppColor.primaryGray,
              fontSize: 20.sp,
              fontFamily: AppFonts.inter,
              fontWeight: FontWeight.w500,
            ),
          ),
          icon: Container(
            width: 98.w,
            height: 98.h,
            decoration: ShapeDecoration(
              shape: const CircleBorder(),
              image: DecorationImage(
                image: AssetImage(AppImages.icons.checkIcon.path),
              ),
            ),
          ),
          actions: [
            PrimaryExpandedButton(
              title: 'Continuer',
              onTap: action,
            ),
          ],
          content: SizedBox(
            width: 195.w,
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColor.secondaryGray,
                fontSize: 16.sp,
                fontFamily: AppFonts.nunito,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        );
      },
    );
  }

  static Future<void> successAlertSend(BuildContext context,
      {required String title, required String description}) async {
    await showDialog(
      context: context,
      builder: (context) {
        Future.delayed(const Duration(milliseconds: 2500), () {
          Navigator.of(context).pop(true);
        });
        return AlertDialog(
          backgroundColor: AppColor.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
          insetPadding: EdgeInsets.symmetric(horizontal: 30.w),
          // actionsPadding: EdgeInsets.fromLTRB(25.w, 33.h, 25.w, 43.h),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 50.w, vertical: 18.h),
          alignment: Alignment.center,
          title: Text(
            title,
            style: TextStyle(
              color: AppColor.primaryGray,
              fontSize: 20.sp,
              fontFamily: AppFonts.inter,
              fontWeight: FontWeight.w500,
            ),
          ),
          icon: Container(
            width: 58.w,
            height: 58.h,
            decoration: ShapeDecoration(
              shape: const CircleBorder(),
              image: DecorationImage(
                image: AssetImage(AppImages.icons.checkIcon.path),
              ),
            ),
          ),
          content: SizedBox(
            width: 195.w,
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColor.secondaryGray,
                fontSize: 14.sp,
                fontFamily: AppFonts.nunito,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        );
      },
    );
  }

  static Future<void> failureAlertSend(BuildContext context,
      {required String title,
      required String description,
      required VoidCallback action}) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actionsPadding: EdgeInsets.fromLTRB(50.w, 33.h, 50.w, 43.h),
          contentPadding: EdgeInsets.fromLTRB(50.w, 18.h, 50.w, 0),
          alignment: Alignment.center,
          title: Text(
            title,
            style: TextStyle(
              color: AppColor.primaryGray,
              fontSize: 20.sp,
              fontFamily: AppFonts.inter,
              fontWeight: FontWeight.w500,
            ),
          ),
          icon: Container(
            width: 98.w,
            height: 98.h,
            padding: EdgeInsets.all(4.w),
            decoration: ShapeDecoration(
              shape: CircleBorder(
                side: BorderSide(color: AppColor.red, width: 1.5.w),
              ),
            ),
            child: const Icon(
              Icons.close_rounded,
              color: AppColor.red,
              size: 35,
            ),
          ),
          actions: [
            PrimaryExpandedButton(
              title: 'Revenir',
              onTap: action,
            ),
          ],
          content: SizedBox(
            width: 195.w,
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColor.secondaryGray,
                fontSize: 14.sp,
                fontFamily: AppFonts.nunito,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        );
      },
    );
  }

  static Future<void> disconnectReq(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actionsPadding: EdgeInsets.fromLTRB(50.w, 33.h, 50.w, 43.h),
          contentPadding: EdgeInsets.fromLTRB(50.w, 18.h, 50.w, 0),
          alignment: Alignment.center,
          title: Text(
            'Déconnexion',
            style: TextStyle(
              color: AppColor.primaryGray,
              fontSize: 20.sp,
              fontFamily: AppFonts.inter,
              fontWeight: FontWeight.w500,
            ),
          ),
          icon: Container(
            width: 98.w,
            height: 98.h,
            decoration: ShapeDecoration(
              shape: const CircleBorder(),
              image: DecorationImage(
                image: AssetImage(AppImages.icons.checkIcon.path),
              ),
            ),
          ),
          actions: [
            PopDialogueButton(
              title: 'Oui',
              onTap: () {
                Navigator.of(context).pop(); // Ferme d'abord le dialogue
                context.goNamed(Paths.login); // redirigé vers la page de login
                context.read<AuthBloc>().add(LogOutEvent());
                // context.push(Paths.initialPath);
                // context.read<AuthBloc>().add(LogOutEvent());
              },
            ),
            PopDialogueButton(
              title: 'Non',
              backgroundColor: AppColor.gray,
              onTap: () {
                context.pop();
              },
            ),
          ],
          content: SizedBox(
            width: 195.w,
            child: Text(
              'Souhaitez-vous vraiment vous déconnecté?',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColor.secondaryGray,
                fontSize: 16.sp,
                fontFamily: AppFonts.nunito,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        );
      },
    );
  }
}

// Container(
//   width: 330,
//   height: 376,
//   child: Stack(
//     children: [
//       Positioned(
//         left: 0,
//         top: 0,
        // child: Container(
        //   width: 330,
        //   height: 376,
        //   decoration: ShapeDecoration(
        //     color: Colors.white,
        //     shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(20),
        //     ),
        //   ),
        // ),
//       ),
//       Positioned(
//         left: 50,
//         top: 39,
//         child: Container(
//           width: 231,
//           height: 294,
//           child: Stack(
//             children: [
//               Positioned(
//                 left: 67,
//                 top: 0,
//                 child: Container(width: 98, height: 98, child: Stack()),
//               ),
//               Positioned(
//                 left: 17,
//                 top: 131,
//                 child: Container(
//                   width: 196,
//                   height: 78,
//                   child: Stack(
//                     children: [
//                       Positioned(
//                         left: 0,
//                         top: 0,
                        // child: Text(
                        //   'Vérification réussie',
                        //   style: TextStyle(
                        //     color: Color(0xFF434343),
                        //     fontSize: 20,
                        //     fontFamily: 'Inter',
                        //     fontWeight: FontWeight.w500,
                        //     height: 0,
                        //   ),
                        // ),
//                       ),
//                       Positioned(
//                         left: 1,
//                         top: 34,
//                         child: SizedBox(
//                           width: 195,
                          // child: Text(
                          //   'Cliquez sur continuer pour continuer',
                          //   textAlign: TextAlign.center,
                          //   style: TextStyle(
                          //     color: Color(0xFF6F6F6F),
                          //     fontSize: 16,
                          //     fontFamily: 'Nunito',
                          //     fontWeight: FontWeight.w400,
                          //     height: 0,
                          //   ),
                          // ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Positioned(
//                 left: 0,
//                 top: 236,
//                 child: Container(
//                   width: 231,
//                   height: 58,
//                   child: Stack(
//                     children: [
//                       Positioned(
//                         left: 0,
//                         top: 0,
                        // child: Container(
                        //   width: 231,
                        //   height: 58,
                        //   decoration: ShapeDecoration(
                        //     color: Color(0xFF7A4419),
                        //     shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(10),
                        //     ),
                        //   ),
//                         ),
//                       ),
//                       Positioned(
//                         left: 68,
//                         top: 18,
//                         child: Text(
//                           'Continuer',
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 20,
//                             fontFamily: 'Inter',
//                             fontWeight: FontWeight.w500,
//                             height: 0,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     ],
//   ),
// )
