<<<<<<< HEAD
import "tower/towerAdmin.dart";
import "level/levelAdmin.dart";
import "field.dart";
import "dart:io";
import "../view/view.dart";
import "player.dart";

class game {
  TowerAdmin tAdmin;
  LevelAdmin lAdmin;
  File levels;
  Map<String, Field> board;
  Map<int, String> images;
  final row = 22;
  final col = 22;
  View view;
  Player player;

  game() {
    //TODO: Enter concrete FilePath
    this.levels = new File(Platform.script.toFilePath());
    this.tAdmin = new TowerAdmin();
    this.lAdmin = new LevelAdmin(levels);
    this.board = new Map<String, Field>();
  }
  /**
   * 
   */
  void startGame() {
    this.board = lAdmin.createBoard(this.row, this.col);
    this.view = new View(convertBoard());
    this.player = new Player(this.view.getPlayerName().toString());
  }
  /**
   * 
   */
  void runGame() {}
  /**
   * 
   */
  void endOfGame() {}
  /**
   * 
   */
  void updateView() {}
  /**
   * 
   */
  void endOfLevel() {}
  /**
   * 
   */
  void calculateHighScore() {}
  /**
   * converts the Map from <String, Field> to <String, String> to create a HTML-Table
   */
  Map<String, String> convertBoard() {
    Map<String, String> htmlBoard = new Map<String, String>();
    String keySet;
    var str;
    this.board.forEach((key, value) {
      keySet = value.getX().toString() + " " + value.getY().toString();
      str = keySet.split(" ");
      htmlBoard.putIfAbsent(str[0], () => str[1]);
    });
    return htmlBoard;
  }
}
=======
import "tower/towerAdmin.dart";
import "level/levelAdmin.dart";
import "field.dart";
import "dart:io";
import "../view/view.dart";

class Game {
  TowerAdmin tAdmin;
  LevelAdmin lAdmin;
  File levels;
  Map<Field, String> board;
  Map<int, String> images;
  final row = 22;
  final col = 22;
  View view;

  Game() {
    //TODO: Enter concrete FilePath
    //this.levels = new File(Platform.script.toFilePath());
    this.tAdmin = new TowerAdmin();
    //this.lAdmin = new LevelAdmin(levels);
    this.board = new Map<Field, String>();
    this.view;
  }
  /**
   * 
   */
  void startGame() {
    this.board = lAdmin.createBoard(this.row, this.col);
    this.view = new View(row, col);
  }
  /**
   * 
   */
  void runGame() {}
  /**
   * 
   */
  void endOfGame() {}
  /**
   * 
   */
  void updateView() {
    view.updateBoard(convertBoard());
  }
  /**
   * s
   */
  void endOfLevel() {}
  /**
   * 
   */
  void calculateHighScore() {}
  /**
   * converts the Map from <String, Field> to <String, String> to create a HTML-Table
   */
  Map<String, String> convertBoard() {
    Map<String, String> htmlBoard = new Map<String, String>();
    this.board.forEach((key, value) {
      htmlBoard.putIfAbsent(key.getX().toString() + key.getY().toString(), () => value);
    });
    return htmlBoard;
  }
  
  int getRow(){
    return row;
  }
  int getCol(){
    return col;
  }
  void setView(View view){
    this.view = view;
  }
}
>>>>>>> 64f68d08116f5dc4adfa56fbcf14d70aa23a9455
