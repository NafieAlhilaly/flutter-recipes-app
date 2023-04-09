import 'dart:convert';
import 'package:http/http.dart';
import 'package:recipes_app/models/recipe.dart';

class RecipeRequest {
  static const String baseUrl = "tasty.p.rapidapi.com";
  static const String recipesList = "recipes/list";
  static const String apiKey = String.fromEnvironment("API_KEY");
  static const String apiHost = String.fromEnvironment("API_HOST");

  static Future<Recipes> getRecipes(
      {required Client client,
      int from = 0,
      int size = 20,
      String? searchFor}) async {
    Response res = await client.get(
      Uri(scheme: "https", host: baseUrl, path: recipesList, queryParameters: {
        "from": from.toString(),
        "size": size.toString(),
        "q": searchFor
      }),
      headers: {"X-RapidAPI-Key": apiKey, "X-RapidAPI-Host": apiHost},
    );
    if (res.statusCode != 200) {
      throw Exception("Error while comunicating with APIs.");
    }

    dynamic data = jsonDecode(res.body)["results"];
    Recipes recipes = Recipes(recipes: []);
    for (var recipeBody in data) {
      double? score;
      dynamic userRatings = recipeBody["user_ratings"];
      if (userRatings != null) {
        score = userRatings["score"] + .0;
      }
      Recipe recipe = Recipe(
          imageUrl: recipeBody["thumbnail_url"],
          name: recipeBody["name"],
          ratings: score);
      recipes.add(recipe);
    }

    return recipes;
  }
}
