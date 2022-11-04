import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:random_film/blocs/mange_list/manage_list_bloc.dart';
import 'package:random_film/components/film_card.dart';

import '../blocs/manage_shared_lists/manage_shared_lists_bloc.dart';

class AddSharedListFilmPage extends StatelessWidget {
  final ManageSharedListsState state;
  final String listId;

  const AddSharedListFilmPage({Key? key, required this.state, required this.listId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ManageSharedListsBloc()..getNotSharedFilmListById(listId))
      ],
      child: BlocBuilder<ManageSharedListsBloc, ManageSharedListsState>(
              builder: (context, sharedListState) {
                return Scaffold(
                    appBar: AppBar(
                        leading: IconButton(
                            icon: const Icon(Icons.arrow_back),
                            onPressed: () => Navigator.pop(context)),
                        title: const Text('Aggiungi un film')),
                    body: Builder(builder: (context) {
                      if (sharedListState is GettingNotSharedList) {
                        return const SpinKitWave(size: 60, color: Colors.orange);
                      } else {
                        return ListView.builder(
                            itemCount:
                            sharedListState is GottenNotSahredList ? sharedListState.notSharedListFilm.length : 0,
                            itemBuilder: (context, index) {
                              if (sharedListState is GottenNotSahredList) {
                                return FilmCard(
                                    movie: sharedListState.notSharedListFilm[index],
                                    onTap: () {
                                      context.read<ManageSharedListsBloc>().addFilmToSharedList(listId, sharedListState.notSharedListFilm[index]);
                                      context.read<ManageSharedListsBloc>().getNotSharedFilmListById(listId);
                                    },
                                    borderColor: Colors.transparent);
                              } else {
                                return Container();
                              }
                            });
                      }
                    }));
              },
          )
    );
  }
}
