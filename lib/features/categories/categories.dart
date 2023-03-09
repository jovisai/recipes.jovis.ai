import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipes_jovis_ai/core/helpers.dart';
import 'package:recipes_jovis_ai/core/interfaces/page_definition.dart';
import 'package:recipes_jovis_ai/features/recipe_repository.dart';

final recipeCategoriesProvider =
    Provider((ref) => Modular.get<RecipeRepository>().getCategories());

class CategoriesPage extends ConsumerWidget implements IPage {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var recipeCategories = ref.read(recipeCategoriesProvider);
    return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
            border: Border(bottom: BorderSide.none)),
        child: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Text(
                        "What would you like to cook today?",
                        style: TextStyle(fontSize: AppDefault.xxFontSize),
                      ),
                    ),
                    const Padding(
                        padding: EdgeInsets.only(top: 8.0, bottom: 38.0),
                        child: CupertinoSearchTextField(
                            placeholder:
                                "Search through ingredients and recipes")),
                    Expanded(
                      child: ListView.builder(
                          itemCount: recipeCategories.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: [
                                const Divider(
                                  height: 1,
                                ),
                                CupertinoListTile(
                                    onTap: () => Modular.to.navigate(
                                        PageConstant.recipes.replaceFirst(
                                            ":id", recipeCategories[index].id)),
                                    padding: const EdgeInsets.only(
                                        left: 0, top: 10.0, bottom: 28),
                                    subtitle: Text(
                                        "${recipeCategories[index].count} recipes"),
                                    title: Text(
                                      recipeCategories[index].name,
                                      style: const TextStyle(
                                          fontSize: AppDefault.xFontSize),
                                    )),
                              ],
                            );
                          }),
                    )
                  ],
                ))));
  }

  @override
  String route() {
    return PageConstant.categories;
  }
}
