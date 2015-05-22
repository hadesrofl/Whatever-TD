part of tower;

class Damage{
  double damage;
  int damageType;
  bool applyCondition;
  
  Damage(){
    
  }
  double getDamage(){
    return this.damage;
  }
  void setDamage(double dmg){
    this.damage = dmg;
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