import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:icare_mobile/application/api/endpoints.dart';
import 'package:icare_mobile/domain/entities/appointment.dart';
import 'package:icare_mobile/domain/entities/doctor.dart';
import 'package:icare_mobile/domain/entities/review.dart';
import 'package:icare_mobile/domain/entities/user.dart';

const FlutterSecureStorage storage = FlutterSecureStorage();

class APIService {
  // handle the api futures here

}

// register patient to the application
Future<User> registerUser(User user) async {
  Uri url = Uri.parse(APIEndpoints.baseUrl + APIEndpoints.registerPatient);
  try {
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'first_name': user.firstName,
        'last_name': user.lastName,
        'email': user.email,
        'phone_number': user.phoneNumber,
        'password1': user.password1,
        'password2': user.password2,
        'gender': user.gender,
        'date_of_birth': user.dateOfBirth,
        'is_patient': user.isPatient,
      }),
    );

    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return User.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw jsonDecode(response.body)['message'];
    }
  } catch (e) {
    rethrow;
  }
}

// login patient to the application
Future<User> loginUser(User user) async {
  Uri url = Uri.parse(APIEndpoints.baseUrl + APIEndpoints.loginPatient);
  try {
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': user.email!,
        'password': user.password1!,
      }),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 CREATED response,
      // then parse the JSON.
      final authToken = jsonDecode(response.body)['tokens'];
      await storage.write(key: 'access', value: authToken['access']);
      await storage.write(key: 'refresh', value: authToken['refresh']);

      return User.fromJson(jsonDecode(response.body));
    } else {
      throw jsonDecode(response.body)['message'];
    }
  } catch (e) {
    rethrow;
  }
}

// logout patient out of the application
Future<User> logoutUser() async {
  final authToken = await storage.read(key: 'access');
  final refreshToken = await storage.read(key: 'refresh');

  Uri url = Uri.parse(APIEndpoints.baseUrl + APIEndpoints.logoutPatient);
  try {
    final response = await http.post(
      url,
      headers: <String, String>{
        'Authorization': 'Bearer $authToken',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'refresh': '$refreshToken',
      }),
    );

    if (response.statusCode == 205) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw jsonDecode(response.body)['message'];
    }
  } catch (e) {
    rethrow;
  }
}

// delete patient out of the application
Future<User> optoutUser() async {
  final authToken = await storage.read(key: 'access');

  Uri url = Uri.parse(APIEndpoints.baseUrl + APIEndpoints.optoutPatient);
  try {
    final response = await http.post(
      url,
      headers: <String, String>{
        'Authorization': 'Bearer $authToken',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 204) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw jsonDecode(response.body)['message'];
    }
  } catch (e) {
    rethrow;
  }
}

// get a list of doctors
Future<List<Doctor>> getDoctors() async {
  final authToken = await storage.read(key: 'access');
  Uri url = Uri.parse(APIEndpoints.baseUrl + APIEndpoints.viewDoctors);
  try {
    final response = await http.get(
      url,
      headers: <String, String>{
        'Authorization': 'Bearer $authToken',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      Iterable jsonList = json.decode(response.body);
      return List<Doctor>.from(jsonList.map((model) => Doctor.fromJson(model)));
    } else {
      throw jsonDecode(response.body)['message'];
    }
  } catch (e) {
    rethrow;
  }
}

// get a specific doctor
Future<Doctor> getDoctor(int id) async {
  final authToken = await storage.read(key: 'access');
  Uri url = Uri.parse(
      '${APIEndpoints.baseUrl}${APIEndpoints.viewSpecificDoctor}$id/');
  try {
    final response = await http.get(
      url,
      headers: <String, String>{
        'Authorization': 'Bearer $authToken',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return Doctor.fromJson(jsonDecode(response.body));
    } else {
      throw jsonDecode(response.body)['message'];
    }
  } catch (e) {
    rethrow;
  }
}

// get your profile details
Future<User> getProfile() async {
  final authToken = await storage.read(key: 'access');
  Uri url = Uri.parse(APIEndpoints.baseUrl + APIEndpoints.patientProfile);
  try {
    final response = await http.get(
      url,
      headers: <String, String>{
        'Authorization': 'Bearer $authToken',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw jsonDecode(response.body)['message'];
    }
  } catch (e) {
    rethrow;
  }
}

// edit your profile details
Future<User> editUserProfile(User user) async {
  final authToken = await storage.read(key: 'access');

  Uri url = Uri.parse(APIEndpoints.baseUrl + APIEndpoints.editPatientProfile);
  try {
    final response = await http.put(
      url,
      headers: <String, String>{
        'Authorization': 'Bearer $authToken',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'first_name': user.firstName,
        'last_name': user.lastName,
        'email': user.email,
        'phone_number': user.phoneNumber,
        'password': user.password1,
        'gender': user.gender,
        'date_of_birth': user.dateOfBirth,
      }),
    );

    if (response.statusCode == 201) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw jsonDecode(response.body)['message'];
    }
  } catch (e) {
    rethrow;
  }
}

// get a list of upcoming appointments
Future<List<Appointment>> getUpcomingAppointments() async {
  final authToken = await storage.read(key: 'access');
  Uri url = Uri.parse(APIEndpoints.baseUrl + APIEndpoints.viewAppointments);
  try {
    final response = await http.get(
      url,
      headers: <String, String>{
        'Authorization': 'Bearer $authToken',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      Iterable jsonList = json.decode(response.body);
      return List<Appointment>.from(
          jsonList.map((model) => Appointment.fromJson(model)));
    } else {
      throw jsonDecode(response.body)['message'];
    }
  } catch (e) {
    rethrow;
  }
}

// get a list of canceled appointments
Future<List<Appointment>> getCanceledAppointments() async {
  final authToken = await storage.read(key: 'access');
  Uri url =
      Uri.parse(APIEndpoints.baseUrl + APIEndpoints.viewCanceledAppointments);
  try {
    final response = await http.get(
      url,
      headers: <String, String>{
        'Authorization': 'Bearer $authToken',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      Iterable jsonList = json.decode(response.body);
      return List<Appointment>.from(
          jsonList.map((model) => Appointment.fromJson(model)));
    } else {
      throw jsonDecode(response.body)['message'];
    }
  } catch (e) {
    rethrow;
  }
}

// get a list of past appointments
Future<List<Appointment>> getPastAppointments() async {
  final authToken = await storage.read(key: 'access');
  Uri url = Uri.parse(APIEndpoints.baseUrl + APIEndpoints.viewPastAppointments);
  try {
    final response = await http.get(
      url,
      headers: <String, String>{
        'Authorization': 'Bearer $authToken',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      Iterable jsonList = json.decode(response.body);
      return List<Appointment>.from(
          jsonList.map((model) => Appointment.fromJson(model)));
    } else {
      throw jsonDecode(response.body)['message'];
    }
  } catch (e) {
    rethrow;
  }
}

// book an appointment
Future<Appointment> bookAppointment(Appointment appointment) async {
  final authToken = await storage.read(key: 'access');
  Uri url = Uri.parse(APIEndpoints.baseUrl + APIEndpoints.bookAppointment);
  try {
    final response = await http.post(
      url,
      headers: <String, String>{
        'Authorization': 'Bearer $authToken',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'doctor': appointment.doctor,
        'date': appointment.date,
        'start_time': appointment.startTime,
        'end_time': appointment.endTime,
      }),
    );

    if (response.statusCode == 201) {
      return Appointment.fromJson(jsonDecode(response.body));
    } else {
      throw jsonDecode(response.body)['message'];
    }
  } catch (e) {
    rethrow;
  }
}

// TODO:Implement reschedule book appointment not working
// reschedule an appointment
Future<Appointment> rescheduleAppointment(
    Appointment appointment, int id) async {
  final authToken = await storage.read(key: 'access');
  Uri url = Uri.parse(
      '${APIEndpoints.baseUrl}${APIEndpoints.rescheduleAppointment}$id/');
  try {
    final response = await http.put(
      url,
      headers: <String, String>{
        'Authorization': 'Bearer $authToken',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'doctor': appointment.doctor,
        'date': appointment.date,
        'start_time': appointment.startTime,
        'end_time': appointment.endTime,
      }),
    );

    if (response.statusCode == 201) {
      return Appointment.fromJson(jsonDecode(response.body));
    } else {
      throw jsonDecode(response.body)['message'];
    }
  } catch (e) {
    rethrow;
  }
}

// cancel an appointment
Future<Appointment> cancelAppointment(int id) async {
  final authToken = await storage.read(key: 'access');
  Uri url =
      Uri.parse('${APIEndpoints.baseUrl}${APIEndpoints.cancelAppointment}$id/');
  try {
    final response = await http.post(
      url,
      headers: <String, String>{
        'Authorization': 'Bearer $authToken',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return Appointment.fromJson(jsonDecode(response.body));
    } else {
      throw jsonDecode(response.body)['message'];
    }
  } catch (e) {
    rethrow;
  }
}

// review doctor
Future<Review> reviewDoctor(Review review) async {
  final authToken = await storage.read(key: 'access');
  Uri url = Uri.parse(APIEndpoints.baseUrl + APIEndpoints.reviewDoctor);
  try {
    final response = await http.post(
      url,
      headers: <String, String>{
        'Authorization': 'Bearer $authToken',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'hcw': review.doctor,
        'rating': review.rating,
        'review': review.review,
      }),
    );

    if (response.statusCode == 201) {
      return Review.fromJson(jsonDecode(response.body));
    } else {
      throw jsonDecode(response.body)['message'];
    }
  } catch (e) {
    rethrow;
  }
}

Future<int> getDoctorReviews(int id) async {
  final authToken = await storage.read(key: 'access');
  Uri url = Uri.parse(
      '${APIEndpoints.baseUrl}${APIEndpoints.listReviewForDoctor}$id/');
  try {
    final response = await http.get(
      url,
      headers: <String, String>{
        'Authorization': 'Bearer $authToken',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['num_reviews'];
    } else {
      throw jsonDecode(response.body)['message'];
    }
  } catch (e) {
    rethrow;
  }
}
