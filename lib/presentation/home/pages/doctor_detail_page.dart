import 'package:flutter/material.dart';
import 'package:icare_mobile/application/api/api_services.dart';
import 'package:icare_mobile/application/core/colors.dart';
import 'package:icare_mobile/application/core/spaces.dart';
import 'package:icare_mobile/application/core/text_styles.dart';
import 'package:icare_mobile/domain/entities/doctor.dart';
import 'package:icare_mobile/domain/value_objects/app_strings.dart';
import 'package:icare_mobile/presentation/core/icare_elevated_button.dart';
import 'package:icare_mobile/application/core/routes.dart';
import 'package:icare_mobile/presentation/core/utils.dart';

class DoctorDetailPage extends StatefulWidget {
  const DoctorDetailPage({
    super.key,
    required this.id,
    required this.doctorFirstName,
    required this.doctorLastName,
    required this.doctorProfession,
    required this.doctorClinic,
  });

  final int id;
  final String doctorFirstName;
  final String doctorLastName;
  final String doctorProfession;
  final String doctorClinic;

  @override
  State<DoctorDetailPage> createState() => _DoctorDetailPageState();
}

class _DoctorDetailPageState extends State<DoctorDetailPage> {
  Future<Doctor>? _getDoctorById;

  @override
  void initState() {
    super.initState();
    _getDoctorById = getDoctor(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.doctorFirstName} ${widget.doctorLastName}',
          style: boldSize16Text(AppColors.blackColor),
        ),
        foregroundColor: AppColors.blackColor,
        backgroundColor: AppColors.whiteColor,
        shadowColor: AppColors.primaryColorLight,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: FutureBuilder(
              future: _getDoctorById,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  errorAlert(context);
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.width * 0.4,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                            border: Border.all(
                              color: AppColors.primaryColorLight,
                            ),
                            color: AppColors.primaryColorLight,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.person,
                                      color: AppColors.primaryColor,
                                      size: 25,
                                    ),
                                    mediumHorizontalSizedBox,
                                    Text(
                                      '${snapshot.data!.firstName} ${snapshot.data!.lastName}',
                                      style:
                                          boldSize20Text(AppColors.blackColor),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.mail,
                                      color: AppColors.primaryColor,
                                    ),
                                    mediumHorizontalSizedBox,
                                    Text(
                                      snapshot.data!.email!,
                                      style:
                                          boldSize18Text(AppColors.blackColor),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.phone,
                                      color: AppColors.primaryColor,
                                    ),
                                    mediumHorizontalSizedBox,
                                    Text(
                                      '0${snapshot.data!.phoneNumber!}',
                                      style:
                                          boldSize16Text(AppColors.blackColor),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        smallVerticalSizedBox,
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                            border: Border.all(
                              color: AppColors.primaryColorLight,
                            ),
                          ),
                          child: Column(
                            children: [
                              ListTile(
                                leading: CircleAvatar(
                                  backgroundColor:
                                      AppColors.primaryColor.withOpacity(0.25),
                                  radius: 20,
                                  child: const Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: FittedBox(
                                      child: Icon(
                                        Icons.work,
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                                title: Text(
                                  'Profession:  ${snapshot.data!.specialization!}',
                                  style: boldSize16Text(AppColors.blackColor),
                                ),
                              ),
                              ListTile(
                                leading: CircleAvatar(
                                  backgroundColor:
                                      AppColors.primaryColor.withOpacity(0.25),
                                  radius: 20,
                                  child: const Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: FittedBox(
                                      child: Icon(
                                        Icons.apartment,
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                                title: Text(
                                  'Clinic:  ${snapshot.data!.clinic!}',
                                  style: boldSize16Text(AppColors.blackColor),
                                ),
                              ),
                              ListTile(
                                leading: CircleAvatar(
                                  backgroundColor:
                                      AppColors.primaryColor.withOpacity(0.25),
                                  radius: 20,
                                  child: const Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: FittedBox(
                                      child: Icon(
                                        Icons.work_history,
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                                title: Text(
                                  'Years of Experience:   ${snapshot.data!.yearsOfExperience!}',
                                  style: boldSize16Text(AppColors.blackColor),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    smallVerticalSizedBox,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          aboutString,
                          style: heavySize18Text(AppColors.blackColor),
                        ),
                        verySmallVerticalSizedBox,
                        Text(
                          snapshot.data!.bio!,
                          style: normalSize14Text(AppColors.blackColor),
                        ),
                        mediumVerticalSizedBox,
                      ],
                    ),
                    mediumVerticalSizedBox,
                  ],
                );
              },
            ),
          ),
        ),
      ),
      floatingActionButton: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        height: 40,
        child: ICareElevatedButton(
          text: bookAppointmentString,
          onPressed: () => Navigator.of(context)
              .pushNamed(AppRoutes.bookAppointment, arguments: {
            'doctorId': widget.id,
            'doctorFirstName': widget.doctorFirstName,
            'doctorLastName': widget.doctorLastName,
          }),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
