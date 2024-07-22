import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mafuriko/gen/gen.dart';

class Section extends StatelessWidget {
  const Section({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: AppColor.secondaryGray,
              fontSize: 16.sp,
              fontFamily: AppFonts.nunito,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            'Voir tout',
            style: TextStyle(
              color: AppColor.secondaryGray,
              fontSize: 12.sp,
              fontFamily: AppFonts.nunito,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

class AlertCard extends StatelessWidget {
  const AlertCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 271.w,
      margin: EdgeInsets.only(left: 16.w),
      decoration: ShapeDecoration(
        color: const Color(0xFFFCF6F2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 15.w,
              vertical: 12.h,
            ),
            child: Column(
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
                              fontSize: 12.sp,
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
                        fontSize: 8.sp,
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
                        fontSize: 16.sp,
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
                              fontSize: 8.sp,
                              fontFamily: AppFonts.nunito,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            'Tolu Oluyole',
                            style: TextStyle(
                              color: AppColor.primaryGray,
                              fontSize: 8.sp,
                              fontFamily: AppFonts.nunito,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'Soyez prêt. Montée des eaux attendue. Surveillez les actualités locales et préparez-vous à évacuer si nécessaire.',
                      style: TextStyle(
                        color: AppColor.primaryGray,
                        fontSize: 12.sp,
                        fontFamily: AppFonts.nunito,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PartnerCard extends StatelessWidget {
  const PartnerCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 261.w,
      margin: EdgeInsets.only(left: 16.w),
      padding: EdgeInsets.symmetric(
        horizontal: 15.w,
        vertical: 12.h,
      ),
      decoration: ShapeDecoration(
        color: const Color(0xFFF9F7F5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Sodexam',
                    style: TextStyle(
                      color: AppColor.primaryGray,
                      fontSize: 14.sp,
                      fontFamily: AppFonts.nunito,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  AppImages.icons.sodexam.image()
                ],
              ),
              SizedBox(height: 16.h),
              Text(
                'Info météo du Samedi 15 Juin 2024',
                style: TextStyle(
                  color: AppColor.primaryGray,
                  fontSize: 12.sp,
                  fontFamily: AppFonts.urbanist,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                "Les régions du Littoral ( Sud Comoé, District d’Abidjan, Grands  ponts, Gbokle et San Pédro) et de Nord-ouest ( Kabadougou, Folon,  Bagoue) observeront des pluies parfois orageuses au cours de cette nuit.\n\nRestons vigilants",
                style: TextStyle(
                  color: AppColor.primaryGray,
                  fontSize: 10.sp,
                  fontFamily: AppFonts.nunito,
                  fontWeight: FontWeight.w400,
                  letterSpacing: -0.50.sp,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  const ServiceCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: .45.sw,
      height: 130.h,
      padding: EdgeInsets.all(8.dm),
      decoration: ShapeDecoration(
        color: const Color(0xFFF9F7F5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(2.dm),
            decoration: ShapeDecoration(
              color: AppColor.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3.36.r),
              ),
            ),
            child: Icon(icon, color: AppColor.white),
          ),
          SizedBox(height: 8.h),
          Text(
            title,
            style: TextStyle(
              color: AppColor.primaryGray,
              fontSize: 14.sp,
              fontFamily: AppFonts.nunito,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            description,
            style: TextStyle(
              color: AppColor.primaryGray,
              fontSize: 8.sp,
              fontFamily: AppFonts.nunito,
              fontWeight: FontWeight.w400,
            ),
          )
        ],
      ),
    );
  }
}
