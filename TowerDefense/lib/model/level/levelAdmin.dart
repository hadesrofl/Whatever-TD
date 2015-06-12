library level;

import "package:xml/xml.dart";
import "../tower/towerAdmin.dart";
import "../game/game.dart";

part "condition.dart";
part "minion.dart";
part "wave.dart";
part "armor.dart";

/**
 * This Class manages different levels
 */
class LevelAdmin {
  /**
   * The File containing all informations for the levels of this game
   */
  var levelFile;
  /**
   * The number of the current level
   */
  int currentLevel;
  /**
   * The number of the current wave
   */
  /* TODO: current Wave as Wave Object */
  int currentWave;
  /**
   * List of Minions active on the board
   */
  List<Minion> minions = new List<Minion>();
  /**
   * Map of all Waves of this current Level
   * Key - integer of the wave number
   * Value - the wave
   */
  Map<int, Wave> waves = new Map<int, Wave>();
/**
 * Path the minions have to follow
 */
  List<Field> path = new List<Field>();
  Map<Field, String> board;

  /**
   * Constructor for the Level Administration object
   * @param levelFile - XML Document containing the information about the levels of this game
   */
  LevelAdmin(String levelFile) {
    this.levelFile = parse(levelFile);
    this.currentLevel = 1;
    this.currentWave = 1;
  }
  /**
   * Method to calculate the hitpoints of every single Minion
   * @param targets - a list of targets from the tower administation
   */
  void calculateHPOfMinions(List<Target> targets) {
    targets.forEach((target) {
      bool foundMinion = false;
      for (int i = 0; i < minions.length; i++) {
        /* Didn't found the minion yet */
        if (foundMinion == false) {
          /* found minion */
          if (minions[i].equals(target.getTarget()) == true) {
            /* minion has 0 or lower hp => dead */
            if (minions[i].calculateHitPoints(target.getDamage()) <= 0) {
              minions.removeAt(i);
            }
            /* mark minion as found */
            foundMinion = true;
          }
        }
      }
    });
  }
  /**
   * Method to spawn a new minion
   */
  void minionSpawn() {
    bool foundMinion = false;
    for (int i = 0; i < minions.length; i++) {
      if (foundMinion == false) {
        if (minions[i].isSpawned() == false) {
          minions[i].spawn();
          foundMinion = true;
        }
      }
    }
  }
  /**
   * Method to move minions
   */
  void moveMinions() {
    minions.forEach((m) {
      if (m.isSpawned()) {
        m.move(path[m.getStepsOnPath()]);
      }
    });
  }
  /**
   * Method to....well...dunno
   * TODO: what the fuck does this method ö.ö
   */
  void updateMinions() {}
  /**
   * Method to get all necessary informations of the XML File
   */
  /** TODO: Implement */
  void evaluateFile() {}
  /**
  * Method to load the next level
  */
  /** TODO: Implement */
  void loadNextLevel() {}
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
   * Returns the number of this current level
   * @return the number of this current level as integer
   */
  int getLevelNumber() {
    return currentLevel;
  }
  /**
   * Checks if the Wave is clear
   * @return true if the wave is clear else false
   */
  bool isWaveClear() {
    return waves[currentWave].isWaveClear();
  }
  /**
   * Checks if the Level ends
   * @return true if the wave is clear and it was the final wave else false
   */
  bool isLevelEnd() {
    bool levelEnd;
    if (isWaveClear() == true && waves[currentWave].isFinalWave()) {
      levelEnd = true;
    } else {
      levelEnd = false;
    }
    return levelEnd;
  }
  /**
   * Returns the List of Minions of this wave and Level
   * @return list of all minions
   */
  List<Minion> getMinions() {
    return this.minions;
  }
}
