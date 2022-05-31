// ignore_for_file: file_names, avoid_print, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sql_databse_demo/employee_model.dart';
import 'package:sql_databse_demo/form.dart';
import 'package:sql_databse_demo/my_dbhelper.dart';

// ignore: camel_case_types
class MyHomepage extends StatefulWidget {
  const MyHomepage({Key? key}) : super(key: key);

  @override
  State<MyHomepage> createState() => _MyHomepageState();
}

class _MyHomepageState extends State<MyHomepage> {
  final dbhelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SQLite"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Formpage()));
            },
            icon: Icon(
              Icons.add,
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.refresh),
        onPressed: () {
          setState(() {});
        },
      ),
      body: FutureBuilder(
        future: DatabaseHelper().getAllRecordFromDB(),
        builder: (BuildContext context,
            AsyncSnapshot<List<EmployeeModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: const CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: ListTile(
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Formpage(
                                                employeeModel:
                                                    snapshot.data?[index])));
                                  });
                                },
                                child: Icon(Icons.edit),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  dbhelper.delete(
                                    int.parse(
                                      snapshot.data?[index].id.toString() ?? '',
                                    ),
                                  );
                                });
                              },
                              child: Icon(Icons.delete),
                            ),
                          ],
                        ),
                        title: Text(
                          snapshot.data![index].name,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(snapshot.data![index].email),
                            Text(snapshot.data![index].mobileNumber),
                            Text(snapshot.data![index].salary),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          }
        },
      ),
    );
  }
}
