library view;

import "dart:html";
/* TODO: DeathCounter for Minions */

/**
   * This Class handles the appearance of our game and manipulates the DOM-Tree of HTML
   */
class View {
  ButtonElement buy;
  ButtonElement cancel;
  ButtonElement sell;
  ButtonElement upgrade;
  ButtonElement canonTower;
  ButtonElement arrowTower;
  ButtonElement lightningTower;
  ButtonElement fireTower;
  TableElement buyMenu;
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
  Element errorDiv;
  Element errorDiv2;
  ButtonElement easy;
  ButtonElement medium;
  ButtonElement hard;
  Element p;

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
    buyMenu = querySelector("#buyMenu");
    buy = querySelector("#buy");
    cancel = querySelector("#cancel");
    sell = querySelector("#sell");
    upgrade = querySelector("#upgrade");
    canonTower = querySelector("#CanonTower");
    arrowTower = querySelector("#ArrowTower");
    lightningTower = querySelector("#LightningTower");
    fireTower = querySelector("#FireTower");
    errorDiv = querySelector("#errorDiv");
    errorDiv2 = querySelector("#errorDiv2");
    easy = querySelector("#easyGame");
    medium = querySelector("#mediumGame");
    hard = querySelector("#hardGame");
    p = querySelector("#difficulty");

    stop.hidden = true;
    menuContainer.hidden = true;
    highScoreContainer.hidden = true;
    buyMenu.hidden = true;
    cancel.hidden = true;
    errorDiv.hidden = true;
    errorDiv2.hidden = true;
    buy.hidden = true;
    upgrade.hidden = true;
    sell.hidden = true;
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
  void setTowerImageToTowerField(
      String id, Map<String, String> images, int key) {
    this.board.children.forEach((c) {
      c.children.forEach((children) {
        if (children.id == id) {
          switch (key) {
            case 1:
              children.style
                ..backgroundImage = "url(" + images["CanonTower1"] + ")";
              break;
            case 2:
              children.style
                ..backgroundImage = "url(" + images["ArrowTower1"] + ")";
              break;
            case 3:
              children.style
                ..backgroundImage = "url(" + images["FireTower1"] + ")";
              break;
            case 4:
              children.style
                ..backgroundImage = "url(" + images["LightningTower1"] + ")";
              break;
            default:
              break;
          }
        }
      });
    });
  }
  void deleteImage(String id, Map<String, String> images) {
    this.board.children.forEach((c) {
      c.children.forEach((children) {
        if (children.id == id) {
          children.style..backgroundImage = "url(" + images["Grass"] + ")";
        }
      });
    });
  }
  void upgradeImage(
      String id, Map<String, String> images, int towerDescription, int level) {
    print(towerDescription);
    print(level);
    this.board.children.forEach((c) {
      c.children.forEach((children) {
        if (children.id == id) {
          switch (towerDescription) {
            case 1:
              switch (level) {
                case 1:
                  children.style
                    ..backgroundImage = "url(" + images["CanonTower2"] + ")";
                  break;
                case 2:
                  children.style
                    ..backgroundImage = "url(" + images["CanonTower3"] + ")";
                  break;
              }
              break;
            case 2:
              switch (level) {
                case 1:
                  children.style
                    ..backgroundImage = "url(" + images["ArrowTower2"] + ")";
                  break;
                case 2:
                  children.style
                    ..backgroundImage = "url(" + images["ArrowTower3"] + ")";
                  break;
              }
              break;
            case 3:
              switch (level) {
                case 1:
                  children.style
                    ..backgroundImage = "url(" + images["FireTower2"] + ")";
                  break;
                case 2:
                  children.style
                    ..backgroundImage = "url(" + images["FireTower3"] + ")";
                  break;
              }
              break;
            case 4:
              switch (level) {
                case 1:
                  children.style
                    ..backgroundImage =
                    "url(" + images["LightningTower2"] + ")";
                  break;
                case 2:
                  children.style
                    ..backgroundImage =
                    "url(" + images["LightningTower3"] + ")";
                  break;
              }
              break;
            default:
              break;
          }
        }
      });
    });
  }
  void hideDifficultyMenu() {
    hard.hidden = true;
    medium.hidden = true;
    easy.hidden = true;
    buy.hidden = false;
    sell.hidden = false;
    upgrade.hidden = false;
    p.hidden = true;
  }
}
