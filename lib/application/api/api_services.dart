import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:icare_mobile/application/api/endpoints.dart';
import 'package:icare_mobile/domain/entities/appointment.dart';
import 'package:icare_mobile/domain/entities/doctor.dart';
import 'package:icare_mobile/domain/entities/user.dart';

const FlutterSecureStorage storage = FlutterSecureStorage();

class APIService {
  // handle the api futures here

}

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
      }),
    );

    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return User.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception(response.body);
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}

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

      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}

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
      throw Exception(response.body);
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}

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
      throw Exception(response.body);
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}

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
      throw Exception(response.body);
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}

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
      throw Exception(response.body);
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}

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
      throw Exception(response.body);
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}

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
      throw Exception(response.body);
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}

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
      throw Exception(response.body);
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}

// TODO: Implement reschedule book appointment
Future<Appointment> _rescheduleAppointment(Appointment appointment) async {
  final authToken = await storage.read(key: 'access');
  Uri url = Uri.parse(APIEndpoints.baseUrl + APIEndpoints.rescheduleAppointment);
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
      throw Exception(response.body);
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}
