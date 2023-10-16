part of 'todo_filter_bloc.dart';

sealed class TodoFilterEvent extends Equatable {
  const TodoFilterEvent();

  @override
  List<Object> get props => [];
}

class ChangeFilterEvent extends TodoFilterEvent {
/*
enum Filter {
  all,
  active,
  completed,
}
*/

  final Filter newFilter;
  ChangeFilterEvent({
    required this.newFilter,
  });
  

  @override
  String toString() => 'ChangeFilterEvent(newFilter: $newFilter)';

    @override
  List<Object> get props => [newFilter];

}
