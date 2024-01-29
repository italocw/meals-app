import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_image.dart';
import 'package:meals_app/widgets/meal_item_trait.dart';

class MealItem extends StatelessWidget {
  const MealItem({super.key, required this.meal, required this.onTapping});

  final void Function(BuildContext context, Meal meal) onTapping;
  final Meal meal;

  String getTextFromEnum(Enum enumValue) =>
      enumValue.name[0].toUpperCase() + enumValue.name.substring(1);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.all(8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        splashColor: Theme.of(context).primaryColor,
        onTap: () {
          onTapping(context, meal);
        },
        child: Stack(
          children: [
            Hero(tag: meal.id, child: MealImage(imageUrl: meal.imageUrl)),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 44),
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MealItemTrait(
                            icon: Icons.schedule,
                            label: '${meal.duration} min'),
                        const SizedBox(width: 12),
                        MealItemTrait(
                            icon: Icons.work,
                            label: getTextFromEnum(meal.complexity)),
                        const SizedBox(width: 12),
                        MealItemTrait(
                            icon: Icons.schedule,
                            label: getTextFromEnum(meal.affordability)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
