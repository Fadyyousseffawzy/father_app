import 'dart:io';

//import 'package:contact_picker/contact_picker.dart';
import 'package:father_app/model/person_model.dart';
import 'package:father_app/widget/cutom_botton.dart';
import 'package:father_app/widget/pickdate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../cubits/add_cubit/add_person_cubit.dart';
import 'custom_texet_filed.dart';
import 'image_circle.dart';

class New_Person_Body extends StatefulWidget {
  const New_Person_Body({
    Key? key,
  }) : super(key: key);

  @override
  State<New_Person_Body> createState() => _New_Person_BodyState();
}

class _New_Person_BodyState extends State<New_Person_Body> {
  TextEditingController controller = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  String? name, adress, phone, dateA3TRAF, work, brith, row, info, photo;
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

  bool? isloading = false;

  // final ContactPicker _contactPicker = new ContactPicker();
  // late Contact _contact;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      autovalidateMode: autovalidateMode,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 5),
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
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  _image == null
                      ? SizedBox(
                          height: 75,
                          child: Image.asset('images/profile_image.png'),
                        )
                      : CircleAvatar(
                          radius: 74,
                          child: ClipOval(
                            child: Image.file(
                              File(
                                _image!.path,
                              ),
                              fit: BoxFit.cover,
                              height: 150,
                              width: 150,
                            ),
                          ),
                        ),
                ],
              ),
            ),
            CustomTextField(
              onSaved: (value) {
                name = value;
              },
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'الرجاء داخال الاسم';
                } else {
                  return null;
                }
              },
              hintText: 'الاسم',
              icon: Icons.person_add,
            ),
            CustomTextField(
              keyboardType: TextInputType.phone,
              onSaved: (value) {
                phone = value;
              },
              icon: Icons.phone,
              hintText: 'رقم التلفون',
              maxLength: 15,
              // suffixicon: IconButton(
              //   onPressed: () async {
              //     try {
              //       Contact contact = await _contactPicker.selectContact();
              //       setState(() {
              //         _contact = contact;
              //         controller.text = _contact.phoneNumber.number;
              //       });
              //     } catch (e) {}
              //   },
              //   icon: const Icon(Icons.add_circle),
              //   color: Colors.green,
              // ),
            ),
            PickDate(
              onsaved: (value) {
                brith = value;
              },
              hintText: "تاريخ الميلاد",
            ),
            PickDate(
              onsaved: (value) {
                dateA3TRAF = value;
              },
              hintText: "تاريخ اخر اعتراف",
            ),
            CustomTextField(
              onSaved: (value) {
                adress = value;
              },
              icon: Icons.home_work,
              hintText: 'العنوان',
            ),
            CustomTextField(
              onSaved: (value) {
                work = value;
              },
              icon: Icons.work,
              hintText: 'الوظيفة',
            ),
            CustomTextField(
              onSaved: (value) {
                row = value;
              },
              icon: Icons.book,
              hintText: 'قانون روحي',
            ),
            CustomTextField(
              onSaved: (value) {
                info = value;
              },
              icon: Icons.info,
              hintText: 'معلومات اضافية',
            ),
            BlocBuilder<AddPersonCubit, AddPersonState>(
              builder: (context, state) {
                return CustomAddBotton(
                  texet: 'اضافة المعترف',
                  isloading: state is AddPersonload ? true : false,
                  onTap: () {
                    if (formkey.currentState!.validate()) {
                      formkey.currentState!.save();

                      if (_image == null) {
                        photo = "";
                      } else {
                        photo = _image!.path;
                      }

                      var personmodel = PersonModel(
                        name: name!,
                        adress: adress!,
                        phone: phone!,
                        work: work!,
                        row: row!,
                        info: info!,
                        barthday: brith.toString(),
                        lastdate: dateA3TRAF.toString(),
                        photo: photo!,
                      );

                      BlocProvider.of<AddPersonCubit>(context)
                          .Addperson(personmodel);
                    } else {
                      autovalidateMode = AutovalidateMode.always;
                      setState(() {});
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
