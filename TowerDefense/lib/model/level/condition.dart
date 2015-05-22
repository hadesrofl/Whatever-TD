part of level;
/**
 * 
 */
class condition{
  /**
   * 
   */
  String identifier;
  /**
   * 
   */
  int duration;
  /**
   * 
   */
  double damagePerTurn;
/**
 * 
 */
  condition(String identifier, int duration){
    this.identifier = identifier;
   switch(this.identifier){
     case "Fire":
       this.duration = 5;
       this.damagePerTurn = 2.0;
       break;
   }
  }
  /**
   * 
   */
  void apply(){
    
  }
}