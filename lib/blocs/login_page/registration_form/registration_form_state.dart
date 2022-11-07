part of 'registration_form_bloc.dart';

abstract class RegistrationFormState extends Equatable {
  final String? email;
  final String? username;
  final String? password;
  final String? passwordConfirm;

  RegistrationFormState(
      {this.email, this.username, this.password, this.passwordConfirm});
}

class RegistrationAllState extends RegistrationFormState {
  RegistrationAllState(
      {super.email, super.username, super.password, super.passwordConfirm});

  bool get validateMail {
    if(super.email == null){
      return true;
    }else if( RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(super.email!)){
      return true;
    }else{
      return false;
    }
  }

  bool get validatePassword {
    if(super.password == null){
      return true;
    } else if(super.password!.length >= 6){
      return true;
    }else{
      return false;
    }
  }

  bool get validatePasswordConfirm {
    if(super.passwordConfirm == null){
      return true;
    } else if(super.password?.compareTo(super.passwordConfirm!)==0){
      return true;
    } else{
      return false;
    }
  }

  bool get validateUsername {
    if(super.username == null){
      return true;
    } else if(super.username != ''){
      return true;
    }else{
      return false;
    }
  }

  bool get enableRegistration =>
      super.username != null &&
      super.password != null &&
      super.passwordConfirm != null &&
      super.email != null &&
      validateMail &&
      validatePassword &&
      validatePasswordConfirm &&
      validateUsername;

  @override
  List<Object?> get props => [email, username, password,passwordConfirm];
}

class RegistrationFormInitial extends RegistrationFormState {
  final String? email;
  final String? username;
  final String? password;
  final String? passwordConfirm;

  RegistrationFormInitial(
      {this.email, this.username, this.password, this.passwordConfirm});

  @override
  // TODO: implement props
  List<Object?> get props => [email, username, passwordConfirm, password];
}
