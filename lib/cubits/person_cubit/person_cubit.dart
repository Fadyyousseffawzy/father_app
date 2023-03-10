import 'package:bloc/bloc.dart';
import 'package:father_app/constance.dart';
import 'package:father_app/model/person_model.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

part 'person_state.dart';

class PersonCubit extends Cubit<PersonState> {
  PersonCubit() : super(PersonInitial());

  List<PersonModel>? person;
  fetchAllPerson() async {
    var PersonBox = Hive.box<PersonModel>(kPersonBox);
    person = PersonBox.values.toList();

    emit(Personsucess());
  }
}
