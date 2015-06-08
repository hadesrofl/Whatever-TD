/**
 * Class to represent a field on our board
 */
class Field{
  /**
   * Identifier for the field
   */
  String identifier;
  /**
   * x position of this field
   */
  int x;
  /**
   * y position of this field
   */
  int y;
  /**
   * Bool if this field is a field of the path the minions have to follow
   */
  bool pathField;
  /**
   * Bool if this fiel is covered with a tower or not
   */
  bool covered;
  /**
   * Constructor
   * @param x - x coordinate of this field
   * @param y - y coordinate of this field
   */
  Field(int x, int y, bool pathField){
    this.identifier = x.toString() + y.toString();
    this.x = x;
    this.y = y;
    this.pathField = pathField;
    this.covered = false;
  }
  /**
   * Checks if a given field object is the same as this field object
   * @param f - field object to check equality for
   * @return true if they are the same else false
   */
  bool equals(Field f){
    bool same;
    if(this.identifier.compareTo(f.getIdentifier()) == 0 && this.getX() == f.getX() && this.getY() == f.getY()){
      same = true;
    }
    else{
      same = false;
    }
    return same;
  }
  /**
     * ---------------Getter and Setter Methods---------------------
     */
  /**
   * Returns the x coordinate of this field
   * @return the value of x
    */
  int getX(){
    return this.x;
  }
  /**
   * Returns the y coordinate of this field
   * @return the value of y
    */
  int getY(){
    return this.y;
  }
  /**
   * Returns the identifier of this field
   * @return the identifier of this field as string
    */
  String getIdentifier(){
    return this.identifier;
  }
  /**
   * Checks if this field is a field of the path the minions have to follow
   * @return true if it is else false
   */
  bool isPathField(){
    return this.pathField;
  }
  /**
   * Checks if this field is covered
   *  
   */
  bool isCovered(){
    return this.covered;
  }
  void setCovered(bool covered){
    this.covered = covered;
  }
}