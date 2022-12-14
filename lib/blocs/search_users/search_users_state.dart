part of 'search_users_bloc.dart';

abstract class SearchUsersState extends Equatable {
  const SearchUsersState();
}

class SearchUsersInitial extends SearchUsersState {
  @override
  List<Object> get props => [];
}



class SearchingUser extends SearchUsersState {

  SearchingUser();

  @override
  List<Object> get props => [];

}

class SearchedUser extends SearchUsersState {
  final List<RLUser?> users;

  SearchedUser(this.users);

  @override
  List<Object> get props => [users];

}


class GettingUser extends SearchUsersState {

  GettingUser();

  @override
  List<Object> get props => [];

}

class GettedUser extends SearchUsersState {
  final RLUser? user;

  GettedUser(this.user);

  @override
  List<Object> get props => [user!];

}