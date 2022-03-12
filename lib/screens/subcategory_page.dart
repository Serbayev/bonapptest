import 'dart:math' as math;

import 'package:bonapptest/config/assets.dart';
import 'package:bonapptest/provider/sub_category_provider.dart';
import 'package:bonapptest/screens/product_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../config/colors.dart';

class SubCategoryPage extends StatefulWidget {
  final String subCategoryName;
  final int subCategoryId;

  const SubCategoryPage({
    Key? key,
    required this.subCategoryName,
    required this.subCategoryId,
  }) : super(key: key);

  @override
  State<SubCategoryPage> createState() => _SubCategoryPageState();
}

class _SubCategoryPageState extends State<SubCategoryPage> {
  bool pageLoaded = false;

  @override
  void initState() {
    pageLoaded = true;
    context
        .read<SubCategoryProvider>()
        .getData(id: widget.subCategoryId)
        .whenComplete(() => pageLoaded = false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SubCategoryProvider>(context);
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          widget.subCategoryName,
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                stops: [0.36, 0.67],
                transform: GradientRotation(math.pi / 2.5),
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: AppColors.gradient),
          ),
        ),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(height: 19.56),
        _sortButton(),
        const SizedBox(height: 24.42),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17),
          child: Text(
            '${provider.products.length} товаров',
            style: const TextStyle(color: AppColors.grey),
          ),
        ),
        Flexible(
          child: Consumer<SubCategoryProvider>(
            builder: (context, value, child) {
              return pageLoaded
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, childAspectRatio: 3 / 4),
                      itemCount: provider.products.length,
                      itemBuilder: (ctx, i) => productCard(
                        productImage: provider.products[i].image,
                        price: provider.products[i].price,
                        productName: provider.products[i].productName,
                        context: context,
                        product: provider.products[i].product,
                      ),
                    );
            },
          ),
        )
      ]),
    );
  }

  Widget _sortButton() {
    return Container(
      height: 42,
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.white,
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        SvgPicture.asset(
          Assets.icons.sortIcon,
        ),
        const SizedBox(width: 10),
        const Text(
          'Сортировать по возрастанию цены',
          style: TextStyle(
            fontSize: 12,
            color: AppColors.textBlack,
          ),
        )
      ]),
    );
  }

  Widget productCard({
    required BuildContext context,
    required String productImage,
    required String productName,
    required int price,
    required Products product,
  }) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => ProductPage(
              productImage: product.image!,
              description: product.description!,
              price: product.price!,
              productName: product.title!,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(15),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.white,
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Flexible(
                child: Align(
                  alignment: Alignment.center,
                  child: Image.network(
                    'https://bon-app.a-lux.dev/storage/${productImage}',
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Text(productName),
              const SizedBox(height: 12.9),
              Text(
                price.toString(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 9.8),
              gradientButton(),
            ]),
      ),
    );
  }

  Widget gradientButton() {
    return InkWell(
      onTap: () {},
      child: Container(
        height: 38,
        width: double.maxFinite,
        // margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: const LinearGradient(
            stops: [0.36, 0.67],
            colors: AppColors.gradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            transform: GradientRotation(math.pi / 4),
          ),
        ),
        alignment: Alignment.center,
        child: const Text(
          'Добавить',
          style: TextStyle(
            fontSize: 16,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}
