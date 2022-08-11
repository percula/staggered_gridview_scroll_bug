import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class Category {
  final String title;
  final List<String> children;

  const Category({
    required this.title,
    required this.children,
  });

}

class MyHomePage extends StatelessWidget {

  const MyHomePage({Key? key}) : super(key: key);

  List<Widget> makeCategorySlivers(Category category) {
    final header = SliverToBoxAdapter(child: Text(category.title, style: const TextStyle(fontSize: 24),));
    final grid = SliverMasonryGrid.extent(
      maxCrossAxisExtent: 200,
      childCount: category.children.length,
      itemBuilder: (BuildContext context, int i) {
        final item = category.children[i];
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(item)),);
      },
    );
    return [header, grid];
  }

  @override
  Widget build(BuildContext context) {
    final slivers = <Widget>[];
    final categories = List.generate(100, (index) => Category(
        title: "Category $index",
        children: List.generate(8, (index) => lorem(paragraphs: 2, words: 30))
    ));
    for (var category in categories) {
      slivers.addAll(makeCategorySlivers(category));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Title"),
      ),
      body: CustomScrollView(
        slivers: slivers,
      )
    );
  }
}