part of tower;

/**
 * This Class represents a condition object, which can be applied to a minion
 */
class Condition {
  /**
   * Identifies the condition by a name e.g. "Fire";
   */
  String identifier;
  /**
   * The duration of the condition
   */
  int duration;
  /**
   * The max duration the condition has
   */
  int maxDuration;
  /**
   * Damage a minion receives per Turn
   */
  double damagePerTurn;
/**
 * Constructor for a condition object
 * @param identifier - name of the condition
 */
  Condition(String identifier) {
    this.identifier = identifier;
    switch (this.identifier) {
      case "Fire":
        this.duration = 5;
        this.maxDuration = 5;
        this.damagePerTurn = 2.0;
        break;
      case "Lightning":
        this.duration = 1;
        this.maxDuration = 1;
        this.damagePerTurn = 10.0;
        break;
    }
  }
  /**
   * Method to apply the damage of the condition and returns its value
   * @return the value of the damage the condition does
   */
  double apply() {
    if (duration > 0) {
      decDuration();
      return damagePerTurn;
    } else {
      return 0.0;
    }
  }
  /**
   * Decreases the duration of this condition
   */
  void decDuration() {
    this.duration--;
  }
  /**
   * Checks if this condition is eqal to the given condition
   * @return true if all attributes of this condition are the same else false
   */
  bool equals(Condition c) {
    bool same;
    if(c != null){
    if (this.identifier.compareTo(c.getIdentifier()) == 0 &&
        this.duration == c.getDuration() &&
        this.maxDuration == c.getMaxDuration() &&
        this.damagePerTurn == c.getDamagePerTurn()) {
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
    return this.duration;
  }
  void resetDuration() {
    this.duration = this.maxDuration;
  }
  String getIdentifier() {
    return this.identifier;
  }
  int getMaxDuration() {
    return this.maxDuration;
  }
  double getDamagePerTurn() {
    return this.damagePerTurn;
  }
}
