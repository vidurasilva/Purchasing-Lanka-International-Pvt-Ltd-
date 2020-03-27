class User {
  final int _id;
  final String _points;
  final String _slug;
  final String _name;
  final List _role;
  final String _userEmail;
  final String _country;
  final String _country_flag;
  final String _tip;
  final String _totalPurchase;

  User(
      this._id,
      this._name,
      this._role,
      this._slug,
      this._country,
      this._country_flag,
      this._points,
      this._userEmail,
      this._tip,
      this._totalPurchase);

  int get id => _id;
  String get points => _points;
  String get name => _name;
  List get role => _role;
  String get slug => _slug;
  String get country => _country;
  String get countryFlag => _country_flag;
  String get userEmail => _userEmail;
  String get tip => _tip;
  String get totalPurchase => _totalPurchase;

  Map<String, dynamic> toJson() => {
        'id': id,
        'points': points,
        'name': name,
        'roles': role,
        'slug': slug,
        'country': country,
        'country_flage': countryFlag,
        'user_email': userEmail,
        'user_tip': tip,
        'user_total_purchase': _totalPurchase,
      };

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        json['id'],
        json['name'],
        json['roles'],
        json['slug'],
        json['country'],
        json['country_flage'],
        json['points'],
        json['user_email'],
        json['user_tip'],
        json['user_total_purchase']);
  }
}
