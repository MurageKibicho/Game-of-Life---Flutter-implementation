import 'package:flutter/material.dart';
import 'dart:math' as Math;

class GameGridq extends StatefulWidget {
  @override
  _GameGridqState createState() => _GameGridqState();
}
const noOfCells = 150;

List stateValues = [0 ,1];

void resetGame() {

}

class _GameGridqState extends State<GameGridq> {
  List randomCellState = List.generate(noOfCells, (index) =>
      Math.Random().nextInt(stateValues.length)
  );
  @override
  void initState() {
    super.initState();
    resetGame();
  }
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    print(randomCellState);
    return Scaffold(
      body: Container(
        height: screenHeight,
        width: screenWidth,
        color: Colors.grey,
        child: GridView.count(
          crossAxisCount: 10,
          children:List.generate(noOfCells, (index) =>
              Container(
                height: screenHeight /10,
                width: screenWidth / 10,
                color: (randomCellState[index]  == 0) ?
                Colors.white : Colors.black,
                child: GestureDetector(
                  onTap: (){
                    List neighbours = getCellNeighbours(index);
                    print(getCellNeighbours(index));
                    print(getNeighbourState(neighbours));
                  },
                  child: Center(
                    child: Text(
                      "$index",
                      style: TextStyle(
                          color:(randomCellState[index]  == 0) ?
                          Colors.black : Colors.white
                      ),
                    ),
                  ),
                ),
              ),
          ),
        ),
      ),
    );
  }
  List getCellNeighbours(int index){
    List cellNeighbours;
    if(index == 0){
      cellNeighbours = [
        index + 1, index + 10, index + 11
      ];
    }
    else if(index == 9) {
      cellNeighbours = [
        index - 1, index + 9, index + 10
      ];
    }
    else if (index == 140){
      cellNeighbours = [
        index - 10, index - 9, index + 1
      ];
    }
    else if (index == 149) {
      cellNeighbours = [
        index - 1, index - 10, index - 11
      ];
    }
    else if(index < 10) {
      cellNeighbours = [
        index + 1, index - 1, index + 10,
        index + 9, index + 11
      ];
    }
    else if(index > 10 && index < 139) {
      cellNeighbours = [
        index + 1, index + 9, index + 10, index + 11,
        index - 1, index - 9, index - 10, index - 11
      ];
    }
    else if(index > 139) {
      cellNeighbours = [
        index + 1, index - 1, index - 11,
        index - 10, index - 9
      ];
    }
    else if(index % 10 == 0) {
      cellNeighbours = [
        index  - 10, index - 9, index + 1,
        index + 10, index + 11
      ];
    }
    else if(index % 10 == 9) {
      cellNeighbours = [
        index  - 11, index - 10, index - 1,
        index + 9, index + 10
      ];
    }
    return cellNeighbours;
  }
  List getNeighbourState(List neighbours){
    List neighbourStates = new List();
    int deadOrAlive;
    for(int i = 0; i < neighbours.length; i++){
      int indexValue = neighbours.elementAt(i);
      deadOrAlive = randomCellState[indexValue];
      neighbourStates.insert(i, deadOrAlive);
    }
    return neighbourStates;
  }
}
