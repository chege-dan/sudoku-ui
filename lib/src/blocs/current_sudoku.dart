import 'dart:async';

class SudokuBLoC {

  //When a new problem sudoku is received, an arbitrary int can be pushed into
  //  this stream controller to tell the UI to update
  final StreamController<int> _problemSudokuController = StreamController<int>();
  //When the user updates their solution, an arbitrary int can be pushed into
  //  this stream controller to tell the UI to update
  final StreamController<int> _currentSudokuController = StreamController<int>();

  //UI elements will listen to the stream to know when the problem sudoku has changed
  late Stream<int> probSudoku;
  //UI elements will listen to the stream to know when the current sudoku has changed
  late Stream<int> curSudoku;

  SudokuBLoC() {
    //Initializer of the class
    probSudoku = _problemSudokuController.stream;
    curSudoku = _currentSudokuController.stream;
  }

  void dispose(){
    //Deconstructor of the class
    //closing sockets so that we can prevent memory leaks
    _problemSudokuController.close();
    _currentSudokuController.close();
  }

  void newSudoku () {
    //When a new problem sudoku is received from the server
    //Adding an arbitrary integer to the stream controller
    _problemSudokuController.add(1);
  }

  void updatedSudoku () {
    //When the user updates their sudoku solution
    //Adding an arbitrary integer to the stream controller
    _currentSudokuController.add(1);
  }
}