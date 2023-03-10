import 'dart:io';

import 'package:father_app/model/person_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../constance.dart';

class Custom_Image extends StatelessWidget {
  Custom_Image({
    super.key,
    required this.ImagePath,
    this.Ridus = 60,
    this.person,
  });
  final PersonModel? person;
  final double Ridus;
  final String ImagePath;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: Ridus,
      child: ClipOval(
        // ignore: avoid_unnecessary_containers
        child: Container(
          child: Image.asset(
            ImagePath,
            width: Ridus * 2,
            height: Ridus * 2,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
