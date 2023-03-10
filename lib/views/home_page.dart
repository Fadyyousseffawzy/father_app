import 'dart:convert';
import 'dart:io';
import 'package:father_app/views/aftqad.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:father_app/constance.dart';
import 'package:father_app/model/person_model.dart';
import 'package:father_app/views/add_new_Pers.dart';
import 'package:father_app/views/person_view.dart';
import 'package:father_app/views/viewbirthday.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import '../cubits/person_cubit/person_cubit.dart';
import '../widget/customtexetwithphoto.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void initState() {
    BlocProvider.of<PersonCubit>(context).fetchAllPerson();
    super.initState();
  }

  Future<void> initHive() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    final hivePath = appDocumentDir.path + '/hive_database';
    Hive.init(hivePath);
    final databaseFile = File(hivePath);
    await Share.share(databaseFile.path);
    debugPrint(hivePath);
  }

// Import a Hive database from a backup file
  Future<void> importDatabaseFromBackupFile() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String databasePath = appDocDir.path;
// Read the backup file and overwrite the current Hive box
    File backupFile = File('$databasePath/my_database.hive.bak');
    List<int> bytes = await backupFile.readAsBytes();
    await Hive.box(kPersonBox).clear();
    // await Hive.box(kPersonBox).addAll(await Hive.box(kPersonBox).fromBytes(bytes));
  }

  Future<Box<dynamic>> createNewBox() async {
    final newBox = await Hive.openBox('imported_data');

    return newBox;
  }

  Future<List<int>> readDataFromFile() async {
    final file = File('path/to/local/file');
    final fileData = await file.readAsBytes();

    return fileData;
  }
// Future<void> importData(Box<dynamic> box, List<int> data) async {
//   final importedData = Hive.decodeData(data);
//   for (var record in importedData) {
//     box.put(record.key, record.value);
//   }
// }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('سجل المعترفين')),
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
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  customtexetwithphoto(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return const AddNewPersView();
                          }),
                        );
                      },
                      text: 'معترف جديد',
                      hieghtSize: 150,
                      imagepath: 'images/newmoaterf.png'),
                  customtexetwithphoto(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return const PersonView();
                          }),
                        );
                      },
                      text: 'القائمة',
                      hieghtSize: 120,
                      imagepath: 'images/AlSqel1.png'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  customtexetwithphoto(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return const BithdayView();
                          }),
                        );
                      },
                      text: 'اعياد ميلاد',
                      hieghtSize: 110,
                      imagepath: 'images/birthday1.png'),
                  customtexetwithphoto(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return const AftatView();
                            //const AftatView();
                          }),
                        );
                      },
                      text: "افتقاد",
                      hieghtSize: 130,
                      imagepath: 'images/aftqad.png'),
                ],
              ),
              customtexetwithphoto(
                  hieghtSize: 100,
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 200),
                              child: AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                contentPadding: const EdgeInsets.all(10),
                                title: const Text("قاعدة البيانات"),
                                content: Column(children: [
                                  SizedBox(
                                    width: 200,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      onPressed: () {
                                        //exportDatabase();
                                        //backupHiveBox();
                                        //initHive();
                                        createBackup();
                                      },
                                      child: const Text("ارسال قاعدة البيانات"),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 200,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      onPressed: () {},
                                      child:
                                          const Text("استرجاع قاعدة البيانات"),
                                    ),
                                  ),
                                ]),
                              ),
                            ),
                          );
                        });
                  },
                  text: 'قاعدة البيانات',
                  imagepath: 'images/download.png'),
              const SizedBox(
                height: 5,
              ),
              const Text('  اذكرني في صلوات قدسك '),
              const Text(
                '@فادي يوسف ',
                style: TextStyle(fontSize: 10),
              ),
            ],
          ),
        ));
  }

  Future<void> createBackup() async {
    if (Hive.box<PersonModel>(kPersonBox).isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('لا يوجد سجل.')),
      );
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Creating backup...')),
    );
// String jsonString=//
// Map<String,dynamic>map = jsonEncode

    Hive.box(kPersonBox).close();
    Map<String, dynamic> map = Hive.box(kPersonBox)
        .toMap()
        .map((key, value) => MapEntry(key.toString(), value));
    String json = jsonEncode(map);
    await Permission.storage.request();
    Directory dir = await _getDirectory();

    String formattedDate = DateTime.now()
        .toString()
        .replaceAll('.', '-')
        .replaceAll(' ', '-')
        .replaceAll(':', '-');
    String path =
        '${dir.path}$formattedDate.json'; //Change .json to your desired file format(like .barbackup or .hive).
    File backupFile = File(path);
    debugPrint('===============databasePath $backupFile.path');
    await Share.share(backupFile.path);

    await backupFile.writeAsString(json);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Backup saved in folder Barcodes')),
    );
  }

  Future<Directory> _getDirectory() async {
    const String pathExt =
        'Barcodes/'; //This is the name of the folder where the backup is stored
    Directory newDirectory = Directory('/storage/emulated/0/' +
        pathExt); //Change this to any desired location where the folder will be created
    if (await newDirectory.exists() == false) {
      debugPrint('===============databasePath $newDirectory');
      return newDirectory.create(recursive: true);
    }

    return newDirectory;
  }

  getDbPath() async {
    final box = await Hive.openBox(kPersonBox);
    final String path = box.path.toString();
    //print('===============databasePath $databasePath');
  }
}
