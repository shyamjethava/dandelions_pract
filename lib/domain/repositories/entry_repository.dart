import 'package:dandelions_practical/domain/entities/entry.dart';

abstract class EntryRepository {
  Future<void> createEntry(Entry entry);
  Future<void> updateEntry(Entry entry);
  Future<void> deleteEntry(int id);
  Future<List<Entry>> getAllEntries();
}
