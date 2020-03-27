class ImageModel {
  int _id;
  String _name;
  String _src;

  ImageModel(this._id, this._name, this._src);
  int get id => _id;
  String get name => _name;
  String get src => _src;

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "src": src,
      };

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(json['id'], json['name'], json['src']);
  }
}
