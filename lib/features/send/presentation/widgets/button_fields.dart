import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mafuriko/gen/gen.dart';

class PopActionButtonField extends StatelessWidget {
  const PopActionButtonField({
    super.key,
    required this.title,
    required this.hint,
    required this.value,
    this.onTap,
  });

  final String title;
  final String hint;
  final String value;

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 2.h),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned(
                    top: 11.h,
                    left: 12.w,
                    child: Text(
                      title,
                      style: TextStyle(
                        color: AppColor.primaryGray,
                        fontSize: 14.sp,
                        fontFamily: AppFonts.nunito,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: 12.w, top: 32.h, right: 12.w, bottom: 8.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.r),
                      border: Border.all(
                        color: AppColor.secondaryGray,
                        strokeAlign: BorderSide.strokeAlignOutside,
                        width: .5.w,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          value != '' ? value : hint,
                          style: TextStyle(
                            color: AppColor.secondaryGray,
                            fontSize: 16.sp,
                            fontFamily: AppFonts.nunito,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 20.h,
                    right: 12.w,
                    child: const Icon(Icons.keyboard_arrow_down),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomDropdownButtonField extends StatefulWidget {
  const CustomDropdownButtonField({
    super.key,
    required this.title,
    required this.val,
    required this.hint,
    this.items,
    this.onSaved,
    this.validator,
  });

  final String title;
  final String? val;
  final String hint;

  final List<DropdownMenuItem<String>>? items;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;

  @override
  State<CustomDropdownButtonField> createState() =>
      _CustomDropdownButtonFieldState();
}

class _CustomDropdownButtonFieldState extends State<CustomDropdownButtonField> {
  final FocusNode _focus = FocusNode();

  @override
  void initState() {
    super.initState();
    _focus.canRequestFocus;
  }

  @override
  void dispose() {
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 2.h),
      child: InkWell(
        onTap: () => _focus.requestFocus(),
        child: Row(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned(
                    top: 11.h,
                    left: 12.w,
                    child: Text(
                      widget.title,
                      style: TextStyle(
                        color: AppColor.primaryGray,
                        fontSize: 14.sp,
                        fontFamily: AppFonts.nunito,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Container(
                    height: 55.8.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.r),
                      border: Border.all(
                        color: AppColor.secondaryGray,
                        strokeAlign: BorderSide.strokeAlignOutside,
                        width: .5.w,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 15.h,
                    height: 40.h,
                    width: 1.sw - 60.w,
                    child: DropdownButtonFormField2<String>(
                      focusNode: _focus,
                      isExpanded: true,
                      alignment: Alignment.centerLeft,
                      menuItemStyleData: MenuItemStyleData(
                        height: 40.h,
                        padding: EdgeInsets.zero,
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(-4.w, 0.h, 0, 0.h),
                        constraints: BoxConstraints(maxHeight: 20.h),
                        border: InputBorder.none,
                      ),
                      value: widget.val,
                      hint: Text(
                        widget.hint,
                        style: TextStyle(
                          color: AppColor.secondaryGray,
                          fontSize: 16.sp,
                          fontFamily: AppFonts.nunito,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      items: widget.items,
                      validator: widget.validator,
                      onChanged: (value) {
                        //Do something when selected item is changed.
                      },
                      onSaved: widget.onSaved,
                      buttonStyleData: ButtonStyleData(
                        padding: EdgeInsets.only(right: 11.w),
                      ),
                      iconStyleData: IconStyleData(
                        icon: Container(),
                        iconSize: 0,
                      ),
                      dropdownStyleData: DropdownStyleData(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
                          color: Colors.white,
                        ),
                        offset: Offset(0, -10.h),
                        elevation: 2,
                        maxHeight: 200.h,
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 0.h),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 20.h,
                    right: 12.w,
                    child: const Icon(Icons.keyboard_arrow_down),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
