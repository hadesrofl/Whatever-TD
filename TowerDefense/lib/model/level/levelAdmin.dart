library level;

import "package:xml/xml.dart";
import "../tower/towerAdmin.dart";
import "../game/game.dart";

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
   * All Minions of the current wave
   */
  List<Minion> minions;

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
      bool foundMinion = false;
      for (int i = 0; i < minions.length; i++) {
        /* Didn't found the minion yet */
        if (foundMinion == false) {
          /* found minion */
          if (minions[i].equals(target.getMinion()) == true) {
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
  void evaluateFile(String difficulty) {
    String chosenDifficulty = "";
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
    levels = levelFile.findElements("allLevels").first
        .findElements(chosenDifficulty).first.findElements("level").toList();
  }
  /**
  * Method to load the next level
  */
  void loadNextLevel() {
    bool finalWave;
    if (!isFinalLevel()) {
      currentLevel++;
      XmlElement level = levels.firstWhere((x) =>
          (x.attributes[0].value.compareTo(currentLevel.toString()) == 0));
      /* Extract Waves of XML */
      List<XmlNode> wavesFromXml = extractWavesFromXml(level);
      wavesFromXml.forEach((x) {
        int waveNumber = int.parse(x.attributes[0].value);
        int numberOfMinions = int.parse(x.attributes[1].value);
        if (x.attributes[2].value.compareTo("true") == 0) {
          finalWave = true;
        } else {
          finalWave = false;
        }
        waves[waveNumber] = new Wave(waveNumber, numberOfMinions, finalWave);
      });
      /* Save first Wave as current Wave */
      currentWave = waves[1];
    }
  }

  /**
   * Loads the next Wave of the current Level from XML
   */
  void loadNextWave() {
    int waveIndex = 0;
    if (currentWave != null) {
      if (isLevelEnd()) {
        loadNextLevel();
      } else {
        List<XmlElement> levelMinions = getMinionsFromXml();
        XmlElement level = levels.firstWhere((x) =>
            (x.attributes[0].value.compareTo(currentLevel.toString()) == 0));
        List<XmlNode> wavesFromXml = extractWavesFromXml(level);
        /* Get Wave index in XML */
        for (int i = 0; i < wavesFromXml.length; i++) {
          if (wavesFromXml[i].attributes[0].value
                  .compareTo((currentWave.getWaveNumber()).toString()) ==
              0) {
            waveIndex = i;
          }
        }
        /* Get Minion from Wave */
        if (waveIndex != -1) {
          int minionIndex = 0;
          bool found = false;
          for (int i = 0; i < wavesFromXml[waveIndex].children.length; i++) {
            if (!found) {
              /* remove pretty format text in XML */
              minionIndex = skipFormatTags(wavesFromXml[waveIndex].children, 0);
              found = true;
            }
          }

          found = false;
          String minionName =
              wavesFromXml[waveIndex].children[minionIndex].attributes[0].value;
          /* compare referring minion in wave to minions in xml and get the attributes */
          for (int i = 0; i < levelMinions.length; i++) {
            if (!found) {
              if (minionName.compareTo(levelMinions[i].attributes[0].value) ==
                  0) {
                found = true;
                int childIndex = skipFormatTags(levelMinions[i].children, 0);
                double hitpoints =
                    double.parse(levelMinions[i].children[childIndex].text);
                childIndex =
                    skipFormatTags(levelMinions[i].children, childIndex);
                Armor armor =
                    new Armor(levelMinions[i].children[childIndex].text);
                print(armor.value);
                childIndex =
                    skipFormatTags(levelMinions[i].children, childIndex);
                double movementSpeed =
                    double.parse(levelMinions[i].children[childIndex].text);
                childIndex =
                    skipFormatTags(levelMinions[i].children, childIndex);
                int droppedGold =
                    int.parse(levelMinions[i].children[childIndex].text);
                print(droppedGold.toString());
                /* create minion objects and save them in the minions list */
                for (int j = 0; j < currentWave.getNumberOfMinions(); j++) {
                  currentWave.addMinion(new Minion(minionName, hitpoints, armor,
                      movementSpeed, droppedGold));
                }
              }
            }
          }
        }
      }
    }
    minions = waves[currentWave.getWaveNumber()].getMinions();
  }
  /**
   * Extracts the Wave Data from XML and removes prettyFormatNodes
   */
  List<XmlNode> extractWavesFromXml(XmlElement level) {
    List<XmlNode> wavesRaw = level.children;
    List<XmlNode> wavesRet = new List<XmlNode>();
    wavesRaw.forEach((x) {
      //int t = x;
      if (x.firstChild != null) {
        wavesRet.add(x);
      }
    });
    return wavesRet;
  }
  /**
   * Gets the Minions from XML
   * @return a list of xml elements containing all minions
   */
  List<XmlElement> getMinionsFromXml() {
    /* Get Minion Data */
    List<XmlElement> levelMinionsRaw = levelFile.findElements("allLevels").first
        .findElements("minions").first.findElements("minion").toList();
    List<XmlElement> levelMinions = new List<XmlElement>();
    /* Extract Minion Data from XML, remove pretty Format XML */
    levelMinionsRaw.forEach((x) {
      if (x.firstChild != null) {
        levelMinions.add(x);
      }
    });
    return levelMinions;
  }
  /**
   * Skips Tags with Pretty Format Text and returns the necessary index
   * @param nodes is the List of nodes contaning pretty format tags
   * @return a number of the index where the first non pretty format text is
   */
  int skipFormatTags(List<XmlNode> nodes, int oldIndex) {
    if (oldIndex > 0) {
      oldIndex = oldIndex + 1;
    }
    int value = 0;
    bool found = false;
    for (int i = oldIndex; i < nodes.length; i++) {
      if (!found) {
        if (!nodes[i].text.startsWith(new RegExp(r"\s"))) {
          found = true;
          value = i;
        }
      }
    }
    return value;
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
    if (isWaveClear() == true && waves[currentWave].isFinalWave()) {
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
  List<Minion> getMinions() {
    return this.minions;
  }
}
