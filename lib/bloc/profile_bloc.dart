import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:purchasing_lanka_international/bloc/profile_event.dart';
import 'package:purchasing_lanka_international/bloc/profile_state.dart';
import 'package:purchasing_lanka_international/models/user.dart';
import 'package:purchasing_lanka_international/services/wp_api.dart';
import 'package:purchasing_lanka_international/util/dataStore.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc();
  @override
  ProfileState get initialState => ProfileLoadingState();

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    if (event is ProfileLoading) {
      //get token
      String token = await getTokenFromPref();
      //get user me
      User userMe = await getUser(token);
      //set user for preforances
      setUserToPref(jsonEncode(userMe));
      User user = await getUserFromPref();
      yield ProfileLoadedState(user);
    }
  }
}
