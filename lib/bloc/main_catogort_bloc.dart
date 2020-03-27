import 'package:bloc/bloc.dart';
import 'package:purchasing_lanka_international/bloc/main_catogort_state.dart';
import 'package:purchasing_lanka_international/bloc/main_catogort_event.dart';

class MainCatogoryBloc extends Bloc<MainCatogoryEvent, MainCatogoryState> {
  MainCatogoryBloc();
  @override
  MainCatogoryState get initialState => MainCatogoryLoadingState();

  @override
  Stream<MainCatogoryState> mapEventToState(
    MainCatogoryEvent event,
  ) async* {}
}
