import 'package:contatos_flutter/exceptions/bad_request_exception.dart';
import 'package:contatos_flutter/exceptions/http_request_exception.dart';
import 'package:contatos_flutter/exceptions/not_found_exception.dart';
import 'package:contatos_flutter/models/contact.dart';
import 'package:contatos_flutter/pages/add_contact_page.dart';
import 'package:contatos_flutter/services/contact/contact_service.dart';
import 'package:contatos_flutter/shared/widget/contact_card.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  final String title;

  const MainPage({super.key, required this.title});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late ContactService _contactService;
  late List<Contact> _contacts = [];
  var isLoading = false;

  @override
  void initState() {
    _contactService = ContactService();
    loadData();
    super.initState();
  }

  void loadData() async {
    setState(() {
      isLoading = true;
    });
    try {
      _contacts = await _contactService.list();
    } catch (e) {
      if (e is HttpRequestException) {
        showErrorMessage(e.message);
      } else {
        rethrow;
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void delete(String objectId) async {
    try {
      await _contactService.delete(objectId);
    } catch (e) {
      if (e is HttpRequestException) {
        showErrorMessage(e.message);
      } else if (e is BadRequestException) {
        showErrorMessage(e.message);
      } else if (e is NotFoundException) {
        showErrorMessage(e.message);
      } else {
        rethrow;
      }
    }
  }

  void showErrorMessage(String message) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            message,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: ListView.builder(
            itemCount: _contacts.length,
            itemBuilder: (_, index) {
              Contact contact = _contacts[index];
              return Dismissible(
                key: Key(contact.objectId ?? contact.email),
                onDismissed: (_) {
                  delete(contact.objectId!);
                },
                child: ContactCard(
                  key: Key(contact.objectId ?? contact.email),
                  contact: contact,
                ),
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const AddContactPage()));
          },
          tooltip: 'Increment',
          child: const Icon(Icons.add_reaction_outlined),
        ),
      ),
    );
  }
}
