import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mafuriko/features/authentication/presentation/widgets/return_app_bar.dart';
import 'package:mafuriko/gen/gen.dart';
import 'package:mafuriko/shared/widgets/app_form_field.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
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
              AppFormField(
                focus: _passwordFocus,
                controller: _passwordController,
                isEmailField: false,
                isObscure: true,
                label: 'Mot de passe',
                hint: 'Saisissez mot de passe',
              ),
              AppFormField(
                focus: _confirmPassFocus,
                controller: _confirmPassController,
                isEmailField: false,
                isObscure: true,
                label: 'Confirmer le mot de passe',
                hint: 'Saisissez à nouveau le mot de passe',
              ),
              SizedBox(height: 12.h),
              PrimaryExpandedButton(
                title: 'Continuer',
                onTap: () {},
              ),
              TextButton(
                style: TextButton.styleFrom(padding: EdgeInsets.zero),
                onPressed: () {},
                child: Text(
                  'Vous avez deja un compte?',
                  style: TextStyle(
                    color: const Color(0xFF6F6F6F),
                    fontSize: 14.sp,
                    fontFamily: AppFonts.lato,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
                child: TextButton(
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  onPressed: () {},
                  child: Text(' Ajouter un profil visiteur.',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: AppFonts.lato,
                      )),
                ),
              ),
              SizedBox(height: 25.h),
            ],
          )),
        ),
      ),
    );
  }
}

class PrimaryExpandedButton extends StatelessWidget {
  const PrimaryExpandedButton({
    super.key,
    required this.title,
    required this.onTap,
  });
  final VoidCallback onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: onTap,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontFamily: AppFonts.inter,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
