import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/testing.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:recipes_app/models/recipe.dart';
import 'package:recipes_app/network/api/recipeRequest.dart';

@GenerateMocks([http.Client])
void main() {
  test("Test get recipes successfully", () async {
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
    Uri uri = Uri(
        scheme: "https",
        host: "tasty.p.rapidapi.com",
        path: "recipes/list",
        queryParameters: {"from": "0", "size": "3", "q": ""});
    // Act
    when(client.get(uri).then((value) => value.body));
    Recipes recipes =
        await RecipeRequest.getRecipes(client: client, from: 0, size: 3);

    //Assert
    expect(mockResponseBody["results"].length, recipes.get().length);
  });
}
