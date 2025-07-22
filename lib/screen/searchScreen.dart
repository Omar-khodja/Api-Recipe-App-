import 'package:flutter/material.dart';
import 'package:recipe_app/widget/searchbar.dart';

class Searchscreen extends StatefulWidget {
  const Searchscreen({super.key});
  @override
  State<Searchscreen> createState() => _SearchscreenState();
}

class _SearchscreenState extends State<Searchscreen> {
    late final TextEditingController _searchControler;
    @override
dispose() {
    super.dispose();
    _searchControler.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Searchtextfailed(controller: _searchControler,),
      ),);

  }
}