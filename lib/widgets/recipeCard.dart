import 'package:flutter/material.dart';
import 'package:recipes_app/models/recipe.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;
  const RecipeCard({super.key, required this.recipe});
  final double cardWidth = 360;
  final double heartIconWidth = 60;

  @override
  Widget build(BuildContext context) {
    return Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 9,
        child: Column(
          children: [
            Stack(
              children: [
                Image.network(
                  recipe.imageUrl,
                  fit: BoxFit.fill,
                ),
                SizedBox(
                  width: cardWidth - 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.favorite_outline_rounded,
                            size: heartIconWidth,
                            color: Colors.white,
                          ))
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 70,
              width: cardWidth - 10,
              child: Row(children: [
                Text(
                  recipe.name,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    const Icon(
                      Icons.thumb_up,
                      color: Colors.blue,
                    ),
                    Text(recipe.ratings.toString())
                  ],
                )
              ]),
            ),
          ],
        ));
  }
}
