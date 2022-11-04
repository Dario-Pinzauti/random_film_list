import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:random_film/blocs/mange_list/manage_list_bloc.dart';
import 'package:random_film/dtos/movie.dart';
import 'package:random_film/dtos/shared_movie.dart';
import 'package:random_film/services/shared_list_service.dart';

import '../../dtos/shared_list.dart';

part 'manage_shared_lists_event.dart';
part 'manage_shared_lists_state.dart';

class ManageSharedListsBloc
    extends Bloc<ManageSharedListsEvent, ManageSharedListsState> {
  ManageSharedListsBloc() : super(SharedListsInitial()) {
    on<ManageSharedListsEvent>((event, emit) async {
      if (event is GetSharedLists) {
        emit(GettingSharedLists());
        var sharedLists = await SharedListService().getSharedLists();
        emit(GottenSahredLists(sharedLists!));
      } else if (event is GetSharedList) {
        emit(GettingSharedList());
        var movies =
            await SharedListService().getMoviesBySharedListId(event.id);
        if (event.watch) {
          emit(GottenSahredList(
              movies!.where((element) => element.watch!).toList()));
        } else {
          emit(GottenSahredList(
              movies!.where((element) => !element.watch!).toList()));
        }
      } else if (event is AddFilmToSharedList) {
        var film = event.film;
        var sharedMovie = SharedMovie(
            id: film.id,
            userId: FirebaseAuth.instance.currentUser!.uid,
            watch: false,
            insertDate: film.insertDate,
            backdropPath: film.backdropPath,
            title: film.title,
            revenue: film.revenue,
            budget: film.budget,
            genres: film.genres,
            originalTitle: film.originalTitle,
            overview: film.overview,
            posterPath: film.posterPath,
            releaseDate: film.releaseDate);
        await SharedListService()
            .addMoviesInToSharedList(event.id, sharedMovie);
      } else if (event is WatchFilmInSharedList) {
        await SharedListService()
            .watchMovieInSharedList(event.listId, event.film);
      } else if (event is RemoveFilmToSharedList) {
        await SharedListService()
            .removeMovieInSharedList(event.listId, event.film);
      }else if (event is GetNotSharedFilmListById) {
        emit(GettingNotSharedList());
        var list = await SharedListService()
            .getFilmList(event.listId);
        emit(GottenNotSahredList(list!));
      }
    });
    getAllSharedList();
  }

  void getAllSharedList() => add(GetSharedLists());

  void getSharedListById(String id, bool watch) =>
      add(GetSharedList(id, watch));

  void getNotSharedFilmListById(String id) =>
      add(GetNotSharedFilmListById(id));

  void addFilmToSharedList(String sharedId, Movie movie) =>
      add(AddFilmToSharedList(movie, sharedId));

  void watchFilmInSharedList(String sharedId, SharedMovie movie) =>
      add(WatchFilmInSharedList(sharedId, movie));

  void removeFilmToSharedList(String sharedId, SharedMovie movie) =>
      add(RemoveFilmToSharedList(sharedId, movie));
}
