part of tower;

/**
 * CanonTower
 * 
 * @author Florian Winzek
 */
class CanonTower extends Tower {
  CanonTower() {
    this.setName("CanonTower");
    this.setRange(2);
    this.setPrice(300);
    this.setSellingPrice(150);
    this.setUpgradeLevel(1);
    this.setAttackSpeed(1.1);
    this.setBasicDamage(7.0);
    this.setDmgType(1);
    this.setAbility(false);
    this.setAbilityFactor(22);
  }
}
