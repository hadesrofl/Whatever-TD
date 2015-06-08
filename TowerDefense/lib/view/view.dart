library view;

import "dart:html";

/**
   * This Class handles the appearance of our game and manipulates the DOM-Tree of HTML
   */
class View {
/**
   * An inputElement so that the user can type in his name
   */
  InputElement nameInput;
/**
   * A start button to start or continue the game
   */
  ButtonElement start;
/**
   * A stop button if the player wants to stop the game
   */
  ButtonElement stop;
/**
   * The board as table. The board has a given size
   */
  TableElement board;

/**
   * Constructor of the view
   * @param board - this is the datastructure for our board in dart. 
   * It cointains informations about the objects on the board which 
   * will be displayed in the view as images
   */
  View(Map<String, String> board) {
    nameInput = querySelector("#playerName");
    start = querySelector("#start");
    stop = querySelector("#stop");
    this.board = createHTMLTable(board);
  }
/**
   * Method to create a board 
   * @param board - contains all information which shall be displayed in the view
   * @return is a table element for the DOM-Tree
   */
  TableElement createHTMLTable(Map<String, String> board) {
//TODO: Do fancy creating stuff
    return null;
  }
/**
   * Method to update a board 
   * @param board - contains all current information which shall be displayed in the view
   */
  void updateBoard() {
//TODO: Do fancy updating stuff
  }
/**
   * Method to update the page
   */
  void updatePage() {
//TODO: Do fancy updating stuff _ rev 2
  }

  //-------------------getter-/setterMethods---------------------------//

  InputElement getPlayerName() {
    return this.nameInput;
  }
}
