part of 'login_bloc.dart';

@immutable
abstract class LoginState extends Equatable{}

class LoginInitial extends LoginState {

  LoginInitial();

  @override
  List<Object?> get props => [];
}


class PerformingLogin extends LoginState {

  PerformingLogin();

  @override
  List<Object?> get props => [];
}

class LoginFailed extends LoginState{
  final String? error;

  LoginFailed({this.error});

  @override
  List<Object?> get props =>[error];
}

class PerformedLogin extends LoginState {

  PerformedLogin();

  @override
  List<Object?> get props => [];
}