part of tower;

class Target {
  Damage damage;
  Minion target;
  Condition condition;

  Target(Damage damage, Minion target, Condition condition) {
    this.damage = damage;
    this.target = target;
    this.condition = condition;
  }

  Damage getDamage() {
    return this.damage;
  }
  void setDamage(Damage dmg) {
    this.damage = dmg;
  }
  Minion getMinion() {
    return this.target;
  }
  void setMinion(Minion tgt) {
    this.target = tgt;
  }
  Condition getCondition(){
   return this.condition;
  }
  void setCondition(Condition con){
    this.condition = con;
  }
}
