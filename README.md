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

  @override
  Widget build(BuildContext context) {
  return MaterialApp(
  title: 'Flutter Demo',
  theme: ThemeData(
  datePickerTheme: const DatePickerThemeData(
  dividerColor: Colors.black,
  backgroundColor: Colors.white,
  dayForegroundColor: WidgetStatePropertyAll(Colors.black),
  confirmButtonStyle: ButtonStyle(
  backgroundColor: WidgetStatePropertyAll(Colors.black),
  )),
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
  useMaterial3: true,
  ),
  home: const PaginatedListView(),
  );
  }
  }

class PaginatedListView extends StatefulWidget {
const PaginatedListView({super.key});

@override
_PaginatedListViewState createState() => _PaginatedListViewState();
}

class _PaginatedListViewState extends State<PaginatedListView> {
final ScrollController _scrollController = ScrollController();
List<dynamic> _products = [];
bool _isLoading = false;
bool _hasMore = true; // To track if more products can be loaded
int _limit = 12;
int _offset = 0;

@override
void initState() {
super.initState();
_fetchProducts();
_scrollController.addListener(() {
if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && !_isLoading && _hasMore) {
_fetchMoreProducts();
}
});
}

Future<void> _fetchProducts() async {
setState(() {
_isLoading = true;
});

    final url = 'https://api.escuelajs.co/api/v1/products?offset=$_offset&limit=$_limit';
    final response = await http.get(Uri.parse(url));
    
    if (response.statusCode == 200) {
      final List<dynamic> fetchedProducts = jsonDecode(response.body);
      
      if (fetchedProducts.length < _limit) {
        // No more products to load
        _hasMore = false;
      }

      setState(() {
        log('Products loaded: ${fetchedProducts.length}');
        _products.addAll(fetchedProducts);
        _offset += _limit;
      });
    } else {
      throw Exception('Failed to load products');
    }

    setState(() {
      _isLoading = false;
    });
}

Future<void> _fetchMoreProducts() async {
if (!_isLoading && _hasMore) {
await _fetchProducts();
}
}

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: const Text('Paginated Products List'),
),
body: _isLoading && _products.isEmpty
? const Center(child: CircularProgressIndicator())
: ListView.builder(
controller: _scrollController,
itemCount: _products.length + (_hasMore ? 1 : 0),
itemBuilder: (context, index) {
if (index == _products.length) {
return const Center(child: CircularProgressIndicator());
}
final product = _products[index];
return ListTile(
title: Text(product['title']),
subtitle: Text('\$${product['price']}'),
);
},
),
);
}

@override
void dispose() {
_scrollController.dispose();
super.dispose();
}
}
