import 'package:flutter/material.dart';
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
    FocusNode? focus,
    TextEditingController? controller,
    this.isEmailField = true,
    this.isNameField = false,
    this.isObscure = false,
    this.onObscured,
    this.onValidate,
    this.enabled = true,
    this.type = TextInputType.text,
  })  : _focus = focus,
        _controller = controller;

  final FocusNode? _focus;
  final TextEditingController? _controller;
  final TextInputType type;

  final bool isEmailField;
  final bool isNameField;
  final bool enabled;

  final String label;
  final String hint;

  final bool isObscure;
  final VoidCallback? onObscured;
  final String? Function(String? val)? onValidate;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 22.h),
      child: GestureDetector(
        onTap: () => _focus?.requestFocus(),
        child: Row(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned(
                    top: 11.h,
                    left: 12.w,
                    child: Text(
                      label,
                      style: TextStyle(
                        color: AppColor.primaryGray,
                        fontSize: 14.sp,
                        fontFamily: AppFonts.nunito,
                        fontWeight: FontWeight.w400,
                      ),
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
                    textAlignVertical: TextAlignVertical.bottom,
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
                    enabled: enabled,
                    keyboardType: type,
                    validator: onValidate,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                          left: 12.w, top: 30.h, right: 12.w, bottom: 8.h),
                      hintText: hint,
                      hintStyle: TextStyle(
                        color: AppColor.tertiaryGray,
                        fontSize: 12.sp,
                        fontFamily: AppFonts.nunito,
                        fontWeight: FontWeight.w400,
                        height: .21.h,
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.r),
                        borderSide: BorderSide(
                          color: AppColor.red,
                          strokeAlign: BorderSide.strokeAlignOutside,
                          width: .5.w,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.r),
                        borderSide: BorderSide(
                          color: AppColor.secondaryGray,
                          strokeAlign: BorderSide.strokeAlignOutside,
                          width: .5.w,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.r),
                        borderSide: BorderSide(
                          color: AppColor.secondaryGray,
                          strokeAlign: BorderSide.strokeAlignOutside,
                          width: .5.w,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.r),
                        borderSide: BorderSide(
                          color: AppColor.secondaryGray,
                          strokeAlign: BorderSide.strokeAlignOutside,
                          width: .5.w,
                        ),
                      ),
                    ),
                  ),
                  if (!isNameField && !isEmailField)
                    Positioned(
                      top: 25.h,
                      right: 12.w,
                      child: InkWell(
                        radius: 30.dm,
                        borderRadius: BorderRadius.circular(25.r),
                        onTap: onObscured,
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
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppFormFieldDescription extends StatelessWidget {
  const AppFormFieldDescription({
    super.key,
    required this.label,
    required this.hint,
    FocusNode? focus,
    TextEditingController? controller,
    this.isEmailField = true,
    this.isNameField = false,
    this.isObscure = false,
    this.onObscured,
    this.onValidate,
    this.type = TextInputType.text,
    this.onChanged,
  })  : _focus = focus,
        _controller = controller;

  final FocusNode? _focus;
  final TextEditingController? _controller;
  final TextInputType type;

  final bool isEmailField;
  final bool isNameField;

  final String label;
  final String hint;

  final bool isObscure;
  final VoidCallback? onObscured;
  final String? Function(String? val)? onValidate;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 22.h),
      child: GestureDetector(
        onTap: () => _focus?.requestFocus(),
        child: Row(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned(
                    top: 11.h,
                    left: 12.w,
                    child: Text(
                      label,
                      style: TextStyle(
                        color: AppColor.primaryGray,
                        fontSize: 14.sp,
                        fontFamily: AppFonts.nunito,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: _controller,
                    focusNode: _focus,
                    onChanged: onChanged,
                    textCapitalization: isEmailField
                        ? TextCapitalization.none
                        : isNameField
                            ? TextCapitalization.words
                            : TextCapitalization.sentences,
                    onTapOutside: (_) => FocusScope.of(context).unfocus(),
                    cursorHeight: 20.h,
                    textAlignVertical: TextAlignVertical.bottom,
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
                    validator: onValidate,
                    keyboardAppearance: Brightness.light,
                    maxLines: 7,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                          left: 12.w, top: 30.h, right: 12.w, bottom: 8.h),
                      hintText: hint,
                      hintStyle: TextStyle(
                        color: AppColor.tertiaryGray,
                        fontSize: 12.sp,
                        fontFamily: AppFonts.nunito,
                        fontWeight: FontWeight.w400,
                        height: .21.h,
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.r),
                        borderSide: BorderSide(
                          color: AppColor.red,
                          strokeAlign: BorderSide.strokeAlignOutside,
                          width: .5.w,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.r),
                        borderSide: BorderSide(
                          color: AppColor.secondaryGray,
                          strokeAlign: BorderSide.strokeAlignOutside,
                          width: .5.w,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.r),
                        borderSide: BorderSide(
                          color: AppColor.secondaryGray,
                          strokeAlign: BorderSide.strokeAlignOutside,
                          width: .5.w,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.r),
                        borderSide: BorderSide(
                          color: AppColor.secondaryGray,
                          strokeAlign: BorderSide.strokeAlignOutside,
                          width: .5.w,
                        ),
                      ),
                    ),
                  ),
                  if (!isNameField && !isEmailField)
                    Positioned(
                      top: 25.h,
                      right: 12.w,
                      child: InkWell(
                        radius: 30.dm,
                        borderRadius: BorderRadius.circular(25.r),
                        onTap: onObscured,
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
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
