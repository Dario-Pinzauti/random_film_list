import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:random_film/services/user_service.dart';

import '../../dtos/user.dart';

part 'search_users_event.dart';
part 'search_users_state.dart';

class SearchUsersBloc extends Bloc<SearchUsersEvent, SearchUsersState> {
  SearchUsersBloc() : super(SearchUsersInitial()) {
    on<SearchUsersEvent>((event, emit) async {
      if (event is SearchUser) {
          emit(SearchingUser());
          List<RLUser?> rlUser = await UserService().findUser(event.user);
          emit(SearchedUser(rlUser));
      } else if(event is GetUserById){
        emit(GettingUser());
        RLUser? rlUser = await UserService().findUserById(event.userId);
        emit(GettedUser(rlUser));
      }
    });
  }

  void searchUser(String userSearchQuery) => add(SearchUser(userSearchQuery));
  void searchUserById(String userId) => add(GetUserById(userId));

}
