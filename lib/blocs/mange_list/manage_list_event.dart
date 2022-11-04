part of 'manage_list_bloc.dart';

abstract class ManageListEvent extends Equatable {
  const ManageListEvent();
}


class AddFilmToList extends ManageListEvent{
   final Movie movie;

   AddFilmToList(this.movie);

  @override
  List<Object?> get props => [movie];
}

class GetAllFilmList extends ManageListEvent{

  GetAllFilmList();

  @override
  List<Object?> get props => [];

}

class GetFilmList extends ManageListEvent{
final bool watch;


GetFilmList(this.watch);

  @override
  List<Object?> get props => [watch];
}

class RemoveFilmByList extends ManageListEvent{
  final Movie movie;

  RemoveFilmByList(this.movie);

  @override
  List<Object?> get props => [movie];
}
class FilmWatched extends ManageListEvent{
  final Movie movie;

  FilmWatched(this.movie);

  @override
  List<Object?> get props => [movie];
}