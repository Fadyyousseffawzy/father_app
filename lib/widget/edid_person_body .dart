import 'dart:io';

import 'package:father_app/cubits/person_cubit/person_cubit.dart';
import 'package:father_app/model/person_model.dart';
import 'package:father_app/widget/cutom_botton.dart';
import 'package:father_app/widget/ediddate.dart';
import 'package:father_app/widget/pickdate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../cubits/add_cubit/add_person_cubit.dart';
import 'custom_texet_filed.dart';
import 'image_circle.dart';

class edid_Person_Body extends StatefulWidget {
  const edid_Person_Body({
    Key? key,
    required this.person,
  }) : super(key: key);
  final PersonModel person;

  @override
  State<edid_Person_Body> createState() => _edid_Person_BodyState();
}

class _edid_Person_BodyState extends State<edid_Person_Body> {
  TextEditingController nameC = new TextEditingController();
  TextEditingController adressC = new TextEditingController();
  TextEditingController phoneC = new TextEditingController();
  TextEditingController workC = new TextEditingController();
  TextEditingController rowC = new TextEditingController();
  TextEditingController infoC = new TextEditingController();
  TextEditingController lastdateC = new TextEditingController();
  TextEditingController barthdayC = new TextEditingController();

  String? name, adress, phone, lastdate, work, barthday, row, info, photo;
  XFile? _image;

  GetImageFromCamra() async {
    final image = await ImagePicker.platform.getImage(
      source: ImageSource.camera,
      imageQuality: 0,
    );
    setState(() {
      _image = image;
    });
  }

  GetImageFromgGallery() async {
    final image = await ImagePicker.platform.getImage(
      source: ImageSource.gallery,
      imageQuality: 0,
    );
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    nameC.text = widget.person.name;
    adressC.text = widget.person.adress;
    phoneC.text = widget.person.phone;
    workC.text = widget.person.work;
    rowC.text = widget.person.row;
    infoC.text = widget.person.info;
    lastdateC.text = widget.person.lastdate;
    barthdayC.text = widget.person.barthday;

    //widget.person.photo == null

    return Form(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 100,
                vertical: 10,
              ),
              child: SizedBox(
                width: 50,
                height: 30,
                child: CustomAddBotton(
                  texet: 'حفظ التغيرات',
                  onTap: () {
                    if (_image == null) {
                      photo = widget.person.photo;
                    } else {
                      photo = _image!.path;
                      //photo = widget.person.photo;
                    }
                    widget.person.name = name ?? widget.person.name;
                    widget.person.adress = adress ?? widget.person.adress;
                    widget.person.phone = phone ?? widget.person.phone;
                    widget.person.work = work ?? widget.person.work;
                    widget.person.barthday = barthday ?? widget.person.barthday;
                    widget.person.info = info ?? widget.person.info;
                    widget.person.row = row ?? widget.person.row;
                    widget.person.lastdate = lastdate ?? widget.person.lastdate;
                    //widget.person.photo = photo ?? widget.person.photo;
                    widget.person.photo = photo!;
                    widget.person.save();
                    BlocProvider.of<PersonCubit>(context).fetchAllPerson();

                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Row(
                children: [
                  Column(
                    children: [
                      ElevatedButton.icon(
                        icon: const Icon(Icons.add_a_photo),
                        label: const Text('الكاميرا'),
                        onPressed: GetImageFromCamra,
                      ),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.photo_album_outlined),
                        label: const Text('معرض الصور'),
                        onPressed: GetImageFromgGallery,
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  widget.person.photo == "" && _image == null
                      ? SizedBox(
                          height: 75,
                          child: Image.asset('images/profile_image.png'),
                        )
                      : CircleAvatar(
                          radius: 74,
                          child: ClipOval(
                            child: Image.file(
                              File(_image != null
                                  ? _image!.path
                                  : widget.person.photo),
                              fit: BoxFit.cover,
                              height: 150,
                              width: 150,
                            ),
                          ),
                        )
                ],
              ),
            ),
            CustomTextField(
              onChanged: (value) {
                name = value;
              },
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'الرجاء داخال الاسم';
                } else {
                  return null;
                }
              },
              labelText: "الاسم",
              controller: nameC,
              icon: Icons.person_add,
            ),
            CustomTextField(
              keyboardType: TextInputType.phone,
              onChanged: (value) {
                phone = value;
              },
              icon: Icons.phone,
              labelText: "تليفون",
              controller: phoneC,
              maxLength: 15,
            ),
            EdidPickDate(
              onChanged: (value) {
                barthday = value;
              },
              labelText: 'تاريخ الميلاد',
              controller: barthdayC,
              hintText: widget.person.barthday,
            ),
            EdidPickDate(
              onChanged: (value) {
                lastdate = value;
              },
              labelText: "تاريخ الاعتراف",
              controller: lastdateC,
              hintText: widget.person.lastdate,
            ),
            CustomTextField(
              onChanged: (value) {
                adress = value;
              },
              icon: Icons.home_work,
              labelText: "العنوان",
              controller: adressC,
            ),
            CustomTextField(
              onChanged: (value) {
                work = value;
              },
              icon: Icons.work,
              labelText: "العمل",
              controller: workC,
            ),
            CustomTextField(
              onChanged: (value) {
                row = value;
              },
              labelText: "القانون الروحي",
              icon: Icons.book,
              controller: rowC,
            ),
            CustomTextField(
              onChanged: (val) {
                info = val;
              },
              icon: Icons.info,
              labelText: "معلومات اضافية",
              controller: infoC,
            ),
          ],
        ),
      ),
    );
  }
}
