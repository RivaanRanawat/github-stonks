import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.budget,
    required this.id,
    required this.email,
    required this.fullName,
  });

  int budget;
  String id;
  String email;
  String fullName;

  factory User.fromJson(Map<String, dynamic> json) => User(
        budget: json["budget"],
        id: json["_id"],
        email: json["email"],
        fullName: json["fullName"],
      );

  Map<String, dynamic> toJson() => {
        "budget": budget,
        "_id": id,
        "email": email,
        "fullName": fullName,
      };
}
