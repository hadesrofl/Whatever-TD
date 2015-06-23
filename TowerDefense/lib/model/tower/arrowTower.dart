part of tower;

class ArrowTower extends Tower {
  ArrowTower() {
    this.setName("ArrowTower");
    this.setRange(5);
    this.setPrice(150);
    this.setSellingPrice(110);
    this.setUpgradeLevel(1);
    this.setAttackSpeed(1.2);
    this.setBasicDamage(5.0);
    this.setDmgType(2);
  }
}
