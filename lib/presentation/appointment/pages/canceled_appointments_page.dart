import 'package:flutter/material.dart';
import 'package:icare_mobile/application/api/api_services.dart';
import 'package:icare_mobile/application/core/colors.dart';
import 'package:icare_mobile/application/core/text_styles.dart';
import 'package:icare_mobile/domain/entities/appointment.dart';
import 'package:icare_mobile/domain/entities/doctor.dart';
import 'package:icare_mobile/domain/value_objects/app_strings.dart';
import 'package:icare_mobile/presentation/appointment/widgets/cancel_appointment_list_item.dart';
import 'package:icare_mobile/presentation/core/utils.dart';
import 'package:icare_mobile/presentation/core/zero_list_state_widget.dart';

class CancelAppointmentsPage extends StatefulWidget {
  const CancelAppointmentsPage({super.key});

  @override
  State<CancelAppointmentsPage> createState() => _CancelAppointmentsPageState();
}

class _CancelAppointmentsPageState extends State<CancelAppointmentsPage> {
  Future<List<Appointment>>? _appointments;

  @override
  void initState() {
    super.initState();
    _appointments = getCanceledAppointments();
  }

  Future<Doctor> getDoctorById(int? id) async {
    List<Doctor> doctors = await getDoctors();
    return doctors.where((doctor) => doctor.id == id).first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                canceledAppointmentsString,
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
                  if (snapshot.hasError) {
                    errorAlert(context);
                  }
                  if (snapshot.data!.isEmpty) {
                    return const ZeroListStateWidget(
                      text: 'No canceled appointments',
                    );
                  }

                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext ctx, int index) {
                      Appointment appointment = snapshot.data![index];

                      return FutureBuilder(
                        future: getDoctorById(appointment.doctor),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (snapshot.hasError) {
                            errorAlert(context);
                          }
                          Doctor doctor = snapshot.data!;

                          return CancelAppointmentListItemWidget(
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
