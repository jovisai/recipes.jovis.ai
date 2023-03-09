import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipes_jovis_ai/core/helpers.dart';
import 'package:recipes_jovis_ai/core/interfaces/page_definition.dart';
import 'package:recipes_jovis_ai/features/recipe_repository.dart';

final recipeProvider = Provider.autoDispose<Recipe>((ref) => Modular.args.data);

class RecipePage extends ConsumerWidget implements IPage {
  const RecipePage({super.key});

  String _ingredients(List<String> ingredients) {
    return ingredients.join("\n");
  }

  String _preparation(List<String> preparation) {
    return preparation.join("\n");
  }

  void _backNavigate() {
    if (Modular.args.params['category_id'] != null &&
        Modular.args.params['category_id'].toString().isNotEmpty) {
      Modular.to.navigate(PageConstant.recipes
          .replaceFirst(":id", Modular.args.params['category_id']));
    } else {
      Modular.to.navigate(PageConstant.categories);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Recipe recipe = ref.read(recipeProvider);
    return WillPopScope(
        onWillPop: () async {
          _backNavigate();
          return false;
        },
        child: CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              border: const Border(bottom: BorderSide.none),
              padding: const EdgeInsetsDirectional.all(0),
              leading: GestureDetector(
                child: Container(
                  width: 55,
                  color: CupertinoTheme.of(context).barBackgroundColor,
                  child: const Icon(
                    CupertinoIcons.back,
                    size: 25,
                  ),
                ),
                onTap: () => _backNavigate(),
              ),
            ),
            child: SafeArea(
                child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              recipe.title,
                              style: const TextStyle(
                                  fontSize: AppDefault.xxFontSize),
                            ),
                            Container(
                              height: 30,
                            ),
                            const Text(
                              "Ingredients",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(_ingredients(recipe.ingredients)),
                            Container(
                              height: 30,
                            ),
                            const Text(
                              "Preparation",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(_preparation(recipe.preparation))
                          ]),
                    )))));
  }

  @override
  String route() {
    return PageConstant.recipe;
  }
}
