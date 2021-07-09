import 'package:sudoku_crypto/src/models/sudoku.dart';
import 'package:sudoku_crypto/src/models/database.dart';
import 'package:sudoku_crypto/src/blocs/current_sudoku.dart';
import 'package:sudoku_crypto/src/blocs/database_state.dart';
import 'package:sudoku_crypto/src/resources/communications.dart';
/*
  sending data using the packet handler class:
  test.send
*/
import 'dart:async';
import 'dart:convert';
import 'dart:io';

//Main class that will be globally accessible
class AppEngine {

  static List<List<int>> testGrid = [
    [1,2,3,0,5,6,0,8,9],
    [1,0,3,4,5,6,0,8,9],
    [1,2,3,4,0,6,7,8,0],
    [1,0,3,0,5,6,0,8,9],
    [1,2,3,0,5,6,0,8,9],
    [0,2,3,4,0,6,7,0,9],
    [1,0,3,4,5,0,7,8,9],
    [1,2,3,0,0,6,7,0,9],
    [1,0,3,0,5,6,0,8,9]
  ];

  //To hold all the database data
  Database database = Database();
  //To hold the user's solution of the database
  Sudoku currentSudoku = Sudoku(sudokuID: 0, grid: testGrid);
  //To hold the original sudoku problem received from the server
  Sudoku problemSudoku = Sudoku(sudokuID: 0, grid: testGrid);
  //To update the UI when the sudoku is changed by the user or server
  SudokuBLoC sudokuBLoC = SudokuBLoC();
  //To update the UI when the database changes
  DatabaseStateBLoC databaseStateBLoC = DatabaseStateBLoC();
  //To communicate with the server
  //TODO: Make the communications class with all the required function members
  late packetHandler test;
  void onData(RawSocketEvent event) {
    // and event handler for when a packet is received
    print("socket event");
    if (event == RawSocketEvent.read) {
      Datagram? rcv = test.socketConnection.receive();
      print("Received data" + ascii.decode(rcv!.data));
      packet_splitter pcktreceived = packet_splitter(ascii.decode(rcv.data));
      if (pcktreceived.type == "0") {
        //the MCU is updating the sudoku
        //TODO CONFIRM SUDOKUS ARE THE SAME ; ACCESS A STRING REPRESENTATIOON OF THE SUDOKU
        //RECEIVED USING COMMAND pcktreceived.sudoku;

      } else if (pcktreceived.type == "2") {
        //someone has completed the sudoku and won
        //TODO Update the database
        //access the person who solved with pcktreceived.solver the old sudoku id is pckreceive.id
      }
    }
  }

  int _selectedNumberID = 0;
  void set selectedNumberID (int s){
    _selectedNumberID = s;
    sudokuBLoC.updatedSudoku();
  }
  int get selectedNumberID => _selectedNumberID;

  AppEngine() {
    //Initializer for the class

  }

  void dispose() {
    //Deconstructor for the class
    sudokuBLoC.dispose();
    databaseStateBLoC.dispose();
  }

  void setNumber(int number) {
    int row = (selectedNumberID/9).truncate();
    int column = selectedNumberID%9;
    this.currentSudoku.grid[row][column] = number;
    sudokuBLoC.updatedSudoku();
  }

  bool checkSudokuComplete(Sudoku sudoku) {
    //TODO: Write code for checking if the sudoku is complete (all numbers present)

    return false;
  }

  bool checkSudokuCorrectness(Sudoku sudoku) {
    //TODO: Write code for checking if complete sudoku is correct

    return false;
  }
}
