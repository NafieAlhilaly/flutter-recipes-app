import 'package:flutter/material.dart';
import 'package:recipes_app/models/recipe.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;
  const RecipeCard({super.key, required this.recipe});
  final double cardWidth = 360;
  final double heartIconWidth = 40;

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
                  fit: BoxFit.fitWidth,
                  height: 300,
                  width: cardWidth + 10,
                  errorBuilder: ((context, error, stackTrace) {
                    return const Text("recipe iamge");
                  }),
                ),
                SizedBox(
                  width: cardWidth,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Opacity(
                          opacity: 0.8,
                          child: Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Container(
                              width: 60.0,
                              height: 60.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey[800],
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 5,
                                    blurRadius: 15,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Opacity(
                                opacity: 1.0,
                                child: IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.favorite_outline_rounded,
                                      size: heartIconWidth,
                                      color: Colors.white,
                                    )),
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 70,
              width: cardWidth - 10,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                        flex: 3,
                        child: Text(
                          recipe.name,
                          overflow: TextOverflow.clip,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        )),
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
