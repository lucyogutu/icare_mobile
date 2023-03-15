import 'package:flutter/material.dart';
import 'package:icare_mobile/application/api/api_services.dart';
import 'package:icare_mobile/application/core/colors.dart';
import 'package:icare_mobile/application/core/text_styles.dart';
import 'package:icare_mobile/domain/entities/appointment.dart';
import 'package:icare_mobile/domain/entities/doctor.dart';
import 'package:icare_mobile/domain/value_objects/app_strings.dart';
import 'package:icare_mobile/presentation/core/zero_list_state_widget.dart';
import 'package:icare_mobile/presentation/profile/widgets/history_item_widget.dart';

class PastAppointmentsPage extends StatefulWidget {
  const PastAppointmentsPage({super.key});

  @override
  State<PastAppointmentsPage> createState() => _PastAppointmentsPageState();
}

class _PastAppointmentsPageState extends State<PastAppointmentsPage> {
  Future<List<Appointment>>? _appointments;

  @override
  void initState() {
    super.initState();
    _appointments = getPastAppointments();
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                pastAppointmentsString,
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
                      text: 'No past appointments',
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
                          Doctor doctor = snapshot.data!;

                          return HistoryItemWidget(
                            date: appointment.date!,
                            time: DateTime.parse(
                                '${appointment.date!} ${appointment.startTime!}'),
                            doctorFirstName: doctor.firstName!,
                            doctorLastName: doctor.lastName!,
                            buttonText: reviewString,
                            clinic: doctor.clinic!,
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
