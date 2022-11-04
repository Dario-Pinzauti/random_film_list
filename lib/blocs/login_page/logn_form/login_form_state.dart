part of 'login_form_bloc.dart';

@immutable
class LoginFormState extends Equatable {
  final String? email;
  final String? password;

  LoginFormState({this.email, this.password});

  bool get validateMail => email != null && RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$').hasMatch(email!);
  bool get validatePassword => password != null && password!.length >= 6 ;
  bool get enableLogin => validateMail && validatePassword;

  @override
  List<Object?> get props => [email,password];
}


class LoginFormInitial extends LoginFormState{
  @override
  bool get validateMail => true;
  @override
  bool get validatePassword => true;
  @override
  bool get enableLogin => false;
}
