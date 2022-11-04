import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      if (event is PerformLogin) {
        emit(PerformingLogin());
        try {
          var userCredential = await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                  email: event.email, password: event.password);
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            emit(LoginFailed(error: 'No user found for that email.'));
          } else if (e.code == 'wrong-password') {
            emit(LoginFailed(error: 'Wrong password provided for that user.'));
          }
          return;
        }
        emit(PerformedLogin());
        //authenticatorCubit.setAuthenticated();
      }
    });
  }

  performLogin(String email, String password) =>
      add(PerformLogin(email, password));
}
