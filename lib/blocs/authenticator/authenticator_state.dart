part of 'authenticator_cubit.dart';

@immutable
abstract class AuthenticatorState extends Equatable {
  const AuthenticatorState();
}


class Authenticated extends AuthenticatorState{


  @override
  List<Object?> get props => [];

}


class NotAuthenticated extends AuthenticatorState{
  @override
  List<Object?> get props => [];

}