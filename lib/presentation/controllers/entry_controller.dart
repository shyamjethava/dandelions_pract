import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/entities/entry.dart';
import '../../domain/usecases/entry_usecases.dart';

class EntryController extends GetxController {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final EntryUseCases useCases;
  var entries = <Entry>[].obs;
  var isLoading = false.obs;

  EntryController(this.useCases);

  @override
  void onInit() {
    super.onInit();
    loadEntries();
  }

  void loadEntries() async {
    isLoading(true);
    entries.value = await useCases.getAllEntries();
    isLoading(false);
  }

  void addEntry(String name, String description) async {
    await useCases.createEntry(Entry(name: name, description: description));
    loadEntries();
  }

  void updateEntry(int id, String name, String description) async {
    await useCases.updateEntry(Entry(id: id, name: name, description: description));
    loadEntries();
  }

  void deleteEntry(int id) async {
    await useCases.deleteEntry(id);
    loadEntries();
  }
}
