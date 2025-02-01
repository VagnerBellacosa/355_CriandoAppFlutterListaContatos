// ignore_for_file: unnecessary_getters_setters

class CreatedContactResponse {
  String _objectId = "";
  String _createdAt = "";

  CreatedContactResponse(
      {required String objectId, required String createdAt}) {
    _objectId = objectId;
    _createdAt = createdAt;
  }

  String get objectId => _objectId;
  set objectId(String objectId) => _objectId = objectId;
  String get createdAt => _createdAt;
  set createdAt(String createdAt) => _createdAt = createdAt;

  CreatedContactResponse.fromJson(Map<String, dynamic> json) {
    _objectId = json['objectId'];
    _createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['objectId'] = _objectId;
    data['createdAt'] = _createdAt;
    return data;
  }
}
