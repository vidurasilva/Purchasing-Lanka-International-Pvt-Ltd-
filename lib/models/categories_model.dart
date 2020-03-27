class CategoriesModel {
  int _id;
  String _name;
  String _slug;

  CategoriesModel(this._id, this._name, this._slug);
  int get id => _id;
  String get name => _name;
  String get slug => _slug;

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
      };

  factory CategoriesModel.fromJson(Map<String, dynamic> json) {
    return CategoriesModel(json['id'], json['name'], json['slug']);
  }
}
