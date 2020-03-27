class BestCustomersCountryModel {
  String _country;
  var _countryuserdetails;

  BestCustomersCountryModel(this._country, this._countryuserdetails);

  String get country => _country;
  Map<String, dynamic> get countryuserdetails => _countryuserdetails;

  BestCustomersCountryModel.fromJson(Map<String, dynamic> json)
      : _country = json['country'],
        _countryuserdetails = json['user_details'];

  Map<String, dynamic> toJson() => {
        'country': _country,
        'user_details': BestCountryUsers.fromJson(_countryuserdetails),
      };
}

class BestCountryUsers {
  int _count;
  String _userspoint;
  String _userstip;
  String _usersPurchase;
  String _countryflage;

  BestCountryUsers(this._count, this._userspoint, this._userstip,
      this._usersPurchase, this._countryflage);
  int get count => _count;
  String get userspoint => _userspoint;
  String get userstip => _userstip;
  String get userspurchase => _usersPurchase;
  String get countryflage => _countryflage;

  Map<String, dynamic> toJson() => {
        "user_id": count,
        "total_points": userspoint,
        "total_tip": userstip,
        "total_purchase": userstip,
        "country_flage": countryflage,
      };

  factory BestCountryUsers.fromJson(Map<String, dynamic> json) {
    return BestCountryUsers(json['count'], json['total_points'],
        json['total_purchase'], json['total_tip'], json['country_flage']);
  }
}
