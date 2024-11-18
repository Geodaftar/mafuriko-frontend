import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:mafuriko/features/authentication/presentation/blocs/bloc/auth_bloc.dart';
import 'package:mafuriko/features/authentication/presentation/widgets/return_app_bar.dart';
import 'package:mafuriko/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:mafuriko/gen/gen.dart';
import 'package:mafuriko/shared/widgets/app_form_field.dart';
import 'package:mafuriko/shared/widgets/buttons.dart';

class ModifyPasswordScreen extends StatefulWidget {
  const ModifyPasswordScreen({super.key});

  @override
  State<ModifyPasswordScreen> createState() => _ModifyPasswordScreenState();
}

class _ModifyPasswordScreenState extends State<ModifyPasswordScreen> {
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();
  final FocusNode _currentPasswordFocus = FocusNode();
  final FocusNode _newPasswordFocus = FocusNode();
  final FocusNode _confirmPassFocus = FocusNode();

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPassController.dispose();
    _currentPasswordFocus.dispose();
    _newPasswordFocus.dispose();
    _confirmPassFocus.dispose();
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
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        return Text(
                          'Mot de passe oublié',
                          style: TextStyle(
                            color: AppColor.primaryGray,
                            fontSize: 18.sp,
                            fontFamily: AppFonts.inter,
                            fontWeight: FontWeight.w500,
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'Entrez votre numéro ci-dessous',
                      style: TextStyle(
                        color: AppColor.secondaryGray,
                        fontSize: 16.sp,
                        fontFamily: AppFonts.nunito,
                        fontWeight: FontWeight.w400,
                        height: 1.5.sp,
                      ),
                    ),
                    SizedBox(height: 60.h),
                    AppFormField(
                      focus: _currentPasswordFocus,
                      controller: _currentPasswordController,
                      isEmailField: false,
                      isObscure: false,
                      displayObscure: false,
                      onObscured: () {
                        context.read<ToggleCubit>().toggler();
                      },
                      label: 'Mot de passe',
                      hint: 'Saisissez votre mot de passe actuel',
                    ),
                    BlocBuilder<ToggleCubit, bool>(
                      builder: (context, state) {
                        return AppFormField(
                          focus: _newPasswordFocus,
                          controller: _newPasswordController,
                          isEmailField: false,
                          isObscure: state,
                          onObscured: () {
                            context.read<ToggleCubit>().toggler();
                          },
                          label: 'Nouveau Mot de passe',
                          hint: 'Saisissez votre nouveau mot de passe',
                        );
                      },
                    ),
                    BlocBuilder<ToggleCubit, bool>(
                      builder: (context, state) {
                        return AppFormField(
                          focus: _confirmPassFocus,
                          controller: _confirmPassController,
                          isEmailField: false,
                          isObscure: state,
                          onObscured: () {
                            context.read<ToggleCubit>().toggler();
                          },
                          label: 'Confirmer le mot de passe',
                          hint: 'Saisissez à nouveau le mot de passe',
                        );
                      },
                    ),
                    SizedBox(height: 12.h),
                  ],
                ),
              ),
              Positioned(
                bottom: 0.h,
                left: 0,
                right: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    BlocConsumer<ProfileBloc, ProfileState>(
                      listener: (context, state) {
                        if (state is ProfileUpdatePassFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.red[400],
                              margin: EdgeInsets.fromLTRB(20.w, 0, 20.w, 110.h),
                              content: Row(
                                children: [
                                  Icon(
                                    Icons.clear_outlined,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 10.w),
                                  Text(
                                    state.message,
                                    style: const TextStyle(
                                      fontFamily: AppFonts.nunito,
                                      color: AppColor.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else if (state is ProfileUpdatePassSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              behavior: SnackBarBehavior.floating,
                              margin: EdgeInsets.fromLTRB(20.w, 0, 20.w, 110.h),
                              backgroundColor: AppColor.primary,
                              content: Row(
                                children: [
                                  Icon(
                                    Icons.check_circle_outline_outlined,
                                    color: Colors.green[400],
                                  ),
                                  SizedBox(width: 10.w),
                                  const Text(
                                    'Mot de passe changé avec succès',
                                    style: TextStyle(
                                      fontFamily: AppFonts.nunito,
                                      color: AppColor.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is ProfileLoading) {
                          return Center(
                            child: SizedBox(
                              width: 25.w,
                              height: 30.h,
                              child: const CircularProgressIndicator(),
                            ),
                          );
                        }

                        return PrimaryExpandedButton(
                          title: 'Procéder',
                          onTap: () {
                            context.read<ProfileBloc>().add(ModifyPasswordEvent(
                                  currentPassword:
                                      _currentPasswordController.text.trim(),
                                  newPassword:
                                      _newPasswordController.text.trim(),
                                  confirmPassword:
                                      _confirmPassController.text.trim(),
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
