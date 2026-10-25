import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final helloProvider = Provider<String>((ref) => 'Hallo');

void main() {
  runApp(const ProviderScope(
    child: MyApp(),
    ),
  );
}

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});
  @override
  build(BuildContext context, WidgetRef ref){
    return Scaffold(
      body: Center(child: Text(ref.watch(helloProvider)),) ,);
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
