part of tower;

 abstract class Tower {
  int range;
  Field attackField;
  int price;
  int sellingPrice;
  int upgradeLevel;
  double attackSpeed;
  Target target;
  Damage damage;
  Field position;
  double basicDamage;

  Tower(int range, Field attackField, int price, int sellingPrice,
      int upgradeLevel, double basicDamage) {
    this.setRange(range);
    this.setAttackField(attackField);
    this.setPrice(price);
    this.setSellingPrice(sellingPrice);
    this.setUpgradeLevel(upgradeLevel);
    this.setBasicDamage(basicDamage);
    //this.target = new Target();
     //this.damage = new Damage();
  }
/**
 * shooot
 * 
 */
    Target shoot(List<Minion> minions);
   // this.damage = new Damage(this.getBasicDamage(), 0)
   // target = new Target()
   // return this.target;
  

  void setCoordinates(Field f) {
    position = f;
  }

  /**
   * Upgrades the tower with the upcoming level factor
   */
  void upgrade() {
    this.setPrice(this.getPrice() + (500 * this.getUpgradeLevel()));
    this.setAttackSpeed(this.getAttackSpeed() * (this.getUpgradeLevel() + 1));
    this.setRange(this.getRange() + (this.getUpgradeLevel() + 1));
    this.setUpgradeLevel(this.getUpgradeLevel() + 1);
    this.setSellingPrice(this.getSellingPrice() * (this.getUpgradeLevel() + 1));
    this.setBasicDamage(this.getBasicDamage() * (this.getUpgradeLevel() + 1));
  }

  bool abilityCalculation() {
    return null;
  }

  // --------------getter-/setter methods-----------------//

  int getRange() {
    return this.range;
  }
  void setRange(int range) {
    this.range = range;
  }
  Field getAttackField() {
    return this.attackField;
  }
  void setAttackField(Field attackField) {
    this.attackField = attackField;
  }
  int getPrice() {
    return this.price;
  }
  void setPrice(int price) {
    this.price = price;
  }
  int getSellingPrice() {
    return this.sellingPrice;
  }
  void setSellingPrice(int p) {
    this.sellingPrice = p;
  }
  int getUpgradeLevel() {
    return this.upgradeLevel;
  }
  void setUpgradeLevel(int ul) {
    this.upgradeLevel = ul;
  }
  double getAttackSpeed() {
    return this.attackSpeed;
  }
  void setAttackSpeed(double as) {
    this.attackSpeed = as;
  }
  double getBasicDamage(){
    return this.basicDamage;
  }
  void setBasicDamage(double bSD){
    this.basicDamage = bSD;
  }

  /*
   * 
   */
  int newPriceAfterUpgrade() {
    return this.getPrice() + (this.getUpgradeLevel() * 500);
  }
}
