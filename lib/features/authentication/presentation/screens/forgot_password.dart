import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mafuriko/core/routes/constant_path.dart';
import 'package:mafuriko/features/authentication/presentation/blocs/bloc/auth_bloc.dart';
import 'package:mafuriko/features/authentication/presentation/widgets/return_app_bar.dart';
import 'package:mafuriko/gen/gen.dart';
import 'package:mafuriko/shared/widgets/app_form_field.dart';
import 'package:mafuriko/shared/widgets/buttons.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPassFocus = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
    _confirmPassController.dispose();
    _passwordFocus.dispose();
    _confirmPassFocus.dispose();
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
                    BlocBuilder<ToggleCubit, bool>(
                      builder: (context, state) {
                        return AppFormField(
                          focus: _passwordFocus,
                          controller: _passwordController,
                          isEmailField: false,
                          isObscure: state,
                          onObscured: () {
                            context.read<ToggleCubit>().toggler();
                          },
                          label: 'Mot de passe',
                          hint: 'Saisissez mot de passe',
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
                bottom: 0.h, // Adjust the bottom padding to 15.h
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
                        } else if (state is AuthSuccess) {
                          context.pushNamed(Paths.home);
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
                          title: 'Procéder',
                          onTap: () {
                            context
                                .read<AuthBloc>()
                                .add(UpdateForgotPasswordEvent(
                                  newPass: _passwordController.text.trim(),
                                  newPassConfirm:
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
