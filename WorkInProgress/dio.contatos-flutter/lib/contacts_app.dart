import 'package:contatos_flutter/pages/main_page.dart';
import 'package:flutter/material.dart';

class ContactsApp extends StatelessWidget {
  const ContactsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contacts App',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: const ColorScheme.dark(
          primary: Colors.indigo,
          onPrimary: Colors.white,
          inversePrimary: Colors.indigo,
        ),
        useMaterial3: true,
      ),
      home: const MainPage(title: 'Lista de Contatos'),
    );
  }
}
