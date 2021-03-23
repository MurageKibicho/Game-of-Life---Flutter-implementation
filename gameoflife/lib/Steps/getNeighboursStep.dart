import 'package:flutter/material.dart';
import 'dart:math' as Math;
//Get neghbours and test with print
class GameGrids extends StatefulWidget {
  @override
  _GameGridsState createState() => _GameGridsState();
}
const noOfCells = 150;

List stateValues = [0 ,1];

void resetGame() {

}
List randomCellState = List.generate(noOfCells, (index) =>
    Math.Random().nextInt(stateValues.length)
);
class _GameGridsState extends State<GameGrids> {

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
                   //print(getCellNeighbours(index));
                    getNeighbourState(getCellNeighbours(index));
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
              )
          ),
        ),
      ),
    );
  }
  List getCellNeighbours(int index){
    List cellNeighbours =[
      if(index == 0){
        index + 1, index + 10, index + 11
      }
      else if(index == 9) {
        index - 1, index + 9, index + 10
      }
      else if (index == 140){
          index - 10, index - 9, index + 1
        }
        else if (index == 149) {
            index - 1, index - 10, index - 11
          }
          else if(index < 10) {
              index + 1, index - 1, index + 10,
              index + 9, index + 11
            }
            else if(index > 10 && index < 139) {
                index + 1, index + 9, index + 10, index + 11,
                index - 1, index - 9, index - 10, index - 11
              }
              else if(index > 139) {
                  index + 1, index - 1, index - 11,
                  index - 10, index - 9
                }
                else if(index % 10 == 0) {
                    index  - 10, index - 9, index + 1,
                    index + 10, index + 11
                  }
                  else if(index % 10 == 9) {
                      index  - 11, index - 10, index - 1,
                      index + 9, index + 10
                    }
    ];
    return cellNeighbours;
  }
}
List getNeighbourState(List neighbours){
  int alive = 1;
  int dead = 0;
  List neighbourStates;
  for(int i = 0; i < neighbours.length; i++){
   neighbourStates =  randomCellState[neighbours[i]];
  }
  //print(neighbourStates);
  return neighbourStates;
}
