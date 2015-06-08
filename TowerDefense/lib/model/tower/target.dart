part of tower;

class Target {
  Damage damage;
  Minion target;

  Target(Damage damage, Minion target) {
    this.damage = damage;
    this.target = target;
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
}
