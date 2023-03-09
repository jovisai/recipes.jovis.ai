import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:localstorage/localstorage.dart';
import 'package:recipes_jovis_ai/app.dart';
import 'package:recipes_jovis_ai/core/interfaces/page_definition.dart';
import 'package:recipes_jovis_ai/features/categories/categories.dart';
import 'package:recipes_jovis_ai/features/recipe/recipe_page.dart';
import 'package:recipes_jovis_ai/features/recipe_repository.dart';
import 'package:recipes_jovis_ai/features/recipes_list/recipes.dart';

const _storage = "recipes.jovis.ai";
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage(_storage).ready;
  // workaround for module access initialization
  runApp(ModularApp(
      module: AppModule(), child: const ProviderScope(child: AppEntry())));
}

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.singleton((i) => LocalStorage(_storage)),
        Bind.singleton((i) => RecipeRepository())
      ];

  @override
  List<ModularRoute> get routes => [
        createChildRoute(CategoriesPage()),
        createChildRoute(const RecipeListPage()),
        createChildRoute(const RecipePage())
      ];

  ChildRoute<dynamic> createChildRoute(IPage page) {
    return ChildRoute(page.route(), child: (context, args) => page);
  }
}
