import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:icare_mobile/application/api/api_services.dart';
import 'package:icare_mobile/application/core/colors.dart';
import 'package:icare_mobile/application/core/spaces.dart';
import 'package:icare_mobile/application/core/text_styles.dart';
import 'package:icare_mobile/domain/entities/review.dart';
import 'package:icare_mobile/domain/value_objects/app_strings.dart';
import 'package:icare_mobile/presentation/core/icare_elevated_button.dart';
import 'package:icare_mobile/presentation/core/icare_text_button.dart';
import 'package:icare_mobile/presentation/core/utils.dart';
import 'package:intl/intl.dart';

class HistoryItemWidget extends StatefulWidget {
  const HistoryItemWidget({
    super.key,
    required this.date,
    required this.time,
    required this.doctorId,
    required this.doctorFirstName,
    required this.doctorLastName,
    required this.buttonText,
    required this.clinic,
  });

  final String date;
  final DateTime time;
  final int doctorId;
  final String doctorFirstName;
  final String doctorLastName;
  final String buttonText;
  final String clinic;

  @override
  State<HistoryItemWidget> createState() => _HistoryItemWidgetState();
}

class _HistoryItemWidgetState extends State<HistoryItemWidget> {
  double rating = 0;
  final TextEditingController _review = TextEditingController();
  Future<Review>? _reviewDoctor;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 120,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(15.0),
            ),
            color: AppColors.primaryColor.withOpacity(0.25),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      dateString,
                      style: heavySize16Text(AppColors.blackColor),
                    ),
                    Text(
                      timeString,
                      style: heavySize16Text(AppColors.blackColor),
                    ),
                    Text(
                      doctorString,
                      style: heavySize16Text(AppColors.blackColor),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.date,
                      style: normalSize16Text(AppColors.blackColor),
                    ),
                    Text(
                      DateFormat.jm().format(widget.time),
                      style: normalSize16Text(AppColors.blackColor),
                    ),
                    Text(
                      '${widget.doctorFirstName} ${widget.doctorLastName}',
                      style: normalSize16Text(AppColors.blackColor),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          clinicString,
                          style: heavySize16Text(AppColors.blackColor),
                        ),
                        verySmallVerticalSizedBox,
                        Text(
                          widget.clinic,
                          style: normalSize16Text(AppColors.blackColor),
                        ),
                      ],
                    ),
                    SizedBox(
                      child: ICareElevatedButton(
                        text: widget.buttonText,
                        onPressed: () {
                          showReviewBottomSheet(
                              context: context,
                              name:
                                  '${widget.doctorFirstName} ${widget.doctorLastName}',
                              Review: RatingBar.builder(
                                minRating: 1,
                                maxRating: 5,
                                itemSize: 20,
                                itemBuilder: (context, _) {
                                  return const Icon(
                                    Icons.star,
                                    color: AppColors.primaryColor,
                                  );
                                },
                                unratedColor: AppColors.hintTextColor,
                                updateOnDrag: true,
                                onRatingUpdate: (rating) {
                                  setState(() {
                                    this.rating = rating;
                                  });
                                },
                              ),
                              review: _review,
                              onPressed: () async {
                                Review reviews = Review(
                                  doctor: widget.doctorId,
                                  rating: rating.toString(),
                                  review: _review.text,
                                );
                                try {
                                  final review = await reviewDoctor(reviews);
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text('Success'),
                                          content: const Text('Review sent'),
                                          actions: [
                                            ICareTextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              text: 'OK',
                                              style: boldSize14Text(
                                                  AppColors.primaryColor),
                                            ),
                                          ],
                                        );
                                      });
                                  setState(() {
                                    _reviewDoctor = Future.value(review);
                                    _review.clear();
                                    Navigator.of(context).pop();
                                  });
                                } catch (error) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title:
                                            const Text('Something went wrong'),
                                        content: Text(error.toString()),
                                        actions: [
                                          ICareTextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            text: 'OK',
                                            style: boldSize14Text(
                                                AppColors.primaryColor),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              });
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        smallVerticalSizedBox,
      ],
    );
  }
}
