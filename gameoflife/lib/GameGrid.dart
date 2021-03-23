import 'package:flutter/material.dart';
import 'dart:math' as Math;
import 'dart:async';

class GameGrid extends StatefulWidget {
  @override
  _GameGridState createState() => _GameGridState();
}
const noOfCells = 150;

List stateValues = [0 ,1];

void resetGame() {

}

class _GameGridState extends State<GameGrid>{
  String now;
  Timer everySecond;
  List randomCellState = new List();
  @override
  void initState() {
    super.initState();
    //growth pattern
    randomCellState = [
      0, 0, 0, 0, 0 ,0, 0, 0, 0, 0,
      0, 0, 0, 0, 0 ,0, 0, 0, 0, 0,
      0, 0, 0, 0, 0 ,0, 0, 1, 0, 0,
      0, 0, 0, 0, 0 ,0, 0, 1, 1, 0,
      0, 0, 0, 0, 0 ,0, 1, 1, 0, 0,
      0, 0, 0, 0, 0 ,0, 1, 0, 0, 0,
      0, 0, 0, 0, 1 ,0, 1, 0, 0, 0,
      0, 0, 1, 0, 1 ,0, 0, 0, 0, 0,
      0, 0, 0, 0, 0 ,0, 0, 0, 0, 0,
      0, 0, 0, 0, 0 ,0, 0, 0, 0, 0,
      0, 0, 0, 0, 0 ,0, 0, 0, 0, 0,
      0, 0, 0, 0, 0 ,0, 0, 0, 0, 0,
      0, 0, 0, 0, 0 ,0, 0, 0, 0, 0,
      0, 0, 0, 0, 0 ,0, 0, 0, 0, 0,
      0, 0, 0, 0, 0 ,0, 0, 0, 0, 0,
    ];
    now = DateTime.now().toString();
    everySecond = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        now = DateTime.now().toString();
        List newCellState = new List();
        for(int i = 0; i < noOfCells; i++){
          List neighbours = getCellNeighbours(i);
          List neighbourStates = getNeighbourState(neighbours);
          // print(neighbours);
          print(neighbourStates);
          //print(checkRules(index, neighbourStates));
          int newValue = checkRules(i, neighbourStates);
          newCellState.insert(i, newValue);
          print("index ${i}, state{$newValue}}");
        }
        randomCellState.clear();
        randomCellState = newCellState;


      });
    });
    resetGame();
  }
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    //print(randomCellState);
    return Scaffold(
      body: Stack(
        children: <Widget>[
           Container(
            height: screenHeight,
            width: screenWidth,
            color: Colors.grey,
            child: GridView.count(
              crossAxisCount: 10,
              children:List.generate(noOfCells, (index) =>
                  Container(
                    height: screenHeight /10,
                    width: screenWidth / 10,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: (randomCellState[index]  == 0) ?
                      Color(0xFF002147).withOpacity(0.2) : Color(0xFF002147),
                    ),

                  ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Text(
              "Game of Life\nComments in source",
              style: TextStyle(
                fontSize: 30,
                color: Colors.black.withOpacity(0.9),
                letterSpacing: 1
              ),
            ),
          ),
        ],
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
    else {
      alive = false;
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
    else if(alive && (count > 1 && count < 4)){
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
    else{
      return 0;
    }

  }
  void setNewValues(){
    setState(() {

    });
  }
}
