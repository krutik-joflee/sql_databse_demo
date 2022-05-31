class EmployeeModel {
  final int id;
  final String mobileNumber;
  final String email;
  final String name;
  final String salary;

  EmployeeModel({
    required this.id,
    required this.mobileNumber,
    required this.email,
    required this.name,
    required this.salary,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "salary": salary,
      "mobileNumber": mobileNumber,
    };
  }
}
