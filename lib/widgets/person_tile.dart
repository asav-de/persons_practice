import 'package:flutter/material.dart';
import 'package:persons_practice/models/person.dart';

class PersonTile extends StatelessWidget{
  const PersonTile({super.key,required this.person, required this.onDelete});

  final Person person;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(person.name),
      subtitle: Text('${person.age} Jahre'),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: onDelete,
        ),
    );
  }
}