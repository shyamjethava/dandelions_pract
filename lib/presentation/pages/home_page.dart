import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/entry_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EntryController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Note App'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return controller.entries.isNotEmpty
            ? ListView.builder(
                itemCount: controller.entries.length,
                itemBuilder: (context, index) {
                  final entry = controller.entries[index];
                  return ListTile(
                    title: Text(entry.name,
                        maxLines: 1, overflow: TextOverflow.ellipsis),
                    subtitle: Text(
                      entry.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            controller.nameController.text = entry.name;
                            controller.descriptionController.text =
                                entry.description;
                            _showForm(context, entry.id, controller,
                                isEdit: true);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => controller.deleteEntry(entry.id!),
                        ),
                      ],
                    ),
                  );
                },
              )
            : const Center(
                child: Text(
                  """Click "+" button to add note""",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              );
      }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _showForm(context, null, controller),
      ),
    );
  }

  void _showForm(BuildContext context, int? id, EntryController controller,
      {bool isEdit = false}) {
    if (!isEdit) {
      controller.nameController.text = '';
      controller.descriptionController.text = '';
    }
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (_) => Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Text(
                    isEdit ? 'Edit Note' : 'Add Note',
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: controller.nameController,
                    decoration: const InputDecoration(
                        labelText: 'Name', border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: controller.descriptionController,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (id == null) {
                        Get.find<EntryController>().addEntry(
                            controller.nameController.text,
                            controller.descriptionController.text);
                      } else {
                        Get.find<EntryController>().updateEntry(
                            id,
                            controller.nameController.text,
                            controller.descriptionController.text);
                      }
                      Navigator.pop(context);
                    },
                    child: Text(id == null ? 'Create New' : 'Update'),
                  ),
                ],
              ),
            ));
  }
}
