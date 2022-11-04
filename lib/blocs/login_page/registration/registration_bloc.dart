import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:random_film/services/user_service.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {

  RegistrationBloc() : super(RegistrationInitial()) {
    on<RegistrationEvent>((event, emit) async {
      if (event is PerformRegistration) {
        emit(PerformingRegistration());
         await UserService().createUser(event.email, event.userName, event.password);
        emit(PerformedRegistration());
      }
    });
  }

  performRegistration(String email, String userName, String password) =>
      add(PerformRegistration(email, userName, password));
}
