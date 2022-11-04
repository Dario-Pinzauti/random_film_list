import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'navigate_shared_list_state.dart';

class NavigateSharedListCubit extends Cubit<NavigateSharedListState> {
  NavigateSharedListCubit() : super(NavigateSharedListWatched());

  void navigateToWatched() => emit(NavigateSharedListWatched());
  void navigateToNotWatched() => emit(NavigateSharedListNotWatched());
}
