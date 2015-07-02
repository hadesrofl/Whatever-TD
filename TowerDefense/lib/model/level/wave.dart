part of level;

/**
 * This class represents a wave object. A wave has a specific number of minions. 
 * Many waves together are one level
 */
class Wave {
  /**
   * Number of the wave
   */
  int _waveNumber;
  /**
   * The number of minions of this wave
   */
  int _numberOfMinions;
  /**
   * Is this wave the final wave of the level or not
   */
  bool _finalWave;
  /**
   * the number of slain minions of this wave
   */
  int _deadMinions;
  /**
   * Minions leaked to the end of the map
   */
  int _leakedMinions;
  /**
   * List of Minions of this wave
   */
  List<Minion> _minions = new List<Minion>();
  /**
   * droppedGold in this wave
   */
  int _droppedGold = 0;

  /**
   * Constructor of a wave object
   * @param waveNumber is number of this wave
   * @param finalWave is true if this is the final wave of the level, false if not
   */
  Wave(int waveNumber, bool finalWave) {
    this._waveNumber = waveNumber;
    this._finalWave = finalWave;
    this._deadMinions = 0;
    this._leakedMinions = 0;
    this._numberOfMinions = 0;
  }
  /**
   * Method to decrease the number of Minions
   */
  void decMinions() {
    this._numberOfMinions--;
  }
  /**
   * Method to increase the number of slain minions
   */
  void incDeadMinions() {
    this._deadMinions++;
  }
  /**
   * Checks if the wave is clear
   * @return true if all minions are dead else false
   */
  bool isWaveClear() {
    bool waveClear;
    if (_numberOfMinions == _deadMinions + _leakedMinions) {
      waveClear = true;
    } else {
      waveClear = false;
    }
    return waveClear;
  }
  /**
   * Adds a minion to the list of minions
   * @param m is the m to add
   */
  void addMinion(Minion m){
    this._minions.add(m);
    this._numberOfMinions++;
  }
  /**
   * Increases the number of leakedMinions
   */
  void incLeakedMinions(){
    this._leakedMinions++;
  }
  /**
   * Increases the amount of dropped gold of this wave
   * @param is the amount of gold dropped by a minion
   */
  void incDroppedGold(int droppedMinionsGold){
    this._droppedGold += droppedMinionsGold;
  }
  /**
   * ---------------Getter and Setter Methods---------------------
   */
  /**
   * Returns the finalWave as bool
   * @return TRUE if it is the finalWave else FALSE
   */
  bool isFinalWave() {
    return this._finalWave;
  }
  /**
   * Returns the number of the wave
   * @return number of this wave and level
   */
  int getWaveNumber() {
    return this._waveNumber;
  }
  /**
   * Returns the number of total minions of this wave
   * @return number of the minions of this wave
   */
  int getNumberOfMinions() {
    return this._numberOfMinions;
  }
  /**
   * Returns the number of slain minions of this wave
   * @return number of the slain minions
   */
  int getDeadMinions() {
    return this._deadMinions;
  }
  /**
   * Gets a list of all minions but only once
   * @return a list of distinct minions of this wave
   */
  List<Minion> getDistinctMinions(){
    bool found;
    List<Minion> distinct = new List<Minion>();
    if(this._minions.length > 0){
    this._minions.forEach((m){
      found = false;
      /* List is not empty */
      if(distinct.length > 0){
        /* Compare all minions to the already added distinct minions */
        distinct.forEach((dm){
         if(m.getName().compareTo(dm.getName()) == 0){
           found = true;
        }});
      }else{
        found = true;
        distinct.add(m);
      }
      if(found != true){
        distinct.add(m);
      }
    });
    }
    return distinct;
  }
  /**
   * Gets the minions of this wave
   * @return a list of all minions of this wave
   */
  List<Minion> getMinions(){
    return this._minions;
  }
  /**
   * Gets the amount of dropped gold
   * @return the dropped gold
   */
  int getDroppedGold(){
    return this._droppedGold;
  }
}
