class CertificateDTO {
  final String eventName;
  final String? category;
  final String? subCategory;
  final String? levelRole;
  final String certificateLink;
  final String duration;

  // Constructor to initialize all the properties
  CertificateDTO({
    required this.eventName,
    required this.category,
    required this.subCategory,
    required this.levelRole,
    required this.certificateLink,
    required this.duration,
  });

  // Optionally, you can create a method to convert the object to a map (for example, for API requests)
  Map<String, dynamic> toMap() {
    return {
      'eventName': eventName,
      'category': category,
      'subCategory': subCategory,
      'levelRole': levelRole,
      'certificateLink': certificateLink,
      'duration': duration,
    };
  }

  // You can also create a factory constructor to create an instance from a map (e.g., for parsing API responses)
  factory CertificateDTO.fromMap(Map<String, dynamic> map) {
    return CertificateDTO(
      eventName: map['eventName'] ?? '',
      category: map['category'] ?? '',
      subCategory: map['subCategory'] ?? '',
      levelRole: map['levelRole'] ?? '',
      certificateLink: map['certificateLink'] ?? '',
      duration: map['duration'] ?? '',
    );
  }
}
