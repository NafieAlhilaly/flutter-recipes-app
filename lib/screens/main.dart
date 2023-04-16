import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:recipes_app/models/recipe.dart';
import 'package:recipes_app/network/api/recipeRequest.dart';
import 'package:recipes_app/widgets/recipeCard.dart';

class App extends StatelessWidget {
  final Client client;
  const App({super.key, required this.client});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipes',
      theme: ThemeData(primarySwatch: Colors.red),
      home: MainScreen(
        title: 'Recipes',
        client: client,
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, required this.title, required this.client});
  final String title;
  final Client client;

  @override
  State<MainScreen> createState() => _MainScreenState(client: client);
}

class _MainScreenState extends State<MainScreen> {
  final Client client;
  _MainScreenState({required this.client});
  TextEditingController _textEdit = TextEditingController();
  late Future<Recipes> recipes;
  bool isSearchActive = false;

  @override
  void initState() {
    super.initState();
    recipes = RecipeRequest.getRecipes(client: client);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          title: isSearchActive
              ? Card(
                  child: TextField(
                    controller: _textEdit,
                    decoration: const InputDecoration(
                      hintText: 'Search...',
                      border: InputBorder.none,
                    ),
                    onSubmitted: (value) {
                      setState(() {
                        recipes = RecipeRequest.getRecipes(
                            client: client,
                            searchFor: _textEdit.text.toString());
                      });
                    },
                  ),
                )
              : const Text("Recipefy"),
          actions: [
            isSearchActive
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        isSearchActive = false;
                      });
                    },
                    icon: const Icon(Icons.close))
                : IconButton(
                    onPressed: () {
                      setState(() {
                        isSearchActive = true;
                      });
                    },
                    icon: const Icon(Icons.search))
          ],
        ),
        body: FutureBuilder<Recipes>(
            future: recipes,
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: ListView.builder(
                      itemCount: snapshot.data!.get().length,
                      itemBuilder: ((context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child:
                              RecipeCard(recipe: snapshot.data!.get()[index]),
                        );
                      })),
                );
              }
              if (snapshot.hasError) {
                return const Text("Error occured while fetching reciepes!");
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Center(
                    child: CircularProgressIndicator(),
                  )
                ],
              );
            })));
  }
}
