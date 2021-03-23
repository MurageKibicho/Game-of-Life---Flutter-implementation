//draw grid with numbers
import 'package:flutter/material.dart';

class GameGrida extends StatefulWidget {
  @override
  _GameGridaState createState() => _GameGridaState();
}
const noOfCells = 100;
class _GameGridaState extends State<GameGrida> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: screenHeight,
        width: screenWidth,
        color: Colors.grey,
        child: GridView.count(
          crossAxisCount: 10,
          children:List.generate(noOfCells, (index) =>
          (index % 2 == 0) ?
          Container(
            height: screenHeight /10,
            width: screenWidth / 10,
            color: Colors.black,
            child: Center(
              child: Text(
                "$index",
                style: TextStyle(
                    color: Colors.white
                ),
              ),
            ),
          )
              :
          Container(
            height: screenHeight /10,
            width: screenWidth / 10,
            color: Colors.white,
            child: Center(
              child: Text(
                "$index",
                style: TextStyle(
                    color: Colors.black
                ),
              ),
            ),
          ),
          ),
        ),
      ),
    );
  }
}
