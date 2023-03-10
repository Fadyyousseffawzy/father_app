import 'package:father_app/constance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/person_cubit/person_cubit.dart';
import '../model/person_model.dart';
import '../widget/custom_person_item.dart';

class BithdayView extends StatefulWidget {
  const BithdayView({super.key});

  @override
  State<BithdayView> createState() => _BithdayViewState();
}

class _BithdayViewState extends State<BithdayView> {
  late List<PersonModel> person =
      BlocProvider.of<PersonCubit>(context).person ?? [];

  List<PersonModel> _foundperson = [];
  final List<String> months = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
    "11",
    "12"
  ];
  var currentMonth = DateTime.now().month.toString();
  // String selectedmonth = currentMonth;

  void _onfilterselected(String filter) {
    setState(() {
      currentMonth = filter;
      _filterlist();
    });
  }

  void _onSearchTextChanged(String qurey) {
    setState(() {
      _foundperson = person.where((person) {
        if (person.barthday != "") {
          final monthperson = DateTime.parse(person.barthday).month.toString();
          return monthperson == qurey;
        } else {
          const monthperson = "";
          return monthperson == qurey;
        }
      }).toList();
    });
  }

  void _filterlist() {
    _foundperson = person.where((person) {
      if (person.barthday != "") {
        final monthperson = DateTime.parse(person.barthday).month.toString();
        return monthperson == currentMonth;
      } else {
        const monthperson = "x";
        return monthperson == currentMonth;
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
        appBar: AppBar(title: const Center(child: Text('اعياد الميلاد '))),
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
                    const Text('الشهر', style: TextStyle(fontSize: 25)),
                    const SizedBox(
                      width: 40,
                    ),
                    Container(
                      width: 200,
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
                          value: currentMonth,
                        ),
                      ),
                    ),
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
                              textdate: _foundperson[index].barthday,
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
      currentMonth = quirrey;
    });
  }
}
