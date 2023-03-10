import 'package:father_app/constance.dart';
import 'package:father_app/cubits/person_cubit/person_cubit.dart';
import 'package:father_app/model/person_model.dart';
import 'package:father_app/simple_bloc_observer.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'views/home_page.dart';

void main() async {
  await Hive.initFlutter();
  Bloc.observer = SimpleBlocObeserver();
  Hive.registerAdapter(PersonModelAdapter());
  await Hive.openBox<PersonModel>(kPersonBox);

  runApp(BlocProvider(
    create: (context) => PersonCubit(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('ar', 'AE'),
        ],
        home: HomePage());
  }
}
