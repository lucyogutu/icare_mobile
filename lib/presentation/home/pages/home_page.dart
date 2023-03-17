import 'package:flutter/material.dart';
import 'package:icare_mobile/application/api/api_services.dart';
import 'package:icare_mobile/application/core/colors.dart';
import 'package:icare_mobile/application/core/text_styles.dart';
import 'package:icare_mobile/domain/entities/category.dart';
import 'package:icare_mobile/domain/entities/doctor.dart';
import 'package:icare_mobile/domain/entities/user.dart';
import 'package:icare_mobile/domain/value_objects/app_strings.dart';
import 'package:icare_mobile/domain/value_objects/svg_asset_strings.dart';
import 'package:icare_mobile/presentation/core/icare_text_button.dart';
import 'package:icare_mobile/application/core/routes.dart';
import 'package:icare_mobile/presentation/core/utils.dart';
import 'package:icare_mobile/presentation/core/zero_list_state_widget.dart';
import 'package:icare_mobile/presentation/home/widgets/carousel.dart';
import 'package:icare_mobile/presentation/home/widgets/category_widget.dart';
import 'package:icare_mobile/presentation/home/widgets/doctor_list_item_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<Doctor>>? _doctors;
  Future<User>? _getUser;

  @override
  void initState() {
    super.initState();
    _getUser = getProfile();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _doctors = getDoctors();
  }

  Future<dynamic> showSearchAppbar(BuildContext context) => showSearch(
        context: context,
        delegate: DoctorSearchDelegate(getDoctors()),
      );

  @override
  Widget build(BuildContext context) {
    List<Category> categories = [
      Category(
        id: physicianString,
        name: physicianString,
        svgPicture: handCareSvg,
      ),
      Category(
        id: dentistString,
        name: dentistString,
        svgPicture: toothSvg,
      ),
      Category(
        id: psychologistString,
        name: psychologistString,
        svgPicture: brainSvg,
      ),
      Category(
        id: pharmacistString,
        name: pharmacistString,
        svgPicture: firstAidKitSvg,
      ),
      Category(
        id: nurseString,
        name: nurseString,
        svgPicture: nurseSvg,
      ),
      Category(
        id: dermatologistString,
        name: dermatologistString,
        svgPicture: dermatologySvg,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: InkWell(
            onTap: () => Navigator.of(context).pushNamed(AppRoutes.profile),
            splashColor: AppColors.primaryColor,
            child: CircleAvatar(
              radius: 25,
              backgroundColor: AppColors.whiteColor,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: FutureBuilder(
                    future: _getUser,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.hasError) {
                        errorAlert(context);
                      }
                      String fullName =
                          "${snapshot.data?.firstName!} ${snapshot.data?.lastName!}";
                      String initials =
                          fullName.split(' ').map((word) => word[0]).join('');
                      return Text(
                        initials,
                        style: heavySize14Text(AppColors.primaryColor),
                      );
                    }),
              ),
            ),
          ),
        ),
        title: FutureBuilder(
            future: _getUser,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                errorAlert(context);
              }

              return Text(
                  "${snapshot.data?.firstName!} ${snapshot.data?.lastName!}");
            }),
        actions: [
          IconButton(
            onPressed: () {
              showSearchAppbar(context);
            },
            icon: const Icon(Icons.search_outlined),
          ),
          IconButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(AppRoutes.notifications),
            icon: const Icon(Icons.notifications_none_outlined),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 140,
                width: double.infinity,
                child: CarouselBanner(),
              ),
              Row(
                children: [
                  Text(
                    categoriesString,
                    style: heavySize14Text(
                      AppColors.blackColor,
                    ),
                  ),
                  const Spacer(),
                  ICareTextButton(
                    onPressed: () {},
                    text: scrollString,
                    style: boldSize12Text(AppColors.primaryColor),
                  ),
                ],
              ),
              SizedBox(
                height: 75,
                child: Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: [
                      ...categories.map((category) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 5.0),
                          child: CategoryWidget(
                            id: category.id,
                            label: category.name,
                            assetName: category.svgPicture,
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Text(
                    doctorString,
                    style: heavySize14Text(
                      AppColors.blackColor,
                    ),
                  ),
                  const Spacer(),
                  ICareTextButton(
                    onPressed: () =>
                        Navigator.of(context).pushNamed(AppRoutes.listDoctors),
                    text: viewAllString,
                    style: boldSize12Text(AppColors.primaryColor),
                  ),
                ],
              ),
              FutureBuilder(
                future: _doctors,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator();
                  }
                  if (snapshot.hasError) {
                    errorAlert(context);
                  }
                  if (snapshot.data!.isEmpty) {
                    return const ZeroListStateWidget(
                      text: 'No doctors available at the moment',
                    );
                  }
                  return Flexible(
                    child: ListView.builder(
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
                    ),
                  );
                },
              ),
            ],
          ),
        )),
      ),
    );
  }
}
