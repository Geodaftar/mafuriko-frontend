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

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
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
                      'Créez votre compte',
                      style: TextStyle(
                        color: AppColor.primaryGray,
                        fontSize: 18.sp,
                        fontFamily: AppFonts.inter,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'Remplissez le formulaire ci-dessous pour créer un compte',
                      style: TextStyle(
                        color: AppColor.secondaryGray,
                        fontSize: 16.sp,
                        fontFamily: AppFonts.nunito,
                        fontWeight: FontWeight.w400,
                        height: 1.5.sp,
                      ),
                    ),
                    SizedBox(height: 30.h),
                    AppFormField(
                      focus: _emailFocus,
                      controller: _emailController,
                      label: 'Email',
                      hint: 'Saisissez l’adresse email',
                      type: TextInputType.emailAddress,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                        SizedBox(
                          height: 20.h,
                          child: TextButton(
                            style:
                                TextButton.styleFrom(padding: EdgeInsets.zero),
                            onPressed: () {},
                            child: Text(
                              'Mot de passe oublié?',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontFamily: AppFonts.lato,
                              ),
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
                bottom: 0, // Adjust the bottom padding to 15.h
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
                          title: 'Se connecter',
                          onTap: () {
                            context.read<AuthBloc>().add(LoginRequested(
                                  userEmail: _emailController.text,
                                  userPassword: _passwordController.text,
                                ));
                          },
                        );
                      },
                    ),
                    Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          "Je n'ai pas de compte, ",
                          style: TextStyle(
                            color: const Color(0xFF6F6F6F),
                            fontSize: 14.sp,
                            fontFamily: AppFonts.lato,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(padding: EdgeInsets.zero),
                          onPressed: () {
                            context.pushNamed(Paths.signUp);
                          },
                          child: Text(
                            'inscrivez-vous',
                            style: TextStyle(
                              color: const Color(0xFF6F6F6F),
                              fontSize: 14.sp,
                              fontFamily: AppFonts.lato,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
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
