import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:persons_practice/models/person.dart';
import 'package:uuid/uuid.dart';

final NotifierProvider<PersonsNotifier, List<Person>> personsProvider = 
NotifierProvider<PersonsNotifier, List<Person>>(PersonsNotifier.new);

class PersonsNotifier extends Notifier<List<Person>> {
  static const _uuid = Uuid();
  
  @override
  List<Person> build() {
    return [
      Person(age: 25, id: _uuid.v4(), name: 'Anna'),
      Person(age: 17, id: _uuid.v4(), name: 'Max'),
      Person(age: 40, id: _uuid.v4(), name: 'Olga'),
    ];
  }

  void removePerson(String id) {
    state = state.where((p) => p.id != id).toList();
  }
}