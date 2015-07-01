part of tower;

/**
 * LigthningTower
 * 
 * @author Florian Winzek
 */
class LightningTower extends Tower {
  /**
   * Constructor
   * 
   */
  LightningTower() {
    this.setName("LightningTower");
    this.setRange(2);
    this.setPrice(1000);
    this.setSellingPrice(500);
    this.setUpgradeLevel(1);
    this.setAttackSpeed(1.1);
    this.setBasicDamage(10.0);
    this.setDmgType(1);
    this.setAbility(false);
    this.setAbilityFactor(20);
  }
}
