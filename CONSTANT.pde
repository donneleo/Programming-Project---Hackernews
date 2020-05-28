//??
final int WINDOW = 800;
final int MARGIN = 100;

//SCREEN
final float SCREENX = 1000;
final float SCREENY = 900;

//COMMENT CONSTANTS
final float COMMENT_INDENT = SCREENX*0.05;
final float COMMENT_WIDTH = SCREENX*0.80;
final float COMMENT_HEIGHT = 100;

//WIDGET PARAMETERS
final float WIDGET_WIDTH = 180;
final float WIDGET_HEIGHT = 40;
final float SEARCH_BAR_CHAR_LIMIT = 2000;
final float STORY_HEIGHT = 120;
final float STORY_WIDTH = SCREENX*0.85;
final float UPVOTE_SPACE = 30;
final color COLOR_URL = color(100, 180, 244);
final float STORY_PADDING = 10;
final float SCROLL_BAR_WIDTH = 30;
final float BANNER_TOTAL_HEIGHT = WIDGET_HEIGHT*5.5;
final float FOOTER_TOTAL_HEIGHT = 2*(WIDGET_HEIGHT+40);
final float SCROLL_BAR_HEIGHT = SCREENY - BANNER_TOTAL_HEIGHT - FOOTER_TOTAL_HEIGHT/2;
final float STORY_DEFAULT_Y_POS = WIDGET_HEIGHT*5.5 + STORY_PADDING;
final float VISIBLE_PIXELS_AT_GIVEN_MOMENT = SCREENY - WIDGET_HEIGHT*5.5 - WIDGET_HEIGHT*2;
final int STORY_PER_PAGE = 20;

//SCREEN TYPES
final int SCREEN_STORY = 0;
final int SCREEN_COMMENT = 1;
final int SCREEN_SUBCOMMENT = 2;

//WIDGET EVENTS
final int EVENT_SCROLL_BAR = 1;
final int EVENT_SEARCH = 2;
final int EVENT_HOME = 3;
final int EVENT_SORTBY= 4;
final int EVENT_NEXTPAGE= 5;
final int EVENT_THEME= 6;
final int EVENT_CROWN = 7;
final int EVENT_FOOTER = 8;
final int EVENT_LASTPAGE = 9;
final int EVENT_BACK = 10;
final int URL_EVENT = 11;
final int EVENT_NULL = 0;
final int TEXT_CURSOR_SPEED = 30;
final int TEXT_CURSOR_TYPING = 20;


//QUERIES
final int SORT_EVENT_LATEST = 3;              //constants that only apply to sortBy class, separate from constants in CONSTANT class
final int SORT_EVENT_OLDEST = 4;
final int SORT_EVENT_MOST_LIKED = 5;
final int SORT_EVENT_LEAST_LIKED = 6;
final int SORT_EVENT_MOST_COMMENTED = 7;
final int SORT_EVENT_LEAST_COMMENTED = 8;

//THEMES
//Blue Light Mode
final int  BLUE_LIGHT_THEME = 1;
final color BLUE_LIGHT_BANNER = color(100, 180, 244);
final color BLUE_LIGHT_WIDGET_BG = color(255, 255, 255);
final color BLUE_LIGHT_WIDGET_ITEM = color(145, 145, 145);

//Red Light Mode
final int RED_LIGHT_THEME = 2;
final color RED_LIGHT_BANNER = color(244, 67, 54);
final color RED_LIGHT_WIDGET_BG = color(255, 255, 255);
final color RED_LIGHT_WIDGET_ITEM = color(145, 145, 145);

//Blue Dark Mode
final int BLUE_DARK_THEME = 3;
final color BLUE_DARK_BANNER = color(92,107,192);
final color BLUE_DARK_WIDGET_BG = color(97, 97, 97);
final color BLUE_DARK_WIDGET_ITEM = color(205, 205, 205);

//Red Dark Mode
final int RED_DARK_THEME = 4;
final color RED_DARK_BANNER = color(183, 28, 28);
final color RED_DARK_WIDGET_BG = color(97, 97, 97);
final color RED_DARK_WIDGET_ITEM = color(205, 205, 205);

//Orange Dark Theme
final int ORANGE_DARK_THEME = 5;
final color ORANGE_DARK_BANNER = color(255, 100, 0);
final color ORANGE_DARK_WIDGET_BG = color(97, 97, 97);
final color ORANGE_DARK_WIDGET_ITEM = color(255, 255, 255);

//SHARED
final color LIGHT_BACKGROUND = color(240, 240, 240);
final color LIGHT_MODE_PLAIN_TEXT = color(0);
final color DARK_MODE_PLAIN_TEXT = color(255, 255, 255);
final color DARK_BACKGROUND = color(30, 30, 30);     
