library game;

import '../tower/towerAdmin.dart';
import 'dart:async';
import '../level/levelAdmin.dart';
part "field.dart";
part "player.dart";

/**
 * Manages a game of the Tower Defense and controls the tower and level admins.
 * @author Florian Winzek, René Kremer
 */
class Game {
  /**
   * Tower Administration of the game
   */
  TowerAdmin _tAdmin;
  /**
   * Level Administration of the game
   */
  LevelAdmin _lAdmin;
  /**
   * The String of levels which is read from the page
   */
  String _levels;
  /**
   * Board of the game where the minions walk and tower can be set
   */
  List<Field> _board;
  /**
   * Rows of the board
   */
  final _row = 11;
  /**
   * Cols of the board
   */
  final _col = 11;
  /**
   * Modifier for the Highscore to multiply with the number of gold earned by the player
   */
  final _highScoreModifier = 0.2;
  /**
   * Maximum value of the lifes a player has per level
   */
  final _maxLife = 5;
  /**
   * Player who plays the game
   */
  Player _player;
  /**
   * Current Life of the player
   */
  int _life;
  /**
   * Money earned from killing minions
   */
  int _earnedMoneyFromMinions = 0;
  /**
   * difficulty the player chose
   */
  String _difficulty;
  /**
   * Timer for spawning minions of a wave
   */
  Timer _spawnTimer;
  /**
   * Timer to check if a life is lost in the dynamic of the game
   */
  Timer _checkLifeTimer;
  /**
   * Timer to trigger the shoot of all tower
   */
  Timer _towerShootTimer;
  /**
   * Duration for the Spawn Timer
   */
  Duration _spawn = const Duration(milliseconds: 2500);
  /**
   * Duration for the Check Life Timer
   */
  Duration _checkLife = const Duration(milliseconds: 1000);
  /**
   * Duration for the towerShootTimer
   */
  Duration _shoot = const Duration(milliseconds: 2000);

  /**
   * Constructor of the game
   * @param levels is the read String of the http request for the levels
   */
  Game(String levels) {
    this._levels = levels;
    this._board = createBoard(this._row, this._col);
    this._life = _maxLife;
  }
  /**
   * Starts the game and resets all values of earnedMoney, life, levelAdmin 
   * and loads the first level and wave
   */
  void startGame() {
    if(_earnedMoneyFromMinions != 0){
      _earnedMoneyFromMinions = 0;
    }
    if (this._life != _maxLife) {
      this._life = _maxLife;
    }
    if (this._lAdmin == null) {
      setLevelAdmin();
    }
    if (this._lAdmin.getCurrentLevel() == 0) {
      this._lAdmin.loadNextLevel();
    }
    if (this._lAdmin.getCurrentLevel() != 0 && this._lAdmin.getCurrentWave() != null) {
      if (this._lAdmin.isLevelEnd()) {
        this._lAdmin.loadNextLevel();
      } else {
        this._lAdmin.loadNextWave();
      }
    }
    runGame();
  }
  /**
   * Runs the game and starts the Timer of the game
   */
  void runGame() {
    startGameTimer();
  }
  /**
   * Evalutes the killed Minions and checks if it is the end of game.
   * Evaluating means updating the amount of gold the player has and the highscore according
   * to the killed minions of the player
   * @param endOfGame indicates if it is the endOfGame and the amount of gold has to be 
   * added to the highscore
   */
  void evaluateKilledMinions(bool endOfGame) {
    int income = this._lAdmin.getCurrentWave().getDroppedGold() - _earnedMoneyFromMinions;
    if(income > 0){
      _earnedMoneyFromMinions += income;
    }else{
      income = 0;
    }
    this._player.setGold(this._player.getGold() + income);
    if (endOfGame) {
      this._player.setHighscore(this._player.getHighscore() +
          (this._player.getGold() * _highScoreModifier).toInt());
      this._player.setGold(0);
    } else {
      this._player.setHighscore(
          this._player.getHighscore() + (income * _highScoreModifier).toInt());
    }
  }
  /**
   * Ends the game and all game timer. Also destroys the level and tower admins
   */
  void endOfGame() {
    stopGameTimer();
    this._lAdmin = null;
    this._tAdmin = null;
  }
  /**
   * Creates the board of this level
   * @param row are the rows of the board
   * @param col are the cols of the board
   * @return a list of fields
   */
  List<Field> createBoard(final row, final col) {
    List<Field> board = new List<Field>();
    for (int i = 0; i < row; i++) {
      for (int j = 0; j < col; j++) {
        board.add(new Field(i, j, false));
      }
    }
    return board;
  }
  /**
   * Starts the game Timer and controls their actions
   */
  void startGameTimer() {
    if (_spawnTimer == null) {
      _spawnTimer = new Timer.periodic(_spawn, (_) {
        this._lAdmin.minionSpawn();
      });
    }

    if (_towerShootTimer == null) {
      _towerShootTimer = new Timer.periodic(_shoot, (_) {
        List<Target> targets = _tAdmin.attack(_lAdmin.getActiveMinions());
        _lAdmin.calculateHPOfMinions(targets);
      });
    }
    if (_checkLifeTimer == null) {
      _checkLifeTimer = new Timer.periodic(_checkLife, (_) {
        this._lAdmin.getActiveMinions().forEach((m) {
          if (m.getStepsOnPath() >= this._lAdmin.getPath().length &&
              m.getHitpoints() > 0 &&
              m.getDestroyedALife() == false) {
            this._life--;
            m.setDestroyedALife(true);
            print("Life remaining: $_life");
          }
        });
      });
    }
  }
  /**
   * Stops all game timer and destroys them
   */
  void stopGameTimer() {
    if(_spawnTimer != null){
      this._spawnTimer.cancel();
      this._spawnTimer = null;
    }

    if(_checkLifeTimer != null){
      this._checkLifeTimer.cancel();
      this._checkLifeTimer = null;
    }

    if(_towerShootTimer != null){
      this._towerShootTimer.cancel();
      this._towerShootTimer = null;
    }

  }
  /**
   * ---------------Getter and Setter Methods---------------------
   */
  /**
   * Gets the number of rows of the board
   * @return the number of rows
   */
  int getRow() {
    return _row;
  }
  /**
   * Gets the number of cols of the board
   * @return the number of cols
   */
  int getCol() {
    return _col;
  }
  /**
   * Sets a player to this game
   * @param name - is the name of the player
   */
  void setPlayer(String name) {
    if(this._player != null){
      this._player = null;
    }
    this._player = new Player(name);
  }
  /**
   * Sets the difficulty of the game
   * @param dif is the new difficulty of the game
   */
  void setDifficulty(String dif) {
    this._difficulty = dif;
  }
  /**
   * Sets and creates the Level Admin to the game
   */
  void setLevelAdmin() {
    this._lAdmin = new LevelAdmin(_levels, _difficulty);
  }
  /**
   * Sets and creates the tower Admin to the game
   */
  void setTowerAdmin() {
    this._tAdmin = new TowerAdmin();
  }
  /**
   * Gets the Player of this game
   * @return the player object
   */
  Player getPlayer(){
    return this._player;
  }
  /**
   * Gets the amount of lifes the player currently has
   * @return an integer with the amount of lifes
   */
  int getLife(){
    return this._life;
  }
  /**
   * Gets the level Admin of this game
   * @return the level admin object
   */
  LevelAdmin getLevelAdmin(){
    return this._lAdmin;
  }
  /**
   * Gets the tower Admin of this game
   * @return the tower admin object
   */
  TowerAdmin getTowerAdmin(){
    return this._tAdmin;
  }
  /**
   * Gets the Board of this game
   * @return a list of fields that represent the board
   */
  List<Field> getBoard(){
    return this._board;
  }
}
