library level;

import "package:xml/xml.dart";
import "../tower/towerAdmin.dart";
import "dart:io";

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
  XmlDocument levelFile;
  /**
   * The number of slain minions this level
   */
  int deadMinions;
  /**
   * The number of the current level
   */
  int level;
  
  /**
   * Constructor for the Level Administration object
   * @param levelFile - XML Document containing the information about the levels of this game
   */
  LevelAdmin(File levelFile) {
    this.levelFile = parse(levelFile.readAsStringSync());
    this.deadMinions = 0;
    this.level = 1;
  }
  /**
   * Method to calculate the hitpoints of every single Minion
   * @param targets - a list of targets from the tower administation
   */
  void calculateHP(List<Target> targets) {}
  /**
   * Method to spawn a new minion
   */
  void minionSpawn() {}
  /**
   * Method to move minions
   */
  void moveMinion() {}
  /**
   * Method to delete a minion if he is dead (hitpoints <= 0)
   */
  void deleteMinion() {}
  /**
   * Method to....well...dunno
   * TODO: what the fuck does this method ö.ö
   */
  void updateMinion() {}
  /**
   * Method to increase the counter of the dead minions
   */
  void incDeadMinions() {
    this.deadMinions++;
  }
  /**
   * Method to clear the dead minions counter
   */
  void clearDeadMinions() {
    this.deadMinions = 0;
  }
  /**
   * Method to get all necessary informations of the XML File
   */
  void evaluateFile() {}
  /**
  * Method to load the next level
  */
  void loadNextLevel() {}
}
