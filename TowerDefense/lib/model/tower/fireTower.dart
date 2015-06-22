part of tower;

class FireTower extends Tower {
  FireTower() {
    this.setName("Fire Tower");
    this.setRange(4);
    this.setPrice(1000);
    this.setSellingPrice(500);
    this.setUpgradeLevel(1);
    this.setAttackSpeed(1.1);
    this.setBasicDamage(21.0);
    this.setDmgType(3);
    this.setAbility(false);
    this.setAbilityFactor(25);
  }
}
