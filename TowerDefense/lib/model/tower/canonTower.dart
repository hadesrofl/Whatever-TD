part of tower;

class CanonTower extends Tower {
  int splashRadius;

  CanonTower(Field attackField, int price, int sellingPrice, int upgradeLevel,
      double attackSpeed, Target target, Damage damage, this.splashRadius)
      : super(4, attackField, price, sellingPrice, upgradeLevel);
}
