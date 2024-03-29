class UserModel {
  final String name;
  final String uid;
  final bool isNgo;
  final String profilePic;
  UserModel({
    required this.name,
    required this.uid,
    required this.isNgo,
    required this.profilePic,
  });


  UserModel copyWith({
    String? name,
    String? uid,
    bool? isNgo,
    String? profilePic,
  }) {
    return UserModel(
      name: name ?? this.name,
      uid: uid ?? this.uid,
      isNgo: isNgo ?? this.isNgo,
      profilePic: profilePic ?? this.profilePic,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'uid': uid,
      'isNgo': isNgo,
      'profilePic': profilePic,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String,
      uid: map['uid'] as String,
      isNgo: map['isNgo'] as bool,
      profilePic: map['profilePic'] as String,
    );
  }
}
