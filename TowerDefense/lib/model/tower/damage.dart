part of tower;

class Damage{
  double dmg;
  int damageType;
  bool applyCondition;
  
  Damage(double damage, int damageType, bool applyCondition){
    this.setApplayCondition(applyCondition);
    this.setDamage(damage);
    this.setDamageType(damageType);
  }
  double getDamage(){
    return this.dmg;
  }
  void setDamage(double dmg){
    this.dmg = dmg;
  }
  int getDamageType(){
    return this.damageType;
  }
  void setDamageType(int dmgType){
    this.damageType = dmgType;
  }
  bool getApplyCondition(){
    return this.applyCondition;
  }
  void setApplayCondition(bool applCon){
    this.applyCondition = applCon;
  }
}