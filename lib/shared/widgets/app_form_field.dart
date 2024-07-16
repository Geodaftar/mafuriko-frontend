import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mafuriko/gen/assets.gen.dart';
import 'package:mafuriko/gen/colors.gen.dart';
import 'package:mafuriko/gen/fonts.gen.dart';

class AppFormField extends StatelessWidget {
  const AppFormField({
    super.key,
    required this.label,
    required this.hint,
    required FocusNode focus,
    required TextEditingController controller,
    this.isEmailField = true,
    this.isNameField = false,
    this.isObscure = false,
    this.type = TextInputType.text,
  })  : _focus = focus,
        _controller = controller;

  final FocusNode _focus;
  final TextEditingController _controller;
  final TextInputType type;

  final bool isEmailField;
  final bool isNameField;

  final String label;
  final String hint;

  final bool isObscure;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _focus.requestFocus(),
      child: Container(
        margin: EdgeInsets.only(bottom: 22.h),
        padding: EdgeInsets.fromLTRB(12.w, 8.h, 12.w, 10.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.r),
            border: Border.all(
              color: AppColor.secondaryGray,
              strokeAlign: BorderSide.strokeAlignOutside,
              width: .5.w,
            )),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      color: AppColor.primaryGray,
                      fontSize: 14.sp,
                      fontFamily: AppFonts.nunito,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextFormField(
                    controller: _controller,
                    focusNode: _focus,
                    textCapitalization: isEmailField
                        ? TextCapitalization.none
                        : isNameField
                            ? TextCapitalization.words
                            : TextCapitalization.sentences,
                    onTapOutside: (_) => FocusScope.of(context).unfocus(),
                    cursorHeight: 20.h,
                    textInputAction: TextInputAction.done,
                    obscuringCharacter: '❋',
                    cursorColor: AppColor.tertiaryGray,
                    obscureText: isObscure,
                    style: TextStyle(
                      color: AppColor.secondaryGray,
                      fontSize: 16.sp,
                      fontFamily: AppFonts.nunito,
                      fontWeight: FontWeight.w600,
                    ),
                    keyboardType: type,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 15.h),
                      constraints: BoxConstraints(maxHeight: 26.h),
                      alignLabelWithHint: false,
                      hintText: hint,
                      hintStyle: TextStyle(
                        color: AppColor.tertiaryGray,
                        fontSize: 12.sp,
                        fontFamily: AppFonts.nunito,
                        fontWeight: FontWeight.w400,
                        height: .21.h,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ],
              ),
            ),
            isNameField || isEmailField
                ? Container()
                : InkWell(
                    radius: 30.dm,
                    borderRadius: BorderRadius.circular(25.r),
                    onTap: () {},
                    child: SizedBox(
                      height: 22.h,
                      width: 22.w,
                      child: SvgPicture.asset(
                        isObscure
                            ? AppImages.icons.eyeSlash.path
                            : AppImages.icons.eye.path,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
