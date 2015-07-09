part of tower;

/**
 * This Class represents a condition object, which can be applied to a minion
 * @author René Kremer
 */
class Condition {
  /**
   * Identifies the condition by a name e.g. "Fire";
   */
  String _identifier;
  /**
   * The duration of the condition
   */
  int _duration;
  /**
   * The max duration the condition has
   */
  int _maxDuration;
  /**
   * Damage a minion receives per Turn
   */
  double _damagePerTurn;
/**
 * Constructor for a condition object
 * @param identifier - name of the condition
 */
  Condition(String identifier) {
    this._identifier = identifier;
    switch (this._identifier) {
      case "Fire":
        this._duration = 5;
        this._maxDuration = 5;
        this._damagePerTurn = 2.0;
        break;
      case "Lightning":
        this._duration = 1;
        this._maxDuration = 1;
        this._damagePerTurn = 10.0;
        break;
    }
  }
  /**
   * Method to apply the damage of the condition and returns its value
   * @return the value of the damage the condition does
   */
  double apply() {
    if (_duration > 0) {
      decDuration();
      return _damagePerTurn;
    } else {
      return 0.0;
    }
  }
  /**
   * Decreases the duration of this condition
   */
  void decDuration() {
    this._duration--;
  }
  /**
   * Checks if this condition is eqal to the given condition
   * @return true if all attributes of this condition are the same else false
   */
  bool equals(Condition c) {
    bool same;
    if(c != null){
    if (this._identifier.compareTo(c.getIdentifier()) == 0 &&
        this._duration == c.getDuration() &&
        this._maxDuration == c.getMaxDuration() &&
        this._damagePerTurn == c.getDamagePerTurn()) {
      same = true;
    }else{
     same = false; 
    }
    } else {
      same = false;
    }
    return same;
  }
  /**
   * ---------------Getter and Setter Methods---------------------
   */
  int getDuration() {
    return this._duration;
  }
  void resetDuration() {
    this._duration = this._maxDuration;
  }
  String getIdentifier() {
    return this._identifier;
  }
  int getMaxDuration() {
    return this._maxDuration;
  }
  double getDamagePerTurn() {
    return this._damagePerTurn;
  }
}
