import 'package:bloc/bloc.dart';
import 'package:purchasing_lanka_international/bloc/nav_event.dart';
import 'package:purchasing_lanka_international/bloc/nav_state.dart';
import 'package:purchasing_lanka_international/services/wp_api.dart';
import 'package:purchasing_lanka_international/util/dataStore.dart';

class NavBloc extends Bloc<NavEvent, NavState> {
  @override
  NavState get initialState => NavLoadingState();

  @override
  Stream<NavState> mapEventToState(
    NavEvent event,
  ) async* {
    String token = await getTokenFromPref();
    // TODO: implement mapEventToState
    if (event is NavStart) {
      //read shaird preferances and get data
      //define state which sute with shaird data
      yield CatogoryState();
    }
    if (event is GoToCatogoryButtonPressedNav) {
      //read shaird preferances and get data
      //define state which sute with shaird data
      yield CatogoryState();
    }
    if (event is GoToCartButtonPressedNav) {
      //read shaird preferances and get data
      //define state which sute with shaird data
      yield CartState();
    }
    if (event is GoToScoreBoadrButtonPressedNav) {
      //read shaird preferances and get data
      //define state which sute with shaird data
      yield ScoreBoardState();
    }

    if (event is GoToHomeButtonPressedNav) {
      yield HomeState(event.categori);
    }
    if (event is GetProductDetails) {
      yield ShowProducts(event.showDetailsproduct);
    }
    if (event is GoToUserProfileButtonPressedNav) {
      yield UserProfileState();
    }
    if (event is AddItemButtonPressed) {
      String body = await addItem(
          event.item.id, event.item.quantity, event.item.variation, token);
      print(body);
    }
  }
}
