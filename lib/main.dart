import 'package:flutter/material.dart';
import 'screen/edit/editdetail.dart';
import 'screen/details/fulldetails.dart';
import 'screen/home.dart';
import 'screen/details/shortdetails.dart';
import 'screen/search/searchstudent.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const SqliteApp());
}

class SqliteApp extends StatefulWidget {
  const SqliteApp({Key? key}) : super(key: key);

  @override
  _SqliteAppState createState() => _SqliteAppState();
}

class _SqliteAppState extends State<SqliteApp> {
  int? selectedId;
  final textController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue,
      primaryColor: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        '/shortDetails': (context) => const ShortDetails(),
        '/fullDetails': (context) => const FullDetails(),
        '/editDetails': (context) => const EditDetails(),
        '/searchStudents': (context) => const SearchStudent(),
      },
    );
  }
}