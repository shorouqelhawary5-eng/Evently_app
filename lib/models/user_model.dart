class UserModel {
  static UserModel? currentUser;
  List<String> favoriteEventId;
  String id;
  String name;
  String email;
  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.favoriteEventId,
  });
  UserModel.fromJson(Map<String, dynamic> json)
    : this(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        favoriteEventId:
            (json["favoriteEventId"] as List?)?.cast<String>() ?? [],
      );
  // UserModel.fromJson(Map<String, dynamic> json)
  //   : this(
  //       id: json["id"],
  //       name: json["name"],
  //       email: json["email"],
  //       favoriteEventId: (json["favoriteEventId"] as List<dynamic>)
  //           .cast<String>(),
  //     );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "favoriteEventId": favoriteEventId,
  };
}
