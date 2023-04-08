class Recipe {
  String name;
  String imageUrl;
  double? ratings;

  Recipe({this.name = "", this.imageUrl = "/", this.ratings});
}

class Recipes {
  List<Recipe> recipes;

  Recipes({required this.recipes});

  List<Recipe> get() {
    return recipes;
  }

  void add(Recipe recipe) {
    recipes.add(recipe);
  }
}
