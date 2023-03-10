import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:icare_mobile/application/api/enpoints.dart';
import 'package:icare_mobile/domain/entities/user.dart';

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
