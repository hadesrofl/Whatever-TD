part of tower;

class fireTower extends tower{
 bool ignite;
  
  fireTower(int x,int y, int range,int attackField,int price,int sellingPrice,
      int upgradeLevel,double attackSpeed,target target,damage damage, this.ignite):
    super(x,y,range,attackField,price,sellingPrice,upgradeLevel,attackSpeed,target,damage);
  
}