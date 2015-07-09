part of game;

/**
 * Class to represent a field on our board
 * @author Florian Winzek
 */
class Field {
  /**
   * x position of this field
   */
  int _x;
  /**
   * y position of this field
   */
  int _y;
  /**
   * Bool if this field is a field of the path the minions have to follow
   */
  bool _pathField;
  /**
   * Bool if this fiel is covered with a tower or not
   */
  bool _covered;
  /**
   * Constructor
   * @param x - x coordinate of this field
   * @param y - y coordinate of this field
   */
  Field(int x, int y, bool pathField) {
    this._x = x;
    this._y = y;
    this._pathField = pathField;
    this._covered = false;
  }
  /**
   * Checks if a given field object is the same as this field object
   * @param f - field object to check equality for
   * @return true if they are the same else false
   */
  bool equals(Field f) {
    bool same;
    if (this.getX() == f.getX() &&
        this.getY() == f.getY()) {
      same = true;
    } else {
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
  int getX() {
    return this._x;
  }
  /**
   * Returns the y coordinate of this field
   * @return the value of y
    */
  int getY() {
    return this._y;
  }
  /**
   * Checks if this field is a field of the path the minions have to follow
   * @return true if it is else false
   */
  bool isPathField() {
    return this._pathField;
  }
  /**
   * Checks if this field is covered
   *  
   */
  bool isCovered() {
    return this._covered;
  }
  /**
   * Sets this field as covered
   */
  void setCovered(bool covered) {
    this._covered = covered;
  }
  /**
   * Returns the field object as string
   */
  String toString() {
    return this.getX().toString() + this.getY().toString();
  }
  /**
   * Sets this field as path field
   */
  void setPathField(bool b){
    this._pathField = b;
  }
}
