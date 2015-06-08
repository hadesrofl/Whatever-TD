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
   * Element to append the board to in the dom tree
   */
  Element boardElement;
  /**
   * Rows for the Board
   */
  int row;
  /**
   * Columns for the Board
   */
  int col;

/**
   * Constructor of the view
   * @param board - this is the datastructure for our board in dart. 
   * It cointains informations about the objects on the board which 
   * will be displayed in the view as images
   */
  View(int row, int col) {
    this.row = row;
    this.col = col;
    nameInput = querySelector("#playerName");
    start = querySelector("#start");
    stop = querySelector("#stop");
    boardElement = querySelector("#board");
    this.board = createBoard(row, col);
    boardElement.append(this.board);
  }
/**
   * Method to create a board 
   * @param board - contains all information which shall be displayed in the view
   * @return is a table element for the DOM-Tree
   */
  Node createBoard(int row, int col){
    final table = new TableElement();
    for(int i = 0; i < row; i++){
      table.append(new TableRowElement());
      for(int j = 0; j < col;j++){ // col.toString() + row.toString()
        final cellElement = new TableCellElement();
        cellElement.id = j.toString() + i.toString();
        cellElement.innerHtml = j.toString() + i.toString();
        table.children.elementAt(i).append(cellElement);
      }
    }
    return table;
  }
/**
   * Method to update a board 
   * @param board - contains all current information which shall be displayed in the view
   * @param table - Table Element of the Dom Tree to display informations of the board in html
   */
  void updateBoard(Map<String, String> board){
    for(int i = 0; i < this.board.children.length;i++){
      for(int j = 0; j < this.board.children.elementAt(0).children.length;j++){
        TableCellElement cell = this.board.children.elementAt(i).children.elementAt(j);
        cell.setInnerHtml(board[cell.id]);
        }
      }
  }
/**
   * Method to update the page
   */
  void updatePage() {
//TODO: Do fancy updating stuff _ rev 2
  }

}
