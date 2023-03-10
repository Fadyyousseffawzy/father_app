import 'package:father_app/constance.dart';
import 'package:father_app/model/person_model.dart';
import 'package:father_app/widget/custom_app_bar.dart';
import 'package:father_app/widget/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import '../cubits/person_cubit/person_cubit.dart';
import '../widget/custom_person_item.dart';
import '../widget/list_view_item.dart';

class PersonView extends StatefulWidget {
  const PersonView({
    super.key,
  });

  @override
  State<PersonView> createState() => _PersonViewState();
}

class _PersonViewState extends State<PersonView> {
  late List<PersonModel> person =
      BlocProvider.of<PersonCubit>(context).person ?? [];

  List<PersonModel> _foundperson = [];
  TextEditingController _searchControlle = TextEditingController();
  @override
  initState() {
    person.sort((a, b) => a.name.compareTo(b.name));
    BlocProvider.of<PersonCubit>(context).fetchAllPerson();
    _foundperson = person;

    super.initState();
  }

  void runFilter(String quirrey) {
    List<PersonModel> person =
        BlocProvider.of<PersonCubit>(context).person ?? [];

    List<PersonModel> results = [];
    if (quirrey.isEmpty) {
      results = _foundperson;
    } else {
      results = person.where((person) {
        final nameLower = person.name.toLowerCase();
        final phoneLower = person.phone.toLowerCase();
        final searchLower = quirrey.toLowerCase();

        return nameLower.contains(searchLower) ||
            phoneLower.contains(searchLower);
      }).toList();
      setState(() {
        _foundperson = results;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonCubit, PersonState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Center(child: Text('القائمة'))),
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
                TextField(
                    controller: _searchControlle,
                    onChanged: (value) => runFilter(value),
                    decoration: const InputDecoration(
                      labelText: 'بحث بالاسم او التليفون',
                      suffixIcon: Icon(
                        Icons.search,
                      ),
                    )),
                BlocBuilder<PersonCubit, PersonState>(
                  builder: (context, state) {
                    return Expanded(
                      child: ListView.builder(
                          itemCount: _foundperson.length,
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: PersonItem(
                                  person: _foundperson[index],
                                  textdate: _foundperson[index].lastdate),
                            );
                          }),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
