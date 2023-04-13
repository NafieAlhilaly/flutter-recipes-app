class Recipe {
  String name;
  String imageUrl;
  double? ratings;

  Recipe({this.name = "", this.imageUrl = "/", this.ratings}) {
    if (ratings != null) {
      ratings = ratings! * 10;
    } else {
      ratings = 0;
    }
  }
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
