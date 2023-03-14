import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipes_jovis_ai/core/helpers.dart';
import 'package:recipes_jovis_ai/core/interfaces/page_definition.dart';
import 'package:recipes_jovis_ai/features/recipe_repository.dart';
import 'package:recipes_jovis_ai/features/recipes_list/recipes.dart';

class SearchQuery {
  final String query;
  final List<Recipe> results;

  SearchQuery(this.query, this.results);
}

final recipeCategoriesProvider =
    Provider((ref) => Modular.get<RecipeRepository>().getCategories());

final searchProvider = StateProvider<String>((ref) => "");

final searchResultsProvider = StateProvider<List<Recipe>>((ref) =>
    Modular.get<RecipeRepository>().findRecipes(ref.watch(searchProvider)));

class CategoriesPage extends ConsumerWidget implements IPage {
  CategoriesPage({super.key});
  final _debouncer = Debouncer(milliseconds: 500);

  final _textSearchController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var recipeCategories = ref.read(recipeCategoriesProvider);
    List<Recipe> recipes = ref.watch(searchResultsProvider);
    return CupertinoPageScaffold(
        child: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "What would you like to cook today?",
                      style: TextStyle(fontSize: AppDefault.xxFontSize),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                        child: CupertinoSearchTextField(
                            controller: _textSearchController,
                            onChanged: (value) => _debouncer.run(() => ref
                                .read(searchProvider.notifier)
                                .update((state) => value)),
                            placeholder:
                                "Search titles, ingredients, cold, hot, soup, juice, lemon, rice etc")),
                    if (recipes.isEmpty)
                      Expanded(
                        child: ListView.builder(
                            itemCount: recipeCategories.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                children: [
                                  CupertinoListTile(
                                    onTap: () => Modular.to.navigate(
                                        PageConstant.recipes.replaceFirst(
                                            ":id", recipeCategories[index].id)),
                                    padding: const EdgeInsets.only(
                                        left: 0, top: 10.0, bottom: 15),
                                    title: Text(
                                      recipeCategories[index].name,
                                      style: const TextStyle(
                                          fontSize: AppDefault.mFontSize),
                                    ),
                                  ),
                                ],
                              );
                            }),
                      ),
                    if (recipes.isNotEmpty) RecipeList(recipes: recipes)
                  ],
                ))));
  }

  @override
  String route() {
    return PageConstant.categories;
  }
}
