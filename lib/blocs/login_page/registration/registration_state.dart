part of 'registration_bloc.dart';

abstract class RegistrationState extends Equatable {
  const RegistrationState();
}

class RegistrationInitial extends RegistrationState {
  @override
  List<Object> get props => [];
}



class PerformingRegistration extends RegistrationState {

  PerformingRegistration();

  @override
  List<Object?> get props => [];
}

class RegistrationFailed extends RegistrationState{
  final String? error;

  RegistrationFailed({this.error});

  @override
  List<Object?> get props =>[error];
}

class PerformedRegistration extends RegistrationState {

  PerformedRegistration();

  @override
  List<Object?> get props => [];
}