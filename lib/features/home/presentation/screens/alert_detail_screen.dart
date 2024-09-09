import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:mafuriko/features/home/presentation/widgets/home_widget.dart';
import 'package:mafuriko/gen/gen.dart';
import 'package:mafuriko/shared/widgets/custom_app_bar.dart';

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
              const FLoodInformationCard(),
              const TechnicalInfosComponentCard(),
              SizedBox(height: 25.h),
            ],
          ),
        ),
      ),
    );
  }
}
