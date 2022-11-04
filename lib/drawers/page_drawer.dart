import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:random_film/blocs/navigate_list/navigate_list_cubit.dart';
import 'package:random_film/components/rf_navigation_drawer.dart';
import 'package:random_film/pages/add_film_page.dart';

import '../blocs/mange_list/manage_list_bloc.dart';
import '../components/film_card.dart';
import '../pages/personal_list_page.dart';
import '../pages/share_list_page.dart';

class PageDrawer extends StatelessWidget {
  const PageDrawer({Key? key}) : super(key: key);

  //qua verrà gestito il router e
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) =>
        ManageListBloc()
          ..getFilmList(false)),
        BlocProvider(create: (context) => NavigateListCubit()),
      ],
      child: BlocBuilder<ManageListBloc, ManageListState>(
        builder: (context, manageListState) {
          return BlocBuilder<NavigateListCubit, NavigateListState>(
            builder: (context, navigateListState) {
              return Scaffold(
                appBar: _appBar(),
                drawer: RfNavigationDrawer(listItems: _drawerMenu(context)),
                floatingActionButton: _floatingActionButton(context),
                floatingActionButtonLocation:
                FloatingActionButtonLocation.endDocked,
                bottomNavigationBar: _bottomAppBar(context, navigateListState),
                body: personalListPage(
                    context, manageListState, navigateListState),
              );
            },
          );
        },
      ),
    );
  }
}

List<Widget> _drawerMenu(BuildContext context) =>
    [
      ListTile(
          selected: true,
          title: Text('La tua Lista'),
          onTap: () {
            Navigator.pop(context);
          },
          leading: Icon(Icons.view_list_rounded)),
      Divider(),
      ListTile(
        title: Text('Liste condvise'),
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ShareListPage())).then((value) => Navigator.pop(context));
        },
        leading: Icon(Icons.share),
      ),
      Divider(),
    ];

Widget _bottomAppBar(BuildContext context, NavigateListState state) =>
    BottomAppBar(
      shape: const CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [_navigationVisibleButton(context, state)],
      ),
    );

PreferredSizeWidget _appBar() {
  return AppBar(
    title: Text('Random Film'),
  );
}

Widget _floatingActionButton(BuildContext context) =>
    FloatingActionButton(
      backgroundColor: Colors.green,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AddFilmPage()),
        ).then((value) => context.read<ManageListBloc>().getFilmList(false));
      },
      child: Icon(Icons.add),
    );

Widget _navigationVisibleButton(BuildContext context,
    NavigateListState state) =>
    OutlinedButton(
      onPressed: () {
        if (state is NavigateListWatched) {
          context.read<NavigateListCubit>().navigateToNotWatched();
          context.read<ManageListBloc>().getFilmList(false);
        } else {
          context.read<NavigateListCubit>().navigateToWatched();
          context.read<ManageListBloc>().getFilmList(true);
        }
      },
      style: ButtonStyle(
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))),
      child: state is NavigateListWatched ? Text('Non Visti') : Text('Visti'),
    );

//Bottone che manda all pagina di condivisione delle liste.
//possibilità di creare liste condividìvise una lista per persona.
//come creare la lista questo ti manda in un altra rotta non rimane li
//1. selezionare la persona , selezionare il numero di film a testa max 5.
//2. selezionare 5 film tra i tuoi salvare.
//se non vuoi creare una nuova lista puoi visionare una già creata.
