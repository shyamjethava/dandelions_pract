import '../entities/entry.dart';
import '../repositories/entry_repository.dart';

class EntryUseCases {
  final EntryRepository repository;

  EntryUseCases(this.repository);

  Future<void> createEntry(Entry entry) {
    return repository.createEntry(entry);
  }

  Future<void> updateEntry(Entry entry) {
    return repository.updateEntry(entry);
  }

  Future<void> deleteEntry(int id) {
    return repository.deleteEntry(id);
  }

  Future<List<Entry>> getAllEntries() {
    return repository.getAllEntries();
  }
}
