import 'package:father_app/constance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/person_cubit/person_cubit.dart';
import '../model/person_model.dart';
import '../widget/custom_person_item.dart';

class AftatView extends StatefulWidget {
  const AftatView({super.key});

  @override
  State<AftatView> createState() => _AftatViewState();
}

class _AftatViewState extends State<AftatView> {
  late List<PersonModel> person =
      BlocProvider.of<PersonCubit>(context).person ?? [];

  List<PersonModel> _foundperson = [];
  final List<String> months = [
    "12",
    "9",
    "6",
    "3",
    "0",
  ];

  String selectedmonth = "12";

  void _onfilterselected(String filter) {
    setState(() {
      selectedmonth = filter;
      _filterlist();
    });
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

  void _onSearchTextChanged(String qurey) {
    setState(() {
      _foundperson = person.where((person) {
        if (person.lastdate != "") {
          final monthperson = fromE3traf(person.lastdate);

          return monthperson > int.parse(qurey) * 30;
        } else {
          const monthperson = "";
          return monthperson == qurey;
        }
      }).toList();
    });
  }

  void _filterlist() {
    _foundperson = person.where((person) {
      if (person.lastdate != "") {
        final monthperson = fromE3traf(person.lastdate);
        return monthperson > 360;
      } else {
        const monthperson = "x";
        return monthperson == "12";
      }
    }).toList();
  }

  @override
  initState() {
    person.sort((a, b) => a.name.compareTo(b.name));
    _filterlist();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonCubit, PersonState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(title: const Center(child: Text('الافتقاد'))),
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
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    const Text('لم يعترف من ', style: TextStyle(fontSize: 20)),
                    const SizedBox(
                      width: 30,
                    ),
                    Container(
                      width: 100,
                      decoration: BoxDecoration(
                        border: Border.all(width: 3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: DropdownButton<String>(
                          items: months.map((dropDownStringitem) {
                            return DropdownMenuItem<String>(
                              value: dropDownStringitem,
                              child: Text(dropDownStringitem),
                            );
                          }).toList(),
                          onChanged: (quirrey) {
                            _dropdwnselected(quirrey!);
                            _onSearchTextChanged(quirrey);
                          },
                          value: selectedmonth,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    const Text('شهر واكثر', style: TextStyle(fontSize: 20)),
                  ],
                ),
              ),
              BlocBuilder<PersonCubit, PersonState>(
                builder: (context, state) {
                  return Expanded(
                    child: ListView.builder(
                        itemCount: _foundperson.length,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 4),
                            child: PersonItem(
                              person: _foundperson[index],
                              textdate: _foundperson[index].lastdate,
                            ),
                          );
                        }),
                  );
                },
              ),
            ],
          ),
        ),
      );
    });
  }

  void _dropdwnselected(String quirrey) {
    setState(() {
      selectedmonth = quirrey;
    });
  }
}
