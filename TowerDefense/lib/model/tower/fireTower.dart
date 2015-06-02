part of tower;

class FireTower extends Tower {
  bool ignite;
  Target target;

  FireTower(int range, Field attackField, int price,
      int sellingPrice, int upgradeLevel, double attackSpeed, Target target,
      Damage damage,double basicDamage, this.ignite)
      : super(range, attackField, price, sellingPrice, upgradeLevel,basicDamage);
  
  Target shoot(List<Minion> minions){
    return this.target;
  }
}
