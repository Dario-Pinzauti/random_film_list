part of 'manage_shared_lists_bloc.dart';

abstract class ManageSharedListsEvent extends Equatable {
  const ManageSharedListsEvent();
}

class GetSharedLists extends ManageSharedListsEvent{


  GetSharedLists();

  @override
  List<Object?> get props => [];
}


class GetSharedList extends ManageSharedListsEvent{
 final String id;
 final bool watch;

  GetSharedList( this.id, this.watch);

  @override
  List<Object?> get props => [id,watch];
}


class AddFilmToSharedList extends ManageSharedListsEvent{
  final String id;
  final Movie film;


  AddFilmToSharedList(this.film,this.id);

  @override
  List<Object?> get props => [film,id];
}


class RemoveFilmToSharedList extends ManageSharedListsEvent{
  final String listId;
  final SharedMovie film;


  RemoveFilmToSharedList(this.listId, this.film);

  @override
  List<Object?> get props => [listId,film];
}


class WatchFilmInSharedList extends ManageSharedListsEvent{
  final String listId;
  final SharedMovie film;


  WatchFilmInSharedList(this.listId, this.film);

  @override
  List<Object?> get props => [listId,film];
}

class GetRandomFilmInSharedList extends ManageSharedListsEvent{


  GetRandomFilmInSharedList();

  @override
  List<Object?> get props => [];

}
class GetNotSharedFilmListById extends ManageSharedListsEvent{
  final String listId;


  GetNotSharedFilmListById(this.listId);

  @override
  List<Object?> get props => [listId];

}