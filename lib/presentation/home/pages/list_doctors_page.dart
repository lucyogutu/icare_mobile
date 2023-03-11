import 'package:flutter/material.dart';
import 'package:icare_mobile/application/api/api_services.dart';
import 'package:icare_mobile/application/core/colors.dart';
import 'package:icare_mobile/application/core/spaces.dart';
import 'package:icare_mobile/application/core/text_styles.dart';
import 'package:icare_mobile/domain/entities/doctor.dart';
import 'package:icare_mobile/domain/value_objects/app_strings.dart';
import 'package:icare_mobile/presentation/core/icare_search_field.dart';
import 'package:icare_mobile/presentation/home/widgets/doctor_list_item_widget.dart';

class ListDoctorsPage extends StatefulWidget {
  const ListDoctorsPage({super.key});

  @override
  State<ListDoctorsPage> createState() => _ListDoctorsPageState();
}

class _ListDoctorsPageState extends State<ListDoctorsPage> {
  Future<List<Doctor>>? _doctors;

  @override
  void initState() {
    super.initState();
    _doctors = getDoctors();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          listOfDoctorsString,
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
          children: [
            smallHorizontalSizedBox,
            ICareSearchField(
              hintText: 'search',
              onSubmitted: (value) {},
            ),
            size15VerticalSizedBox,
            FutureBuilder(
              future: _doctors,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext ctx, int index) {
                    var doctor = snapshot.data![index];
                    return DoctorListItemWidget(
                      id: doctor.id!,
                      doctorFirstName: doctor.firstName!,
                      doctorLastName: doctor.lastName!,
                      doctorProfession: doctor.specialization!,
                      doctorClinic: doctor.clinic!,
                      // remove hard coding
                      rating: 5,
                      reviews: 500,
                    );
                  },
                );
              },
            ),
          ],
        ),
      )),
    );
  }
}
