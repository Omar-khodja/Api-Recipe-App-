import 'package:flutter/material.dart';

class MealcardContent extends StatelessWidget {
  const MealcardContent({super.key,required this.iCon,required this.title});
  final IconData iCon;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Icon(iCon),
      const SizedBox(width: 3,),
      Text(title,style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),)
    ],);
  }
}