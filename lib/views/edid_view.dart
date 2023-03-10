import 'package:father_app/constance.dart';
import 'package:father_app/cubits/person_cubit/person_cubit.dart';
import 'package:father_app/model/person_model.dart';
import 'package:flutter/material.dart';
import '../widget/edid_person_body .dart';

class EdidViewPerson extends StatelessWidget {
  const EdidViewPerson({super.key, required this.person});

  final PersonModel person;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('تعديل بيانات المعترف')),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: const AssetImage(
            backgroundImage,
          ),
          colorFilter: ColorFilter.mode(
            Colors.white.withOpacity(0.5),
            BlendMode.modulate,
          ),
          fit: BoxFit.cover,
        )),
        child: edid_Person_Body(person: person),
      ),
    );
  }
}
