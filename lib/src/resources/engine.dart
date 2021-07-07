import 'package:sudoku_crypto/src/models/sudoku.dart';
import 'package:sudoku_crypto/src/models/database.dart';
import 'package:sudoku_crypto/src/blocs/current_sudoku.dart';


//Main class that will be globally accessible
class Engine {
  CurrentSudokuBLoC currentSudokuBLoC = CurrentSudokuBLoC();

  Engine() {
    //Initializer for the class

  }

  void dispose() {
    //Deconstructor for the class
    currentSudokuBLoC.dispose();
  }
}