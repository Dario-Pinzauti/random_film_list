import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:random_film/blocs/login_page/login_register_navigation_cubit/login_register_navigation_cubit.dart';

part 'registration_form_event.dart';
part 'registration_form_state.dart';

class RegistrationFormBloc extends Bloc<RegistrationFormEvent, RegistrationFormState> {
  RegistrationFormBloc() : super(RegistrationFormInitial()) {
    on<RegistrationFormEvent>((event, emit) {
      if(event is EmailRegistrationEvent){
        emit(RegistrationAllState(email: event.email,password: state.password,username: state.username,passwordConfirm: state.passwordConfirm));
      } else if(event is PasswordRegistrationEvent ){
        emit(RegistrationAllState(email: state.email,password: event.password,username: state.username,passwordConfirm: state.passwordConfirm));
      } else if(event is PasswordConfirmRegistrationEvent ){
        emit(RegistrationAllState(email: state.email,password: state.password,username: state.username,passwordConfirm: event.passwordConfirm));
      } else if(event is UsernameRegistrationEvent){
        emit(RegistrationAllState(email: state.email,password: state.password,username: event.username,passwordConfirm: state.passwordConfirm));
      }
    });
  }

  void changeMailStatus(String? email)=> add(EmailRegistrationEvent(email!));
  void changePasswordStatus(String? password)=> add(PasswordRegistrationEvent(password!));
  void changeUserName(String? userName)=> add(UsernameRegistrationEvent(userName!));
  void changeConfirmPassword(String? confirmPassword)=> add(PasswordConfirmRegistrationEvent(confirmPassword!));
}
