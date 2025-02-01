// ignore_for_file: unnecessary_getters_setters

import 'package:contatos_flutter/models/contact.dart';

class Contacts {
  List<Contact> _results = [];

  Contacts({required List<Contact> results}) {
    _results = results;
  }

  List<Contact> get results => _results;
  set results(List<Contact> results) => _results = results;

  Contacts.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      _results = <Contact>[];
      json['results'].forEach((v) {
        _results.add(Contact.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = _results.map((v) => v.toJson()).toList();
    return data;
  }
}
