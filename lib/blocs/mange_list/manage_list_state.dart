part of 'manage_list_bloc.dart';

abstract class ManageListState extends Equatable {
  const ManageListState();
}

class ManageListInitial extends ManageListState {

  ManageListInitial();

  @override
  List<Object> get props => [];

}


class AddedFilmOnList extends ManageListState{
  final List<int> moviesId;

  AddedFilmOnList(this.moviesId);

  @override
  List<Object?> get props => [];
}

class AddingFilmOnList extends ManageListState{

  AddingFilmOnList();

  @override
  List<Object?> get props => [];
}

class GettingFilmList extends ManageListState{

  GettingFilmList();

  @override
  List<Object?> get props => [];
}

class GottenFilmList extends ManageListState{
  List<Movie> movies;


  GottenFilmList(this.movies);

  @override
  List<Object?> get props => [movies];
}
