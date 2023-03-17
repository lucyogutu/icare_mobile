class Review {
  final int? id;
  final int? patient;
  final int? doctor;
  final String? rating;
  final String? review;

  Review({
    this.id,
    this.patient,
    required this.doctor,
    required this.rating,
    required this.review,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'],
      patient: json['patient'],
      doctor: json['hcw'],
      rating: json['rating'],
      review: json['review'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'patient': patient,
        'hcw': doctor,
        'rating': rating,
        'review': review,
      };
}
