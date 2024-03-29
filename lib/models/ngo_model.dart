class NGO {
  final String ngoName;
  final String ngoId;
  final String activity;
  final String address;
  final String coordinator;
  final String description;
  final String contactUs;
  NGO({
    required this.ngoName,
    required this.ngoId,
    required this.activity,
    required this.address,
    required this.coordinator,
    required this.description,
    required this.contactUs,
  });

  NGO copyWith({
    String? ngoName,
    String? ngoId,
    String? activity,
    String? address,
    String? coordinator,
    String? description,
    String? contactUs,
  }) {
    return NGO(
      ngoName: ngoName ?? this.ngoName,
      ngoId: ngoId ?? this.ngoId,
      activity: activity ?? this.activity,
      address: address ?? this.address,
      coordinator: coordinator ?? this.coordinator,
      description: description ?? this.description,
      contactUs: contactUs ?? this.contactUs,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ngoName': ngoName,
      'ngoId': ngoId,
      'activity': activity,
      'address': address,
      'coordinator': coordinator,
      'description': description,
      'contactUs': contactUs,
    };
  }

  factory NGO.fromMap(Map<String, dynamic> map) {
    return NGO(
      ngoName: map['ngoName'] as String,
      ngoId: map['ngoId'] as String,
      activity: map['activity'] as String,
      address: map['address'] as String,
      coordinator: map['coordinator'] as String,
      description: map['description'] as String,
      contactUs: map['contactUs'] as String,
    );
  }
}
