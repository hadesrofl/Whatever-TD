part of tower;

class FireTower extends Tower{
 bool ignite;
  
  FireTower(int x,int y, int range,Field attackField,int price,int sellingPrice,
      int upgradeLevel,double attackSpeed,Target target,Damage damage, this.ignite):
    super(range,attackField,price,sellingPrice,upgradeLevel);
  
}