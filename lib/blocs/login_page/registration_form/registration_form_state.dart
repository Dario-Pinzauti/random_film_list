part of 'registration_form_bloc.dart';

abstract class RegistrationFormState extends Equatable {
  final String? email;
  final String? username;
  final String? password;
  final String? passwordConfirm;

  RegistrationFormState(
      {this.email, this.username, this.password, this.passwordConfirm});
}

class RegistrationAllState extends RegistrationFormState {
  RegistrationAllState(
      {super.email, super.username, super.password, super.passwordConfirm});

  bool get validateMail {
    return super.email != null &&
        RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
            .hasMatch(super.email!);
  }

  bool get validatePassword {
    return super.password != null && super.password!.length >= 6;
  }

  bool get validatePasswordConfirm =>
      super.passwordConfirm != null &&
      super.password?.compareTo(super.passwordConfirm!)==0;

  bool get validateUsername => super.username != null && super.username != '';

  bool get enableRegistration =>
      validateMail &&
      validatePassword &&
      validatePasswordConfirm &&
      validateUsername;

  @override
  List<Object?> get props => [email, username, password,passwordConfirm];
}

class RegistrationFormInitial extends RegistrationFormState {
  final String? email;
  final String? username;
  final String? password;
  final String? passwordConfirm;

  RegistrationFormInitial(
      {this.email, this.username, this.password, this.passwordConfirm});

  @override
  // TODO: implement props
  List<Object?> get props => [email, username, passwordConfirm, password];
}
