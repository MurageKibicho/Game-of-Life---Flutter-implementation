import 'package:flutter/material.dart';
import 'dart:math' as Math;

class GameGriqd extends StatefulWidget {
  @override
  _GameGriqdState createState() => _GameGriqdState();
}
const noOfCells = 150;

List stateValues = [0 ,1];

void resetGame() {

}

class _GameGriqdState extends State<GameGriqd> {
  List randomCellState = new List();
  @override
  void initState() {
    super.initState();
    randomCellState = List.generate(noOfCells, (index) =>
        Math.Random().nextInt(stateValues.length)
    );
    resetGame();
  }
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    //print(randomCellState);
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
                    List newCellState = new List();
                    for(int i = 0; i < noOfCells; i++){
                      List neighbours = getCellNeighbours(i);
                      List neighbourStates = getNeighbourState(neighbours);
                      // print(neighbours);
                      //print(neighbourStates);
                      //print(checkRules(neighbourStates));
                      int newValue = checkRules( i, neighbourStates);
                      newCellState.insert(i, newValue);
                      print(i);
                    }
                    setState(() {
                      randomCellState.clear();
                      randomCellState = newCellState;
                    });
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
        index - 11, index - 10, index - 1
      ];
    }
    else if(index < 10) {
      cellNeighbours = [
        index - 1, index + 1, index + 9,
        index + 10, index + 11
      ];
    }
    else if(index % 10 == 9) {
      cellNeighbours = [
        index  - 11, index - 10, index - 1,
        index + 9, index + 10
      ];
    }
    else if(index % 10 == 0) {
      cellNeighbours = [
        index  - 10, index - 9, index + 1,
        index + 10, index + 11
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
        index - 11, index - 10, index - 9,
        index - 1, index + 1,

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
  int checkRules(int currentElement ,List neighbourStates) {
    bool alive = false;
    int count = 0;
    int aliveOrDead = randomCellState.elementAt(currentElement);
    if (aliveOrDead == 1){
      alive = true;
    }
    for(int i = 0; i <neighbourStates.length; i++ ){
      int indexState = neighbourStates.elementAt(i);
      if(indexState == 1){
        count++;
      }
    }
    //Overpopulation
    //Dies if surrounded by more than 3 living cells
    if(alive && count > 3){
      return 0;
    }
    //Stasis
    //Survives if surrounded by 2 or 3 living cells
    else if(alive && count >= 2 && count <= 3){
      return 1;
    }
    //Underpopulation
    //Dies if surrounded by less than 2 cells
    else if(alive && count < 2){
      return 0;
    }
    //Reproduction(dead cells)
    //Lives if surrounded by 3 alive
    else if(!alive && count == 3){
      return 1;
    }
  }
  void setNewValues(){
    setState(() {

    });
  }
}
