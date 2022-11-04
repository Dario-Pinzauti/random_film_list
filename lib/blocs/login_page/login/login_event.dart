part of 'login_bloc.dart';

@immutable
abstract class LoginEvent extends Equatable{
}


class PerformLogin extends LoginEvent {
  final String email;
  final String password;

  PerformLogin(this.email, this.password);

  @override
  List<Object?> get props => [email,password];
}

