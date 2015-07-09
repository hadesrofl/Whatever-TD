part of game;

/**
 * Administrations a Player Object
 * @author Florian Winzek
 */
class Player {
  /**
   * Name of the player
   */
  String _name;
  /**
   * gold of the player to buy towers and upgrade them
   */
  int _gold;
  /**
   * highscore points of the player
   */
  int _highscore;
/**
 * Constructor of a player object
 * @param name is the name of the player
 */
  Player(String name) {
    this.setName(name);
    this.setGold(2000);
    this.setHighscore(0);
  }
  /**
   * ---------------Getter and Setter Methods---------------------
   */
  /**
   * Gets the name of the player
   * @return the name of the player
   */
  String getName() {
    return this._name;
  }
  /**
   * Sets the name of the player 
   * @param name is the name of the player that shall be set
   */
  void setName(String name) {
    this._name = name;
  }
  /**
   * Gets the gold value of the player
   * @return an integer with the value of the gold
   */
  int getGold() {
    return this._gold;
  }
  /**
   * Sets the gold value of the player
   * @param gold is the new gold value
   */
  void setGold(int gold) {
    this._gold = gold;
  }
  /**
   * Gets the highscore of the player
   * @return an integer with the highscore of the player
   */
  int getHighscore() {
    return this._highscore;
  }
  /**
   * Sets the highscore of the player
   * @param highscore is the new value of the highscore
   */
  void setHighscore(int highscore) {
    this._highscore = highscore;
  }
}
