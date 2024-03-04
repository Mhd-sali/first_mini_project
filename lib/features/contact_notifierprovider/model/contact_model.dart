import 'dart:io';

import 'package:flutter/material.dart';

@immutable
class ContactModel {
  final String name;
  final String phone;
  final File? imagefile;

  const ContactModel({
    required this.name,
    required this.phone,
    this.imagefile,
  });

  ContactModel copywith({
    String? name,
    String? phone,
    File? imagefile,
  }) {
    return ContactModel(
      imagefile: imagefile ?? this.imagefile,
      name: name ?? this.name,
      phone: phone ?? this.phone,
    );
  }
}
