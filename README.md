# Flutter CRUD Application

Flutter SDK : 3.24.0

A Flutter application that implements CRUD (Create, Read, Update, Delete) functionalities with a
local database.
Users can manage entries with fields like ID, Name, and Description.

## Features

- **Create**: Add new entries to the local database.
- **Read**: Display the list of entries in a structured format.
- **Update**: Edit existing entries.
- **Delete**: Remove entries from the local database.

## Technology Stack

- Flutter
- Dart
- SQLite (local database solution)

// datepicker

theme :

datePickerTheme: const DatePickerThemeData(
dividerColor: Colors.black,
backgroundColor: Colors.white,
dayForegroundColor: WidgetStatePropertyAll(Colors.black),
confirmButtonStyle: ButtonStyle(
backgroundColor: WidgetStatePropertyAll(Colors.black),
)),

void onTapDatepicker() {
showDatePicker(
context: context,
firstDate: DateTime(2020),
lastDate: DateTime.now(),
confirmText: "OK",
cancelText: "Cancel",
initialDatePickerMode: DatePickerMode.day,
builder: (context, child) {
return Theme(
data: ThemeData.light().copyWith(
primaryColor: Colors.black,
colorScheme: const ColorScheme.light(primary: Colors.black),
buttonTheme:
const ButtonThemeData(textTheme: ButtonTextTheme.primary)),
child: child!);
},
);
}