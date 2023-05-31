import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@immutable
class User {
  final String name;
  final int age;

  const User({required this.name, required this.age});

  User copyWith({String? name, int? age}) {
    return User(name: name ?? this.name, age: age ?? this.age);
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json["name"],
      age: int.parse(json["age"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "age": age,
    };
  }
//
}

class UserNotifier extends StateNotifier<User> {
  UserNotifier() : super(const User(name: "Vishal", age: 18)) {
    updateName('username');
  }

  void updateName(String n) {
    state = state.copyWith(name: n);
  }

  void updateAge(int n) {
    state = state.copyWith(age: n);
  }
}
