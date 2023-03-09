import 'package:flutter/cupertino.dart';

/// A simple page in this application must have a route madatorily.
/// All pages in the code must implement to be able to be added in the router.
abstract class IPage extends Widget {
  const IPage({super.key});

  String route();
}

class PageConstant {
  static const categories = "/";
  static const recipes = "/recipes/:id";
  static const recipe = "/recipe/:category_id";
}
