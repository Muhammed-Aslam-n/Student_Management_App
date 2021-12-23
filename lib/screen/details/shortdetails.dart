import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todofromnet/db/database.dart';
import '../../db/databasehandler.dart';
import 'fulldetails.dart';
import '../home.dart';

class ShortDetails extends StatefulWidget {
  const ShortDetails({Key? key}) : super(key: key);

  @override
  _ShortDetailsState createState() => _ShortDetailsState();
}

class _ShortDetailsState extends State<ShortDetails> {
  int? selectedId;
  final textController = TextEditingController();

  @override
  void initState() {
    DatabaseHelper.instance.reset();
    debugPrint("reloaded");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => Home()));
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: Image.asset('images/AppbarICon.png'),
          centerTitle: true,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: const [
              Text(
                'DreamSchool',
                style: TextStyle(
                    fontFamily: 'DancingScript',
                    fontWeight: FontWeight.w600,
                    fontSize: 26),
              ),
              Text(
                'Where Wishes Comes True',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 8,
                ),
              ),
            ],
          ),
        ),
        endDrawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: const [
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      image: DecorationImage(
                          image: AssetImage("images/student/s4.jfif"),
                          fit: BoxFit.cover),
                    ),
                    child: Text(''),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text("Muhammed Aslam n",style: TextStyle(fontSize: 22),),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text("Ass.Prof Computer Science",style: TextStyle(fontSize: 14),),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              const Text("Utilities",textAlign: TextAlign.center,style: TextStyle(fontSize: 15,color: Colors.blueAccent,letterSpacing: 2),),
              const Divider(
                color: Colors.blueAccent,thickness: 1.3,
              ),
              ListTile(
                title: Row(
                  children: const [
                    Icon(Icons.wysiwyg_outlined),
                    SizedBox(
                      width: 20,
                    ),
                    Text("View Students"),
                  ],
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/shortDetails');
                },
              ),
              ListTile(
                title: Row(
                  children: const [
                    Icon(Icons.search_outlined),
                    SizedBox(
                      width: 20,
                    ),
                    Text("Search Students"),
                  ],
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/searchStudents');
                },
              ),
              ListTile(
                title: Row(
                  children: const [
                    Icon(Icons.add),
                    SizedBox(
                      width: 20,
                    ),
                    Text("Add Students"),
                  ],
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/editDetails');
                },
              ),
            ],
          ),
        ),
        body: Center(
          child: FutureBuilder<List<Grocery>>(
            future: DatabaseHelper.instance.getGroceries(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Grocery>> snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: Text('Loading...'));
              }
              return snapshot.data!.isEmpty
                  ? const Center(child: Text('No Students Added yet.'))
                  : ListView(
                      children: snapshot.data!.map(
                        (grocery) {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(8,16,8,8),
                              child: Card(
                                color: selectedId == grocery.id
                                    ? Colors.white70
                                    : Colors.white,
                                child: ListTile(
                                  subtitle: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Roll Num : ${grocery.rollnum}",style: const TextStyle(fontSize: 13,color: Colors.blueAccent)),
                                  ),
                                  title: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(grocery.name,style: const TextStyle(fontSize: 20,color: Colors.redAccent)),
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      DatabaseHelper.instance.idd = ((grocery.id)!);
                                       Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const FullDetails()));
                                    });
                                  },
                                  onLongPress: () {
                                    setState(
                                      () {
                                        showDialog<String>(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (BuildContext context) => AlertDialog(
                                            title: const Text('Delete'),
                                            content: const Text('Are you Sure you want to Remove this Student ?'),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () => Navigator.pop(context, 'Cancel'),
                                                child: const Text('Cancel'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  setState(() {
                                                    DatabaseHelper.instance
                                                        .remove(grocery.id!);
                                                    Navigator.pop(context, 'Cancel');
                                                  });
                                                },
                                                child: const Text('OK'),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      ).toList(),
                    );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () async {
            Navigator.pushNamed(context, '/editDetails');
          },
        ),
      ),
    );
  }
}
