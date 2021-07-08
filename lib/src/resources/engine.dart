import 'package:sudoku_crypto/src/models/sudoku.dart';
import 'package:sudoku_crypto/src/models/database.dart';
import 'package:sudoku_crypto/src/blocs/current_sudoku.dart';
import 'package:sudoku_crypto/src/blocs/database_state.dart';


//Main class that will be globally accessible
class AppEngine {
  //To hold all the database data
  Database database = Database();
  //To hold the user's solution of the database
  Sudoku currentSudoku = Sudoku();
  //To hold the original sudoku problem received from the server
  Sudoku problemSudoku = Sudoku();
  //To update the UI when the sudoku is changed by the user or server
  SudokuBLoC sudokuBLoC = SudokuBLoC();
  //To update the UI when the database changes
  DatabaseStateBLoC databaseStateBLoC = DatabaseStateBLoC();
  //To communicate with the server
  //TODO: Make the communications class with all the required function members

  AppEngine() {
    //Initializer for the class

  }

  void dispose() {
    //Deconstructor for the class
    sudokuBLoC.dispose();
    databaseStateBLoC.dispose();
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