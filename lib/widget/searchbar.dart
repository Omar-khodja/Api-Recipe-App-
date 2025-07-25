import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/provider/mealApiProvider.dart';

class Searchtextfailed extends ConsumerWidget {
  const Searchtextfailed({super.key,required this.controller});
  final TextEditingController controller;
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white, fontSize: 18),
      autofocus: false,
      decoration: InputDecoration(
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primaryContainer, width: 1),
          ),
        hintText: "Search...",
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        fillColor: Theme.of(context).colorScheme.onPrimary,
        filled: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(13)),
      ),
      onSubmitted: (value) {
        if(value.trim().isEmpty) {
          return;
        }
        ref.read(mealApiProvider.notifier).searchByName(controller.text);
      },
    );
  }
}