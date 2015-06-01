part of tower;

class Tower{
  int range;
  Field attackField;
  int price;
  int sellingPrice;
  int upgradeLevel;
  double attackSpeed;
  Target target;
  Damage damage;
  Field position;
  
  Tower(int range, Field attackField, int price, int sellingPrice, 
      int upgradeLevel){
    this.setRange(range);
    this.setAttackField(attackField);
    this.setPrice(price);
    this.setSellingPrice(sellingPrice);
    this.setUpgradeLevel(upgradeLevel);
    //this.target = new Target();
   // this.damage = new Damage();
  }
  
  Target shoot(Minion minion){
    return this.target;
  }
 
  void setCoordinates(Field f){
    position = f;
  }
  void upgrade(){
    
  }
  bool abilityCalculation(){
    return null;
  }
  
  // --------------getter-/setter methods-----------------//
  
  int getRange(){
    return this.range;
  }
  void setRange(int range){
    this.range = range;
  }
  Field getAttackField(){
    return this.attackField;
  }
  void setAttackField(Field attackField){
    this.attackField = attackField;
  }
  int getPrice(){
    return this.price;
  }
  void setPrice(int price){
    this.price = price;
  }
  int getSellingPrice(){
    return this.sellingPrice;
  }
  void setSellingPrice(int p){
    this.sellingPrice = p;
  }
  int getUpgradeLevel(){
    return this.upgradeLevel;
  }
  void setUpgradeLevel(int ul){
    this.upgradeLevel = ul;
  }
  double getAttackSpeed(){
    return this.attackSpeed;
  }
  void setAttackSpeed(double as){
    this.attackSpeed = as;
  }
  
}