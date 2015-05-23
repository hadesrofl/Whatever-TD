part of tower;

class FireTower extends Tower{
 bool ignite;
  
  FireTower(int x,int y, int range,int attackField,int price,int sellingPrice,
      int upgradeLevel,double attackSpeed,target target,damage damage, this.ignite):
    super(x,y,range,attackField,price,sellingPrice,upgradeLevel,attackSpeed,target,damage);
  
}