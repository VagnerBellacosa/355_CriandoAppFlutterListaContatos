import 'dart:io';

import 'package:contatos_flutter/exceptions/bad_request_exception.dart';
import 'package:contatos_flutter/exceptions/http_request_exception.dart';
import 'package:contatos_flutter/models/input_contact.dart';
import 'package:contatos_flutter/pages/main_page.dart';
import 'package:contatos_flutter/services/contact/contact_service.dart';
import 'package:contatos_flutter/shared/widget/custom_form_field.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';

class AddContactPage extends StatefulWidget {
  const AddContactPage({super.key});

  @override
  State<AddContactPage> createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  TextEditingController nameController = TextEditingController(text: "");
  TextEditingController emailController = TextEditingController(text: "");
  TextEditingController phoneController = TextEditingController(text: "");
  XFile? image;

  late ImagePicker imagePicker;

  var isLoading = false;
  late ContactService _contactService;

  @override
  void initState() {
    imagePicker = ImagePicker();
    _contactService = ContactService();
    super.initState();
  }

  Future<CroppedFile?> cropImage(XFile imageFile) async {
    return await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
        WebUiSettings(
          context: context,
        ),
      ],
    );
  }

  void saveImage(CroppedFile croppedFile) async {
    await ImageGallerySaver.saveFile(croppedFile.path);
    image = XFile(croppedFile.path);
    setState(() {});
  }

  void saveContact() async {
    setState(() {
      isLoading = true;
    });

    var hasError = "";
    if (nameController.text.trim() == "") {
      hasError = "Nome não pode estar vazio";
    }
    if (emailController.text.trim() == "") {
      if (hasError.trim().isNotEmpty) {
        hasError += ", E-mail não pode estar vazio";
      } else {
        hasError = "E-mail não pode estar vazio";
      }
    }
    if (phoneController.text.trim() == "") {
      if (hasError.trim().isNotEmpty) {
        hasError += ", Telefone não pode estar vazio";
      } else {
        hasError = "Telefone não pode estar vazio";
      }
    }
    if (image == null) {
      if (hasError.trim().isNotEmpty) {
        hasError += ", Imagem deve ser selecionada";
      } else {
        hasError = "Imagem deve ser selecionada";
      }
    }

    if (hasError.trim().isNotEmpty) {
      showErrorMessage(hasError);
      setState(() {
        isLoading = false;
      });
    } else {
      var inputContact = InputContact(
        name: nameController.text,
        email: emailController.text,
        phoneNumber: int.tryParse(phoneController.text) ?? 0,
        imageUrl: image!.path,
      );

      try {
        var response = await _contactService.create(inputContact);
        debugPrint(response.toString());
        nameController.text = "";
        emailController.text = "";
        phoneController.text = "";
        image = null;
        if (context.mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => const MainPage(title: 'Lista de Contatos'),
            ),
          );
        }
      } catch (e) {
        if (e is BadRequestException) {
          showErrorMessage(e.message);
        } else if (e is HttpRequestException) {
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
          title: const Text("Adicionar contato"),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: ListView(
            children: [
              CustomFormField(
                label: "Nome",
                keyboardType: TextInputType.name,
                controller: nameController,
              ),
              const SizedBox(height: 12),
              CustomFormField(
                label: "E-mail",
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
              ),
              const SizedBox(height: 12),
              CustomFormField(
                label: "Telefone",
                keyboardType: TextInputType.phone,
                controller: phoneController,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 64,
                      child: ElevatedButton(
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (_) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Wrap(
                                    children: [
                                      ListTile(
                                        leading: const Icon(Icons.camera),
                                        title: const Text("Câmera"),
                                        onTap: () async {
                                          image = await imagePicker.pickImage(
                                              source: ImageSource.camera);
                                          if (image != null) {
                                            var croppedImage =
                                                await cropImage(image!);
                                            if (croppedImage != null) {
                                              saveImage(croppedImage);
                                            }
                                          }
                                          if (context.mounted) {
                                            Navigator.of(context).pop();
                                          }
                                        },
                                      ),
                                      ListTile(
                                        leading: const Icon(Icons.image),
                                        title: const Text("Galeria"),
                                        onTap: () async {
                                          image = await imagePicker.pickImage(
                                              source: ImageSource.gallery);
                                          if (image != null) {
                                            var croppedImage =
                                                await cropImage(image!);
                                            if (croppedImage != null) {
                                              saveImage(croppedImage);
                                            }
                                          }
                                          if (context.mounted) {
                                            Navigator.of(context).pop();
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              });
                        },
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                              side: const BorderSide(
                                color: Colors.indigo,
                                style: BorderStyle.solid,
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                        child: const Text(
                          "Adicionar Imagem",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  image == null
                      ? const SizedBox(
                          width: 64,
                          height: 64,
                          child: Icon(
                            Icons.image_search,
                            size: 40,
                          ),
                        )
                      : SizedBox(
                          width: 64,
                          height: 64,
                          child: Image.file(
                            File(image!.path),
                          ),
                        ),
                ],
              ),
              const SizedBox(height: 64),
              SizedBox(
                height: 48,
                child: FilledButton(
                  onPressed: () => saveContact(),
                  child: isLoading
                      ? const Center(
                          child: SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
                        )
                      : const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.save,
                              size: 24,
                            ),
                            SizedBox(width: 8),
                            Text(
                              "Salvar",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
