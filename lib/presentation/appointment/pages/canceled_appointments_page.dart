import 'package:flutter/material.dart';
import 'package:icare_mobile/application/api/api_services.dart';
import 'package:icare_mobile/application/core/colors.dart';
import 'package:icare_mobile/application/core/spaces.dart';
import 'package:icare_mobile/application/core/text_styles.dart';
import 'package:icare_mobile/domain/entities/appointment.dart';
import 'package:icare_mobile/domain/value_objects/app_strings.dart';
import 'package:icare_mobile/presentation/appointment/widgets/cancel_appointment_list_item.dart';
import 'package:icare_mobile/presentation/core/zero_state_widget.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                smallVerticalSizedBox,
                FutureBuilder(
                  future: _appointments,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.data!.isEmpty) {
                      return ZeroStateWidget(
                        text: 'No canceled appointments',
                        onPressed: () => Navigator.of(context).pop(),
                      );
                    }
      
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext ctx, int index) {
                        var appointment = snapshot.data![index];
      
                        return CancelAppointmentListItemWidget(
                          doctorId: appointment.doctor!,
                          doctorFirstName: '${appointment.doctor}',
                          doctorLastName: '${appointment.doctor}',
                          doctorProfession: '${appointment.doctor}',
                          date: DateTime.tryParse(appointment.date!)!,
                          startTime: DateTime.parse(
                              '${appointment.date!} ${appointment.startTime!}'),
                          endTime: DateTime.parse(
                              '${appointment.date!} ${appointment.endTime!}'),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
