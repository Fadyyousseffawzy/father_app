import 'dart:io';
import 'dart:math';

import 'package:father_app/model/person_model.dart';
import 'package:father_app/views/person_card_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../cubits/person_cubit/person_cubit.dart';
import 'image_circle.dart';

class PersonItem extends StatefulWidget {
  const PersonItem({
    Key? key,
    required this.person,
    required this.textdate,
  }) : super(key: key);

  final PersonModel person;
  final String textdate;

  @override
  State<PersonItem> createState() => _PersonItemState();
}

class _PersonItemState extends State<PersonItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return PersonalCardView(
              person: widget.person,
            );
          }),
        );
      },
      child: ListTile(
        leading: widget.person.photo == ""
            ? SizedBox(
                height: 30,
                child: Image.asset('images/profile_image.png'),
              )
            : CircleAvatar(
                radius: 30,
                child: ClipOval(
                  child: Image.file(
                    File(
                      widget.person.photo,
                    ),
                    fit: BoxFit.cover,
                    height: 60,
                    width: 60,
                  ),
                ),
              ),

        //  Custom_Image(
        //   Ridus: 29,

        //   ImagePath: 'images/profile_image.png',
        // ),
        trailing: CircleAvatar(
          backgroundColor: getcolor(),
          child: getIcon(),
        ),
        title: Text(
          widget.person.name,
          style: const TextStyle(fontSize: 20),
        ),
        subtitle: Text(widget.textdate),
      ),
    );
  }

  fromE3traf(String? _date) {
    try {
      if (_date != null) {
        DateTime start = DateTime.parse(_date);
        DateTime end = DateTime.now();
        // DateTime s = DateTime(start.year, start.month, start.day);
        // DateTime to = DateTime(end.year, end.month, end.day);
        int diff = (end.difference(start).inDays).round();

        return diff;
      } else {
        return "XXX";
      }
    } catch (e) {
      return "XXX";
    }
  }

  Color getcolor() {
    try {
      //final _date = DateTime.tryParse(person.lastdate);
      var days = fromE3traf(widget.person.lastdate);
      if (days == "XXX") {
        return Colors.amber;
      }
      if (days < 60) {
        return Colors.green;
      } else {
        return const Color.fromRGBO(236, 35, 21, 1);
      }
    } catch (e) {
      return const Color.fromRGBO(121, 21, 236, 1);
    }
    setState(() {});
  }

  Icon getIcon() {
    try {
      int days = fromE3traf(widget.person.lastdate);
      if (days == "XXX") {
        return const Icon(Icons.question_mark);
      }
      if (days < 60) {
        return const Icon(Icons.check);
      } else {
        return const Icon(Icons.close);
      }
    } catch (e) {
      return const Icon(Icons.question_mark);
    }
  }
}
