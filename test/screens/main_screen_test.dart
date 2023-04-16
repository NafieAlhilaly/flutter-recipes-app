import 'package:flutter_test/flutter_test.dart';
import 'dart:convert';
import 'package:http/testing.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:recipes_app/screens/main.dart';
import 'package:flutter/material.dart';

void main() {
  Uri uri = Uri(
      scheme: "https",
      host: "tasty.p.rapidapi.com",
      path: "recipes/list",
      queryParameters: {"from": "0", "size": "3", "q": ""});
  testWidgets("Test loading recipes success", (tester) async {
    await tester.runAsync(() async {
      // Arrange
      int ok = 200;
      Map<String, dynamic> mockResponseBody = {
        "count": 3,
        "results": [
          {
            "name": "recipe 1",
            "thumbnail_url":
                "https://img.buzzfeed.com/thumbnailer-prod-us-east-1/video-api/assets/437985.jpg",
            "user_ratings": {"score": 1}
          },
          {
            "name": "recipe 2",
            "thumbnail_url":
                "https://img.buzzfeed.com/thumbnailer-prod-us-east-1/video-api/assets/436838.jpg",
          },
          {
            "name": "recipe 3",
            "thumbnail_url":
                "https://img.buzzfeed.com/thumbnailer-prod-us-east-1/video-api/assets/436869.jpg",
            "user_ratings": {"score": 0.898}
          }
        ]
      };
      final client = MockClient(
          (_) async => http.Response(json.encode(mockResponseBody), ok));

      // Act
      when(client.get(uri).then((value) => value.body));
      await tester.pumpWidget(App(
        client: client,
      ));
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      await tester.pumpAndSettle();
      final recipe1NameFinder = find.text("recipe 1");
      final recipe2NameFinder = find.text("recipe 2");
      final recipe3NameFinder = find.text("recipe 3");
      final recipe1RatingsFinder = find.text("10.0");
      final recipe2RatingsFinder = find.text("0.0");
      final recipe3RatingsFinder = find.text("8.98");

      // Assert
      expect(recipe1NameFinder, findsOneWidget);
      expect(recipe2NameFinder, findsOneWidget);
      expect(recipe3NameFinder, findsOneWidget);
      expect(recipe1RatingsFinder, findsOneWidget);
      expect(recipe2RatingsFinder, findsOneWidget);
      expect(recipe3RatingsFinder, findsOneWidget);
    });
  });

  testWidgets("Test loading recipes error", (tester) async {
    // Arrange
    int error = 500;
    Map<String, dynamic> mockResponseBody = {};
    final client = MockClient(
        (_) async => http.Response(json.encode(mockResponseBody), error));

    // Act
    when(client.get(uri).then((value) => value.body));
    await tester.pumpWidget(App(
      client: client,
    ));
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    await tester.pump(const Duration(seconds: 1));
    final recipe1NameFinder = find.text("recipe 1");
    final recipe2NameFinder = find.text("recipe 2");
    final recipe3NameFinder = find.text("recipe 3");
    final recipe1RatingsFinder = find.text("1.0");
    final recipe2RatingsFinder = find.text("0.0");
    final recipe3RatingsFinder = find.text("8.98");
    final recipeNotRecieviedFinter =
        find.text("Error occured while fetching reciepes!");

    // Assert
    expect(recipe1NameFinder, findsNothing);
    expect(recipe2NameFinder, findsNothing);
    expect(recipe3NameFinder, findsNothing);
    expect(recipe1RatingsFinder, findsNothing);
    expect(recipe2RatingsFinder, findsNothing);
    expect(recipe3RatingsFinder, findsNothing);
    expect(recipeNotRecieviedFinter, findsOneWidget);
  });
}
