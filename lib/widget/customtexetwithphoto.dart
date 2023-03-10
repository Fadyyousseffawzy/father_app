import 'dart:ffi';

import 'package:father_app/widget/image_circle.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class customtexetwithphoto extends StatelessWidget {
  customtexetwithphoto({
    super.key,
    required this.text,
    required this.imagepath,
    this.onTap,
    required this.hieghtSize,
  });
  final String text;
  final String imagepath;
  final void Function()? onTap;
  final double hieghtSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(children: [
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          height: hieghtSize,
          child: Image.asset(imagepath),
        ),
        Center(
          child: Text(
            text,
            style: const TextStyle(color: Colors.black, fontSize: 20),
          ),
        ),
      ]),
    );
  }
}
