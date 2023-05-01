class UrlModel {
  int id;
  String name;

  UrlModel(this.id, this.name);

  get title => null;

  // Method to convert UrlModel object to a Map
  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name};
  }

  // Method to create UrlModel object from a Map
  factory UrlModel.fromMap(Map<String, dynamic> map) {
    return UrlModel(map['id'], map['name']);
  }
  void updateName(String newName) {
    name = newName;
  }
}
/*
UrlModel: This is a class that represents a URL model with two properties: _id
and name.
 */