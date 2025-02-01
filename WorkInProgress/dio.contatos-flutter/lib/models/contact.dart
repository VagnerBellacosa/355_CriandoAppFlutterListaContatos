// ignore_for_file: unnecessary_getters_setters

class Contact {
  String? _objectId;
  String? _createdAt;
  String? _updatedAt;
  String _name = "";
  String _email = "";
  int _phoneNumber = 0;
  String _imageUrl = "";

  Contact(
      {String? objectId,
      String? createdAt,
      String? updatedAt,
      required String name,
      required String email,
      required int phoneNumber,
      required String imageUrl}) {
    if (objectId != null) {
      _objectId = objectId;
    }
    if (createdAt != null) {
      _createdAt = createdAt;
    }
    if (updatedAt != null) {
      _updatedAt = updatedAt;
    }
    _name = name;
    _email = email;
    _phoneNumber = phoneNumber;
    _imageUrl = imageUrl;
  }

  String? get objectId => _objectId;
  set objectId(String? objectId) => _objectId = objectId;
  String? get createdAt => _createdAt;
  set createdAt(String? createdAt) => _createdAt = createdAt;
  String? get updatedAt => _updatedAt;
  set updatedAt(String? updatedAt) => _updatedAt = updatedAt;
  String get name => _name;
  set name(String name) => _name = name;
  String get email => _email;
  set email(String email) => _email = email;
  int get phoneNumber => _phoneNumber;
  set phoneNumber(int phoneNumber) => _phoneNumber = phoneNumber;
  String get imageUrl => _imageUrl;
  set imageUrl(String imageUrl) => _imageUrl = imageUrl;

  Contact.fromJson(Map<String, dynamic> json) {
    _objectId = json['objectId'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _name = json['name'];
    _email = json['email'];
    _phoneNumber = json['phoneNumber'];
    _imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['objectId'] = _objectId;
    data['createdAt'] = _createdAt;
    data['updatedAt'] = _updatedAt;
    data['name'] = _name;
    data['email'] = _email;
    data['phoneNumber'] = _phoneNumber;
    data['imageUrl'] = _imageUrl;
    return data;
  }
}
