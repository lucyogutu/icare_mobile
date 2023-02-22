import 'package:flutter/material.dart';
import 'package:icare_mobile/application/core/colors.dart';
import 'package:icare_mobile/application/core/spaces.dart';
import 'package:icare_mobile/application/core/text_styles.dart';
import 'package:icare_mobile/domain/entities/appointment.dart';
import 'package:icare_mobile/domain/value_objects/app_strings.dart';
import 'package:icare_mobile/presentation/appointment/widgets/cancel_appointment_list_item.dart';
import 'package:icare_mobile/presentation/core/zero_state_widget.dart';

class CancelAppointmentsPage extends StatelessWidget {
  const CancelAppointmentsPage({super.key});

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
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                upcomingAppointmentsString,
                style: boldSize18Text(AppColors.primaryColor),
              ),
              smallVerticalSizedBox,
              if (appointments.isNotEmpty) ...[
                ...appointments.map((appointment) {
                  return CancelAppointmentListItemWidget(
                    doctorName: appointment.doctor,
                    doctorProfession: appointment.profession,
                    date: appointment.date,
                  );
                }).toList(),
              ] else
                ZeroStateWidget(
                  text: 'No canceled appointments',
                  onPressed: () => Navigator.of(context).pop(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
