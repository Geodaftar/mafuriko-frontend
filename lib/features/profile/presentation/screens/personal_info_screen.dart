import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mafuriko/features/authentication/presentation/blocs/bloc/auth_bloc.dart';
import 'package:mafuriko/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:mafuriko/shared/helpers/validators.dart';
import 'package:mafuriko/shared/widgets/app_form_field.dart';
import 'package:mafuriko/shared/widgets/buttons.dart';
import 'package:mafuriko/shared/widgets/custom_app_bar.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _nameFocus.dispose();
    _emailFocus.dispose();
    _phoneFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const AppBackAppBar(
        title: 'Informations personnelles',
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(18.w, 0, 18.w, 20.h),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 30.h),
                        if (state is AuthSuccess)
                          AppFormField(
                            focus: _nameFocus,
                            controller: _nameController
                              ..text = '${state.user.userName}'
                              ..selection = TextSelection.collapsed(
                                offset: _nameController.text.length,
                              ),
                            isNameField: true,
                            isEmailField: false,
                            label: 'Nom et prénom',
                            hint: 'Saisissez votre nom complet',
                            type: TextInputType.name,
                            onValidate: (value) {
                              final isValid =
                                  Name.dirty(value!).validator(value);
                              return isValid?.name;
                            },
                          ),
                        if (state is AuthSuccess)
                          AppFormField(
                            enabled: false,
                            focus: _emailFocus,
                            controller: _emailController
                              ..text = '${state.user.userEmail}'
                              ..selection = TextSelection.collapsed(
                                offset: _emailController.text.length,
                              ),
                            label: 'Email',
                            hint: 'Saisissez l’adresse email',
                            type: TextInputType.emailAddress,
                            onValidate: (value) {
                              final isValid =
                                  Email.dirty(value!).validator(value);
                              return isValid?.name;
                            },
                          ),
                        if (state is AuthSuccess)
                          AppFormField(
                            focus: _phoneFocus,
                            controller: _phoneController
                              ..text = '${state.user.userNumber}'
                              ..selection = TextSelection.collapsed(
                                offset: _phoneController.text.length,
                              ),
                            label: 'Téléphone',
                            hint: 'Saisissez le numéro de téléphone',
                            type: TextInputType.phone,
                            onValidate: (value) {
                              final isValid =
                                  PhoneNumber.dirty(value!).validator(value);
                              return isValid?.name;
                            },
                          ),
                      ],
                    );
                  },
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  BlocConsumer<ProfileBloc, ProfileState>(
                    listener: (context, state) {
                      if (state is ProfileLoadFailure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.message)),
                        );
                      } else if (state is ProfileUpdateSuccess) {
                        context
                            .read<ProfileBloc>()
                            .add(LoadUserProfile(state.user));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            behavior: SnackBarBehavior.floating,
                            content: Text('Mise à jour réussie'),
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
                        title: 'Sauvegarder',
                        onTap: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            context.read<ProfileBloc>().add(UpdateProfileEvent(
                                userName: _nameController.text.trim(),
                                phoneNumber: _phoneController.text.trim(),
                                userEmail: _emailController.text.trim()));
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
