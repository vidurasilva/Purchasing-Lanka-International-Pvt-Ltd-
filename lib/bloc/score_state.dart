import 'package:equatable/equatable.dart';
import 'package:purchasing_lanka_international/models/country_best_customers.dart';
import 'package:purchasing_lanka_international/models/user.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ScoreState extends Equatable {
  const ScoreState();
}

class ScoreLoadingState extends ScoreState {
  @override
  List<Object> get props => [];
}

class ScoreLoadedState extends ScoreState {
  final User user;
  final List<User> bestUsersList;
  ScoreLoadedState(this.user, this.bestUsersList, this.bestContributeCountry);
  final List<BestCustomersCountryModel> bestContributeCountry;

  @override
  // TODO: implement props
  List<Object> get props => [user, bestUsersList, bestContributeCountry];
}
