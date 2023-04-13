import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recipes_app/models/recipe.dart';
import 'package:recipes_app/widgets/recipeCard.dart';

void main() {
  testWidgets("Test creating recipe card with ratings", (tester) async {
    // Arrange
    Recipe recipe = Recipe(name: "ma3sob", imageUrl: '', ratings: 0.1);

    // Act
    await tester.pumpWidget(MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text(""),
        ),
        body: Center(
          child: RecipeCard(recipe: recipe),
        ),
      ),
    ));
    final nameFinder = find.text(recipe.name);
    final ratingsFinder = find.text(recipe.ratings.toString());

    // Assert
    expect(nameFinder, findsOneWidget);
    expect(ratingsFinder, findsOneWidget);
  });

  testWidgets("Test creating recipe card without ratings", (tester) async {
    // Arrange
    Recipe recipe = Recipe(name: "ma3sob", imageUrl: '');
    String defaultRating = "0.0";

    // Act
    await tester.pumpWidget(MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text(""),
        ),
        body: Center(
          child: RecipeCard(recipe: recipe),
        ),
      ),
    ));
    final nameFinder = find.text(recipe.name);
    final ratingsFinder = find.text(defaultRating);

    // Assert
    expect(nameFinder, findsOneWidget);
    expect(ratingsFinder, findsOneWidget);
  });
}
