import 'dart:convert';

import 'package:bonapptest/model/catalog_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Catalog with ChangeNotifier {
  List<CatalogModel> _catalogProducts = [];

  List<CatalogModel> get products {
    return [..._catalogProducts];
  }

  Future<void> getData() async {
    const url = 'https://bon-app.a-lux.dev/api/shop/category?id=1';

    final response = await http.get(
      Uri.parse(url),
    );
    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final trueResponse = CatalogResponse.fromJson(data);
    _catalogProducts = trueResponse.category!.subcategories!
        .map(
          (e) => CatalogModel(
            id: e.id!,
            image: e.image!,
            subCategoryName: e.title!,
          ),
        )
        .toList();
    notifyListeners();
  }
}

class CatalogResponse {
  Category? category;

  CatalogResponse({this.category});

  CatalogResponse.fromJson(Map<String, dynamic> json) {
    category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (category != null) {
      data['category'] = category!.toJson();
    }
    return data;
  }
}

class Category {
  int? id;
  String? title;
  String? image;
  String? createdAt;
  String? updatedAt;
  List<Subcategories>? subcategories;

  Category(
      {this.id,
      this.title,
      this.image,
      this.createdAt,
      this.updatedAt,
      this.subcategories});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['subcategories'] != null) {
      subcategories = <Subcategories>[];
      json['subcategories'].forEach((v) {
        subcategories!.add(Subcategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['image'] = image;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (subcategories != null) {
      data['subcategories'] = subcategories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Subcategories {
  int? id;
  String? title;
  String? image;
  int? categoryId;
  String? createdAt;
  String? updatedAt;

  Subcategories(
      {this.id,
      this.title,
      this.image,
      this.categoryId,
      this.createdAt,
      this.updatedAt});

  Subcategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    categoryId = json['category_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['image'] = image;
    data['category_id'] = categoryId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
