import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notifier_provider/features/contact_notifierprovider/provider/contact_provider.dart';

class ContactSheet extends StatelessWidget {
  final TextEditingController name;
  final TextEditingController phone;
  final GlobalKey<FormState> formkey;
  final VoidCallback onsubmit;
  final VoidCallback ontapimage;
  final File? image;

  const ContactSheet({
    super.key,
    required this.name,
    required this.formkey,
    required this.onsubmit,
    required this.ontapimage,
    required this.phone,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Form(
        key: formkey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 49),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.close,
                      size: 40,
                    ),
                  ),
                  const Text(
                    "Save to Google",
                  ),
                  IconButton(
                    onPressed: onsubmit,
                    icon: const Icon(
                      Icons.check,
                      size: 40,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: ontapimage,
              child: Consumer(
                builder: (_, ref, __) {
                  return CircleAvatar(
                    backgroundImage: image != null &&
                            ref.watch(imageprovider) == null
                        ? FileImage(image!)
                        : ref.watch(imageprovider) == null
                            ? null
                            : FileImage(File(ref.watch(imageprovider)!.path)),
                    radius: 50,
                    child: image != null
                        ? const SizedBox.shrink()
                        : ref.watch(imageprovider) == null
                            ? const Icon(
                                Icons.account_circle,
                                size: 100,
                              )
                            : null,
                  );
                },
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: 350,
              height: 85,
              child: TextFormField(
                controller: phone,
                decoration: InputDecoration(
                  counterText: "",
                  filled: true,
                  fillColor: Colors.grey,
                  errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.redAccent,
                  )),
                  hintText: "Phone:",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Colors.blue,
                      )),
                ),
                maxLength: 10,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Phone number Cannot be empty";
                  }
                  if (value.length < 10) {
                    return "Enter a valid Phone number";
                  }
                  return null;
                },
                keyboardType: TextInputType.phone,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 350,
              height: 85,
              child: TextFormField(
                controller: name,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey,
                  errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.redAccent,
                  )),
                  hintText: "Name:",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Colors.blue,
                      )),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Name Cannot be empty";
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
