part of tower;

class LighteningTower extends Tower {

  LighteningTower() {
    this.setRange(4);
    this.setPrice(100);
    this.setSellingPrice(70);
    this.setUpgradeLevel(1);
    this.setAttackSpeed(1.1);
    this.setBasicDamage(20.0);
    this.setDmgType(1);
    this.setAbility(false);
    this.setAbilityFactor(20);
  }
}