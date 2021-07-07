import 'dart:async';

import 'package:sudoku_crypto/src/models/sudoku.dart';

class CurrentSudokuBLoC {
  Sudoku sudoku = Sudoku();

  //Communications will call functions that will push the latest sudoku to the sink
  final StreamController<Sudoku> _currentSudokuController = StreamController<Sudoku>();

  //UI elements will listen to the stream to get the latest sudoku
  late Stream<Sudoku> outSudoku;

  CurrentSudokuBLoC() {
    //Initializer of the class
    outSudoku = _currentSudokuController.stream;
  }

  void dispose(){
    //Deconstructor of the class
    //closing socket so that we can prevent memory leaks
    _currentSudokuController.close();
  }

  void newSudoku (List<int> data){
    //When a new sudoku is received from the server

    //TODO: Write code for generating the sudoku from the data received

    _currentSudokuController.add(sudoku);
  }
}