
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:random_film/pages/detail_film_page.dart';

import '../blocs/mange_list/manage_list_bloc.dart';
import '../blocs/navigate_list/navigate_list_cubit.dart';
import '../components/film_card.dart';

Widget personalListPage(BuildContext context, ManageListState state,
    NavigateListState navigationState) =>
    Builder(builder: (context) {
      if (state is GettingFilmList) {
        return const SpinKitWave(size: 60, color: Colors.green);
      } else {
        return ListView.builder(
            itemCount: state is GottenFilmList ? state.movies.length : 0,
            itemBuilder: (context, index) {
              if (state is GottenFilmList) {
                return Dismissible(
                  key: Key(state.movies[index].id.toString()),
                  onDismissed: (DismissDirection direction) => {
                    if (direction == DismissDirection.startToEnd)
                      {
                        context
                            .read<ManageListBloc>()
                            .removeToList(state.movies[index])
                      }
                    else
                      {
                        context
                            .read<ManageListBloc>()
                            .filmWatched(state.movies[index])
                      }
                  },
                  background: _primaryBackground(),
                  secondaryBackground: _secondaryBackground(navigationState),
                  child: FilmCard(
                    movie: state.movies[index],
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DetailListPage( film: state.movies[index])));
                    },
                    borderColor: state.movies[index].watch!
                        ? Colors.green
                        : Colors.transparent,
                    button: state.movies[index].watch!
                        ? Icon(Icons.check, color: Colors.green)
                        : null,
                  ),
                );
              } else {
                return Container();
              }
            });
      }
    });

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

Widget _secondaryBackground(NavigateListState navigateListState) => Padding(
  padding: const EdgeInsets.all(4.0),
  child: ClipRRect(
    borderRadius: BorderRadius.circular(10),
    child: ColoredBox(
      color: navigateListState is NavigateListWatched
          ? const Color.fromRGBO(175, 80, 2, 0.5)
          : const Color.fromRGBO(76, 175, 80, 0.5),
      child: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: navigateListState is NavigateListWatched
                ? const Icon(Icons.remove_outlined)
                : const Icon(Icons.check),
          )),
    ),
  ),
);
