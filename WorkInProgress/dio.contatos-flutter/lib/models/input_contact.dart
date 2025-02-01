// ignore_for_file: unnecessary_getters_setters

class InputContact {
  String? _objectId;
  String _name = "";
  String _email = "";
  int _phoneNumber = 0;
  String _imageUrl = "";

  InputContact(
      {required String name,
      required String email,
      required int phoneNumber,
      required String imageUrl}) {
    _name = name;
    _email = email;
    _phoneNumber = phoneNumber;
    _imageUrl = imageUrl;
  }

  String? get objectId => _objectId;
  set objectId(String? objectId) => _objectId = objectId;
  String get name => _name;
  set name(String name) => _name = name;
  String get email => _email;
  set email(String email) => _email = email;
  int get phoneNumber => _phoneNumber;
  set phoneNumber(int phoneNumber) => _phoneNumber = phoneNumber;
  String get imageUrl => _imageUrl;
  set imageUrl(String imageUrl) => _imageUrl = imageUrl;

  InputContact.fromJson(Map<String, dynamic> json) {
    _objectId = json['objectId'];
    _name = json['name'];
    _email = json['email'];
    _phoneNumber = json['phoneNumber'];
    _imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['objectId'] = _objectId;
    data['name'] = _name;
    data['email'] = _email;
    data['phoneNumber'] = _phoneNumber;
    data['imageUrl'] = _imageUrl;
    return data;
  }
}
