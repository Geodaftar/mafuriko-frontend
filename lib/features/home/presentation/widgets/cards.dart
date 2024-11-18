import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';

import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mafuriko/features/home/presentation/cubit/navigation_cubit.dart';

import 'package:mafuriko/features/home/presentation/widgets/skeleton.dart';
import 'package:mafuriko/features/send/domain/entities/alert_entity.dart';
import 'package:mafuriko/gen/gen.dart';

String capitalizeFirstLetter(String? text) {
  if (text == null || text.isEmpty) return '';
  return text[0].toUpperCase() + text.substring(1);
}

// List<Placemark> placeMarks = await placemarkFromCoordinates(
//             position.latitude, position.longitude);

Future<String?> place(double latitude, double longitude) async {
  List<Placemark> placeMarks =
      await placemarkFromCoordinates(latitude, longitude);
  final city =
      '${placeMarks[1].subLocality}${placeMarks[1].subLocality == '' ? '' : ','} ${placeMarks[1].locality}';
  return city;
}

class Section extends StatelessWidget {
  const Section({super.key, required this.title, this.route, this.routeTitle});

  final String title;
  final String? routeTitle;
  final String? route;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16.h),
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
          InkWell(
            borderRadius: BorderRadius.circular(8.r),
            onTap: route == null
                ? () => context.read<NavigationCubit>().updateIndex(1)
                : () => GoRouter.of(context).pushNamed('$route'),
            child: Container(
              alignment: Alignment.centerRight,
              // width: 65.w,
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              height: 25.h,
              child: Text(
                routeTitle ?? 'Voir tout',
                style: TextStyle(
                  color: AppColor.secondaryGray,
                  fontSize: 12.sp,
                  fontFamily: AppFonts.nunito,
                  fontWeight: FontWeight.w400,
                ),
              ),
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
    this.floodDescription,
    this.floodScene,
    this.image,
    this.postAt,
    this.margin,
    this.postedBy,
    this.pos,
  });

  final String? image;
  final String? floodScene;
  final String? floodDescription;
  final DateTime? postAt;
  final String? postedBy;
  final Map<String, dynamic>? pos;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 271.w,
      margin: margin,
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
                image: image == null || image == ''
                    ? AssetImage(AppImages.images.onboarding.thumb.path)
                    : CachedNetworkImageProvider(
                        image!,
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
                      '${DateFormat("HH'h'MM").format(postAt ?? DateTime.now())} || ${DateFormat('dd/MM/yyyy').format(postAt ?? DateTime.now())}',
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
                      capitalizeFirstLetter(floodScene),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
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
                          FutureBuilder<String?>(
                              future: place(double.parse(pos?['latitude']),
                                  double.parse(pos?['longitude'])),
                              builder: (context, snapshot) {
                                return Text(
                                  '${snapshot.data} || Envoyée par: ',
                                  style: TextStyle(
                                    color: AppColor.primaryGray,
                                    fontSize: 8.sp,
                                    fontFamily: AppFonts.nunito,
                                    fontWeight: FontWeight.w400,
                                  ),
                                );
                              }),
                          Text(
                            postedBy.toString(),
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
                    SizedBox(
                      height: 60.h,
                      child: Text(
                        floodDescription ?? 'N/A',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColor.primaryGray,
                          fontSize: 12.sp,
                          fontFamily: AppFonts.nunito,
                          fontWeight: FontWeight.w400,
                        ),
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

class AlertWithMoreDetailCard extends StatelessWidget {
  const AlertWithMoreDetailCard({
    super.key,
    this.floodDescription,
    this.floodScene,
    this.image,
    this.postAt,
    this.postedBy,
    this.pos,
    this.isHistoryView = false,
    this.status,
  });

  final String? image;
  final String? floodScene;
  final String? floodDescription;
  final DateTime? postAt;
  final String? postedBy;
  final Map<String, dynamic>? pos;
  final bool isHistoryView;
  final String? status;

  Color alertStatusColor(String status) {
    switch (status) {
      case 'Validé':
        return Colors.green;
      case 'En attente':
        return Colors.grey;
      case 'Rejeté':
        return AppColor.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 271.w,
      margin: EdgeInsets.symmetric(horizontal: 30.w),
      decoration: ShapeDecoration(
        color: const Color(0xFFFCF6F2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 135.h,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  image: DecorationImage(
                    image: image == null || image == ''
                        ? AssetImage(AppImages.images.onboarding.thumb.path)
                        : CachedNetworkImageProvider(
                            // cacheManager:
                            //     CachedNetworkImageProvider.defaultCacheManager,
                            image.toString(),
                          ),
                    fit: BoxFit.cover,
                  ),
                ),
                // child: ClipRRect(
                //   borderRadius: BorderRadius.circular(10.r),
                //   child: CachedNetworkImage(
                //     imageUrl: image.toString(),
                //     fit: BoxFit.cover,
                //     progressIndicatorBuilder: (context, url, p) => Center(
                //       child: CircularProgressIndicator(
                //         value: p.progress,
                //       ),
                //     ),
                //     errorWidget: (context, url, error) => const Icon(Icons.error),
                //   ),
                // ),
              ),
              if (isHistoryView)
                Container(
                  // width: 79.w,
                  height: 30.h,
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
                  // alignment: Alignment.center,
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: alertStatusColor(status.toString()),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.r),
                        bottomRight: Radius.circular(10.r),
                      ),
                    ),
                  ),
                  child: Text(
                    '$status',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontFamily: AppFonts.nunito,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 12.h),
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
                      '${DateFormat("HH'h'MM").format(postAt ?? DateTime.now())} || ${DateFormat('dd/MM/yyyy').format(postAt ?? DateTime.now())}',
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
                      capitalizeFirstLetter(floodScene),
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
                          FutureBuilder<String?>(
                              future: place(double.parse(pos?['latitude']),
                                  double.parse(pos?['longitude'])),
                              builder: (context, snapshot) {
                                return Text(
                                  '${snapshot.data} || Envoyée par: ',
                                  style: TextStyle(
                                    color: AppColor.primaryGray,
                                    fontSize: 8.sp,
                                    fontFamily: AppFonts.nunito,
                                    fontWeight: FontWeight.w400,
                                  ),
                                );
                              }),
                          Text(
                            postedBy.toString(),
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
                    SizedBox(
                      height: 40.h,
                      child: Text(
                        floodDescription ?? 'N/A',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColor.primaryGray,
                          fontSize: 12.sp,
                          fontFamily: AppFonts.nunito,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 12.h),
                  // child: Row(
                  //   // mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     const Icon(
                  //       Icons.thumb_up_off_alt_outlined,
                  //       color: AppColor.primary,
                  //     ),
                  //     Text(
                  //       '1,964',
                  //       style: TextStyle(
                  //         color: AppColor.primary,
                  //         fontSize: 10.37.sp,
                  //         fontFamily: AppFonts.nunito,
                  //         fontWeight: FontWeight.w700,
                  //       ),
                  //     ),
                  //     SizedBox(width: 10.h),
                  //     const Icon(
                  //       Icons.chat_bubble_rounded,
                  //       color: AppColor.primary,
                  //     ),
                  //     Text(
                  //       '135',
                  //       style: TextStyle(
                  //         color: AppColor.primary,
                  //         fontSize: 10.37.sp,
                  //         fontFamily: AppFonts.nunito,
                  //         fontWeight: FontWeight.w700,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ),
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
    this.margin,
  });
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 261.w,
      margin: margin,
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

class TechnicalInfosComponentCard extends StatelessWidget {
  const TechnicalInfosComponentCard({
    super.key,
    this.lat = '0.0',
    this.lng = '0.0',
    required this.weather,
    required this.temperature,
  });

  final String? lat;
  final String? lng;
  final String? weather;
  final String? temperature;

  // final LatLng coordinate;

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 330.w,
      // height: 234.h,
      margin: EdgeInsets.only(top: 25.h),
      padding: EdgeInsets.all(15.dm),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1.50.w, color: const Color(0xFFDEE5E5)),
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
                '${temperature != '' ? temperature : 'N/A'} ${temperature == '' ? '' : '°C'}',
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
                '${weather != '' ? weather : 'N/A'}',
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
                '$lat , $lng',
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
    );
  }
}

class FLoodInformationCard extends StatelessWidget {
  const FLoodInformationCard({super.key, required this.alert});

  final AlertEntity? alert;

  @override
  Widget build(BuildContext context) {
    return Column(
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
              '${DateFormat("HH'h'MM").format(alert?.postAt ?? DateTime.now())} || ${DateFormat('dd/MM/yyyy').format(alert?.postAt ?? DateTime.now())}',
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
              capitalizeFirstLetter(alert?.floodScene),
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
                  FutureBuilder<String?>(
                      future: place(
                          double.parse(alert?.floodLocation?['latitude']),
                          double.parse(alert?.floodLocation?['longitude'])),
                      builder: (context, snapshot) {
                        return Text(
                          '${snapshot.data} || Envoyée par: ',
                          style: TextStyle(
                            color: AppColor.primaryGray,
                            fontSize: 12.sp,
                            fontFamily: AppFonts.nunito,
                            fontWeight: FontWeight.w400,
                          ),
                        );
                      }),
                  Text(
                    '${alert?.postBy}',
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
              alert?.floodDescription ?? 'N/A',
              style: TextStyle(
                color: AppColor.primaryGray,
                fontSize: 14.sp,
                fontFamily: AppFonts.nunito,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class AlertSkeletonCard extends StatelessWidget {
  const AlertSkeletonCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          const BoxShadow(
            color: Color(0xff969292),
            offset: Offset(5, 3),
            blurRadius: 8,
            spreadRadius: -6,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Skeleton(
            height: 127.h,
            width: 250.w,
          ),
          SizedBox(height: 8.h),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 15.w,
              vertical: 12.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Skeleton(
                  height: 15.h,
                  width: 100.w,
                ),
                SizedBox(height: 8.h),
                Skeleton(
                  height: 15.h,
                  width: 140.w,
                ),
                SizedBox(height: 8.h),
                Skeleton(
                  height: 8.h,
                  width: 140.w,
                ),
                SizedBox(height: 8.h),
                Skeleton(
                  height: 45.h,
                  width: 200.w,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
