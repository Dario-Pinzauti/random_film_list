part of 'search_film_bloc.dart';

@immutable
abstract class SearchFilmState extends Equatable {}

class SearchFilmInitial extends SearchFilmState {

  SearchFilmInitial();

  @override
  List<Object?> get props => [];

}


class SearchingFilm extends SearchFilmState {

  SearchingFilm();

  @override
  List<Object> get props => [];

}

class SearchedFilm extends SearchFilmState {
  final List<Movie> movies ;

  SearchedFilm(this.movies);

  @override
  List<Object> get props => [movies];

}

