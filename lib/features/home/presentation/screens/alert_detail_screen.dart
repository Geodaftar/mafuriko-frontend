import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mafuriko/features/home/presentation/screens/alerts_list_screen.dart';
import 'package:mafuriko/gen/gen.dart';
import 'package:nb_utils/nb_utils.dart';

class AlertDetailScreen extends StatelessWidget {
  const AlertDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBackAppBar(title: 'Marché cocovico'),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 127.h,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.r),
                      topRight: Radius.circular(10.r),
                    ),
                  ),
                  image: DecorationImage(
                    image: AssetImage(
                      AppImages.images.onboarding.thumb.path,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              HorizontalList(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                itemCount: 3,
                // crossAxisAlignment: WrapCrossAlignment.end,
                wrapAlignment: WrapAlignment.spaceBetween,
                spacing: 12,
                itemBuilder: (context, index) => Container(
                  width: 102.w,
                  height: 62.h,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    image: DecorationImage(
                      image: AssetImage(
                        AppImages.images.onboarding.thumb.path,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 3.h,
                            ),
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              color: AppColor.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6.r),
                              ),
                            ),
                            child: Text(
                              'Inondation',
                              style: TextStyle(
                                color: AppColor.white,
                                fontSize: 13.sp,
                                fontFamily: AppFonts.nunito,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SizedBox(width: 9.w),
                          AppImages.icons.verify.svg()
                        ],
                      ),
                      Text(
                        '11h28  || 25/04/2024',
                        style: TextStyle(
                          color: AppColor.primaryGray,
                          fontSize: 10.sp,
                          fontFamily: AppFonts.nunito,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 7.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Marché cocovico',
                        style: TextStyle(
                          color: AppColor.primaryGray,
                          fontSize: 18.sp,
                          fontFamily: AppFonts.nunito,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 5.h),
                        child: Wrap(
                          children: [
                            Text(
                              'Cocody, Abidjan  || Uploaded by: ',
                              style: TextStyle(
                                color: AppColor.primaryGray,
                                fontSize: 12.sp,
                                fontFamily: AppFonts.nunito,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              'Tolu Oluyole',
                              style: TextStyle(
                                color: AppColor.primaryGray,
                                fontSize: 12.sp,
                                fontFamily: AppFonts.nunito,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(height: 22.h),
                      Text(
                        'Soyez prêt. Montée des eaux attendue. Surveillez les actualités locales et préparez-vous à évacuer si nécessaire.',
                        style: TextStyle(
                          color: AppColor.primaryGray,
                          fontSize: 14.sp,
                          fontFamily: AppFonts.nunito,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  // Padding(
                  //   padding: EdgeInsets.only(top: 12.h),
                  //   child: Row(
                  //     // mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       const Icon(
                  //         Icons.thumb_up_off_alt_outlined,
                  //         color: AppColor.primary,
                  //       ),
                  //       Text(
                  //         '1,964',
                  //         style: TextStyle(
                  //           color: AppColor.primary,
                  //           fontSize: 10.37.sp,
                  //           fontFamily: AppFonts.nunito,
                  //           fontWeight: FontWeight.w700,
                  //         ),
                  //       ),
                  //       SizedBox(width: 10.h),
                  //       const Icon(
                  //         Icons.chat_bubble_rounded,
                  //         color: AppColor.primary,
                  //       ),
                  //       Text(
                  //         '135',
                  //         style: TextStyle(
                  //           color: AppColor.primary,
                  //           fontSize: 10.37.sp,
                  //           fontFamily: AppFonts.nunito,
                  //           fontWeight: FontWeight.w700,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
              Container(
                // width: 330.w,
                // height: 234.h,
                margin: EdgeInsets.only(top: 25.h),
                padding: EdgeInsets.all(15.dm),
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                        width: 1.50.w, color: const Color(0xFFDEE5E5)),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 300.w,
                      height: 33.h,
                      padding: EdgeInsets.only(left: 15.w),
                      alignment: Alignment.centerLeft,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFFCF7F2),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7)),
                      ),
                      child: Text(
                        'Informations techniques',
                        style: TextStyle(
                          color: AppColor.primary,
                          fontSize: 14.sp,
                          fontFamily: AppFonts.nunito,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 65.h,
                      child: ListTile(
                        shape: const Border(
                          bottom: BorderSide(
                            color: Color(0xFFD9D9D9),
                          ),
                        ),
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          '12.4 °C',
                          style: TextStyle(
                            color: AppColor.primaryGray,
                            fontSize: 14.sp,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        subtitle: Text(
                          'Pluviométrie',
                          style: TextStyle(
                            color: const Color(0xFF626666),
                            fontSize: 12.sp,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 65.h,
                      child: ListTile(
                        shape: const Border(
                          bottom: BorderSide(
                            color: Color(0xFFD9D9D9),
                          ),
                        ),
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          'Ensoleillé',
                          style: TextStyle(
                            color: AppColor.primaryGray,
                            fontSize: 14.sp,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        subtitle: Text(
                          'Météo',
                          style: TextStyle(
                            color: const Color(0xFF626666),
                            fontSize: 12.sp,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 65.h,
                      child: ListTile(
                        shape: const Border(
                          bottom: BorderSide(
                            color: Color(0xFFD9D9D9),
                          ),
                        ),
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          '12.523 , -5.980',
                          style: TextStyle(
                            color: AppColor.primaryGray,
                            fontSize: 14.sp,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        subtitle: Text(
                          'Coordonnées géographiques',
                          style: TextStyle(
                            color: const Color(0xFF626666),
                            fontSize: 12.sp,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25.h),
            ],
          ),
        ),
      ),
    );
  }
}
