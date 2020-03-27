import 'dart:convert';
import 'package:purchasing_lanka_international/bloc/authentication_bloc.dart';
import 'package:purchasing_lanka_international/bloc/bloc.dart';
import 'package:purchasing_lanka_international/bloc/request_access_event.dart';
import 'package:bloc/bloc.dart';
import 'package:purchasing_lanka_international/bloc/request_access_state.dart';
import 'package:purchasing_lanka_international/models/user.dart';
import 'package:purchasing_lanka_international/services/wp_api.dart';
import 'package:purchasing_lanka_international/util/dataStore.dart';
import 'package:meta/meta.dart';
import 'authentication_event.dart';

class RequestAccessBloc extends Bloc<RequestAccessEvent, RequestAccessState> {
  final AuthenticationBloc authenticationBloc;

  RequestAccessBloc({
    @required this.authenticationBloc,
  }) : assert(authenticationBloc != null);

  @override
  RequestAccessState get initialState => RequestInitial();

  @override
  Stream<RequestAccessState> mapEventToState(
    RequestAccessEvent event,
  ) async* {
    if (event is PressRequestingAccess) {
      String receiptImage = await getReceiptImageFromPref();
      yield RequestingState();
      try {
        String strTok = await newUserRequest(event.username, event.email,
            event.firstname, event.country, event.password);
        print(strTok);

        //Decode the Jsone file and assign data to veriable
        Map<String, dynamic> mapToken = jsonDecode(strTok);
        int id = mapToken["id"];

        String username = mapToken["username"];
        //update Country
        String countryReturn = await userCountryUpdate(event.country, id);
        print(countryReturn);

        //update countryFlage
        String countryFlageReturn =
            await userCountryFlageUpdate(event.countryFlag, id);
        print(countryFlageReturn);

        add(UploadImage(receiptImage, id, username));
      } catch (error) {
        yield RequestAccessFailure(error: error.toString());
      }
    }
    if (event is UploadImage) {
      yield ImageUploadedState();
      try {
        String strTok = await receiptImageUplade(
            event.receiptImage, event.id, event.username);
        print(strTok);
        authenticationBloc.add(LoggedOut());
        yield RequestedState();
        if (state is RequestedState) {
          authenticationBloc.add(LoggedOut());
        }
      } catch (error) {
        yield RequestAccessFailure(error: error.toString());
      }
    }
    if (event is UplodingImage) {
      yield UploadingImageState(event.imagePath);
    }
    if (event is PressUpdateUser) {
      //get new token
      String strTok = await getToken(event.username, event.password);

      //Decode the Jsone file and assign data to veriable
      Map<String, dynamic> mapToken = jsonDecode(strTok);
      var token = mapToken["token"];
      //get user details
      User userShired = await getUser(token);
      //set user for shaired pref
      setUserToPref(jsonEncode(userShired));
      //loging as new user
      authenticationBloc.add(LoggedIn(token: token, user: userShired));
    }
    if (event is PressRulesScreen) {
      yield PressRulescreenState(
          username: event.username,
          firstname: event.firstname,
          email: event.email,
          password: event.password,
          country: event.country,
          countryFlag: event.countryFlag,
          token: event.token);
    }

    if (event is PressLoadingScreen) {
      yield RequestingState();
      //set new user
      String resultUpdateUser = await userUpdateUsingCode(event.username,
          event.email, event.firstname, event.country, event.password);
      print(resultUpdateUser);
      //get new token
      String strTok = await getToken(event.username, event.password);

      //Decode the Jsone file and assign data to veriable
      Map<String, dynamic> mapToken = jsonDecode(strTok);
      var token = mapToken["token"];

      //set as shaired preferances
      setTokenToPref(token);

      //get user details
      User user = await getUser(token);

      //update user country
      String resultCountry = await userCountryUpdate(event.country, user.id);
      print(resultCountry);
      //update user country flage
      String resultCountryFlage =
          await userCountryFlageUpdate(event.countryFlag, user.id);
      print(resultCountryFlage);
      //addPointToUser to new user
      String resultaddPointToUser = await addPointToUser(user.id, 00000, token);
      print(resultaddPointToUser);

      //get user details
      User userShired = await getUser(token);
      //set user for shaired pref
      setUserToPref(jsonEncode(userShired));

      //Change state
      yield PressLoadingScreenState(
          username: event.username,
          firstname: event.firstname,
          email: event.email,
          password: event.password,
          country: event.country,
          countryFlag: event.countryFlag,
          token: event.token);
    }
  }
}
