part of 'registration_bloc.dart';

abstract class RegistrationEvent extends Equatable {
  const RegistrationEvent();
}

class PerformRegistration extends RegistrationEvent {
  final String email;
  final String userName;
  final String password;

  PerformRegistration(this.email,this.userName,this.password);

  @override
  List<Object?> get props => [email,userName,password];
}

