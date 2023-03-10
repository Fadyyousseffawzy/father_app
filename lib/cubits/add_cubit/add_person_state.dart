part of 'add_person_cubit.dart';

@immutable
abstract class AddPersonState {}

class AddPersonInitial extends AddPersonState {}

class AddPersonload extends AddPersonState {}

class AddPersonsucess extends AddPersonState {}

class AddPersonfailar extends AddPersonState {
  final String errMessage;
  AddPersonfailar(this.errMessage);
}
