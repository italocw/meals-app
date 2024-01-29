import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal.dart';

enum FavoritingResult { removed, added }

class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavoriteMealsNotifier() : super([]);

  FavoritingResult toggleMealFavoriteStatus(Meal toggledMeal) {
    final mealIsFavorite = state.contains(toggledMeal);

    if (mealIsFavorite) {
      state = state
          .where((mealBeingAnalized) => mealBeingAnalized.id != toggledMeal.id)
          .toList();

      return FavoritingResult.removed;
    } else {
      state = [...state, toggledMeal];

      return FavoritingResult.added;
    }
  }
}

final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>((ref) {
  return FavoriteMealsNotifier();
});
