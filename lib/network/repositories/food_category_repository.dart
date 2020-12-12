import 'dart:convert';

import 'package:comida/model/food_category.dart';
import 'package:flutter/services.dart';

class FoodCategoryRepository {
  static Future<List<FoodCategory>> getFoodCategories() async {
    final String jsonString = await rootBundle.loadString('assets/json/food_categories.json');
    final data = json.decode(jsonString);

    List foodCategories = data;

    return foodCategories.map((data) => FoodCategory.fromJson(data)).toList();
  }
}