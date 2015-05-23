part of tower;

class Tower{
  int x;
  int y;
  int range;
  int attackField;
  int price;
  int sellingPrice;
  int upgradeLevel;
  double attackSpeed;
  Target target;
  Damage damage;
  
  Tower(int x, int y, int range, int attackField, int price, int sellingPrice, 
      int upgradeLevel){
    this.setX(x);
    this.setY(y);
    this.setRange(range);
    this.setAttackField(attackField);
    this.setPrice(price);
    this.setSellingPrice(sellingPrice);
    this.setUpgradeLevel(upgradeLevel);
    this.target = new Target();
    this.damage = new Damage();
  }
  
  Target shoot(Minion minion){
    return this.target;
  }
  void sell(){
    
  }
  void setCoordinates(){
    
  }
  void upgrade(){
    
  }
  bool abilityCalculation(){
    return null;
  }
  
  // --------------getter-/setter methods-----------------//
  
  int getX(){
    return this.x;
  }
  void setX(int x){
    this.x = x;
  }
  int getY(){
    return this.y;
  }
  void setY(int y){
    this.y = y;
  }
  int getRange(){
    return this.range;
  }
  void setRange(int range){
    this.range = range;
  }
  int getAttackField(){
    return this.attackField;
  }
  void setAttackField(int attackField){
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