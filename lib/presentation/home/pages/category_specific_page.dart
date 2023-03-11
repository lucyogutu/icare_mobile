import 'package:flutter/material.dart';
import 'package:icare_mobile/application/api/api_services.dart';
import 'package:icare_mobile/application/core/colors.dart';
import 'package:icare_mobile/application/core/spaces.dart';
import 'package:icare_mobile/application/core/text_styles.dart';
import 'package:icare_mobile/domain/entities/doctor.dart';
import 'package:icare_mobile/presentation/core/icare_search_field.dart';
import 'package:icare_mobile/presentation/core/zero_state_widget.dart';
import 'package:icare_mobile/presentation/home/widgets/doctor_list_item_widget.dart';

class CategorySpecificPage extends StatefulWidget {
  const CategorySpecificPage({
    super.key,
    required this.id,
    required this.label,
  });

  final String id;
  final String label;

  @override
  State<CategorySpecificPage> createState() => _CategorySpecificPageState();
}

class _CategorySpecificPageState extends State<CategorySpecificPage> {
  Future<List<Doctor>>? _filteredDoctors;

  Future<List<Doctor>> _filter() async {
    Future<List<Doctor>>? doctors = getDoctors();
    List<Doctor> doctor = await doctors;
    List<Doctor> filteredDoctors = doctor.where((doctor) {
      return doctor.specialization!.contains(widget.label);
    }).toList();
    return filteredDoctors;
  }

  @override
  void initState() {
    super.initState();
    _filteredDoctors = _filter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.label,
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
            mediumVerticalSizedBox,
            FutureBuilder(
              future: _filteredDoctors,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.data!.isEmpty) {
                  return ZeroStateWidget(
                    text: 'No ${widget.label} doctors',
                    onPressed: () => Navigator.of(context).pop(),
                  );
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
