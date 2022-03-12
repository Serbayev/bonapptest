import 'dart:convert';

import 'package:bonapptest/model/sub_category_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SubCategoryProvider with ChangeNotifier {
  List<SubCategoryModel> _subCategoryProducts = [];

  List<SubCategoryModel> get products {
    return [..._subCategoryProducts];
  }

  Future<void> getData({
    required int id,
  }) async {
    final url =
        'https://bon-app.a-lux.dev/api/shop/subcategory?id=$id&city_id=1';
    final response = await http.get(Uri.parse(url));
    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final convertedResponse = SubCategoryResponse.fromJson(data);
    _subCategoryProducts = convertedResponse.subcategory!.products!
        .map(
          (e) => SubCategoryModel(
              id: e.id!,
              productName: e.title!,
              image: e.image!,
              price: e.price!,
              product: Products(
                image: e.image,
                price: e.price,
                title: e.title,
                available: e.available,
                bonus: e.bonus,
                categoryId: e.categoryId,
                createdAt: e.createdAt,
                description: e.description,
                id: e.id,
                newPrice: e.newPrice,
                recId: e.recId,
                saleId: e.saleId,
                subcategoryId: e.subcategoryId,
                updatedAt: e.updatedAt,
              )),
        )
        .toList();
    notifyListeners();
  }
}

class SubCategoryResponse {
  Subcategory? subcategory;

  SubCategoryResponse({this.subcategory});

  SubCategoryResponse.fromJson(Map<String, dynamic> json) {
    subcategory = json['subcategory'] != null
        ? Subcategory.fromJson(json['subcategory'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (subcategory != null) {
      data['subcategory'] = subcategory!.toJson();
    }
    return data;
  }
}

class Subcategory {
  int? id;
  String? title;
  String? image;
  int? categoryId;
  String? createdAt;
  String? updatedAt;
  List<Products>? products;

  Subcategory(
      {this.id,
      this.title,
      this.image,
      this.categoryId,
      this.createdAt,
      this.updatedAt,
      this.products});

  Subcategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    categoryId = json['category_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['image'] = image;
    data['category_id'] = categoryId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  int? id;
  String? title;
  String? image;
  String? description;
  int? bonus;
  int? subcategoryId;
  int? categoryId;
  int? saleId;
  int? recId;
  String? createdAt;
  String? updatedAt;
  int? price;
  Null? newPrice;
  int? available;

  Products(
      {this.id,
      this.title,
      this.image,
      this.description,
      this.bonus,
      this.subcategoryId,
      this.categoryId,
      this.saleId,
      this.recId,
      this.createdAt,
      this.updatedAt,
      this.price,
      this.newPrice,
      this.available});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    description = json['description'];
    bonus = json['bonus'];
    subcategoryId = json['subcategory_id'];
    categoryId = json['category_id'];
    saleId = json['sale_id'];
    recId = json['rec_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    price = json['price'];
    newPrice = json['new_price'];
    available = json['available'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['image'] = image;
    data['description'] = description;
    data['bonus'] = bonus;
    data['subcategory_id'] = subcategoryId;
    data['category_id'] = categoryId;
    data['sale_id'] = saleId;
    data['rec_id'] = recId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['price'] = price;
    data['new_price'] = newPrice;
    data['available'] = available;
    return data;
  }
}
