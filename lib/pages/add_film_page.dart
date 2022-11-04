import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:random_film/blocs/mange_list/manage_list_bloc.dart';
import 'package:random_film/blocs/search_film/search_film_bloc.dart';

import '../components/film_card.dart';

class AddFilmPage extends StatelessWidget {
  const AddFilmPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context)),
          title: const Text('Aggiungi un film')),
      body: MultiBlocProvider(
        providers: [
        BlocProvider(create: (context)=>SearchFilmBloc()),
        BlocProvider(create: (context)=>ManageListBloc()),
        ],
        child: BlocBuilder<SearchFilmBloc, SearchFilmState>(
          builder: (context, state) {
            return Column(
              children: [
                Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        decoration: InputDecoration(
                            label:const Text('Cerca'),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                        onChanged: context.watch<SearchFilmBloc>().searchFilm,
                      ),
                    )),
                Expanded(
                  flex: 6,
                  child: Builder(builder: (context) {
                    if (state is SearchingFilm) {
                      return const SpinKitWave(size: 60, color: Colors.green);
                    } else {
                      return ListView.builder(
                          itemCount:
                              state is SearchedFilm ? state.movies.length : 0,
                          itemBuilder: (context, index) {
                            if (state is SearchedFilm) {
                              return FilmCard(
                                movie: state.movies[index],
                                onTap: () {
                                    context.read<ManageListBloc>().addFilmToList(state.movies[index]);
                                    context.read<SearchFilmBloc>().reloadSearchFilm();
                                },
                                borderColor:  state.movies[index].selected ? Colors.green : Colors.transparent,
                              );
                            } else {
                              return Container();
                            }
                          });
                    }
                  }),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
