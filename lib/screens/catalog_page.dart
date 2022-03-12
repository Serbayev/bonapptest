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
        title: const Text(
          'Продукты питания',
          style: TextStyle(
            color: AppColors.textBlack,
          ),
        ),
      ),
      body: Consumer<Catalog>(
        builder: (context, value, child) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, childAspectRatio: 1 / 1),
              itemCount: provider.products.length,
              itemBuilder: (ctx, i) => categories(
                  id: provider.products[i].id,
                  image: provider.products[i].image,
                  categoryName: provider.products[i].subCategoryName),
            ),
          );
        },
      ),
    );
  }

  Widget categories({
    required String image,
    required String categoryName,
    required int id,
  }) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => SubCategoryPage(
              subCategoryName: categoryName,
              subCategoryId: id,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(6),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.1), blurRadius: 2)
            ]),
        child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          Image.network(
            'https://bon-app.a-lux.dev/storage/$image',
          ),
          const SizedBox(height: 10),
          Flexible(
            child: Text(
              categoryName,
              maxLines: 1,
              overflow: TextOverflow.fade,
              style: const TextStyle(
                fontSize: 11,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
