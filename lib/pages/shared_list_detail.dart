import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:random_film/blocs/navigate_shared_list/navigate_shared_list_cubit.dart';
import 'package:random_film/components/film_card.dart';
import 'package:random_film/pages/add_shared_list_film_page.dart';

import '../blocs/manage_shared_lists/manage_shared_lists_bloc.dart';
import '../blocs/navigate_list/navigate_list_cubit.dart';
import 'detail_film_page.dart';

class SharedListDetail extends StatelessWidget {
  final String listId;
  final ManageSharedListsState state;

  const SharedListDetail({Key? key, required this.listId, required this.state})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ManageSharedListsBloc()..getSharedListById(listId, false)),
        BlocProvider(create: (context) => NavigateSharedListCubit()),
      ],
      child: BlocBuilder<ManageSharedListsBloc, ManageSharedListsState>(
        builder: (context, state) {
          return BlocBuilder<NavigateSharedListCubit, NavigateSharedListState>(
            builder: (context, navigatorState) {
              return Scaffold(
                bottomNavigationBar: _bottomAppBar(context, navigatorState),
                appBar: AppBar(
                  title: const Text("Lista Nome"),
                  leading: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context)),
                ),
                body: _listBody(context, state, navigatorState),
                floatingActionButton: _floatingActionButton(context, state),
                floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
              );
            },
          );
        },
      ),
    );
  }

  Widget _listBody(BuildContext context, ManageSharedListsState state,
          NavigateSharedListState navigateSharedListState) =>
      Builder(builder: (context) {
        if (state is GettingSharedList) {
          return const SpinKitWave(size: 60, color: Colors.orange);
        } else {
          return ListView.builder(
              itemCount:
                  state is GottenSahredList ? state.sharedListFilm.length : 0,
              itemBuilder: (context, index) {
                if (state is GottenSahredList) {
                  return Dismissible(
                    key: Key(state.sharedListFilm[index].id.toString()),
                    onDismissed: (DismissDirection direction) => {
                      if (direction == DismissDirection.startToEnd)
                        {
                          context
                              .read<ManageSharedListsBloc>()
                              .removeFilmToSharedList(
                                  listId, state.sharedListFilm[index])
                        }
                      else
                        {
                          context
                              .read<ManageSharedListsBloc>()
                              .watchFilmInSharedList(
                                  listId, state.sharedListFilm[index])
                        }
                    },
                    background: _primaryBackground(),
                    secondaryBackground:
                        _secondaryBackground(navigateSharedListState),
                    child: FilmCard(
                        movie: state.sharedListFilm[index],
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => DetailListPage( film: state.sharedListFilm[index])));
                        },
                      borderColor: state.sharedListFilm[index].watch!
                          ? Colors.orange
                          : Colors.transparent,
                      button: state.sharedListFilm[index].watch!
                          ? Icon(Icons.check, color: Colors.orange)
                          : null,
                    ),
                  );
                } else {
                  return Container();
                }
              });
        }
      });

  Widget _floatingActionButton(
          BuildContext context, ManageSharedListsState state) =>
      FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    AddSharedListFilmPage(state: state, listId: listId)),
          ).then((value) => context
              .read<ManageSharedListsBloc>()
              .getSharedListById(listId, false));
        },
        child: Icon(Icons.add),
      );

  Widget _primaryBackground() => Padding(
        padding: const EdgeInsets.all(4.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: const ColoredBox(
              color: Color.fromRGBO(244, 67, 54, 0.5),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.close),
                  ))),
        ),
      );

  Widget _secondaryBackground(
          NavigateSharedListState navigateSharedListState) =>
      Padding(
        padding: const EdgeInsets.all(4.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: ColoredBox(
            color: navigateSharedListState is NavigateSharedListNotWatched
                ? const Color.fromRGBO(175, 80, 2, 0.5)
                : const Color.fromRGBO(76, 175, 80, 0.5),
            child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: navigateSharedListState is NavigateSharedListNotWatched
                      ? const Icon(Icons.remove_outlined)
                      : const Icon(Icons.check),
                )),
          ),
        ),
      );

  Widget _bottomAppBar(BuildContext context, NavigateSharedListState state) =>
      BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [_navigationVisibleButton(context, state)],
        ),
      );

  Widget _navigationVisibleButton(
          BuildContext context, NavigateSharedListState state) =>
      OutlinedButton(
        onPressed: () {
          if (state is NavigateSharedListNotWatched) {
            context.read<NavigateSharedListCubit>().navigateToWatched();
            context
                .read<ManageSharedListsBloc>()
                .getSharedListById(listId, false);
          } else {
            context.read<NavigateSharedListCubit>().navigateToNotWatched();
            context
                .read<ManageSharedListsBloc>()
                .getSharedListById(listId, true);
          }
        },
        style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)))),
        child: state is NavigateSharedListNotWatched
            ? const Text('Non Visti', style: TextStyle(color: Colors.orange))
            : const Text('Visti', style: TextStyle(color: Colors.orange)),
      );
}
