import 'package:bonapptest/screens/subcategory_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config/colors.dart';
import '../provider/catalog_provider.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({Key? key}) : super(key: key);

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  @override
  void initState() {
    context.read<Catalog>().getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Catalog>(context);
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'Продукты питания',
          style: TextStyle(
            color: AppColors.textBlack,
          ),
        ),
      ),
      body: Consumer<Catalog>(
        builder: (context, value, child) {
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, childAspectRatio: 1 / 1),
            itemCount: provider.products.length,
            itemBuilder: (ctx, i) => categories(
                image: provider.products[i].image,
                categoryName: provider.products[i].subCategoryName),
          );
        },
      ),
    );
  }

  Widget categories({
    required String image,
    required String categoryName,
  }) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => SubCategoryPage(subCategoryName: ''),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.all(6),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.1), blurRadius: 2)
            ]),
        child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          Image.network(
            image,
          ),
          SizedBox(height: 10),
          Text(
            categoryName,
            style: TextStyle(fontSize: 12),
          ),
        ]),
      ),
    );
  }
}
