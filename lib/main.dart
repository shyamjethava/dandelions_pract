import 'package:dandelions_practical/data/datasources/local_database.dart';
import 'package:dandelions_practical/data/repositories/entry_repository_impl.dart';
import 'package:dandelions_practical/domain/usecases/entry_usecases.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'presentation/controllers/entry_controller.dart';
import 'presentation/pages/home_page.dart';

void main() {
  final entryRepository = EntryRepositoryImpl(LocalDatabase.instance);
  final entryUseCases = EntryUseCases(entryRepository);
  Get.put(EntryController(entryUseCases));
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
