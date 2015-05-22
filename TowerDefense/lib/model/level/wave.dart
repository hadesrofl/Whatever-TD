part of level;
/**
 * 
 */
class wave{
  /**
   * 
   */
  int identifier;
  /**
   * 
   */
  int numberOfMinions;
  /**
   * 
   */
  bool finalWave;
  /**
   * 
   */
  wave(int identifier, int numberOfMinions, bool finalWave){
    this.identifier = identifier;
    this.numberOfMinions = numberOfMinions;
    this.finalWave = finalWave;
  }
  /**
   * 
   */
  void decMinions(){
    this.numberOfMinions--;
  }
}