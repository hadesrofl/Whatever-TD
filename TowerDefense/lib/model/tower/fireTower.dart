part of tower;

class FireTower extends Tower {

  FireTower() {
    this.setRange(4);
    this.setPrice(120);
    this.setSellingPrice(90);
    this.setUpgradeLevel(1);
    this.setAttackSpeed(1.1);
    this.setBasicDamage(21.0);
    this.setDmgType(3);
    this.setAbility(false);
    this.setAbilityFactor(25);
  }
}
