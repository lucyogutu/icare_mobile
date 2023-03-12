import 'dart:io';

class APIEndpoints {
  static String baseUrl = Platform.isAndroid ? 'http://192.168.188.104:8000/' :'http://127.0.0.1:8000/';

  //patients
  static const  String registerPatient = 'patients/register-patient/';
  static const  String loginPatient = 'patients/login-patient/';
  // logout not yet done
  static const  String logoutPatient = 'patients/logout-patient/';
  static const  String viewDoctors = 'patients/view-doctors/';
  static const  String viewSpecificDoctor = 'patients/view-doctor/';
  static const  String patientProfile = 'patients/profile-view/';
  static const  String editPatientProfile = 'patients/edit-profile-view/';
  static const  String viewAppointments = 'patients/view-appointments/';
  static const  String viewCanceledAppointments = 'patients/view-canceled-appointments/';
  // appointments
  static const  String bookAppointment = 'appointments/';
  static const  String rescheduleAppointment = 'appointments/reschedule-appointment/';
  static const  String cancelAppointment = 'appointments/cancel-appointment/';

}