part of tower;

class Target {
  Damage _damage;
  Minion _target;
  Condition _condition;

  Target(Damage damage, Minion target, Condition condition) {
    this._damage = damage;
    this._target = target;
    this._condition = condition;
  }

  Damage getDamage() {
    return this._damage;
  }
  void setDamage(Damage dmg) {
    this._damage = dmg;
  }
  Minion getMinion() {
    return this._target;
  }
  void setMinion(Minion tgt) {
    this._target = tgt;
  }
  Condition getCondition(){
   return this._condition;
  }
  void setCondition(Condition con){
    this._condition = con;
  }
}
