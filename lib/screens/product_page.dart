import 'dart:math' as math;

import 'package:bonapptest/config/assets.dart';
import 'package:bonapptest/config/colors.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  final String productName;
  final int price;
  final String productImage;
  final String description;

  const ProductPage({
    Key? key,
    required this.productName,
    required this.price,
    required this.productImage,
    required this.description,
  }) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int quantity = 0;

  void quantityPlus() {
    setState(() {
      quantity++;
    });
  }

  void quantityMinus() {
    if (quantity == 0) return;
    setState(() {
      quantity--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: AppColors.textBlack,
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Column(children: [
        productImage(image: widget.productImage),
        const SizedBox(height: 23.6),
        productInfo(
          productName: widget.productName,
          price: widget.price,
          description: widget.description,
        ),
        const Expanded(child: SizedBox()),
        addToCart(quantity: quantity),
        const SizedBox(height: 30),
      ]),
    );
  }

  Widget productImage({
    required String image,
  }) {
    return Container(
      height: 200,
      decoration: const BoxDecoration(color: AppColors.white),
      alignment: Alignment.center,
      child: Image.network('https://bon-app.a-lux.dev/storage/$image'),
    );
  }

  Widget productInfo({
    required String productName,
    required int price,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                productName,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                price.toString(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
          const SizedBox(height: 26.5),
          Text(
            description,
          )
        ],
      ),
    );
  }

  Widget addToCart({required int quantity}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.84),
      child: Row(
        children: [
          plusMinusButton(
            icon: Assets.icons.minus,
            onTap: quantityMinus,
          ),
          SizedBox(
            width: 38.9,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                quantity.toString(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          plusMinusButton(
            icon: Assets.icons.plus,
            onTap: quantityPlus,
          ),
          const SizedBox(width: 19.52),
          longButton(price: 590),
        ],
      ),
    );
  }

  Widget plusMinusButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 44,
        width: 44,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          gradient: const LinearGradient(
            stops: [0.36, 0.67],
            colors: AppColors.gradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Icon(
          icon,
          size: 20,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget longButton({required int price}) {
    return Expanded(
      child: Container(
        height: 44,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            gradient: const LinearGradient(
                stops: [0.36, 0.67],
                colors: AppColors.gradient,
                transform: GradientRotation(math.pi / 2))),
        child: Column(children: [
          const Text(
            'Перейти в корзину',
            style:
                TextStyle(fontWeight: FontWeight.bold, color: AppColors.white),
          ),
          const SizedBox(height: 7.8),
          Text(
            (price * quantity).toString(),
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: AppColors.white),
          ),
        ]),
      ),
    );
  }
}
