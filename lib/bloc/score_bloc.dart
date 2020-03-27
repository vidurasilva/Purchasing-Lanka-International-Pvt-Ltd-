import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:purchasing_lanka_international/bloc/score_event.dart';
import 'package:purchasing_lanka_international/bloc/score_state.dart';
import 'package:purchasing_lanka_international/models/country_best_customers.dart';
import 'package:purchasing_lanka_international/models/user.dart';
import 'package:purchasing_lanka_international/services/manage_best_country_list.dart';
import 'package:purchasing_lanka_international/services/sort_customers.dart';
import 'package:purchasing_lanka_international/services/wp_api.dart';
import 'package:purchasing_lanka_international/util/dataStore.dart';

class ScoreBloc extends Bloc<ScoreEvent, ScoreState> {
  ScoreBloc();
  @override
  ScoreState get initialState => ScoreLoadingState();

  @override
  Stream<ScoreState> mapEventToState(
    ScoreEvent event,
  ) async* {
    if (event is ScoreLoading) {
      print('Score Bloc : ScoreLoading event run');

      String token = await getTokenFromPref();
      //get customers from wp_api
      List<User> bestUsers = await getBestUsers(token);
      //sort custormers using their points
      SortCustomers customerBestLevel = new SortCustomers(bestUsers);
      List<User> bestUsersList = customerBestLevel.getFinalCustomerUser();

      //get countries  from wp_api
      List<BestCustomersCountryModel> bestContributeCountry =
          await getBestCustomersCountryList(token);

      //sort country using their points
      ManegeBestCountryList bestCountryLevel =
          new ManegeBestCountryList(bestContributeCountry);
      List<BestCustomersCountryModel> bestCountryList =
          bestCountryLevel.getFinalCountryItem();
      //get user me
      User userMe = await getUser(token);
      //set user for preforances
      setUserToPref(jsonEncode(userMe));

      User user = await getUserFromPref();
      yield ScoreLoadedState(user, bestUsersList, bestCountryList);
      print(bestContributeCountry);
    }
  }
}
