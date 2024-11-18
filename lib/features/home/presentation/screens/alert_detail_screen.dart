import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:mafuriko/features/home/presentation/widgets/home_widget.dart';
import 'package:mafuriko/features/send/domain/entities/alert_entity.dart';
import 'package:mafuriko/shared/widgets/custom_app_bar.dart';

class AlertDetailScreen extends StatelessWidget {
  const AlertDetailScreen({super.key, this.alert});

  final AlertEntity? alert;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBackAppBar(title: '${alert?.floodScene}'),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 135.h,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(
                      alert?.image ??
                          'https://mafu.ams3.cdn.digitaloceanspaces.com/images_flood/palmeraie_programme5.jpg',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              FLoodInformationCard(
                alert: alert,
              ),
              TechnicalInfosComponentCard(
                lat: alert?.floodLocation?['latitude'],
                lng: alert?.floodLocation?['longitude'],
                weather: alert?.weather,
                temperature: alert?.temperature,
              ),
              SizedBox(height: 25.h),
            ],
          ),
        ),
      ),
    );
  }
}
