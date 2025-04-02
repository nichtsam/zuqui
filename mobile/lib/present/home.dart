import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.logout),
        onPressed: () {
          context.go("/auth/login");
        },
      ),
      body: SafeArea(
        child: GridView.count(
          crossAxisCount: 2,
          padding: EdgeInsets.all(16),
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          children: List.generate(6, (index) {
            if (index == 5) {
              return Card(child: Icon(Icons.add, size: 64));
            }

            return Card(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Name",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Text("Subject"),
                    Text("Category"),
                    Text("Specification"),
                    Text("Difficulty"),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
