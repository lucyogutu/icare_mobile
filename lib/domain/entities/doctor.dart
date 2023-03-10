class Doctor {
  final String? firstName;
  final String? lastName;
  final String? email;
  final int? phoneNumber;
  final String? password1;
  final String? password2;
  final String? gender;
  final String? dateOfBirth;

  final String? bio;
  final String? specialization;
  final int? yearsOfExperience;
  final String? clinic;
  final String? address;

  Doctor({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.password1,
    required this.password2,
    required this.gender,
    required this.dateOfBirth,
    required this.bio,
    required this.specialization,
    required this.yearsOfExperience,
    required this.clinic,
    required this.address,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      password1: json['password1'],
      password2: json['password2'],
      gender: json['gender'],
      dateOfBirth: json['date_of_birth'],
      bio: json['bio'],
      specialization: json['specialization'],
      yearsOfExperience: json['years_of_experience'],
      clinic: json['clinic'],
      address: json['address'],
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
        'bio': bio,
        'specialization': specialization,
        'years_of_experience': yearsOfExperience,
        'clinic': clinic,
        'address': address,
      };
}
