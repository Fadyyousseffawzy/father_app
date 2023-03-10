import 'package:father_app/model/person_model.dart';
import 'package:father_app/widget/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/person_cubit/person_cubit.dart';
import 'custom_person_item.dart';

class listViewItem extends StatelessWidget {
  listViewItem({super.key});

  String query = 'query';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonCubit, PersonState>(
      builder: (context, state) {
        List<PersonModel> person =
            BlocProvider.of<PersonCubit>(context).person ?? [];

        void searchPerson(String query) {
          final _persons = person.where((person) {
            final titleLower = person.name.toLowerCase();
            final authorLower = person.phone.toLowerCase();
            final searchLower = query.toLowerCase();

            return titleLower.contains(searchLower) ||
                authorLower.contains(searchLower);
          }).toList();
        }

        Widget buildSearch() => SearchWidget(
              text: query,
              hintText: 'Name or Phone',
              onChanged: searchPerson,
            );

        return ListView.builder(
            itemCount: person.length,
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: PersonItem(
                  person: person[index],
                  textdate: person[index].lastdate,
                ),
              );
            });
      },
    );
  }
}
