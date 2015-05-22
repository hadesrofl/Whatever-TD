library level;

import "package:xml/xml.dart";
import "../tower/towerAdmin.dart";

part "condition.dart";
part "minion.dart";
part "wave.dart";

/**
 * 
 */
class levelAdmin {
  /**
   * 
   */
  XmlDocument levelFile;
  /**
   * 
   */
  int deadMinions;
  /**
   * 
   */
  int level;
  /**
   * 
   */
  levelAdmin(XmlDocument levelFile) {
    this.levelFile = levelFile;
    this.deadMinions = 0;
    this.level = 1;
  }
  /**
   * 
   */
  void calculateHP(List<Target> targets) {}
  /**
   * 
   */
  void minionSpawn() {}
  /**
   * 
   */
  void moveMinion() {}
  /**
   * 
   */
  void deleteMinion() {}
  /**
   * 
   */
  void updateMinion() {}
  /**
   * 
   */
  void incDeadMinions() {
    this.deadMinions++;
  }
  /**
   * 
   */
  void clearDeadMinions() {
    this.deadMinions = 0;
  }
  /**
   * 
   */
  void evaluateFile() {}
  /**
  * 
  */
  void loadNextLevel() {}
}
