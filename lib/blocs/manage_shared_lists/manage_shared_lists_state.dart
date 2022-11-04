part of 'manage_shared_lists_bloc.dart';

abstract class ManageSharedListsState extends Equatable {
  const ManageSharedListsState();
}

class SharedListsInitial extends ManageSharedListsState {
  SharedListsInitial();

  @override
  List<Object?> get props => [];
}

class GettingSharedLists extends ManageSharedListsState {
  GettingSharedLists();

  @override
  List<Object?> get props => [];
}

class GottenSahredLists extends ManageSharedListsState {
  List<SharedList> sharedLists;

  GottenSahredLists(this.sharedLists);

  @override
  List<Object?> get props => [sharedLists];
}

class GettingSharedList extends ManageSharedListsState {
  GettingSharedList();

  @override
  List<Object?> get props => [];
}

class GottenSahredList extends ManageSharedListsState {
  List<SharedMovie> sharedListFilm;

  GottenSahredList(this.sharedListFilm);

  @override
  List<Object?> get props => [sharedListFilm];
}

class AddingOnSharedList extends ManageSharedListsState {
  AddingOnSharedList();

  @override
  List<Object?> get props => [];
}

class AddedOnSahredList extends ManageSharedListsState {
  AddedOnSahredList();

  @override
  List<Object?> get props => [];
}

class GettingNotSharedList extends ManageSharedListsState {
  GettingNotSharedList();

  @override
  List<Object?> get props => [];
}

class GottenNotSahredList extends ManageSharedListsState {
  List<SharedMovie> notSharedListFilm;

  GottenNotSahredList(this.notSharedListFilm);

  @override
  List<Object?> get props => [notSharedListFilm];
}