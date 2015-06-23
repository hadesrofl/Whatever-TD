part of tower;

/**
 * Instance of a LigthningTower
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
    this.setRange(4);
    this.setPrice(100);
    this.setSellingPrice(70);
    this.setUpgradeLevel(1);
    this.setAttackSpeed(1.1);
    this.setBasicDamage(5.0);
    this.setDmgType(1);
    this.setAbility(false);
    this.setAbilityFactor(20);
  }
}
