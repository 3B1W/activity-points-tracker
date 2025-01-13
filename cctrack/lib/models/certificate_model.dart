
class Certificate {
  final int id;
  final int tkmId;
  final String category;
  final String subCategory;
  final String levelRole;
  final String eventName;
  final String durationDate;
  final String proofCertificate;
  final String createdAt;
  final int pointsEarned;

  Certificate({
    required this.id,
    required this.tkmId,
    required this.category,
    required this.subCategory,
    required this.levelRole,
    required this.eventName,
    required this.durationDate,
    required this.proofCertificate,
    required this.createdAt,
    required this.pointsEarned
  });

  // Factory constructor to create a Certificate object from JSON
  factory Certificate.fromJson(Map<String, dynamic> json) {
    return Certificate(
      id: json['id'],
      tkmId: json['tkmId'],
      category: json['category'],
      subCategory: json['subCategory'],
      levelRole: json['levelRole'] ?? '', // Handle null values
      eventName: json['eventName'],
      durationDate: json['durationDate'],
      proofCertificate: json['proofCertificate'],
      createdAt: json['createdAt'],
      pointsEarned: json['pointsEarned']
    );
  }
}


