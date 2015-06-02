part of tower;

class LighteningTower extends Tower {
  bool overloaded;
  Target target;

  LighteningTower(int range, Field attackField, int price, int sellingPrice,
      int upgradeLevel, double attackSpeed, Target target, Damage damage,double basicDamage,
      this.overloaded)
      : super(range, attackField, price, sellingPrice, upgradeLevel,basicDamage);
  
  Target shoot(List<Minion> minions){
    return this.target;
  }
}
