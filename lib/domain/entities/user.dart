class User {
  final String? firstName;
  final String? lastName;
  final String? email;
  final int? phoneNumber;
  final String? password1;
  final String? password2;
  final String? gender;
  final String? dateOfBirth;
  final bool? isPatient;

  User({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.password1,
    required this.password2,
    required this.gender,
    required this.dateOfBirth,
    this.isPatient = true,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      password1: json['password1'],
      password2: json['password2'],
      gender: json['gender'],
      dateOfBirth: json['date_of_birth'],
      isPatient: json['is_patient'],
    );
  }

  Map<String, dynamic> toJson() => {
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'phone_number': phoneNumber,
        'password1': password1,
        'password2': password2,
        'gender': gender,
        'date_of_birth': dateOfBirth,
        'is_patient': isPatient,
      };
}
