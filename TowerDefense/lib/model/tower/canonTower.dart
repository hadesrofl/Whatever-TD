part of tower;

class CanonTower extends Tower {
  int splashRadius;
  Target target;

  CanonTower(Field attackField, int price, int sellingPrice, int upgradeLevel,
      double attackSpeed, this.target, Damage damage, double basicDamage,
      splashRadius)
      : super(4, attackField, price, sellingPrice, upgradeLevel, basicDamage);

  Target shoot(List<Minion> minion) {
    return this.target;
  }
}
