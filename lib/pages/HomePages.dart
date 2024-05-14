import 'package:flutter/material.dart';
import 'package:projeto_modulo_4/widgets/CustomNavBar.dart';
import 'package:projeto_modulo_4/widgets/NewMoviesWidget.dart';
import 'package:projeto_modulo_4/widgets/NewSeriesWidget.dart';
import 'package:projeto_modulo_4/widgets/UpcomingWidget.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView( 
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 18, horizontal: 10),
              child: Row(
                children: [
                  Column(
                    children: [
                      Text(
                        "Cinesquad",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Container(
              height: 60,
              padding: EdgeInsets.all(9),
              margin: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Color(0xFF292B37),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.search,
                    color: Colors.white54,
                    size: 30,
                  ),
                  Container(
                    width: 300,
                    margin: EdgeInsets.only(left: 5),
                    child: TextFormField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Buscar",
                        hintStyle: TextStyle(color: Colors.white54),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            UpcomingWidget(),
            SizedBox(height: 30),
            NewMoviesWidget(),
            SizedBox(height: 30),
            NewSeriesWidget(),
            SizedBox(height: 40),
          ],
        ),
      ),
      // bottomNavigationBar: CustomNavBar(),
    );
  }
}
