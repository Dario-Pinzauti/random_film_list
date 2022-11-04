import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'navigate_list_state.dart';

class NavigateListCubit extends Cubit<NavigateListState> {
  NavigateListCubit() : super(NavigateListNotWatched());

  void navigateToWatched() => emit(NavigateListWatched());
  void navigateToNotWatched() => emit(NavigateListNotWatched());
}


