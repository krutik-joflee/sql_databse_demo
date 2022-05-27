import 'package:flutter/material.dart';
import 'package:sql_databse_demo/dbhelper.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final dbhelper = DatabaseHelper.instance;

  void insertdata() async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnName: "krutik",
      DatabaseHelper.ColumnId: 20
    };
    final id = await dbhelper.insert(row);
    print(row);
  }

  void queryall() async {
    var allrows = await dbhelper.queryall();
    allrows.forEach((row) {
      print(row);
    });
  }

  void update() async {
    var row = dbhelper.update(20);
    print(row);
  }

  void delete() async {
    var row = dbhelper.delete(20);
    print(row);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Database"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: insertdata,
              child: Text("Insert"),
            ),
            ElevatedButton(onPressed: queryall, child: Text("Qurey All")),
            ElevatedButton(onPressed: update, child: Text("Update")),
            ElevatedButton(onPressed: delete, child: Text("Delete")),
          ],
        ),
      ),
    );
  }
}
