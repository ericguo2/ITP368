// CounterBloc.dart
import 'package:bloc/bloc.dart';

// Define the events
abstract class CounterEvent {}

class IncrementCounter extends CounterEvent {}

// Define the states
class CounterState {
  final int counterValue;

  CounterState(this.counterValue);
}

// Define the BLoC
class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterState(0)) {
    // Event handler for IncrementCounter event
    on<IncrementCounter>((event, emit) {
      emit(CounterState(state.counterValue + 1));
    });
  }
}
