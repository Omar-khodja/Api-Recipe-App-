import 'package:flutter/material.dart';
import 'package:recipe_app/servise/apiService.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final api = Apiservice();
  @override
  void initState() {
    // TODO: implement initState
    api.featchData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test", style: Theme.of(context).textTheme.titleLarge),

      ),
      
    );
  }
}
