library view;

import "dart:html";
/* TODO: DeathCounter for Minions */

/**
   * This Class handles the appearance of our game and manipulates the DOM-Tree of HTML
   */
class View {
/**
   * An inputElement so that the user can type in his name
   */
  InputElement nameInput;
  /**
   * Label for the name and points of a player
   */
  Element nameLabel;
  /**
   * Container of the menu
   */
  Element menuContainer;
  /**
   * Unordered List Element for the menu
   */
  UListElement menu;
  /**
   * Container of the highscore Table
   */
  Element highScoreContainer;
  /**
   * Ordered List Element for showing some points of other players
   */
  OListElement highScoreTable;
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
    nameLabel = querySelector("#player");
    menuContainer = querySelector("#navigation");
    highScoreContainer = querySelector("#highscore");

    stop.hidden = true;
    menuContainer.hidden = true;
    highScoreContainer.hidden = true;
  }
/**
   * Method to create a board 
   * @param board - contains all information which shall be displayed in the view
   * @return is a table element for the DOM-Tree
   */
  void createBoard(int row, int col) {
    final table = new TableElement();
    for (int i = 0; i < row; i++) {
      table.append(new TableRowElement());
      for (int j = 0; j < col; j++) {
        // col.toString() + row.toString()
        final cellElement = new TableCellElement();
        cellElement.id = j.toString() + i.toString();
        cellElement.innerHtml = j.toString() + i.toString();
        table.children.elementAt(i).append(cellElement);
      }
    }
    this.board = table;
    boardElement.append(this.board);
  }
/**
   * Method to update a board 
   * @param board - contains all current information which shall be displayed in the view
   * @param table - Table Element of the Dom Tree to display informations of the board in html
   */
  void updateBoard(Map<String, String> board) {
    for (int i = 0; i < this.board.children.length; i++) {
      for (int j = 0;
          j < this.board.children.elementAt(0).children.length;
          j++) {
        TableCellElement cell =
            this.board.children.elementAt(i).children.elementAt(j);
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
  void createHighScoreTable() {
    this.highScoreContainer.hidden = false;
    this.highScoreContainer.innerHtml = "<strong>Highscore</strong>";
    this.highScoreTable = new OListElement();
    this.highScoreTable.id = "highscoreTable";
    this.highScoreContainer.append(this.highScoreTable);
    for (int i = 0; i < 5; i++) {
      LIElement le = new LIElement();
      le.text = "Player $i";
      this.highScoreTable.append(le);
    }
  }
  void createMenu() {
    ButtonElement buy = new ButtonElement();
    ButtonElement sell = new ButtonElement();
    ButtonElement upgrade = new ButtonElement();

    this.menuContainer.hidden = false;
    this.menuContainer.innerHtml = "<strong>Menu</strong>";
    this.menu = new UListElement();
    this.menu.id = "menu";
    this.menuContainer.append(menu);
    LIElement Buy = new LIElement();
    Buy.append(buy);
    buy.text = "Buy";
    LIElement Sell = new LIElement();
    Sell.append(sell);
    sell.text = "Sell";
    LIElement Upgrade = new LIElement();
    Upgrade.append(upgrade);
    upgrade.text = "Upgrade";
    this.menu.append(Buy);
    this.menu.append(Sell);
    this.menu.append(Upgrade);
  }
}
