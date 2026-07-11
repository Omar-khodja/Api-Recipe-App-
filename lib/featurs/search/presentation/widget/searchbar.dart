import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/featurs/search/presentation/controler/search_notifire_provider.dart';

class Searchtextfailed extends ConsumerWidget {
  const Searchtextfailed({super.key,required this.controller});
  final TextEditingController controller;
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return TextField(
      controller: controller,
      style: Theme.of(context).textTheme.titleMedium,
      autofocus: true,
      decoration: InputDecoration(
        
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primaryContainer, width: 1),
          ),
        hintText: "Search...",
        
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        fillColor: Theme.of(context).colorScheme.surfaceContainer,
        prefixIcon: const Icon(Icons.search),
        filled: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
      ),
      onChanged: (value) {
        if(value.trim().isEmpty) {
          return;
        }
        ref.read(searchNotifireProvider.notifier).searchByName(controller.text);
      },
    );
  }
}