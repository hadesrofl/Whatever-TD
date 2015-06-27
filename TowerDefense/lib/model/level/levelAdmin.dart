library level;

import "package:xml/xml.dart";
import "../tower/towerAdmin.dart";
import "../game/game.dart";
import "dart:async";
import 'dart:math';

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
   * The number of the current level
   */
  int currentLevel;
  /**
   * The number of the current wave
   */
  Wave currentWave;
  /**
   * List of Levels
   */
  List<XmlElement> levels;
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
  /**
   * All Minions currently active on the board
   */
  List<Minion> activeMinions = new List<Minion>();

  /**
   * Constructor for the Level Administration object
   * @param levelFile - XML Document containing the information about the levels of this game
   */
  LevelAdmin(String levelFile, String difficulty) {
    this.levelFile = parse(levelFile);
    this.evaluateFile(difficulty);
    this.currentLevel = 0;
    this.currentWave = null;
  }
  /**
   * Method to calculate the hitpoints of every single Minion
   * @param targets - a list of targets from the tower administation
   */
  void calculateHPOfMinions(List<Target> targets) {
    targets.forEach((target) {
      if (target != null) {
        bool foundMinion = false;
        for (int i = 0; i < activeMinions.length; i++) {
          /* Didn't found the minion yet */
          if (foundMinion == false) {
            /* found minion */
            if (activeMinions[i].equals(target.getMinion()) == true) {
              activeMinions[i].calculateHitPoints(target);
              print(activeMinions[i].getHitpoints().toString());
              /* mark minion as found */
              foundMinion = true;
            }
          }
        }
      }
    });
  }
  /**
   * Method to spawn a new minion
   * @return the spawned minion
   */
  Minion minionSpawn() {
    bool foundMinion = false;
    Minion m = null;
    for (int i = 0; i < currentWave.getMinions().length; i++) {
      if (foundMinion == false) {
        if (currentWave.getMinions()[i].isSpawned() == false) {
          currentWave.getMinions()[i].spawn();
          m = currentWave.getMinions()[i];
          activeMinions.add(m);
          foundMinion = true;
          m.setPath(path);
          m.setStartPosition();
        }
      }
    }
    return m;
  }
  /**
   * Method to get all necessary informations of the XML File
   * @param difficulty is the difficulty chosen by the player
   */
  void evaluateFile(String difficulty) {
    String chosenDifficulty = "";
    chosenDifficulty = translateDifficulty(difficulty);
    levels = levelFile.findElements("allLevels").first
        .findElements(chosenDifficulty).first.findElements("level").toList();
  }
  /**
   * Translates the given difficulty for the xml document.
   * @param difficulty is the given string of the difficulty
   * @return the name in the xml file for this difficulty
   */
  String translateDifficulty(String difficulty) {
    String chosenDifficulty;
    if (difficulty.compareTo("easy") == 0) {
      chosenDifficulty = "easyLevels";
    } else if (difficulty.compareTo("medium") == 0) {
      chosenDifficulty = "mediumLevels";
    } else if (difficulty.compareTo("hard") == 0) {
      chosenDifficulty = "hardLevels";
      /* Default */
    } else {
      chosenDifficulty = "easyLevels";
    }
    return chosenDifficulty;
  }
  /**
  * Method to load the next level
  * @return false, if it is the last level and no new could be loaded, true if a new level is loaded
  */
  bool loadNextLevel() {
    bool finalWave;
    bool nextLevelLoaded = false;
    if (!isFinalLevel()) {
      currentLevel++;
      XmlElement level = getCurrentLevelFromXml();
      /* Extract Waves of XML */

      List<XmlElement> waveList = getCurrentWavesFromXml();
      waveList.forEach((x) {
        int waveNumber = int.parse(x.attributes[0].value);
        if (x.attributes[1].value.compareTo("true") == 0) {
          finalWave = true;
        } else {
          finalWave = false;
        }
        waves[waveNumber] = new Wave(waveNumber, finalWave);
      });
      currentWave = null;
      loadNextWave();
      nextLevelLoaded = true;
    }
    return nextLevelLoaded;
  }

  /**
   * Loads the next Wave of the current Level from XML
   * @return false if it is the last wave of the level, true if new wave is loaded
   */
  bool loadNextWave() {
    bool nextWaveLoaded;
    /* there is no current wave, load first one */
    if (currentWave == null) {
      currentWave = waves[1];
      nextWaveLoaded = getMinionsForWave();
      /* Wave is clear, load next one */
    } else if (isLevelEnd()) {
      nextWaveLoaded = false;
    } else if (currentWave.isWaveClear()) {
      currentWave = waves[currentWave.getWaveNumber() + 1];
      nextWaveLoaded = getMinionsForWave();
    } else {
      /* The Wave is still running */
      nextWaveLoaded = false;
    }
    return nextWaveLoaded;
  }
  /**
   * Loads the path from the xml and updates the fields inside the board
   * @param board is the board of the game
   */
    void loadPath(List<Field> board) {
      List<int> pathCoords = transformPathFromXml();
      for (int i = 0; i < pathCoords.length; i = i + 2) {
        board.forEach((f) {
          if (f.getX() == pathCoords[i + 1] && f.getY() == pathCoords[i]) {
            f.setPathField(true);
            this.path.add(f);
          }
        });
      }
    } 
    /**
     * Gets the current Level of the xml file
     * @return the current level as xml element
     */
    XmlElement getCurrentLevelFromXml() {
      XmlElement level = levels.firstWhere(
          (x) => (x.attributes[0].value.compareTo(currentLevel.toString()) == 0));
      return level;
    }
  /**
   * Extracts the Wave Data from XML
   * @return a list of the waves as xml nodes
   */
  List<XmlNode> getCurrentWavesFromXml() {
    XmlElement level = getCurrentLevelFromXml();
    List<XmlElement> waves = level.findElements("wave").toList();
    return waves;
  }

  /**
   * Reads the Minions for this level from the xml and gets the specific minion of the current wave
   * @return if it was successful
   */
  bool getMinionsForWave() {
    bool minionsLoaded;
    XmlElement level = levels.firstWhere(
        (x) => (x.attributes[0].value.compareTo(currentLevel.toString()) == 0));
    List<XmlNode> waves = getCurrentWavesFromXml();
    XmlElement wave = waves.firstWhere((x) => x.attributes[0].value
            .compareTo(currentWave.getWaveNumber().toString()) ==
        0);
    List<XmlElement> levelMinions = wave.findElements("minion").toList();

    /* compare referring minion in wave to minions in xml and get the attributes */
    for (int i = 0; i < levelMinions.length; i++) {
          XmlElement minion = getMinionFromXml(levelMinions[i].attributes[0].value);
          String minionName = levelMinions[i].attributes[0].value;
          double hitpoints =
              double.parse(minion.findElements("hitpoints").single.text);
          Armor armor = new Armor(minion.findElements("armor").single.text);
          Duration movementSpeed = new Duration(
              milliseconds: int
                  .parse(minion.findElements("movementSpeed").single.text));
          int droppedGold =
              int.parse(minion.findElements("droppedGold").single.text);
          /* create minion objects and save them in the minions list */
          for (int j = 0; j < int.parse(levelMinions[i].attributes[1].value); j++) {
            currentWave.addMinion(new Minion(
                minionName, hitpoints, armor, movementSpeed, droppedGold));
          }
        }
      minionsLoaded = true;
      return minionsLoaded;
    }
  
  /**
   * Gets the Minions from XML
   * @param the name of the minion
   * @return a list of xml elements containing the minion
   */
  XmlElement getMinionFromXml(String minionName) {
    bool found = false;
    List<XmlElement> minions = levelFile.findElements("allLevels").first
        .findElements("minions").first.findElements("minion").toList();
    XmlElement minion;
    minions.forEach((m){
      if(!found){
        if(m.attributes[0].value.compareTo(minionName) == 0){
          found = true;
        minion = m;
      }
      }
    });
    return minion;
  }
  /**
   * Extracts the Wave Data from XML, removes prettyFormatNodes and returns a list 
   * with the ids of the fields that are path fields
   * @param level is the current level
   * @return a list of integer containing the field ids, which are path fields
   */
  List<int> transformPathFromXml() {
    List<XmlNode> paths = levelFile.findElements("allLevels").first
        .findElements("paths").first.findElements("path").toList();
    List<int> coords = new List<int>();
    Random rand = new Random(new DateTime.now().millisecondsSinceEpoch);
    int randomNumber = (rand.nextInt(paths.length)) + 1;
    XmlElement path = paths.firstWhere((x) => x.attributes[0].value.compareTo(randomNumber.toString()) == 0);
    List<XmlElement> pathfields = path.findElements("pathfield").toList();
    for(int i = 0; i < pathfields.length; i++){
      XmlElement ycoord = pathfields[i].findElements("y-coord").single;
      XmlElement xcoord = pathfields[i].findElements("x-coord").single;
      coords.add(int.parse(ycoord.text));
      coords.add(int.parse(xcoord.text));
    }
    return coords;
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
    return waves[currentWave.getWaveNumber()].isWaveClear();
  }
  /**
   * Checks if the Level ends
   * @return true if the wave is clear and it was the final wave else false
   */
  bool isLevelEnd() {
    bool levelEnd;
    if (isWaveClear() == true &&
        waves[currentWave.getWaveNumber()].isFinalWave()) {
      levelEnd = true;
    } else {
      levelEnd = false;
    }
    return levelEnd;
  }
  /**
   * Checks if the Level is the final one
   */
  bool isFinalLevel() {
    bool finalLevel;
    if (currentLevel == 0) {
      finalLevel = false;
    } else {
      String value = levels.firstWhere(
          (x) => (x.attributes[0].value.compareTo(currentLevel.toString()) ==
              0)).attributes[1].value;
      if (value.compareTo("true") == 0) {
        finalLevel = true;
      } else {
        finalLevel = false;
      }
    }
    return finalLevel;
  }
  /**
   * Returns the List of Minions of this wave and Level
   * @return list of all minions
   */
  List<Minion> getActiveMinions() {
    return this.activeMinions;
  }
  /**
   * Gets the Path Fields
   * @return a list of path fields
   */
  List<Field> getPath() {
    return this.path;
  }
  /**
   * Returns the current wave object
   * @return the current wave
   */
  Wave getCurrentWave() {
    return this.currentWave;
  }
}
