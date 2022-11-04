import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_film/blocs/authenticator/authenticator_cubit.dart';
import 'package:random_film/blocs/login_page/login_register_navigation_cubit/login_register_navigation_cubit.dart';
import 'package:random_film/blocs/login_page/registration/registration_bloc.dart';
import 'package:random_film/blocs/login_page/registration_form/registration_form_bloc.dart';
import 'package:random_film/pages/login_page.dart';
import 'package:random_film/pages/registration_page.dart';

import 'blocs/login_page/login/login_bloc.dart';
import 'blocs/login_page/logn_form/login_form_bloc.dart';
import 'drawers/page_drawer.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthenticatorCubit()),
        BlocProvider(create: (_) => LoginRegisterNavigationCubit()),
        BlocProvider(create: (_) => LoginFormBloc()),
        BlocProvider(create: (context) => LoginBloc()),
        BlocProvider(create: (context) => RegistrationBloc()),
        BlocProvider(create: (context) => RegistrationFormBloc())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          brightness: Brightness.dark,
          primaryColor: Colors.green.shade900,
          primarySwatch: Colors.green,
        ),
        home: BlocBuilder<LoginRegisterNavigationCubit,
            LoginRegisterNavigationState>(
          builder: (context, loginRegisterState) {
            return BlocBuilder<AuthenticatorCubit, AuthenticatorState>(
              builder: (context, loginState) {
                return _authenticationDrawer(
                    context, loginState, loginRegisterState);
              },
            );
          },
        ),
      ),
    );
  }
}

Widget _authenticationDrawer(
    BuildContext context,
    AuthenticatorState authenticatorState,
    LoginRegisterNavigationState loginRegisterNavigationState) {
  context.read<AuthenticatorCubit>().verifyAuth();
  if (authenticatorState is Authenticated) {
    return PageDrawer();
  } else {
    return loginRegisterNavigationState is Login
        ? LoginPage()
        : RegistrationPage();
  }
}
