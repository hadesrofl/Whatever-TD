part of tower;

/**
 * Instance of a Damage Object
 * 
 * @author Florian Winzek
 */
class Damage {
  /**
   * basic damage value 
   */
  double _dmg;
  /**
   * type of damage
   */
  int _damageType;
  /**
   * special condition
   */
  bool _applyCondition;
/**
 * Constructor
 * 
 * @param damage transer of attribute damage
 * @param damageType transfer of attribute damageType
 * @param applyCondition transfer of attribute applyCondition
 */
  Damage(double damage, int damageType, bool applyCondition) {
    this.setApplayCondition(applyCondition);
    this.setDamage(damage);
    this.setDamageType(damageType);
  }

  //-------------------------getter/setter-methods---------------------------//
  double getDamageValue() {
    return this._dmg;
  }
  void setDamage(double dmg) {
    this._dmg = dmg;
  }
  int getDamageType() {
    return this._damageType;
  }
  void setDamageType(int dmgType) {
    this._damageType = dmgType;
  }
  bool getApplyCondition() {
    return this._applyCondition;
  }
  void setApplayCondition(bool applCon) {
    this._applyCondition = applCon;
  }
}
