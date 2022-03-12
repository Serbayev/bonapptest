import 'package:bonapptest/provider/catalog_provider.dart';
import 'package:bonapptest/provider/sub_category_provider.dart';
import 'package:bonapptest/screens/catalog_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Catalog(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => SubCategoryProvider(),
        ),
      ],
      child: const MaterialApp(
        home: CatalogPage(),
      ),
    );
  }
}
