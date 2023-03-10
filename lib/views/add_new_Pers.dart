import 'package:father_app/constance.dart';
import 'package:father_app/cubits/person_cubit/person_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/add_cubit/add_person_cubit.dart';
import '../widget/new_person_body.dart';

class AddNewPersView extends StatelessWidget {
  const AddNewPersView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddPersonCubit(),
      child: BlocConsumer<AddPersonCubit, AddPersonState>(
        listener: (context, state) {
          if (state is AddPersonfailar) {
            print('failied ${state.errMessage}');
          }
          if (state is AddPersonsucess) {
            BlocProvider.of<PersonCubit>(context).fetchAllPerson();
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                title: const Center(child: Text('اضافة معترف جديد')),
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
                  child: const New_Person_Body()));
        },
      ),
    );
  }
}
