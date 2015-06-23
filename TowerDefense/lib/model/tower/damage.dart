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
  double dmg;
  /**
   * type of damage
   */
  int damageType;
  /**
   * special condition
   */
  bool applyCondition;
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
    return this.dmg;
  }
  void setDamage(double dmg) {
    this.dmg = dmg;
  }
  int getDamageType() {
    return this.damageType;
  }
  void setDamageType(int dmgType) {
    this.damageType = dmgType;
  }
  bool getApplyCondition() {
    return this.applyCondition;
  }
  void setApplayCondition(bool applCon) {
    this.applyCondition = applCon;
  }
}
