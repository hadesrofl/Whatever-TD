library game;

import '../tower/towerAdmin.dart';
import 'dart:async';
import '../level/levelAdmin.dart';
import '../../view/view.dart';
part "field.dart";
part "player.dart";

class Game {
  TowerAdmin _tAdmin;
  LevelAdmin _lAdmin;
  String _levels;
  List<Field> _board;
  final _row = 11;
  final _col = 11;
  final _highScoreModifier = 0.2;
  final _maxLife = 5;
  View _view;
  Player _player;
  int _life;
  int _startCounter = 15;
  int _earnendMoneyFromMinions = 0;
  String _difficulty;
  Timer _spawnTimer;
  Timer _checkLifeTimer;
  Timer _towerShootTimer;
  bool _runningGame = false;
  Duration _spawn = const Duration(milliseconds: 2500);
  Duration _checkLife = const Duration(milliseconds: 1000);
  Duration _shoot = const Duration(milliseconds: 2000);

  Game(String levels) {
    this._levels = levels;
    this._board = createBoard(this._row, this._col);
    this._life = _maxLife;
  }
  /**
   * 
   */
  void startGame() {
    if(_earnendMoneyFromMinions != 0){
      _earnendMoneyFromMinions = 0;
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
   * 
   */
  void runGame() {
    _runningGame = true;
    startGameTimer();
  }
  void evaluateKilledMinions(bool endOfGame) {
    int income = this._lAdmin.getCurrentWave().getDroppedGold() - _earnendMoneyFromMinions;
    if(income > 0){
      _earnendMoneyFromMinions += income;
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
   * Ends the game
   */
  void endOfGame() {
    stopGameTimer();
    this._lAdmin = null;
    this._tAdmin = null;
  }
  /**
   * Creates the board of this level
   * @return a map of this level
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
   * Sets a view object to the game
   * @param view - the view object to interact with
   */
  void setView(View view) {
    this._view = view;
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
  void setDifficulty(String dif) {
    this._difficulty = dif;
  }
  void setLevelAdmin() {
    this._lAdmin = new LevelAdmin(_levels, _difficulty);
  }
  void setTowerAdmin() {
    this._tAdmin = new TowerAdmin();
  }
  Player getPlayer(){
    return this._player;
  }
  int getLife(){
    return this._life;
  }
  LevelAdmin getLevelAdmin(){
    return this._lAdmin;
  }
  TowerAdmin getTowerAdmin(){
    return this._tAdmin;
  }
  List<Field> getBoard(){
    return this._board;
  }
}
