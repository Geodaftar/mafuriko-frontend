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

class VerifyNumberScreen extends StatefulWidget {
  const VerifyNumberScreen({super.key});

  @override
  State<VerifyNumberScreen> createState() => _VerifyNumberScreenState();
}

class _VerifyNumberScreenState extends State<VerifyNumberScreen> {
  final TextEditingController _phoneController = TextEditingController();

  final FocusNode _phoneFocus = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _phoneController.dispose();
    _phoneFocus.dispose();
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
                      'Mot de passe oublié',
                      style: TextStyle(
                        color: AppColor.primaryGray,
                        fontSize: 18.sp,
                        fontFamily: AppFonts.inter,
                        fontWeight: FontWeight.w500,
                      ),
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
                          focus: _phoneFocus,
                          controller: _phoneController,
                          label: 'Téléphone',
                          hint: 'Saisissez le numéro de téléphone',
                          type: TextInputType.phone,
                        );
                      },
                    ),
                    SizedBox(height: 12.h),
                  ],
                ),
              ),
              Positioned(
                bottom: 50.h, // Adjust the bottom padding to 15.h
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
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Connexion réussie')),
                          );
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
                            // context.read<AuthBloc>().add(LoginRequested(
                            //       userEmail: _emailController.text,
                            //       userPassword: _passwordController.text,
                            //     ));
                            context.pushNamed(Paths.otpScreen);
                          },
                        );
                      },
                    ),
                    // Wrap(
                    //   alignment: WrapAlignment.center,
                    //   crossAxisAlignment: WrapCrossAlignment.center,
                    //   children: [
                    //     Text(
                    //       "Je n'ai pas de compte, ",
                    //       style: TextStyle(
                    //         color: const Color(0xFF6F6F6F),
                    //         fontSize: 14.sp,
                    //         fontFamily: AppFonts.lato,
                    //         fontWeight: FontWeight.w400,
                    //       ),
                    //     ),
                    //     TextButton(
                    //       style: TextButton.styleFrom(padding: EdgeInsets.zero),
                    //       onPressed: () {
                    //         context.pushNamed(Paths.signUp);
                    //       },
                    //       child: Text(
                    //         'Procéder',
                    //         style: TextStyle(
                    //           color: const Color(0xFF6F6F6F),
                    //           fontSize: 14.sp,
                    //           fontFamily: AppFonts.lato,
                    //           fontWeight: FontWeight.w700,
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
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
