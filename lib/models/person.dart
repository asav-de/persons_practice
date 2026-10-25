import 'package:flutter/material.dart';

@immutable
class Person {
  const Person({required this.age,required this.id,required this.name});

  final String id;
  final String name;
  final int age;



  Map<String,dynamic> toJson() => {
    'id': id,
    'name': name,
    'age': age,
  };

  factory Person.fromJson(Map<String,dynamic> json) => Person(
    age: json['age'] as int, 
    id: json['id'] as String, 
    name: json['name'] as String);

  @override
  bool operator ==(Object other) => 
    other is Person &&
    id == other.id &&
    name == other.name &&
    age == other.age;

  Person copyWith({
    String? id,
    String? name,
    int? age,
  }) => Person(
    age: age ?? this.age, 
    id: id ?? this.id, 
    name: name ?? this.name
    );

  @override
  int get hashCode => Object.hash(id, name, age);
}