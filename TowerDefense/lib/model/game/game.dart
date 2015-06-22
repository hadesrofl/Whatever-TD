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
  int life;
  /* TODO: Get Difficulty from User Input (button or something else) */
  String difficulty = "easy";

  Game(String levels) {
    this.levels = levels;
    this.tAdmin = new TowerAdmin();
    this.board = createBoard(this.row, this.col);
    this.lAdmin = new LevelAdmin(levels, difficulty, board);
    this.images = new Map<String, String>();
    this.setImagesToMap();
  }
  /**
   * 
   */
  void startGame() {}
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
    this.images.putIfAbsent("ArrowTower1", () => "img/towers/arrowtower.jpg");
    this.images.putIfAbsent("ArrowTower2", () => "img/towers/arrowtower2.jpg");
    this.images.putIfAbsent("ArrowTower3", () => "img/towers/arrowtower3.jpg");
    this.images.putIfAbsent("CanonTower1", () => "img/towers/canontower.jpg");
    this.images.putIfAbsent("CanonTower2", () => "img/towers/canontower2.jpg");
    this.images.putIfAbsent("CanonTower3", () => "img/towers/canontower3.jpg");
    this.images.putIfAbsent(
        "LightningTower1", () => "img/towers/lightningtower.jpg");
    this.images.putIfAbsent(
        "LightningTower2", () => "img/towers/lightningtower2.png");
    this.images.putIfAbsent(
        "LightningTower3", () => "img/towers/lightningtower3.jpg");
    this.images.putIfAbsent("FireTower1", () => "img/towers/firetower.jpg");
    this.images.putIfAbsent("FireTower2", () => "img/towers/firetower2.jpg");
    this.images.putIfAbsent("FireTower3", () => "img/towers/firetower3.png");
    this.images.putIfAbsent("Dirt", () => "img/background/dirt.jpg");
    this.images.putIfAbsent("Grass", () => "img/background/grass.jpg");
  }
}
