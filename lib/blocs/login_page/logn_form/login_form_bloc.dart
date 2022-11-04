import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'login_form_event.dart';
part 'login_form_state.dart';

class LoginFormBloc extends Bloc<LoginFormEvent, LoginFormState> {
  LoginFormBloc() : super(LoginFormInitial()) {
    on<LoginFormEvent>((event, emit) {
      if(event is EmailFormEvent){
        emit(LoginFormState(email: event.email,password: state.password));
      } else if(event is PasswordFormEvent){
        emit(LoginFormState(email: state.email,password: event.password));
      }
    });
  }

  void changeMailStatus(String? email)=> add(EmailFormEvent(email!));
  void changePasswordStatus(String? password)=> add(PasswordFormEvent(password!));
}
