import 'package:flutter/material.dart';
import 'package:icare_mobile/domain/entities/appointment.dart';
import 'package:icare_mobile/domain/value_objects/app_strings.dart';
import 'package:icare_mobile/presentation/appointment/widgets/appointment_list_item_widget.dart';
import 'package:icare_mobile/presentation/core/zero_state_widget.dart';

class UpcomingAppointmentsPage extends StatelessWidget {
  const UpcomingAppointmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Appointment> appointments = [
      Appointment(
        date: DateTime.now(),
        doctor: 'Dr. Yusuf',
        profession: physicianString,
      ),
      Appointment(
        date: DateTime.now(),
        doctor: 'Dr. Ramires',
        profession: nurseString,
      ),
      Appointment(
        date: DateTime.now(),
        doctor: 'Dr. Rodrigues',
        profession: dentistString,
      ),
      Appointment(
        date: DateTime.now(),
        doctor: 'Dr. Yusuf',
        profession: physicianString,
      ),
      Appointment(
        date: DateTime.now(),
        doctor: 'Dr. Ramires',
        profession: nurseString,
      ),
      Appointment(
        date: DateTime.now(),
        doctor: 'Dr. Rodrigues',
        profession: dentistString,
      ),
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (appointments.isNotEmpty) ...[
                ...appointments.map((appointment) {
                  return AppointmentListItemWidget(
                    doctorName: appointment.doctor,
                    doctorProfession: appointment.profession,
                    date: appointment.date,
                  );
                }).toList(),
              ] else
                ZeroStateWidget(
                  text: 'No scheduled appointments',
                  onPressed: () => Navigator.of(context).pop(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
