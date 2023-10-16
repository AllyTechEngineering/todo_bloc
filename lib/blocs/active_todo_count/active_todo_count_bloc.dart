import 'package:bloc/bloc.dart';
import 'package:todo_bloc/blocs/blocs.dart';
import 'dart:async';
import '../../models/todo_model.dart';
import 'package:equatable/equatable.dart';

part 'active_todo_count_event.dart';
part 'active_todo_count_state.dart';

class ActiveTodoCountBloc
    extends Bloc<ActiveTodoCountEvent, ActiveTodoCountState> {
  /// from active_todo_cubit
  late final StreamSubscription todoListSubscription;
  final int initialActiveTodoCount;
  final TodoListBloc todoListBloc;

  ///
  ActiveTodoCountBloc({
    required this.initialActiveTodoCount,
    required this.todoListBloc,
  }) : super(ActiveTodoCountState(activeTodoCount: initialActiveTodoCount)) {
    todoListSubscription =
        todoListBloc.stream.listen((TodoListState todoListState) {
      print('todoListState: $todoListState');

      final int currentActiveTodoCount = todoListState.todos
          .where((Todo todo) => !todo.completed)
          .toList()
          .length;

      add(CalculateActiveTodoCountEvent(
          activeTodoCount: currentActiveTodoCount));
    });
    on<CalculateActiveTodoCountEvent>((event, emit) {
      emit(state.copyWith(activeTodoCount: event.activeTodoCount));
    });
  }
  @override
  Future<void> close() {
    todoListSubscription.cancel();
    return super.close();
  }
}