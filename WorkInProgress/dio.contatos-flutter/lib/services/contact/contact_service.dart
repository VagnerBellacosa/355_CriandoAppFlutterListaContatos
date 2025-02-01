import 'package:contatos_flutter/models/updated_contact_response.dart';
import 'package:dio/dio.dart';
import 'package:contatos_flutter/models/contact.dart';
import 'package:contatos_flutter/exceptions/bad_request_exception.dart';
import 'package:contatos_flutter/exceptions/http_request_exception.dart';
import 'package:contatos_flutter/exceptions/not_found_exception.dart';
import 'package:contatos_flutter/models/input_contact.dart';
import 'package:contatos_flutter/models/created_contact_response.dart';
import 'package:contatos_flutter/services/back4app/back_4_app_dio.dart';

class ContactService {
  late Back4AppDio _back4appDio;

  ContactService() {
    _back4appDio = Back4AppDio();
  }

  Future<CreatedContactResponse> create(InputContact inputContact) async {
    try {
      var createContactDTO = InputContact.fromJson(inputContact.toJson());
      var response = await _back4appDio.dio
          .post("/contact", data: createContactDTO.toJson());
      return CreatedContactResponse.fromJson(response.data);
    } catch (e) {
      if (e is DioException) {
        DioException ex = e;
        if (ex.response!.statusCode == 400) {
          throw BadRequestException(
              "Erro ao tentar cadastrar contato: 400 Bad Request");
        } else {
          throw HttpRequestException(
              "Erro ao tentar cadastrar contato: status code ${ex.response!.statusCode}");
        }
      }
      rethrow;
    }
  }

  Future<List<Contact>> list() async {
    try {
      var response = await _back4appDio.dio.get("/contact");
      return (response.data["results"] as List)
          .map((contact) => Contact.fromJson(contact))
          .toList();
    } catch (e) {
      if (e is DioException) {
        DioException ex = e;
        throw HttpRequestException(
            "Erro ao tentar listar contatos: status code ${ex.response!.statusCode}");
      }
      rethrow;
    }
  }

  Future<Contact> getByObjectId(String objectId) async {
    try {
      var response = await _back4appDio.dio.get("/contact/$objectId");
      return Contact.fromJson(response.data);
    } catch (e) {
      if (e is DioException) {
        if (e.response!.statusCode == 404) {
          throw BadRequestException(
              "Erro ao tentar buscar contato: 404 Not Found");
        }
        throw HttpRequestException(
            "Erro ao tentar buscar contato: status code ${e.response!.statusCode.toString()}");
      }
      rethrow;
    }
  }

  Future<UpdatedContactResponse> update(
      String objectId, InputContact inputContact) async {
    try {
      var updateContactDTO = InputContact.fromJson(inputContact.toJson());
      updateContactDTO.objectId = objectId;
      var response = await _back4appDio.dio
          .put("/contact/$objectId", data: updateContactDTO.toJson());
      return UpdatedContactResponse.fromJson(response.data);
    } catch (e) {
      if (e is DioException) {
        DioException ex = e;
        if (ex.response!.statusCode == 400) {
          throw BadRequestException(
              "Erro ao tentar cadastrar contato: 400 Bad Request");
        } else {
          throw HttpRequestException(
              "Erro ao tentar cadastrar contato: status code ${ex.response!.statusCode}");
        }
      }
      rethrow;
    }
  }

  Future<void> delete(String objectId) async {
    try {
      await _back4appDio.dio.delete("/contact/$objectId");
    } catch (e) {
      if (e is DioException) {
        if (e.response!.statusCode == 400) {
          throw BadRequestException(
              "Erro ao tentar deletar contato: 400 Baq Request");
        }
        if (e.response!.statusCode == 404) {
          throw NotFoundException(
              "Erro ao tentar deletar contato: 404 Not Found");
        }
        throw HttpRequestException(
            "Erro ao tentar deletar contato: status code ${e.response!.statusCode}");
      }
      rethrow;
    }
  }
}
