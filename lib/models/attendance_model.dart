class Attendance {
  final DateTime date;
  final String uid;
  final String name;
  Attendance({
    required this.date,
    required this.uid,
    required this.name,
  });


  Attendance copyWith({
    DateTime? date,
    String? uid,
    String? name,
  }) {
    return Attendance(
      date: date ?? this.date,
      uid: uid ?? this.uid,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'date': date.millisecondsSinceEpoch,
      'uid': uid,
      'name': name,
    };
  }

  factory Attendance.fromMap(Map<String, dynamic> map) {
    return Attendance(
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      uid: map['uid'] as String,
      name: map['name'] as String,
    );
  }
}
