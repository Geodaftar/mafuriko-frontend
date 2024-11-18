import 'package:formz/formz.dart';

enum EmailValidationError { invalid, empty }

enum PhoneNumberError { empty, invalid }

enum PasswordError { empty, invalid }

enum NameError { empty, invalid, short }

class Email extends FormzInput<String, EmailValidationError> {
  const Email.pure([super.value = '']) : super.pure();
  const Email.dirty([super.value = '']) : super.dirty();

  static final RegExp _emailRegExp = RegExp(
    // r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
    r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$',
  );

  @override
  EmailValidationError? validator(String value) {
    if (value.isEmpty) {
      return EmailValidationError.empty;
    }
    return _emailRegExp.hasMatch(value) ? null : EmailValidationError.invalid;
  }
}

extension Explanation on EmailValidationError {
  String get name {
    switch (this) {
      case EmailValidationError.invalid:
        return "* Ceci n'est pas un email valide";
      case EmailValidationError.empty:
        return '* Email est requis';
      default:
        return '';
    }
  }
}

class PhoneNumber extends FormzInput<String, PhoneNumberError> {
  const PhoneNumber.pure([super.value = '']) : super.pure();
  const PhoneNumber.dirty([super.value = '']) : super.dirty();

  static final RegExp _phoneNumberRegExp = RegExp(
    r'^(\+?[1-9][0-9]{0,2}[0-9]{4,15}|[0-9]{8,15})$',
    // r'^(07|05|01)[0-9]{10}|\(77|74|66)[0-9]{7}$'
  );

  @override
  PhoneNumberError? validator(String value) {
    if (value.isNotEmpty == false) {
      return PhoneNumberError.empty;
    }
    return _phoneNumberRegExp.hasMatch(value) ? null : PhoneNumberError.invalid;
  }
}

extension ExplanationNumber on PhoneNumberError {
  String get number {
    switch (this) {
      case PhoneNumberError.empty:
        return "* Le numéro est requis";
      case PhoneNumberError.invalid:
        return "This is not a valid number. try with code. eg: (+225)";
      default:
        return '';
    }
  }
}

class PasswordValidator extends FormzInput<String, PasswordError> {
  const PasswordValidator.pure([super.value = '']) : super.pure();
  const PasswordValidator.dirty([super.value = '']) : super.dirty();

  static final RegExp _passwordRegExp = RegExp(
    r'^.{6,}$',
  );

  @override
  PasswordError? validator(String value) {
    if (value.isNotEmpty == false) {
      return PasswordError.empty;
    }
    return _passwordRegExp.hasMatch(value) ? null : PasswordError.invalid;
  }
}

extension ExplanationPassword on PasswordError {
  String get name {
    switch (this) {
      case PasswordError.empty:
        return "* le mot de passe est requis";
      case PasswordError.invalid:
        return "* This is not a valid password";
      default:
        return '';
    }
  }
}

class Name extends FormzInput<String, NameError> {
  const Name.pure() : super.pure('');
  const Name.dirty([super.value = '']) : super.dirty();

  static final RegExp _nameRegExp = RegExp(
    r"^[a-zA-Z][a-zA-Z\é\è\ê\']*(\s+[A-Z][a-zA-Z\é\è\ê\']*)*$",
    // r"^(?:[A-Z][a-zA-Z\é\è\ê\']*(?:\s+[A-Z][a-zA-Z\é\è\ê\']*)*){1,}$",
  );

  @override
  NameError? validator(String value) {
    if (value.isNotEmpty == false) {
      return NameError.empty;
    } else if (value.length < 2) {
      return NameError.short;
    }
    return _nameRegExp.hasMatch(value) ? null : NameError.empty;
  }
}

extension ExplanationName on NameError {
  String get name {
    switch (this) {
      case NameError.invalid:
        return "This is not a valid name";
      case NameError.empty:
        return "Name cannot be empty";
      case NameError.short:
        return "Name is too short";
      default:
        return '';
    }
  }
}
