import 'package:flutter_bloc/flutter_bloc.dart';
part 'table_event.dart';
part 'table_state.dart';
class TableBloc extends Bloc<TableEvent, TableState> {
  TableBloc() : super(TableState([])) {
    on<TableData>((event, emit) async {
      final data = ["cell1", "cell2", "cell3", "cell4", "cell5", "cell1", "cell2", "cell3", "cell4", "cell5"];
      emit(TableState(data));
    }
    );
  }
}

