import 'package:sudoku_crypto/src/models/sudoku.dart';
import 'package:sudoku_crypto/src/models/database.dart';
import 'package:sudoku_crypto/src/blocs/current_sudoku.dart';
import 'package:sudoku_crypto/src/blocs/database_state.dart';


//Main class that will be globally accessible
class AppEngine {

  //Test Grid to use
  static List<List<int>> testGrid = [
    [1,2,3,4,5,6,7,8,0],
    [1,2,3,4,5,0,7,8,9],
    [1,2,0,4,5,6,0,8,9],
    [1,2,3,4,5,6,7,8,9],
    [1,2,3,4,5,6,7,8,9],
    [1,2,3,4,5,6,7,8,9],
    [1,2,3,4,5,0,7,8,9],
    [1,2,3,0,5,6,7,8,9],
    [1,2,3,4,5,6,0,8,9]
  ];

  //To hold all the database data
  Database database = Database();
  //To hold the user's solution of the database
  Sudoku currentSudoku = Sudoku(
      sudokuID: 0,
      grid: testGrid
  );
  //To hold the original sudoku problem received from the server
  Sudoku problemSudoku = Sudoku(sudokuID:0, grid: testGrid);
  //To update the UI when the sudoku is changed by the user or server
  SudokuBLoC sudokuBLoC = SudokuBLoC();
  //To update the UI when the database changes
  DatabaseStateBLoC databaseStateBLoC = DatabaseStateBLoC();
  //To communicate with the server
  //TODO: Make the communications class with all the required function members

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