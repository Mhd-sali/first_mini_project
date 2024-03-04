import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notifier_provider/features/contact_notifierprovider/model/contact_model.dart';

class ContactNotifier extends Notifier<List<ContactModel>> {
  @override
  List<ContactModel> build() {
    return [];
  }

  void addcontact(ContactModel contact) {
    state = [contact, ...state];
  }

  void updatecontact(
      String contactname, String phonenumber, int index, File? image) {
    state = [
      for (final contact in state)
        if (contact == state[index])
          contact.copywith(
            name: contactname,
            phone: phonenumber,
            imagefile: image,
          )
        else
          contact
    ];
  }

  void deletecontact(int index) {
    state = [
      for (final contact in state)
        if (contact != state[index]) contact
    ];
  }
}

final contactsprovider = NotifierProvider<ContactNotifier, List<ContactModel>>(
  () => ContactNotifier(),
);
final imageprovider = StateProvider<XFile?>((ref) => null);
