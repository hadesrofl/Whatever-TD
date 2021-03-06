part of tower;

/**
 * FireTower
 * 
 * @author Florian Winzek
 */
class FireTower extends Tower {
  /**
   * Constructor
   */
  FireTower() {
    this.setName("FireTower");
    this.setRange(2);
    this.setPrice(1000);
    this.setSellingPrice(500);
    this.setUpgradeLevel(1);
    this.setAttackSpeed(1.1);
    this.setBasicDamage(10.0);
    this.setDmgType(3);
    this.setAbility(false);
    this.setAbilityFactor(90);
  }
}
