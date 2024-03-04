import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notifier_provider/features/contact_notifierprovider/model/contact_model.dart';
import 'package:notifier_provider/features/contact_notifierprovider/provider/contact_provider.dart';
import 'package:notifier_provider/features/contact_notifierprovider/theme/themechanger.dart';
import 'package:notifier_provider/features/contact_notifierprovider/view/widgets/contactsheet.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContactMainpage extends ConsumerWidget {
  ContactMainpage({super.key});
  final name = TextEditingController();
  final phone = TextEditingController();
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contacts = ref.watch(contactsprovider);
    XFile? image;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              ref.read(themeProvider.notifier).switcher();
            },
            icon: ref.watch(themeProvider)
                ? const Icon(Icons.sunny)
                : const Icon(
                    Icons.dark_mode,
                    color: Colors.white,
                  )),
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.call,
                color: Color.fromARGB(255, 14, 193, 20),
              ),
            ),
            const SizedBox(
              width: 40,
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.account_circle,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 25,
              vertical: 25,
            ),
            child: SizedBox(
              height: 45,
              child: TextField(
                decoration: InputDecoration(
                  hintText: "1121 Contacts",
                  hintStyle: const TextStyle(color: Colors.grey),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  filled: true,
                  fillColor: const Color.fromARGB(255, 66, 66, 66),
                  border: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Color.fromARGB(0, 194, 18, 18)),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        phone.text = contacts[index].phone;
                        name.text = contacts[index].name;
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (context) => ContactSheet(
                            phone: phone,
                            name: name,
                            formkey: formkey,
                            onsubmit: () {
                              if (formkey.currentState!.validate()) {
                                if (image != null) {
                                  ref
                                      .read(contactsprovider.notifier)
                                      .updatecontact(name.text, phone.text,
                                          index, File(image!.path));
                                }

                                name.clear();
                                phone.clear();
                                ref.read(imageprovider.notifier).state = null;
                                Navigator.pop(context);
                              }
                            },
                            ontapimage: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text(
                                    "Photo",
                                    textAlign: TextAlign.center,
                                  ),
                                  content: Row(
                                    children: [
                                      TextButton(
                                        onPressed: () async {
                                          final imagepicker = ImagePicker();
                                          XFile? image =
                                              await imagepicker.pickImage(
                                                  source: ImageSource.camera);
                                          if (image != null) {
                                            if (context.mounted) {
                                              Navigator.pop(context);
                                            }
                                          }
                                          ref
                                              .read(imageprovider.notifier)
                                              .state = image;
                                        },
                                        child: const Text("Take photo"),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          final imagepicker = ImagePicker();
                                          image = await imagepicker.pickImage(
                                              source: ImageSource.gallery);
                                          if (image != null) {
                                            Future.sync(
                                                () => Navigator.pop(context));
                                          }
                                          ref
                                              .read(imageprovider.notifier)
                                              .state = image;
                                        },
                                        child:
                                            const Text("Choose from Gallery"),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            image: contacts[index].imagefile,
                          ),
                        );
                      },
                      child: Card(
                        child: ListTile(
                          trailing: IconButton(
                            onPressed: () {
                              ref
                                  .read(contactsprovider.notifier)
                                  .deletecontact(index);
                            },
                            icon: const Icon(Icons.delete),
                          ),
                          leading: CircleAvatar(
                            backgroundImage: contacts[index].imagefile == null
                                ? null
                                : FileImage(contacts[index].imagefile!),
                            child: contacts[index].imagefile == null
                                ? const Icon(Icons.account_circle)
                                : null,
                          ),
                          title: Text(contacts[index].name),
                          subtitle: Text(contacts[index].phone),
                        ),
                      ),
                    )),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) => ContactSheet(
              phone: phone,
              name: name,
              formkey: formkey,
              onsubmit: () {
                if (formkey.currentState!.validate()) {
                  ref.read(contactsprovider.notifier).addcontact(ContactModel(
                        name: name.text,
                        phone: phone.text,
                        imagefile: ref.watch(imageprovider) == null
                            ? null
                            : File(ref.watch(imageprovider)!.path),
                      ));
                  name.clear();
                  phone.clear();
                  ref.read(imageprovider.notifier).state = null;
                  Navigator.pop(context);
                }
              },
              ontapimage: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text(
                      "Photo",
                      textAlign: TextAlign.center,
                    ),
                    content: Row(
                      children: [
                        TextButton(
                          onPressed: () async {
                            final imagepicker = ImagePicker();
                            XFile? image = await imagepicker.pickImage(
                                source: ImageSource.camera);
                            if (image != null) {
                              if (context.mounted) {
                                Navigator.pop(context);
                              }
                            }
                            ref.read(imageprovider.notifier).state = image;
                          },
                          child: const Text("Take photo"),
                        ),
                        TextButton(
                          onPressed: () async {
                            final imagepicker = ImagePicker();
                            XFile? image = await imagepicker.pickImage(
                                source: ImageSource.gallery);
                            if (image != null) {
                              Future.sync(() => Navigator.pop(context));
                            }
                            ref.read(imageprovider.notifier).state = image;
                          },
                          child: const Text("Choose from Gallery"),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
