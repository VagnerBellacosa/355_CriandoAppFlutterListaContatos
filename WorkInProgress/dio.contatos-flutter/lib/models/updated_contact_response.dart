// ignore_for_file: unnecessary_getters_setters

class UpdatedContactResponse {
  String? _updatedAt;

  UpdatedContactResponse({String? updatedAt}) {
    if (updatedAt != null) {
      _updatedAt = updatedAt;
    }
  }

  String? get updatedAt => _updatedAt;
  set updatedAt(String? updatedAt) => _updatedAt = updatedAt;

  UpdatedContactResponse.fromJson(Map<String, dynamic> json) {
    _updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['updatedAt'] = _updatedAt;
    return data;
  }
}
