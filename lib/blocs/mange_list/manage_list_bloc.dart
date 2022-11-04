import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:random_film/dtos/movie.dart';
import 'package:random_film/services/movie_service.dart';

part 'manage_list_event.dart';
part 'manage_list_state.dart';

class ManageListBloc extends Bloc<ManageListEvent, ManageListState> {
  ManageListBloc() : super(ManageListInitial()) {
    on<ManageListEvent>((event, emit) async {
      if (event is AddFilmToList) {
        emit(AddingFilmOnList());
        Movie movie = event.movie;
        movie.insertDate = Timestamp.now();
        movie.watch = false;
        List<int> moviesId = await MovieService().addFilmToList(movie);
        emit(AddedFilmOnList(moviesId));
      } else if (event is GetFilmList) {
        emit(GettingFilmList());
        List<Movie> movieList = await MovieService().getFilmList();
        if (event.watch) {
          emit(GottenFilmList(
              movieList.where((element) => element.watch!).toList()));
        } else {
          emit(GottenFilmList(
              movieList.where((element) => !element.watch!).toList()));
        }
      } else if (event is RemoveFilmByList) {
        await MovieService().removeFilmByList(event.movie);
      } else if (event is FilmWatched) {
        await MovieService().setFilmWatched(event.movie);
      } else if (event is GetAllFilmList) {
        emit(GettingFilmList());
        List<Movie> movieList = await MovieService().getFilmList();
        emit(GottenFilmList(movieList.toList()));
      }
    });
  }

  void addFilmToList(Movie movie) => add(AddFilmToList(movie));

  void getFilmList(bool watch) => add(GetFilmList(watch));

  void getAllFilmList() => add(GetAllFilmList());


  void removeToList(Movie movie) => add(RemoveFilmByList(movie));

  void filmWatched(Movie movie) => add(FilmWatched(movie));
}
