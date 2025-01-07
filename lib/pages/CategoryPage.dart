import 'package:flutter/material.dart';
import 'package:tvabertaflix/widgets/CustomNavBar.dart';


class CategoryPage extends StatelessWidget{
  const CategoryPage({super.key});

  
   @override
  Widget build(BuildContext context) {
    return const Scaffold(
      bottomNavigationBar: CustomNavBar(),
    );
  }
}