import 'package:flutter/material.dart';
import 'package:projeto_modulo_4/widgets/CustomNavBar.dart';


class CategoryPage extends StatelessWidget{
  
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomNavBar(),
    );
  }
}