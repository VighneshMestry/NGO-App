class UserModel {
  final String name;
  final String uid;
  final bool isStaff;
  final String profilePic;
  UserModel({
    required this.name,
    required this.uid,
    required this.isStaff,
    required this.profilePic,
  });


  UserModel copyWith({
    String? name,
    String? uid,
    bool? isStaff,
    String? profilePic,
  }) {
    return UserModel(
      name: name ?? this.name,
      uid: uid ?? this.uid,
      isStaff: isStaff ?? this.isStaff,
      profilePic: profilePic ?? this.profilePic,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'uid': uid,
      'isStaff': isStaff,
      'profilePic': profilePic,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String,
      uid: map['uid'] as String,
      isStaff: map['isStaff'] as bool,
      profilePic: map['profilePic'] as String,
    );
  }
}
