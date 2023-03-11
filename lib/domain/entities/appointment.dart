class Appointment {
  final int? id;
  final int? patient;
  final int? doctor;
  final String? date;
  final String? startTime;
  final String? endTime;

  Appointment({
    this.id,
    this.patient,
    required this.doctor,
    required this.date,
    required this.startTime,
    required this.endTime,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'],
      patient: json['patient'],
      doctor: json['doctor'],
      date: json['date'],
      startTime: json['start_time'],
      endTime: json['end_time'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'patient': patient,
        'doctor': doctor,
        'date': date,
        'start_time': startTime,
        'end_time': endTime,
      };
}
