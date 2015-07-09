part of tower;

/**
 * A Class that represents a target object of a tower
 * @author Florian Winzek
 */
class Target {
  /**
   * Damage of the tower
   */
  Damage _damage;
  /**
   * Minion to hit
   */
  Minion _target;
  /**
   * The Condition of the tower to apply to the minion
   */
  Condition _condition;

  /**
   * Constructor of a target object
   */
  Target(Damage damage, Minion target, Condition condition) {
    this._damage = damage;
    this._target = target;
    this._condition = condition;
  }
  /**
   * ---------------Getter and Setter Methods---------------------
   */
  /**
   * Gets the damage object of the target
   * @return the damage object
   */
  Damage getDamage() {
    return this._damage;
  }
  /**
   * Sets the damage object
   * @param dmg is the new damage object of this target
   */
  void setDamage(Damage dmg) {
    this._damage = dmg;
  }
  /**
   * Gets the Minion object of this target
   * @return the minion object of this target
   */
  Minion getMinion() {
    return this._target;
  }
  /**
   * Sets the Minion object 
   * @param tgt is the minion which is hit
   */
  void setMinion(Minion tgt) {
    this._target = tgt;
  }
  /**
   * Gets the condition of this target
   * @return the condition of this target
   */
  Condition getCondition(){
   return this._condition;
  }
  /**
   * Sets the condition of this target
   * @param con is the new condition of this target
   */
  void setCondition(Condition con){
    this._condition = con;
  }
}
