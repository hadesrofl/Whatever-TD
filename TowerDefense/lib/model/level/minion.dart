part of level;

class Armor{
final value;
 const Armor(this.value);
 toString() => 'Enum.$value';

 static const light = const Armor(1);
 static const medium = const Armor(2);
 static const heavy = const Armor(3);
}
 class minion{
  int hitpoints;
  Armor armor;
minion(){
  armor = new Armor(Armor.light);
      switch(armor){
        case 1:
  }
}
}