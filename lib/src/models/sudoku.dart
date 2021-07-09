class Sudoku {
  int sudokuID;
  late List<List<int>> grid;

  //TODO: Add the extra properties for the sudoku

  Sudoku({required this.sudokuID, required List<List<int>> grid}) {
    //Initializer for the class
    this.grid = [];
    List<int> temp = [];
    for (List<int> l in grid) {
      temp.addAll(l);
      this.grid.add(temp);
      temp = [];
    }
  }

  /*
    Methods for the sudoku class
  */

  void updateSudoku(String data) {
    //When a new sudoku is received from the server

    //TODO: Write code for generating the sudoku from the data received
    data = data + "";
  }

  List<List<int>> getBoxFormatGrid() {
    //Function to return a 2D array of the grid for each box for the UI output
    List<List<int>> boxFormatGrid = [];
    List<int> temp = [];

    for (int b = 0; b < 9; b++) {
      for (int n = 0; n < 9; n++) {
        int row = ((b / 3).truncate() * 3) + ((n / 3).truncate());
        int column = ((b % 3) * 3) + (n % 3);
        temp.add(this.grid[row][column]);
      }
      boxFormatGrid.add(temp);
      temp = [];
    }
    return boxFormatGrid;
  }

  List<List<bool>> getZeros() {
    List<List<bool>> zeros = [];
    List<bool> temp = [];

    for (int b = 0; b < 9; b++) {
      for (int n = 0; n < 9; n++) {
        int row = ((b / 3).truncate() * 3) + ((n / 3).truncate());
        int column = ((b % 3) * 3) + (n % 3);
        temp.add((this.grid[row][column]) == 0);
      }
      zeros.add(temp);
      temp = [];
    }

    return zeros;
  }

  bool checkSectionCorrectness(List<int> data) {
    //given either a row column or box check if it is complete and correct
    if (data.length != 9) {
      return false;
    }
    data.sort();
    for (var x = 0; x < 9; ++x) {
      if (data[x] != x + 1) {
        return false;
      }
    }
    return true;
  }

  bool checkRows() {
    for (int i = 0; i < 9; ++i) {
      List<int> currow = [];
      for (int j = 0; j < 9; ++j) {
        currow.add(this.grid[i][j]);
      }
      if (!checkSectionCorrectness(currow)) {
        return false;
      }
    }
    return true;
  }

  bool checkColumns() {
    for (int i = 0; i < 9; ++i) {
      List<int> col = [];
      for (int j = 0; j < 9; ++j) {
        col.add(this.grid[j][i]);
      }
      if (!checkSectionCorrectness(col)) {
        return false;
      }
    }
    return true;
  }

  bool checkBoxes() {
    for (int i = 0; i < 9; i += 3) {
      for (int j = 0; j < 9; j += 3) {
        List<int> box = [];
        for (int x = i; x < i + 3; ++x) {
          for (int y = j; y < j + 3; ++y) {
            box.add(this.grid[x][y]);
          }
        }
        if (!checkSectionCorrectness(box)) {
          return false;
        }
      }
    }
    return true;
  }

  bool checkSudokuCorrectness() {
    if (!this.checkRows()) {
      return false;
    }
    if (!this.checkColumns()) {
      return false;
    }
    if (!this.checkBoxes()) {
      return false;
    }
    return true;
  }
}
