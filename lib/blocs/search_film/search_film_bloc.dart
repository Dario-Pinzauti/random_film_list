import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../dtos/movie.dart';
import '../../services/movie_service.dart';

part 'search_film_event.dart';
part 'search_film_state.dart';

class SearchFilmBloc extends Bloc<SearchFilmEvent, SearchFilmState> {
  Timer? _timer;
  String? text;
  
  SearchFilmBloc() : super(SearchFilmInitial()) {
    on<SearchFilmEvent>((event, emit) async {
      if (event is SearchFilm) {
        emit(SearchingFilm());
        text = event.text;
        var list = await MovieService().getFilmListId();
        var movieList = await _searchFilms(event.text);
        for (var element in movieList) {
          if(list.contains(element.id)){
           element.selected = true;
          }
        }
        emit(SearchedFilm(movieList));
      }
    });
  }

  Future<List<Movie>> _searchFilms(String text) {
    var complete = Completer<List<Movie>>();
    if (text.length > 1) {
      if (_timer != null && _timer!.isActive) {
        _timer!.cancel();
      }
      _timer = Timer(const Duration(milliseconds: 500), () async {
        List<Movie> findMovies = await MovieService().findMovies(text);
        complete.complete(findMovies);
      });
      return complete.future;
    }
    return complete.future;
  }

  void searchFilm(String text) => add(SearchFilm(text));
  void reloadSearchFilm() => add(SearchFilm(text!));
}
