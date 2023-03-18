import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:icare_mobile/application/api/api_services.dart';
import 'package:icare_mobile/application/core/colors.dart';
import 'package:icare_mobile/application/core/spaces.dart';
import 'package:icare_mobile/application/core/text_styles.dart';
import 'package:icare_mobile/domain/value_objects/app_strings.dart';
import 'package:icare_mobile/domain/value_objects/svg_asset_strings.dart';
import 'package:icare_mobile/presentation/core/icare_elevated_button.dart';
import 'package:icare_mobile/application/core/routes.dart';
import 'package:icare_mobile/presentation/core/utils.dart';

class DoctorListItemWidget extends StatefulWidget {
  const DoctorListItemWidget({
    super.key,
    required this.id,
    required this.doctorFirstName,
    required this.doctorLastName,
    required this.doctorProfession,
    required this.doctorClinic,
    this.onIconPressed,
    required this.rating,
    required this.reviews,
    this.onButtonPressed,
  });
  final int id;
  final String doctorFirstName;
  final String doctorLastName;
  final String doctorProfession;
  final String doctorClinic;
  final int rating;
  final int reviews;
  final VoidCallback? onIconPressed;
  final VoidCallback? onButtonPressed;

  @override
  State<DoctorListItemWidget> createState() => _DoctorListItemWidgetState();
}

class _DoctorListItemWidgetState extends State<DoctorListItemWidget> {
  Future<int>? _getReviewsForDoctor;

  @override
  void initState() {
    super.initState();
    _getReviewsForDoctor = getDoctorReviews(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () => Navigator.of(context)
              .pushNamed(AppRoutes.doctorDetail, arguments: {
            'id': widget.id,
            'doctorFirstName': widget.doctorFirstName,
            'doctorLastName': widget.doctorLastName,
            'doctorProfession': widget.doctorProfession,
            'doctorClinic': widget.doctorClinic,
          }),
          splashColor: AppColors.primaryColor,
          child: Container(
            width: double.infinity,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(10.0),
              ),
              border: Border.all(
                color: AppColors.primaryColorLight,
              ),
            ),
            child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              return Row(
                children: [
                  Container(
                    height: constraints.maxHeight,
                    width: constraints.maxWidth * 0.3,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      color: AppColors.primaryColorLight,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FittedBox(
                        child: SvgPicture.asset(
                          userSvg,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: 8.0,
                      right: constraints.maxHeight * 0.05,
                      left: constraints.maxHeight * 0.05,
                    ),
                    child: SizedBox(
                      width: constraints.maxWidth * 0.65,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${widget.doctorFirstName} ${widget.doctorLastName}',
                                style: boldSize14Text(AppColors.blackColor),
                              ),
                              IconButton(
                                onPressed: widget.onIconPressed,
                                icon: const Icon(
                                  Icons.favorite_outline,
                                  color: AppColors.primaryColor,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            widget.doctorProfession,
                            style: boldSize12Text(AppColors.blackColor),
                          ),
                          verySmallVerticalSizedBox,
                          Text(
                            widget.doctorClinic,
                            style: normalSize12Text(AppColors.greyTextColor),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    size: 15.0,
                                    color: AppColors.primaryColor,
                                  ),
                                  verySmallHorizontalSizedBox,
                                  Text('${widget.rating}'),
                                ],
                              ),
                              FutureBuilder(
                                  future: _getReviewsForDoctor,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasError) {
                                      errorAlert(context);
                                    }
                                    return Text(
                                      '${snapshot.data} reviews',
                                      style: normalSize12Text(
                                          AppColors.greyTextColor),
                                    );
                                  }),
                              SizedBox(
                                height: 30,
                                width: 50,
                                child: ICareElevatedButton(
                                  text: bookString,
                                  textStyle:
                                      boldSize12Text(AppColors.whiteColor),
                                  onPressed: () {
                                    Navigator.of(context).pushNamed(
                                      AppRoutes.bookAppointment,
                                      arguments: {
                                        'doctorId': widget.id,
                                        'doctorFirstName':
                                            widget.doctorFirstName,
                                        'doctorLastName': widget.doctorLastName,
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
        smallVerticalSizedBox,
      ],
    );
  }
}
