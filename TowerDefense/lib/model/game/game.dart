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
    this.images.putIfAbsent("Amazon", () => "/img/amazon.png");
    this.images.putIfAbsent("Apple", () => "img/apple.png");
    this.images.putIfAbsent("CookieMonster", () => "img/cookiemonster.jpg");
    this.images.putIfAbsent("Dart", () => "img/dart.jpg");
    this.images.putIfAbsent("Docker", () => "img/docker.png");
    this.images.putIfAbsent("Facebook", () => "img/facebook.png");
    this.images.putIfAbsent("Google", () => "img/google.png");
    this.images.putIfAbsent("Kratzke", () => "img/kratzke.jpeg");
    this.images.putIfAbsent("Twitter", () => "img/twitter.png");
    this.images.putIfAbsent("Whatsapp", () => "img/whatsapp.png");

    void setImagesToMap() {
      this.images["Amazon"] = "img/amazon.png";
      this.images["Apple"] = "img/apple.png";
      this.images["CookieMonster"] = "img/cookiemonster.jpg";
      this.images["Dart"] = "img/dart.jpg";
      this.images["Docker"] = "img/docker.png";
      this.images["Facebook"] = "img/facebook.png";
      this.images["Google"] = "img/google.png";
      this.images["Kratzke"] = "img/kratzke.jpeg";
      this.images["Twitter"] = "img/twitter.png";
      this.images["Whatsapp"] = "img/whatsapp.png";
    }
  }
}
