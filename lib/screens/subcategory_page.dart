import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../config/colors.dart';

class SubCategoryPage extends StatelessWidget {
  final subCategoryName;

  const SubCategoryPage({
    Key? key,
    required this.subCategoryName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          subCategoryName,
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                stops: [0.4, 0.5, 0.6],
                transform: GradientRotation(math.pi / 2.5),
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: AppColors.gradient),
          ),
        ),
      ),
      body: SizedBox(),
    );
  }

  Widget _sortButton() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.white,
      ),
      child: Row(children: [Icon(Icons.arrow_upward,)]),
    );
  }
}
