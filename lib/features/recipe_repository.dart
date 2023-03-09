import 'dataset.dart';

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
}
