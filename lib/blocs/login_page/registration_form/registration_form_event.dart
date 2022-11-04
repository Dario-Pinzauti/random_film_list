part of 'registration_form_bloc.dart';

abstract class RegistrationFormEvent extends Equatable {
  const RegistrationFormEvent();
}

class UsernameRegistrationEvent extends RegistrationFormEvent{
  final String username;

  UsernameRegistrationEvent(this.username);

  @override
  List<Object?> get props => [username];

}


class EmailRegistrationEvent extends RegistrationFormEvent{
  final String email;

  EmailRegistrationEvent(this.email);

  @override
  List<Object?> get props => [email];

}

class PasswordRegistrationEvent extends RegistrationFormEvent{
  final String password;


  PasswordRegistrationEvent(this.password);

  @override
  List<Object?> get props => [password];

}

class PasswordConfirmRegistrationEvent extends RegistrationFormEvent{
  final String passwordConfirm;


  PasswordConfirmRegistrationEvent(this.passwordConfirm);

  @override
  List<Object?> get props => [passwordConfirm];

}