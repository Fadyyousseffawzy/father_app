import 'dart:io';
import 'package:age_calculator/age_calculator.dart';
import 'package:father_app/constance.dart';
import 'package:father_app/cubits/person_cubit/person_cubit.dart';
import 'package:father_app/model/person_model.dart';
import 'package:father_app/views/edid_view.dart';
import 'package:father_app/views/person_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:permission_handler/permission_handler.dart';

import '../widget/custom_tex_view.dart';
import '../widget/image_circle.dart';

class PersonalCardView extends StatefulWidget {
  PersonalCardView({super.key, required this.person});
  PersonModel person;

  @override
  State<PersonalCardView> createState() => _PersonalCardViewState();
}

class _PersonalCardViewState extends State<PersonalCardView> {
  String? lastdate;

  @override
  Widget build(BuildContext context) {
    return BlocListener<PersonCubit, PersonState>(
      listener: (context, state) {},
      child: BlocBuilder<PersonCubit, PersonState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Center(child: Text('بيانات المعترف')),
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
              child: ListView(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Container(
                        width: 150,
                        height: 150,
                        clipBehavior: Clip.antiAlias,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: widget.person.photo == ""
                            ? SizedBox(
                                height: 75,
                                child: Image.asset('images/profile_image.png'),
                              )
                            : CircleAvatar(
                                radius: 74,
                                child: ClipOval(
                                  child: Image.file(
                                    File(
                                      widget.person.photo,
                                    ),
                                    fit: BoxFit.cover,
                                    height: 150,
                                    width: 150,
                                  ),
                                ),
                              ),
                      ),
                    ),
                    Center(
                      child: Text(
                        widget.person.name,
                        style: const TextStyle(
                          fontSize: 28,
                          color: Color.fromARGB(255, 95, 2, 2),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        custom_texet_view(
                          title: 'تليفون',
                          subject: widget.person.phone,
                        ),
                        IconButton(
                          color: Colors.green[900],
                          iconSize: 30,
                          onPressed: () async {
                            final Uri phonewhats =
                                Uri.parse(widget.person.phone);
                            var whatsappUrl =
                                "whatsapp://send?phone=+2$phonewhats";
                            if (phonewhats != null) {
                              await launch(whatsappUrl);
                            } else
                              return;
                          },
                          icon: const Icon(Icons.whatsapp),
                        ),
                        IconButton(
                          color: Colors.black,
                          iconSize: 30,
                          onPressed: () async {
                            final Uri phone = Uri.parse(widget.person.phone);
                            var callphone = "tel://$phone";
                            if (phone != null) {
                              await launch(callphone);
                            } else
                              return;
                          },
                          icon: const Icon(Icons.call),
                        )
                      ],
                    ),
                    custom_texet_view(
                      title: 'تاريخ الميلاد',
                      subject: widget.person.barthday,
                    ),
                    custom_texet_view(
                      title: 'العمر',
                      color: Color.fromARGB(255, 5, 135, 242),
                      subject: fromDate(widget.person.barthday),
                    ),
                    custom_texet_view(
                      title: 'تاريخ اخر اعتراف',
                      subject: widget.person.lastdate,
                    ),
                    custom_texet_view(
                        title: "من",
                        color: Color.fromARGB(255, 245, 23, 8),
                        subject: fromDate(widget.person.lastdate)),
                    custom_texet_view(
                      title: 'العنوان',
                      subject: widget.person.adress,
                    ),
                    custom_texet_view(
                      title: 'معلومات اضافية',
                      subject: widget.person.info,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          style:
                              ElevatedButton.styleFrom(primary: Colors.green),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return EdidViewPerson(
                                  person: widget.person,
                                );
                              }),
                            );
                          },
                          child: const Text(
                            'تعديل',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(255, 76, 84, 175)),
                          onPressed: () async {
                            DateTime? pickeddate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1920),
                                lastDate: DateTime(2300));
                            if (pickeddate != null) {
                              lastdate =
                                  DateFormat('yyyy-MM-dd').format(pickeddate);
                              widget.person.lastdate =
                                  lastdate ?? widget.person.lastdate;
                              widget.person.save();
                              BlocProvider.of<PersonCubit>(context)
                                  .fetchAllPerson();
                            }
                          },
                          child: const Text(
                            'اضافة ميعاد اعتراف',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(255, 250, 26, 26)),
                          onPressed: () {
                            widget.person.delete();
                            Navigator.pop(context);

                            Navigator.pop(context);
                            BlocProvider.of<PersonCubit>(context)
                                .fetchAllPerson();
                          },
                          child: const Text(
                            'حزف',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    )
                  ]),
            ),
          );
        },
      ),
    );
  }

  String fromDate(String? _date) {
    try {
      if (_date != null) {
        DateTime start = DateTime.parse(_date);
        DateTime end = DateTime.now();
        DateTime s = DateTime(start.year, start.month, start.day);
        DateTime to = DateTime(end.year, end.month, end.day);
        var diff = AgeCalculator.age(start);
        //int diff = (end.difference(start).inDays / days).round();

        return '$diff ';
      } else {
        return "";
      }
    } catch (e) {
      return "";
    }
  }
}
