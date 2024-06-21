import 'package:flutter_bloc/flutter_bloc.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState>{
  CounterBloc() : super(CounterState(0)){
    on<CountIncremant>(
            (event, emit){
              final count = state.count+1;
              emit(CounterState(count));
            }
    );
    on<CountDecremant>(
            (event, emit){
              emit(CounterState(state.count - 1));
            }
            );
  }

}