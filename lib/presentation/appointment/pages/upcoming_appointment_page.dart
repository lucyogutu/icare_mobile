import 'package:flutter/material.dart';
import 'package:icare_mobile/application/api/api_services.dart';
import 'package:icare_mobile/application/core/colors.dart';
import 'package:icare_mobile/application/core/text_styles.dart';
import 'package:icare_mobile/domain/entities/appointment.dart';
import 'package:icare_mobile/domain/entities/doctor.dart';
import 'package:icare_mobile/domain/value_objects/app_strings.dart';
import 'package:icare_mobile/presentation/appointment/widgets/appointment_list_item_widget.dart';
import 'package:icare_mobile/presentation/core/zero_list_state_widget.dart';

class UpcomingAppointmentsPage extends StatefulWidget {
  const UpcomingAppointmentsPage({super.key});

  @override
  State<UpcomingAppointmentsPage> createState() =>
      _UpcomingAppointmentsPageState();
}

class _UpcomingAppointmentsPageState extends State<UpcomingAppointmentsPage> {
  Future<List<Appointment>>? _appointments;
  // traverse list

  @override
  void initState() {
    super.initState();
    _appointments = getUpcomingAppointments();
  }

  Future<Doctor?> getDoctorById(int id) async {
    List<Doctor>? doctors = await getDoctors();
    return doctors.where((doctor) => doctor.id == id).first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                upcomingAppointmentsString,
                style: boldSize18Text(AppColors.primaryColor),
              ),
              FutureBuilder(
                future: _appointments,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.data!.isEmpty) {
                    return const ZeroListStateWidget(
                      text: 'No upcoming appointments',
                    );
                  }

                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext ctx, int index) {
                      var appointment = snapshot.data![index];

                      return FutureBuilder(
                        future: getDoctorById(appointment.doctor!),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          var doctor = snapshot.data!;
                          return AppointmentListItemWidget(
                            id: appointment.id!,
                            doctorId: appointment.doctor!,
                            doctorFirstName: doctor.firstName!,
                            doctorLastName: doctor.lastName!,
                            doctorProfession: doctor.specialization!,
                            date: DateTime.tryParse(appointment.date!)!,
                            startTime: DateTime.parse(
                                '${appointment.date!} ${appointment.startTime!}'),
                            endTime: DateTime.parse(
                                '${appointment.date!} ${appointment.endTime!}'),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
