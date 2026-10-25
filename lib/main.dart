import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:persons_practice/providers/person_notivier.dart';
import 'package:persons_practice/widgets/person_tile.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final persons = ref.watch(personsProvider);

    return Scaffold(
      body: ListView.builder(
        itemCount: persons.length,
        itemBuilder: (context, index) {
          final person = persons[index];
          return PersonTile(
            person: person,
            onDelete: () => ref.read(personsProvider.notifier).removePerson(person.id),
          );
        },
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Persons Practice',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomeScreen(),
    );
  }
}
