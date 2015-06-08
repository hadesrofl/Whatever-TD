import "tower/towerAdmin.dart";
import "level/levelAdmin.dart";
import "field.dart";
import "../view/view.dart";
import "player.dart";

class Game {
  TowerAdmin tAdmin;
  LevelAdmin lAdmin;
  String levels;
  Map<Field, String> board;
  Map<int, String> images;
  final row = 22;
  final col = 22;
  View view;
  Player player;

  Game(String levels) {
    //TODO: Enter concrete FilePath
    this.levels = levels;
    this.tAdmin = new TowerAdmin();
    this.lAdmin = new LevelAdmin(levels);
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
  /**
   * ---------------Getter and Setter Methods---------------------
   */
  /**
   * Gets the number of rows of the board
   * @return
   */
  int getRow(){
    return row;
  }
  /**
   * 
   */
  int getCol(){
    return col;
  }
  /**
   * 
   */
  void setView(View view){
    this.view = view;
  }
  /**
   * 
   */
  void setPlayer(String name){
    this.player = new Player(name);
  }
}
