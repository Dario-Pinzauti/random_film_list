part of 'search_film_bloc.dart';

@immutable
abstract class SearchFilmEvent extends Equatable{

}

class SearchFilm extends SearchFilmEvent{
  final String text;

  SearchFilm(this.text);

  @override
  List<Object?> get props => [text];
}
