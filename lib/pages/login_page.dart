import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_film/blocs/login_page/login_register_navigation_cubit/login_register_navigation_cubit.dart';

import '../blocs/login_page/login/login_bloc.dart';
import '../blocs/login_page/logn_form/login_form_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Accedi'),
          actions: [_register(context)],
        ),
        body: BlocBuilder<LoginFormBloc, LoginFormState>(
            builder: (context, formState) {
          return BlocBuilder<LoginBloc, LoginState>(
              builder: (context, loginState) {
            return Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: Column(
                children: [
                  _email(context, formState, loginState),
                  _password(context, formState, loginState),
                  _loginButton(context, formState, loginState),
                  _errorMessage(context, formState, loginState)
                ],
              ),
            );
          });
        }));
  }

  Widget _email(
      BuildContext context, LoginFormState state, LoginState loginState) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextFormField(

          decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              labelText: 'Email',
              hintText: 'Inserire email',
              errorText: !state.validateMail ? 'Email errata' : null),
          onChanged: context.watch<LoginFormBloc>().changeMailStatus),
    );
  }

  Widget _password(
          BuildContext context, LoginFormState state, LoginState loginState) =>
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: TextFormField(
          obscureText: true,
          decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              labelText: 'Password',
              hintText: 'Inserire password',
              errorText: !state.validatePassword
                  ? 'la password deve essere almeno di 6 caratteri'
                  : null),
          onChanged: context.watch<LoginFormBloc>().changePasswordStatus,
        ),
      );

  Widget _loginButton(
      BuildContext context, LoginFormState state, LoginState loginState) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextButton(
          onPressed: state.enableLogin
              ? ()=>context
                  .read<LoginBloc>()
                  .performLogin(state.email!, state.password!)
              : null,
          child: Text('login')),
    );
  }

  Widget _errorMessage(
      BuildContext context, LoginFormState state, LoginState loginState) {
    return Padding(
        padding: const EdgeInsets.all(15.0),
        child: loginState is LoginFailed ? Text(loginState.error!) : null);
  }

  Widget _register(
      BuildContext context) {
    return TextButton(onPressed: (){context.read<LoginRegisterNavigationCubit>().setRegister();}, child: Text('Registati!'),);
  }
}
