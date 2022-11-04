import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_film/blocs/login_page/registration/registration_bloc.dart';
import 'package:random_film/blocs/login_page/registration_form/registration_form_bloc.dart';

import '../blocs/login_page/login/login_bloc.dart';
import '../blocs/login_page/login_register_navigation_cubit/login_register_navigation_cubit.dart';
import '../blocs/login_page/logn_form/login_form_bloc.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Restrati'),
          actions: [_login(context)],
        ),
        body: BlocBuilder<RegistrationFormBloc, RegistrationFormState>(
            builder: (context, registrationFormState) {
              return BlocBuilder<RegistrationBloc, RegistrationState>(
                  builder: (context, registrationState) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 0.0),
                      child: Column(
                        children: [
                          _email(context, registrationFormState, registrationState),
                          _userName(context, registrationFormState, registrationState),
                          _password(context, registrationFormState, registrationState),
                          _passwordConfirm(context, registrationFormState, registrationState),
                          _loginButton(context, registrationFormState, registrationState),
                          _errorMessage(context, registrationFormState, registrationState),

                        ],
                      ),
                    );
                  });
            }));
  }

  Widget _email(
      BuildContext context, RegistrationFormState state, RegistrationState loginState) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextFormField(

          decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              labelText: 'Email',
              hintText: 'Inserire email',
              errorText: state is RegistrationAllState && !state.validateMail ? 'Email errata' : null),
        onChanged: context.watch<RegistrationFormBloc>().changeMailStatus,
      ),
    );
  }

  Widget _userName(
      BuildContext context, RegistrationFormState state, RegistrationState loginState) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextFormField(

          decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              labelText: 'User Name',
              hintText: 'Inserire Nome Utente',
              errorText: state is RegistrationAllState && !state.validateUsername ?  'Il nome utente è obbligatorio' : null),
        onChanged: context.watch<RegistrationFormBloc>().changeUserName,
      ),
    );
  }

  Widget _password(
      BuildContext context, RegistrationFormState state, RegistrationState loginState) =>
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: TextFormField(
          obscureText: true,
          decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              labelText: 'Password',
              hintText: 'Inserire password',
              errorText: state is RegistrationAllState && !state.validatePassword
                  ? 'la password deve essere almeno di 6 caratteri'
                  : null),
          onChanged: context.watch<RegistrationFormBloc>().changePasswordStatus,
        ),
      );

  Widget _passwordConfirm(
      BuildContext context, RegistrationFormState state, RegistrationState loginState) =>
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: TextFormField(
          obscureText: true,
          decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              labelText: 'Conferma Password',
              hintText: 'Confermare password ',
              errorText: state is RegistrationAllState && !state.validatePasswordConfirm
                  ? 'Le password non corrispondono ${state.validatePasswordConfirm}'
                  : null),
          onChanged: context.watch<RegistrationFormBloc>().changeConfirmPassword,

        ),
      );

  Widget _loginButton(
      BuildContext context, RegistrationFormState state, RegistrationState loginState) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextButton(
          onPressed: state is RegistrationAllState && state.enableRegistration
             ? ()=>context
              .read<RegistrationBloc>()
              .performRegistration(state.email!, state.username!,state.password!)
              : null,
          child: Text('Crea Account')),
    );
  }

  Widget _errorMessage(
      BuildContext context, RegistrationFormState state, RegistrationState loginState) {
    return Padding(
        padding: const EdgeInsets.all(15.0),
        child: loginState is RegistrationFailed ? Text(loginState.error!) : null);
  }

  Widget _login(
      BuildContext context) {
    return TextButton(onPressed: (){context.read<LoginRegisterNavigationCubit>().setLogin();}, child: Text('Accedi!'));
  }
}
