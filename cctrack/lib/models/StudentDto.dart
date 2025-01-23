class Student {
  final int tkmId;
  final int year;
  final String firstName;
  final String lastName;
  final String email;
  final String? rollNo;
  final int? actpts;

  Student({
    required this.tkmId,
    required this.year,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.rollNo,
    this.actpts,
  });

  // Convert JSON data to Student object
  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      tkmId: json['tkmId'],
      year: json['year'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      rollNo: json['rollNo'],
      actpts: json['actpts'],
    );
  }
}
