import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'authenticator_state.dart';

class AuthenticatorCubit extends Cubit<AuthenticatorState> {
  AuthenticatorCubit() : super(NotAuthenticated());



  void setNotAuthenticated()=> emit(NotAuthenticated());
  void setAuthenticated()=> emit(Authenticated());
  void verifyAuth(){
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        emit(Authenticated());
        return;
      }
      emit(NotAuthenticated());
    });
  }

}
