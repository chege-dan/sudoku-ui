import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


class SudokuDatabase {
  late final Future<Database> database;

  Future<void> initializeDatabase () async {

    //Hard coding players into the database
    List<Player> player = [];
    player.add(Player(playerName: "Kezziah"));
    player.add(Player(playerName: "AlvyneZ"));
    player.add(Player(playerName: "Nigel"));
    player.add(Player(playerName: "Danson"));
    player.add(Player(playerName: "Lyn"));
    player.add(Player(playerName: "Bill"));
    player.add(Player(playerName: "Shawn"));
    player.add(Player(playerName: "Francis"));
    player.add(Player(playerName: "Ravine"));
    player.add(Player(playerName: "Sharon"));
    player.add(Player(playerName: "Nyokabi"));
    player.add(Player(playerName: "Medrine"));
    player.add(Player(playerName: "Fao"));
    player.add(Player(playerName: "Peris"));
    player.add(Player(playerName: "Gicheru"));
    player.add(Player(playerName: "Fiona"));
    player.add(Player(playerName: "Elisha"));
    player.add(Player(playerName: "Gibson"));
    player.add(Player(playerName: "Ngugi"));

    database = openDatabase(
      join(await getDatabasesPath(), 'sudoku_crypto.db'),
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE players(playerName VARCHAR[50] PRIMARY KEY, money INTEGER)',
        );
        await db.execute(
          'CREATE TABLE logs(sudokuID INTEGER PRIMARY KEY, playerWhoSolved VARCHAR[50] FOREIGN KEY REFERENCES players(playerName), moneyAwarded INTEGER)',
        );
        for (int i = 0; i < 19; i++){
          insertPlayer(player[i]);
        }
      },
      version: 1,
    );
  }

  // Define a function that inserts players into the database
  Future<void> insertPlayer(Player player) async {
    // Get a reference to the database.
    final db = await database;
    await db.insert(
      'players',
      player.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // A method that retrieves all the players from the players table.
  Future<List<Player>> players() async {
    // Get a reference to the database.
    final db = await database;

    // Query the table for all The Players.
    final List<Map<String, dynamic>> maps = await db.query('players');

    // Convert the List<Map<String, dynamic> into a List<Player>.
    return List.generate(maps.length, (i) {
      return Player(
        playerName: maps[i]['playerName'],
        money: maps[i]['money'],
      );
    });
  }

  // A method that retrieves a player from the players table.
  Future<Player?> getPlayer(String playerName) async {
    // Get a reference to the database.
    final db = await database;

    // Query the table for all The Players.
    final List<Map<String, dynamic>> maps = await db.query(
        'players',
        columns: ["playerName", "money"],
        where: 'playerName = ?',
        whereArgs: [playerName]
    );

    // Convert the first element of List<Map<String, dynamic> into a Player.
    if (maps.length > 0){
      return Player(
        playerName: maps[0]['playerName'],
        money: maps[0]['money'],
      );
    }
    return null;
  }

  Future<void> updatePlayer(Player player) async {
    // Get a reference to the database.
    final db = await database;

    // Update the given Player.
    await db.update(
      'players',
      player.toMap(),
      // Ensure that the Player has a matching name.
      where: 'playerName = ?',
      // Pass the Player's name as a whereArg to prevent SQL injection.
      whereArgs: [player.playerName],
    );
  }

  Future<void> deletePlayer(String playerName) async {
    // Get a reference to the database.
    final db = await database;

    // Remove the Player from the database.
    await db.delete(
      'players',
      // Use a `where` clause to delete a specific player.
      where: 'playerName = ?',
      // Pass the Player's name as a whereArg to prevent SQL injection.
      whereArgs: [playerName],
    );
  }

  // Define a function that inserts logs into the database
  Future<void> insertLog(Log log) async {
    // Get a reference to the database.
    final db = await database;
    await db.insert(
      'logs',
      log.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // A method that retrieves all the logs from the logs table.
  Future<List<Log>> logs() async {
    // Get a reference to the database.
    final db = await database;

    // Query the table for all The Logs.
    final List<Map<String, dynamic>> maps = await db.query('logs');

    // Convert the List<Map<String, dynamic> into a List<Log>.
    return List.generate(maps.length, (i) {
      return Log(
          sudokuID: maps[i]['sudokuID'],
          playerWhoSolved: maps[i]['playerWhoSolved'],
          moneyAwarded: maps[i]['moneyAwarded']
      );
    });
  }

  Future<void> updateLog(Log log) async {
    // Get a reference to the database.
    final db = await database;

    // Update the given Log.
    await db.update(
      'logs',
      log.toMap(),
      // Ensure that the log has a matching sudokuID.
      where: 'sudokuID = ?',
      // Pass the log's sudokuID as a whereArg to prevent SQL injection.
      whereArgs: [log.sudokuID],
    );
  }

  Future<void> deleteLog(int sudokuID) async {
    // Get a reference to the database.
    final db = await database;

    // Remove the log from the database.
    await db.delete(
      'logs',
      // Use a `where` clause to delete a specific log.
      where: 'sudokuID = ?',
      // Pass the log's sudokuID as a whereArg to prevent SQL injection.
      whereArgs: [sudokuID],
    );
  }

  Future<void> updateDatabase (int sudokuID, String playerName) async {
    const int moneyPerSudoku = 10;

    Player? playerToUpdate = await getPlayer(playerName);
    if (playerToUpdate == null) {
      return;
    }
    playerToUpdate.money += moneyPerSudoku;

    await updatePlayer(playerToUpdate);

    Log newLog = Log(sudokuID: sudokuID, playerWhoSolved: playerName, moneyAwarded: moneyPerSudoku);
    await insertLog(newLog);
  }
}


class Player {
  String playerName;
  int money;

  Player({
    required this.playerName,
    this.money = 0
  });

  Map<String, dynamic> toMap() {
    return {
      'playerName': playerName,
      'money': money,
    };
  }

  @override
  String toString() {
    return 'Player{playerName: $playerName, money: $money}';
  }
}

class Log {
  int sudokuID;
  String playerWhoSolved;
  int moneyAwarded;

  Log ({
    required this.sudokuID,
    required this.playerWhoSolved,
    required this.moneyAwarded
  });

  Map<String, dynamic> toMap() {
    return {
      'sudokuID': sudokuID,
      'playerWhoSolved': playerWhoSolved,
      'moneyAwarded': moneyAwarded,
    };
  }

  @override
  String toString() {
    return 'Log{sudokuID: $sudokuID, playerWhoSolved: $playerWhoSolved, moneyAwarded: $moneyAwarded}';
  }
}


class Database {
  //TODO: Write code for database
  //Use "List"

  String name = "";
  int amount = 0;
  DateTime? timestamp;

  void newEntry () {

  }
}