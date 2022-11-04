part of 'login_form_bloc.dart';

@immutable
abstract class LoginFormEvent extends Equatable {
  const LoginFormEvent();
}

class EmailFormEvent extends LoginFormEvent{
final String email;

  EmailFormEvent(this.email);

  @override
  List<Object?> get props => [email];

}


class PasswordFormEvent extends LoginFormEvent{
 final String password;

  PasswordFormEvent(this.password);

  @override
  List<Object?> get props => [password];
}