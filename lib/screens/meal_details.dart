import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/providers/favorites_provider.dart';
import 'package:meals_app/widgets/meal_image.dart';

class MealDetailsScreen extends ConsumerWidget {
  const MealDetailsScreen({super.key, required this.meal});

  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteMeals = ref.watch(favoriteMealsProvider);

    bool isMealFavorite = favoriteMeals.contains(meal);
    IconData favoriteIcon = isMealFavorite ? Icons.star : Icons.star_border;

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
            onPressed: () {
              final favoritingResult = ref
                  .read(favoriteMealsProvider.notifier)
                  .toggleMealFavoriteStatus(meal);
              ScaffoldMessengerState scaffoldMessengerState =
                  ScaffoldMessenger.of(context);
              scaffoldMessengerState.clearSnackBars();

              final snackBarText = favoritingResult == FavoritingResult.added
                  ? 'Meal added as a favorite'
                  : 'Meal removed';

              scaffoldMessengerState.showSnackBar(
                SnackBar(
                  content: Text(snackBarText),
                ),
              );
            },
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 3000),
              transitionBuilder: (child, animation) {
                return RotationTransition(
                  turns: Tween(begin: 1.0, end: 0.8).animate(animation),
                  child: child,
                );
              },
              child: Icon(
                favoriteIcon,
                key: ValueKey(isMealFavorite),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Hero(
            tag: meal.id,
            child: MealImage(imageUrl: meal.imageUrl),
          ),
          const SizedBox(height: 14),
          Text(
            'Ingredients',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 14),
          ...meal.ingredients.map(
            (ingredient) => Text(
              ingredient,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Steps',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 14),
          ...meal.steps.map(
            (ingredient) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: Text(
                ingredient,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
