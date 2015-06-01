part of tower;

class LighteningTower extends Tower{
  bool overloaded;
  
  LighteningTower(int range,Field attackField,int price,int sellingPrice,
      int upgradeLevel,double attackSpeed,Target target,Damage damage, this.overloaded):
    super(range,attackField,price,sellingPrice,upgradeLevel);
  
}