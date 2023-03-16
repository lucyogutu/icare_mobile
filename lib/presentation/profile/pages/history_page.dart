import 'package:flutter/material.dart';
import 'package:icare_mobile/application/api/api_services.dart';
import 'package:icare_mobile/application/core/colors.dart';
import 'package:icare_mobile/application/core/text_styles.dart';
import 'package:icare_mobile/domain/entities/appointment.dart';
import 'package:icare_mobile/domain/entities/doctor.dart';
import 'package:icare_mobile/domain/value_objects/app_strings.dart';
import 'package:icare_mobile/presentation/core/zero_list_state_widget.dart';
import 'package:icare_mobile/presentation/profile/widgets/history_item_widget.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
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
      appBar: AppBar(
        title: Text(
          historyString,
          style: boldSize16Text(AppColors.blackColor),
        ),
        foregroundColor: AppColors.blackColor,
        backgroundColor: AppColors.whiteColor,
        shadowColor: AppColors.primaryColor.withOpacity(0.25),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: FutureBuilder(
              future: _appointments,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.data!.isEmpty) {
                  return const ZeroListStateWidget(
                    text: 'No history',
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
          ),
        ),
      ),
    );
  }
}
