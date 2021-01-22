import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Hive Testing'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Box box;

  @override
  void initState() {
    // init state implementation
    super.initState();
    openBox();
  }

  void openBox() async {
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    box = await Hive.openBox('testBox');
    return;
  }

  void putData() {
    // key / pair
    // box.put('name', 'Nicolas');
    // box.put('name1', 'Tom');
    box.add('value');
  }

  void getAll() {
    print(box.toMap());
  }

  void getData() {
    // print(box.get('name'));
    print(box.getAt(1));
  }

  void updateData() {
    // box.put('name', 'Jessica');
    box.put(0, 'Jessica');
  }

  void deleteData() {
    // box.delete('name');
    box.delete(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
                child: Align(
              alignment: Alignment.center,
              child: Text("Output"),
            )),
            RaisedButton(onPressed: putData, child: Text("Put Data")),
            RaisedButton(onPressed: getData, child: Text("Get Data")),
            RaisedButton(onPressed: getAll, child: Text("Get All")),
            RaisedButton(onPressed: updateData, child: Text("Update Data")),
            RaisedButton(onPressed: deleteData, child: Text("Delete Data")),
          ],
        ),
      ),
    );
  }
}
