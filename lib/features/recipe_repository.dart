import 'dart:convert';

import 'dataset.dart';
import 'package:http/http.dart' as http;

Map<String, List<SearchEngineResult>> cachedSearchResults = {};

class RecipeCategory {
  final String id;
  final String name;
  final int count;

  RecipeCategory(this.id, this.name, this.count);
}

class Recipe {
  final String id;
  final String title;
  final String categoryId;
  final List<String> ingredients;
  final List<String> preparation;

  Recipe(
      this.id, this.title, this.categoryId, this.ingredients, this.preparation);
}

const searchEngineAPI =
    "https://www.googleapis.com/customsearch/v1?key=AIzaSyARV_EjWYlVg8_GUooSPhuZN_8BF6Hhkf8&q={0}%20vegetarian&cx=b42f308d6884c4cc1&hl=en";

class SearchEngineResult {
  final String title;
  final String link;
  final String snippet;
  final String imageUrl;

  SearchEngineResult(this.title, this.link, this.snippet, this.imageUrl);
}

class RecipeRepository {
  List<RecipeCategory> getCategories() {
    List<RecipeCategory> returnData = [];
    List<Map<String, Object>> categories = dataset['categories']!;
    for (Map category in categories) {
      returnData.add(
          RecipeCategory(category['id'], category['name'], category['count']));
    }
    return returnData;
  }

  List<Recipe> getRecipesInCategory(String categoryId) {
    List<Recipe> returnData = [];
    List<Map<String, Object>> recipes = dataset['recipes']!;
    List<Map<String, Object>> filteredData =
        recipes.where((recipe) => recipe['category_id'] == categoryId).toList();
    for (Map recipe in filteredData) {
      List<String> ingredients = [];
      recipe['ingredients'].forEach((e) => ingredients.add(e.toString()));
      List<String> preparation = [];
      recipe['preparation'].forEach((e) => preparation.add(e.toString()));
      returnData.add(Recipe(recipe['id'], recipe['title'],
          recipe['category_id'], ingredients, preparation));
    }
    return returnData;
  }

  String getCategoryName(String categoryId) {
    Map firstWhere = dataset['categories']!
        .firstWhere((element) => element['id'].toString() == categoryId);
    return firstWhere["name"];
  }

  List<Recipe> findRecipes(String query) {
    List<Recipe> returnData = [];
    if (query.trim().isNotEmpty) {
      List<Map<String, Object>> recipes = dataset['recipes']!;
      for (Map recipe in recipes) {
        try {
          List<String> ingredients = [];
          recipe['ingredients'].forEach((e) => ingredients.add(e.toString()));
          List<String> preparation = [];
          recipe['preparation'].forEach((e) => preparation.add(e.toString()));

          if (recipe['title'].toString().contains(query) ||
              ingredients.indexWhere((element) => element.contains(query)) >
                  -1 ||
              preparation.indexWhere((element) => element.contains(query)) >
                  -1) {
            returnData.add(Recipe(recipe['id'], recipe['title'],
                recipe['category_id'], ingredients, preparation));
          }
        } catch (e) {}
      }
    }
    return returnData;
  }

  Future<List<SearchEngineResult>> getSearchEngineResults(String query) async {
    if (cachedSearchResults.containsKey(query)) {
      return Future.value(cachedSearchResults[query]);
    }
    List<SearchEngineResult> results = [];
    final response =
        await http.get(Uri.parse(searchEngineAPI.replaceFirst("{0}", query)));
    if (response.statusCode == 200) {
      Map decoded = jsonDecode(response.body);
      List resultsList = decoded["items"];
      for (var element in resultsList) {
        try {
          String imageUrl = element["pagemap"]["cse_image"][0]["src"];
          results.add(SearchEngineResult(element["title"], element["link"],
              element["formattedUrl"], imageUrl));
        } catch (e) {}
      }
      cachedSearchResults[query] = results;
    }
    return results;
  }
}
