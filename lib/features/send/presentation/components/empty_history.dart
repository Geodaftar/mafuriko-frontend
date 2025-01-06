import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mafuriko/gen/gen.dart';
import 'package:mafuriko/shared/widgets/buttons.dart';

class EmptyHistory extends StatelessWidget {
  final TabController tabController; // Ajoutez ce champ

  const EmptyHistory({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(30.w, 0, 30.w, 40.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AppImages.icons.emptyH.path),
              SizedBox(height: 42.h),
              Text(
                'Aucun événement signalé pour l\'instant',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColor.primaryGray,
                  fontSize: 18.sp,
                  fontFamily: AppFonts.nunito,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 5.h),
              Text(
                'Tous vos événements signalés apparaîtront ici',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.sp,
                  fontFamily: AppFonts.nunito,
                  fontWeight: FontWeight.w400,
                ),
              ),
              // SizedBox(height: 42.h,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 24.h),
                child: PrimaryExpandedButton(
                  title: 'Signaler un incident',
                  onTap: () {
                    tabController.index = 0;
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
