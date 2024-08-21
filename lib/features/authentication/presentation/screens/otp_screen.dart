import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mafuriko/core/routes/constant_path.dart';
import 'package:mafuriko/features/authentication/presentation/blocs/bloc/auth_bloc.dart';
import 'package:mafuriko/features/authentication/presentation/widgets/return_app_bar.dart';
import 'package:mafuriko/gen/gen.dart';
import 'package:mafuriko/shared/widgets/buttons.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key, required this.vId, required this.phoneNumber});

  final String vId;
  final String phoneNumber;

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final TextEditingController _otpController = TextEditingController();

  final FocusNode _otpFocus = FocusNode();

  @override
  void dispose() {
    _otpController.dispose();
    _otpFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const BackAppBar(
        title: 'Revenir',
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(18.w, 0, 18.w, 20.h),
        child: Form(
          child: Stack(
            children: [
              Positioned(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.h),
                    Text(
                      'Vérifions vous',
                      style: TextStyle(
                        color: AppColor.primaryGray,
                        fontSize: 20.sp,
                        fontFamily: AppFonts.inter,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    SizedBox(
                      width: 256.w,
                      child: Text(
                        'Veuillez entrer le code à 4 chiffres pour vérifier votre identité.',
                        style: TextStyle(
                          color: AppColor.secondaryGray,
                          fontSize: 16.sp,
                          fontFamily: AppFonts.nunito,
                          fontWeight: FontWeight.w400,
                          height: 1.5.sp,
                        ),
                      ),
                    ),
                    SizedBox(height: 60.h),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        BlocBuilder<ToggleCubit, bool>(
                          builder: (context, state) {
                            return Container(
                              margin: EdgeInsets.symmetric(horizontal: 10.w),
                              child: PinCodeTextField(
                                textStyle: TextStyle(
                                  color: AppColor.primaryGray,
                                  fontSize: 25.sp,
                                  fontFamily: AppFonts.nunito,
                                  fontWeight: FontWeight.w600,
                                ),
                                appContext: context,
                                length: 6,
                                controller: _otpController,
                                cursorColor: AppColor.primaryGray,
                                keyboardType: TextInputType.number,
                                cursorHeight: 28.h,
                                pinTheme: PinTheme(
                                  borderWidth: 1.w,
                                  inactiveColor: const Color(0xFFC4C4C4),
                                  activeColor: AppColor.secondaryGray,
                                  fieldWidth: 49.w,
                                  selectedColor: AppColor.primary,
                                  shape: PinCodeFieldShape.box,
                                  borderRadius: BorderRadius.circular(3.r),
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: 20.h,
                          child: TextButton(
                            style:
                                TextButton.styleFrom(padding: EdgeInsets.zero),
                            onPressed: () {
                              context.pushNamed(Paths.forgotPassword);
                            },
                            child: Wrap(
                              spacing: 10.w,
                              // alignment: WrapAlignment.center,
                              children: [
                                Text(
                                  "Je n'ai pas reçu de code OTP ?",
                                  style: TextStyle(
                                    color: const Color(0xFF6F6F6F),
                                    fontSize: 16.sp,
                                    fontFamily: AppFonts.inter,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(
                                  height: 20.h,
                                  // width: 25.h,
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      alignment: Alignment.topLeft,
                                    ),
                                    onPressed: () {},
                                    child: Text(
                                      'Renvoyer',
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontFamily: AppFonts.inter,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                  ],
                ),
              ),
              Positioned(
                bottom: 30.h, // Adjust the bottom padding to 15.h
                left: 0,
                right: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    BlocConsumer<AuthBloc, AuthState>(
                      listener: (context, state) {
                        if (state is AuthFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.message)),
                          );
                        } else if (state is SuccessOTP) {
                          context.pushNamed(Paths.forgotPassword);
                        }
                      },
                      builder: (context, state) {
                        if (state is AuthLoading) {
                          return Center(
                            child: SizedBox(
                              width: 25.w,
                              height: 30.h,
                              child: const CircularProgressIndicator(),
                            ),
                          );
                        }

                        return PrimaryExpandedButton(
                          title: 'Confirmer OTP',
                          onTap: () {
                            context.read<AuthBloc>().add(VerifyOTPEvent(
                                  otpCode: _otpController.text,
                                  vId: widget.vId,
                                  phoneNumber: widget.phoneNumber,
                                ));
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
