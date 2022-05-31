// ignore_for_file: prefer_const_constructors, unused_local_variable, avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:sql_databse_demo/employee_model.dart';

import 'my_dbhelper.dart';

class Formpage extends StatefulWidget {
  const Formpage({Key? key, this.employeeModel}) : super(key: key);

  final EmployeeModel? employeeModel;

  @override
  State<Formpage> createState() => _FormpageState();
}

class _FormpageState extends State<Formpage> {
  final dbhelper = DatabaseHelper();

  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController salaryController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    if (widget.employeeModel != null) {
      emailController.text = widget.employeeModel?.email ?? '';
      nameController.text = widget.employeeModel?.name ?? '';
      numberController.text = widget.employeeModel?.mobileNumber ?? '';
      salaryController.text = widget.employeeModel?.salary ?? '';
    } else {
      emailController.text = '';
      nameController.text = '';
      numberController.text = '';
      salaryController.text = '';
    }
    super.initState();
  }

  Future<void> insertdata({
    required String name,
    required String email,
    required String salary,
    required String mobilenumber,
  }) async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnMobilenumber: mobilenumber,
      DatabaseHelper.columnEmail: email,
      DatabaseHelper.ColumnName: name,
      DatabaseHelper.ColumnSalary: salary,
    };
    final id = await dbhelper.insert(row);
    print(row);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.employeeModel != null ? "Update Employee" : "Add Employee",
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: "Enter the name",
                    labelText: "Name",
                  ),
                ),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: "Enter the email",
                    labelText: "Email",
                  ),
                ),
                TextFormField(
                  controller: salaryController,
                  decoration: InputDecoration(
                    hintText: "Enter the salary",
                    labelText: "Salary",
                  ),
                ),
                TextFormField(
                  controller: numberController,
                  decoration: InputDecoration(
                    hintText: "Enter the mobile number",
                    labelText: "Mobile number",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                      child: const Text("submit"),
                      onPressed: () {
                        if (widget.employeeModel != null) {
                          dbhelper.update(EmployeeModel(
                            id: widget.employeeModel?.id ?? 0,
                            mobileNumber: numberController.text,
                            email: emailController.text,
                            name: nameController.text,
                            salary: salaryController.text,
                          ));
                        } else {
                          insertdata(
                            email: emailController.text,
                            mobilenumber: numberController.text,
                            name: nameController.text,
                            salary: salaryController.text,
                          );
                        }
                        Navigator.pop(context);
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
