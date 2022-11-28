// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shop_app/models/http_exception.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFav;
  Product(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.imageUrl,
      this.isFav = false});

  Future<void> toggleFavoriteStatus() async {
    final oldStatus = isFav;
    isFav = !isFav;
    notifyListeners();
    final url =
        "https://shop-app-3f832-default-rtdb.firebaseio.com/products/${id}.json";
    final response =
        await http.patch(Uri.parse(url), body: json.encode({'isFav': isFav}));
    if (response.statusCode >= 400) {
      isFav = oldStatus;
      notifyListeners();
      throw HttpException('Could not favorite this!');
    }
  }
}
