import 'package:flutter/material.dart';
import 'package:icare_mobile/application/core/colors.dart';
import 'package:icare_mobile/application/core/spaces.dart';
import 'package:icare_mobile/application/core/text_styles.dart';
import 'package:icare_mobile/domain/value_objects/app_strings.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    // List<Appointment> appointments = [
    //   Appointment(
    //     date: DateTime.now(),
    //     doctor: 'Dr. Yusuf',
    //     profession: physicianString,
    //   ),
    //   Appointment(
    //     date: DateTime.now(),
    //     doctor: 'Dr. Ramires',
    //     profession: nurseString,
    //   ),
    // ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          notificationString,
          style: boldSize16Text(AppColors.blackColor),
        ),
        foregroundColor: AppColors.blackColor,
        backgroundColor: AppColors.whiteColor,
        shadowColor: AppColors.primaryColorLight,
      ),
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
              // ...appointments.map((appointment) {
              //   return AppointmentListItemWidget(
              //     doctorName: appointment.doctor,
              //     doctorProfession: appointment.profession,
              //     date: appointment.date,
              //   );
              // }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
