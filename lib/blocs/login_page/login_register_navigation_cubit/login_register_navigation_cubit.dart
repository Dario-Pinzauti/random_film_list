import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_register_navigation_state.dart';

class LoginRegisterNavigationCubit extends Cubit<LoginRegisterNavigationState> {
  LoginRegisterNavigationCubit() : super(Login());


  void setLogin()=> emit(Login());
  void setRegister()=> emit(Register());
}

