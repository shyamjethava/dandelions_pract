import 'package:dandelions_practical/presentation/controllers/entry_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:dandelions_practical/main.dart';
import 'package:dandelions_practical/data/datasources/local_database.dart';
import 'package:dandelions_practical/data/repositories/entry_repository_impl.dart';
import 'package:dandelions_practical/domain/usecases/entry_usecases.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  setUpAll(() {
    databaseFactory = databaseFactoryFfi;
  });

  setUp(() async {
    await LocalDatabase.instance.database;
    final entryRepository = EntryRepositoryImpl(LocalDatabase.instance);
    final entryUseCases = EntryUseCases(entryRepository);
    Get.put(EntryController(entryUseCases));
  });

  testWidgets('CRUD Integration Test for Entry', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    await tester.tap(find.byIcon(Icons.add));
    await tester.enterText(find.byType(TextField).first, 'Test Name');
    await tester.enterText(find.byType(TextField).last, 'Test Description');
    await tester.tap(find.text('Create New'));
    await tester.pumpAndSettle();

    expect(find.text('Test Name'), findsOneWidget);
    expect(find.text('Test Description'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.edit).first);
    await tester.enterText(find.byType(TextField).first, 'Updated Name');
    await tester.enterText(find.byType(TextField).last, 'Updated Description');
    await tester.tap(find.text('Update'));
    await tester.pumpAndSettle();

    expect(find.text('Updated Name'), findsOneWidget);
    expect(find.text('Updated Description'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.delete).first);
    await tester.pumpAndSettle();

    expect(find.text('Updated Name'), findsNothing);
    expect(find.text('Updated Description'), findsNothing);
  });

  tearDown(() {
    Get.delete<EntryController>();
  });
}
