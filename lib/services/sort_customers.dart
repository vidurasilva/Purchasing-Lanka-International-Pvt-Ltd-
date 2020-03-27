import 'package:purchasing_lanka_international/models/user.dart';

class SortCustomers {
  List<User> _customerList;

  SortCustomers(this._customerList);

  List<User> get customerLevelList => _customerList;

  List<User> getFinalCustomerUser() {
    int temp;
    int tempId;
    bool is_sorted;
    List<User> customerLevelList = new List<User>();
    //Sort user List
    List<int> input = new List<int>();
    //Sort Id
    List<int> inputId = new List<int>();
    //for loop .prodLists
    // create new list for level
    //add new
    for (var k = 0; k < _customerList.length; k++) {
      if (true) {
        int pointvalu = int.parse(_customerList[k].points);
        input.add(pointvalu);
        inputId.add(_customerList[k].id);
      }
    }

    for (int i = 0; i < input.length; i++) {
      is_sorted = true;

      for (int j = 1; j < (input.length - i); j++) {
        if (input[j - 1] < input[j]) {
          temp = input[j - 1];
          tempId = inputId[j - 1];

          input[j - 1] = input[j];
          inputId[j - 1] = inputId[j];

          input[j] = temp;
          inputId[j] = tempId;

          is_sorted = false;
        }
      }
      // is sorted? then break it, avoid useless loop.
      if (is_sorted) break;
    }
    print(input.toString());
    print(inputId.toString());

    for (var n = 0; n < input.length; n++) {
      for (var m = 0; m < input.length; m++) {
        int pointUservalu = _customerList[m].id;
        if (inputId[n] == pointUservalu) {
          customerLevelList.add(_customerList[m]);
        }
      }
    }
    return customerLevelList;
  }
}
