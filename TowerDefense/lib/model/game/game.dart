library game;

import '../tower/towerAdmin.dart';
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
  Map<String, String> images;
  final row = 11;
  final col = 11;
  View view;
  Player player;

  Game(String levels) {
    this.levels = levels;
    this.tAdmin = new TowerAdmin();
    this.lAdmin = new LevelAdmin(levels);
    this.board = new Map<Field, String>();
    this.images = new Map<String, String>();
    this.setImagesToMap();
  }
  /**
   * 
   */
  void startGame() {
    this.board = lAdmin.createBoard(this.row, this.col);
  }
  /**
   * 
   */
  void runGame() {
    //tAdmin.buyTower(towerDescription, player);
  }
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
      htmlBoard.putIfAbsent(
          key.getX().toString() + key.getY().toString(), () => value);
    });
    return htmlBoard;
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
  /**
   * Sets the Path of the images to the keys of the objects
   */

  void setImagesToMap() {
    this.images.putIfAbsent("Amazon", () => "img/minions/amazon.png");
    this.images.putIfAbsent("Apple", () => "img/minions/apple.png");
    this.images.putIfAbsent(
        "CookieMonster", () => "img/minions/cookiemonster.jpg");
    this.images.putIfAbsent("Dart", () => "img/minions/dart.jpg");
    this.images.putIfAbsent("Docker", () => "img/minions/docker.png");
    this.images.putIfAbsent("Facebook", () => "img/minions/facebook.png");
    this.images.putIfAbsent("Google", () => "img/minions/google.png");
    this.images.putIfAbsent(
        "WeakKratzke", () => "img/minions/weakkratzke.jpeg");
    this.images.putIfAbsent("Twitter", () => "img/minions/twitter.png");
    this.images.putIfAbsent("Whatsapp", () => "img/minions/whatsapp.png");
    this.images.putIfAbsent(
        "StrongKratzke", () => "img/minions/strongkratzke.jpg");
  }
}
