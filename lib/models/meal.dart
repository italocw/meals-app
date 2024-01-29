import 'package:meals_app/providers/filters_provider.dart';
import 'package:meals_app/screens/filters.dart';

enum Complexity {
  simple,
  challenging,
  hard,
}

enum Affordability {
  affordable,
  pricey,
  luxurious,
}

class Meal {
  const Meal({
    required this.id,
    required this.categories,
    required this.title,
    required this.imageUrl,
    required this.ingredients,
    required this.steps,
    required this.duration,
    required this.complexity,
    required this.affordability,
    required this.isGlutenFree,
    required this.isLactoseFree,
    required this.isVegan,
    required this.isVegetarian,
  });

  final String id;
  final List<String> categories;
  final String title;
  final String imageUrl;
  final List<String> ingredients;
  final List<String> steps;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;
  final bool isGlutenFree;
  final bool isLactoseFree;
  final bool isVegan;
  final bool isVegetarian;

  bool shouldBeAcceptedByFiltering(Map<Filter, bool> filters) {
    bool hasSomeNotAcceptedIngredient = false;

    if (filters[Filter.glutenFree]! && !isGlutenFree) {
      hasSomeNotAcceptedIngredient = true;
    } else if (filters[Filter.lactoseFree]! && !isLactoseFree) {
      hasSomeNotAcceptedIngredient = true;
    } else if (filters[Filter.vegetarian]! && !isVegetarian) {
      hasSomeNotAcceptedIngredient = true;
    } else if (filters[Filter.vegan]! && !isVegan) {
      hasSomeNotAcceptedIngredient = true;
    }

    return !hasSomeNotAcceptedIngredient;
  }
}
