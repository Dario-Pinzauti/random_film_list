part of 'search_users_bloc.dart';

abstract class SearchUsersEvent extends Equatable {
  const SearchUsersEvent();
}

class SearchUser extends SearchUsersEvent{
  final String user;

  SearchUser(this.user);

  @override
  List<Object?> get props => [user];
}

class GetUserById extends SearchUsersEvent{
  final String userId;

  GetUserById(this.userId);

  @override
  List<Object?> get props => [userId];
}
