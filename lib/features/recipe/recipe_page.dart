import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipes_jovis_ai/core/helpers.dart';
import 'package:recipes_jovis_ai/core/interfaces/page_definition.dart';
import 'package:recipes_jovis_ai/core/widgets/navigation_back_button.dart';
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

  String _backNavigate() {
    if (Modular.args.params['category_id'] != null &&
        Modular.args.params['category_id'].toString().isNotEmpty) {
      return PageConstant.recipes
          .replaceFirst(":id", Modular.args.params['category_id']);
    }
    return PageConstant.categories;
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
                leading: NavigationBackButton(backRoute: _backNavigate())),
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
                                  fontSize: AppDefault.xFontSize),
                            ),
                            Container(
                              height: 30,
                            ),
                            const Text(
                              "Ingredients\n",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: AppDefault.ssFontSize),
                            ),
                            Text(_ingredients(recipe.ingredients),
                                style: const TextStyle(
                                    fontSize: AppDefault.sFontSize)),
                            Container(
                              height: 30,
                            ),
                            const Text(
                              "Preparation\n",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: AppDefault.ssFontSize),
                            ),
                            Text(_preparation(recipe.preparation),
                                style: const TextStyle(
                                    fontSize: AppDefault.sFontSize))
                          ]),
                    )))));
  }

  @override
  String route() {
    return PageConstant.recipe;
  }
}
