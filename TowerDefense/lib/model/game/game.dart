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
  List<Field> board;
  final row = 11;
  final col = 11;
  final highScoreModifier = 0.2;
  final maxLife = 20;
  View view;
  Player player;
  int life;
  int startCounter = 15;
  /* TODO: Get Difficulty from User Input (button or something else) */
  String difficulty;
  Timer spawnTimer;
  Timer checkLifeTimer;
  Timer towerShootTimer;
  bool runningGame = false;
  Duration spawn = const Duration(milliseconds: 2500);
  Duration checkLife = const Duration(milliseconds: 1000);
  Duration shoot = const Duration(milliseconds: 2000);

  Game(String levels) {
    this.levels = levels;
    this.tAdmin = new TowerAdmin();
    this.board = createBoard(this.row, this.col);
    this.life = maxLife;
  }
  /**
   * 
   */
  void startGame() {
    if (this.tAdmin == null) {
      this.tAdmin = new TowerAdmin();
    }
    if (this.life != maxLife) {
      this.life = maxLife;
    }
    if (this.lAdmin == null) {
      setLevelAdmin();
    }
    this.lAdmin.loadNextLevel();
    //this.lAdmin.loadPath(board);
    this.lAdmin.loadNextWave();
    runGame();
    /** if (!runningGame) {
      startWave = new Timer.periodic((buildingPhase), (_) {
        if (this.startCounter == 0) runGame();
        else {
          startCounter--;
        }
      });
    }*/
  }
  /**
   * 
   */
  void runGame() {
    runningGame = true;
    startGameTimer();
  }
  void evaluateKilledMinions(bool endOfGame) {
    int income = this.lAdmin.getCurrentWave().deadMinions *
        this.lAdmin.getCurrentWave().getMinions()[0].getDroppedGold();
    this.player.setGold(this.player.getGold() + income);
    if (endOfGame) {
      this.player.setHighscore(this.player.getHighscore() +
          (this.player.getGold() * highScoreModifier).toInt());
      this.player.setGold(0);
    } else {
      this.player.setHighscore(
          this.player.getHighscore() + (income * highScoreModifier).toInt());
    }
  }
  /**
   * TODO: End Game Somehow
   */
  void endOfGame() {
    spawnTimer.cancel();
    checkLifeTimer.cancel();
    towerShootTimer.cancel();
    this.lAdmin = null;
    this.tAdmin = null;
  }
  /**
   * 
   */
  void calculateHighScore() {}
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
    if (spawnTimer == null) {
      spawnTimer = new Timer.periodic(spawn, (_) {
        this.lAdmin.minionSpawn();
      });
    }

    if (towerShootTimer == null) {
      towerShootTimer = new Timer.periodic(shoot, (_) {
        List<Target> targets = tAdmin.attack(lAdmin.getActiveMinions());
        lAdmin.calculateHPOfMinions(targets);
      });
    }
    if (checkLifeTimer == null) {
      checkLifeTimer = new Timer.periodic(checkLife, (_) {
        List<Minion> tmp = new List<Minion>();
        this.lAdmin.activeMinions.forEach((m) {
          if (m.getStepsOnPath() >= this.lAdmin.path.length &&
              m.getHitpoints() > 0 &&
              m.getDestroyedALife() == false) {
            this.life--;
            m.setDestroyedALife(true);
            print("Life remaining: $life");
          }
        });
      });
    }
  }
  void stopGameTimer() {
    this.spawnTimer.cancel();
    this.spawnTimer = null;
    this.checkLifeTimer.cancel();
    this.checkLifeTimer = null;
    this.towerShootTimer.cancel();
    this.towerShootTimer = null;
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
  void setDifficulty(String dif) {
    this.difficulty = dif;
  }
  void setLevelAdmin() {
    this.lAdmin = new LevelAdmin(levels, difficulty);
  }
}
