import '../../domain/entities/entry.dart';
import '../../domain/repositories/entry_repository.dart';
import '../datasources/local_database.dart';
import '../models/entry_model.dart';

class EntryRepositoryImpl implements EntryRepository {
  final LocalDatabase database;

  EntryRepositoryImpl(this.database);

  @override
  Future<void> createEntry(Entry entry) async {
    final entryModel = EntryModel(name: entry.name, description: entry.description);
    await database.createEntry(entryModel);
  }

  @override
  Future<void> deleteEntry(int id) async {
    await database.deleteEntry(id);
  }

  @override
  Future<List<Entry>> getAllEntries() async {
    final entryModels = await database.readAllEntries();
    return entryModels
        .map((model) => Entry(id: model.id, name: model.name, description: model.description))
        .toList();
  }

  @override
  Future<void> updateEntry(Entry entry) async {
    final entryModel = EntryModel(id: entry.id, name: entry.name, description: entry.description);
    await database.updateEntry(entryModel);
  }
}
