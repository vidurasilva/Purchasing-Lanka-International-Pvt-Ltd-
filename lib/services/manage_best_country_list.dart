import 'package:purchasing_lanka_international/models/country_best_customers.dart';

class ManegeBestCountryList {
  List<BestCustomersCountryModel> _countryList;

  ManegeBestCountryList(
    this._countryList,
  );

  List<BestCustomersCountryModel> get bestCountryList => _countryList;
  List<BestCustomersCountryModel> getFinalCountryItem() {
    int temp;
    BestCustomersCountryModel tempId;

    //Sort country List
    List<BestCustomersCountryModel> input = _countryList;
    //for loop .prodLists
    // create new list for level
    //add new
    for (var i = 0; i < _countryList.length; i++) {
      bool is_sorted = true;
      for (var j = 1; j < (_countryList.length - i); j++) {
        int point1 = int.parse(
            "${_countryList[j - 1].countryuserdetails['total_points']}");
        print(point1);
        int point2 =
            int.parse("${_countryList[j].countryuserdetails['total_points']}");

        print(point2);

        if (point1 < point2) {
          temp = point1;
          tempId = _countryList[j - 1];

          point1 = point2;
          input[j - 1] = input[j];

          point2 = temp;
          input[j] = tempId;

          is_sorted = false;
        }
      }
      // is sorted? then break it, avoid useless loop.
      if (is_sorted) break;
    }

    return input;
  }
}
