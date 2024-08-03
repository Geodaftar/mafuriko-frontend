import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mafuriko/core/routes/constant_path.dart';
import 'package:mafuriko/features/authentication/presentation/blocs/bloc/auth_bloc.dart';
import 'package:mafuriko/features/authentication/presentation/widgets/auth_option.dart';
import 'package:mafuriko/features/authentication/presentation/widgets/return_app_bar.dart';
import 'package:mafuriko/gen/gen.dart';
import 'package:mafuriko/shared/widgets/app_form_field.dart';
import 'package:mafuriko/shared/widgets/buttons.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPassFocus = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPassController.dispose();
    _nameFocus.dispose();
    _emailFocus.dispose();
    _phoneFocus.dispose();
    _passwordFocus.dispose();
    _confirmPassFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: const BackAppBar(
        title: 'Revenir',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(18.w, 0, 18.w, 20.h),
          child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
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
                    focus: _nameFocus,
                    controller: _nameController,
                    isNameField: true,
                    isEmailField: false,
                    label: 'Nom et prénom',
                    hint: 'Saisissez votre nom complet',
                    type: TextInputType.name,
                  ),
                  AppFormField(
                    focus: _emailFocus,
                    controller: _emailController,
                    label: 'Email',
                    hint: 'Saisissez l’adresse email',
                    type: TextInputType.emailAddress,
                  ),
                  AppFormField(
                    focus: _phoneFocus,
                    controller: _phoneController,
                    label: 'Téléphone',
                    hint: 'Saisissez le numéro de téléphone',
                    type: TextInputType.phone,
                  ),
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
                  BlocConsumer<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state is AuthFailure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.message)),
                        );
                      } else if (state is AuthSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Inscription réussie')),
                        );
                        context.pushNamed(Paths.home);
                        // Navigate to the next screen or perform any other action on success
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
                        title: 'Continuer',
                        onTap: () {
                          context.read<AuthBloc>().add(SignUpRequested(
                                userEmail: _emailController.text,
                                userName: _nameController.text,
                                userNumber: _phoneController.text,
                                userPassword: _passwordController.text,
                                confirmPassword: _confirmPassController.text,
                              ));
                        },
                      );
                    },
                  ),
                  OptionAuth(
                    message: "Vous avez déjà un compte?",
                    option: "Connectez-vous",
                    path: Paths.login,
                  ),
                  SizedBox(
                    height: 22.h,
                    child: TextButton(
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      onPressed: () {},
                      child: Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Color(0xFF6F6F6F),
                            ),
                          ),
                        ),
                        child: Text(
                          'Ajouter un profil visiteur',
                          style: TextStyle(
                            color: const Color(0xFF6F6F6F),
                            fontSize: 14.sp,
                            fontFamily: AppFonts.lato,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
