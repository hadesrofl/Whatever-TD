library game;

import '../tower/towerAdmin.dart';
import 'dart:async';
import '../level/levelAdmin.dart';
import '../../view/view.dart';
part "field.dart";
part "player.dart";

class Game {
  TowerAdmin tAdmin;
  LevelAdmin lAdmin;
  String levels;
  Map<Field, String> board;
  /**
   * Map with Images - The Key is the Name of a Tower or Minion, the value is the path to that image
   */
  final row = 11;
  final col = 11;
  View view;
  Player player;
  int life;
  /* TODO: Get Difficulty from User Input (button or something else) */
  String difficulty;
  Timer startWave;
  bool runningGame = false;
  Duration buildingPhase = const Duration(seconds: 15);

  Game(String levels) {
    this.levels = levels;
    this.tAdmin = new TowerAdmin();
    this.board = createBoard(this.row, this.col);
  }
  /**
   * 
   */
  void startGame() {
    this.lAdmin.loadNextLevel();
    this.lAdmin.loadPath(board, difficulty);
    this.lAdmin.loadNextWave();
    if(!runningGame){
      startWave = new Timer(buildingPhase, () => runGame());
    }
  }
  /**
   * 
   */
  void runGame() {
    runningGame = true;
    if(startWave != null) {
      startWave.cancel();
    }
    print("War....war never changes....");
    
  }
  /**
   * 
   */
  void endOfGame() {}
  /**
   * 
   */

  /**
   * s
   */
  void endOfLevel() {}
  /**
   * 
   */
  void calculateHighScore() {}
  /**
   * Creates the board of this level
   * @return a map of this level
   */
  Map<Field, String> createBoard(final row, final col) {
    Map<Field, String> board = new Map<Field, String>();
    for (int i = 0; i < row; i++) {
      for (int j = 0; j < col; j++) {
        board.putIfAbsent(new Field(i, j, false), () => "");
      }
    }
    return board;
  }
  /**
   * ---------------Getter and Setter Methods---------------------
   */
  /**
   * Gets the number of rows of the board
   * @return the number of rows
   */
  int getRow() {
    return row;
  }
  /**
   * Gets the number of cols of the board
   * @return the number of cols
   */
  int getCol() {
    return col;
  }
  /**
   * Sets a view object to the game
   * @param view - the view object to interact with
   */
  void setView(View view) {
    this.view = view;
  }
  /**
   * Sets a player to this game
   * @param name - is the name of the player
   */
  void setPlayer(String name) {
    this.player = new Player(name);
  }
  void setDifficulty(String dif){
    this.difficulty = dif;
  }
  void setLevelAdmin(){
    this.lAdmin = new LevelAdmin(levels, difficulty);
  }
}
