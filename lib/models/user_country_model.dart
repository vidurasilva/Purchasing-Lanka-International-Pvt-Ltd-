// class UserCountryModel {
//   /// the flag image asset name
//   final String _asset;

//   /// the dialing code
//   final String _dialingCode;

//   /// the 2-letter ISO code
//   final String _isoCode;

//   /// the localized / English country name
//   final String _name;

//   final String _currency;

//   final String _currencyISO;

//   const UserCountryModel(this._asset, this._dialingCode, this._isoCode,
//       this._name, this._currency, this._currencyISO);

//   String get asset => _asset;
//   String get dialingCode => _dialingCode;
//   String get isoCode => _isoCode;
//   String get currency => _currency;
//   String get currencyISO => _currencyISO;
//   String get name => _name;

//   // method
//   Map<String, dynamic> toJson() => {
//         'name': name,
//         'asset': asset,
//         'dialingCode': dialingCode,
//         'isoCode': isoCode,
//         'currency': currency,
//         'currencyISO': currencyISO,
//       };

//   // named constructor
//   factory UserCountryModel.fromJson(Map<String, dynamic> json) {
//     return UserCountryModel(json['asset'], json['name'], json['dialingCode'],
//         json['isoCode'], json['currency'], json['currencyISO']);
//   }
// }

class UserCountryModel {
  final String _asset;

  /// the dialing code
  final String _dialingCode;

  /// the 2-letter ISO code
  final String _isoCode;

  /// the localized / English country name
  final String _name;

  final String _currency;

  final String _currencyISO;
  UserCountryModel(this._asset, this._dialingCode, this._isoCode, this._name,
      this._currency, this._currencyISO);

  // named constructor
  UserCountryModel.fromJson(Map<String, dynamic> json)
      : _asset = json['asset'],
        _dialingCode = json['dialingCode'],
        _isoCode = json['isoCode'],
        _name = json['name'],
        _currencyISO = json['currencyISO'],
        _currency = json['currency'];

  // method
  Map<String, dynamic> toJson() {
    return {
      'name': _name,
      'asset': _asset,
      'dialingCode': _dialingCode,
      'isoCode': _isoCode,
      'currencyISO': _currencyISO,
      'currency': _currency,
    };
  }
}
