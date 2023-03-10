import 'package:bloc/bloc.dart';
import 'package:father_app/constance.dart';
import 'package:father_app/model/person_model.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

part 'add_person_state.dart';

class AddPersonCubit extends Cubit<AddPersonState> {
  AddPersonCubit() : super(AddPersonInitial());

  Addperson(PersonModel person) async {
    emit(AddPersonload());
    try {
      var pesonBox = Hive.box<PersonModel>(kPersonBox);
      await pesonBox.add(person);

      emit(AddPersonsucess());
    } catch (e) {
      emit(AddPersonfailar(e.toString()));
    }
  }
}
