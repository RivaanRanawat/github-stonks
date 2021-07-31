import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.budget,
    required this.id,
    required this.email,
    required this.fullName,
    required this.token
  });

  int budget;
  String id;
  String email;
  String fullName;
  String token;

  factory User.fromJson(Map<String, dynamic> json) => User(
        budget: json["user"]["budget"],
        id: json["user"]["_id"],
        email: json["user"]["email"],
        fullName: json["user"]["fullName"],
        token: json["token"]
      );

  Map<String, dynamic> toJson() => {
        "budget": budget,
        "_id": id,
        "email": email,
        "fullName": fullName,
      };
}
