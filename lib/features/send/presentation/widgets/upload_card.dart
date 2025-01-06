import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:mafuriko/gen/gen.dart';

class UploaderImageCard extends StatefulWidget {
  const UploaderImageCard(
      {super.key, required this.onTap, required this.image});
  final void Function()? onTap;
  final XFile? image;

  @override
  State<UploaderImageCard> createState() => _UploaderImageCardState();
}

class _UploaderImageCardState extends State<UploaderImageCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Télécharger une image',
          style: TextStyle(
            color: AppColor.primaryGray,
            fontSize: 14.sp,
            fontFamily: AppFonts.nunito,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 6.h),
        InkWell(
          onTap: widget.onTap,
          borderRadius: BorderRadius.circular(6.23.r),
          child: Ink(
            decoration: ShapeDecoration(
              color: const Color(0xFFFCF6F2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.23.r),
              ),
            ),
            child: DottedBorderWidget(
              gap: 6.w,
              dotsWidth: 8.w,
              color: AppColor.primary,
              radius: 6.23.r,
              child: Container(
                width: 330.w,
                height: 109.68.h,
                alignment: Alignment.center,
                child: widget.image != null
                    ? Container(
                        width: 330.w,
                        height: 109.68.h,
                        decoration: ShapeDecoration(
                          color: const Color(0xFFFCF6F2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.23.r),
                          ),
                          image: DecorationImage(
                            image: FileImage(
                              File('${widget.image?.path}'),
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 35.53.w,
                            height: 32.77.h,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(AppImages.icons.picture.path),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Text(
                            'Cliquez ici pour ajouter une image ou parcourir',
                            style: TextStyle(
                              color: const Color(0xFF132A00),
                              fontSize: 13.30.sp,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            'Prise en charge : PNG, JPG, JPEG, WEBP',
                            style: TextStyle(
                              color: const Color(0xFF959DB1),
                              fontSize: 9.95.sp,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
