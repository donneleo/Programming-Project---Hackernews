class Banner extends Widget {    //Written by Stephen

  String textInput;    
  float scrollEffect;         //used for when width of text entry is greater than width of searchbox
  PImage searchIcon;
  int bannerScreenType;
  boolean blink;              //determines if text cursor should be blinking
  int timeSinceLastTyped;     //used to determine if the text cursor should be solid, if the user is currently typing.
  float bannerHeightValue;

  String currentQueryLabel;   //printed on screen, tells the user their current query

  Banner(float searchBoxX, float searchBoxY, float width, float height, PImage icon, int bannerScreenType, int event)
  {
    super(searchBoxX, searchBoxY, width, height, "", icon, event); 
    textInput = "";
    this.bannerScreenType = bannerScreenType;
    searchIcon = icon;
    bannerHeightValue = 3*WIDGET_HEIGHT;
    
  }

  //@Override
  void draw()
  {    
    fill(headerColor); 
    noStroke(); 
    rect(x, 0, SCREENX-x, bannerHeightValue);

    fill(widgetBackgroundColor); 
    stroke(widgetItemColor);  
    strokeWeight(1);                                        //background rectangle of searchBar
    rect(x, y, width, height);

    fill(widgetItemColor); 
    textFont(fontWidget);
    textAlign(LEFT, CENTER);                                //text input from user being printed back to screen with scroll effect
    text(textInput, x+height-scrollEffect, y+(height/2));

    textSize(13); 
    fill(50); 
    textAlign(RIGHT, CENTER);                               //small "[DEL] to clear" message below searchBox
    text("[DEL] TO CLEAR", x+width, height*2+10);

    fill(headerColor);                                      //background color of entire header
    noStroke();    
    rect(0, 0, x, bannerHeightValue);

    fill(widgetBackgroundColor); 
    noStroke();                                             //box behind magnifying glass on searchbar, so text doesn't interfere with image, 
    rect(x+1, y+1, height-1, height-1);                     //and color matches background rectangle of searchBar

    tint(widgetItemColor); 
    imageMode(CENTER);                                      //magnifying glass image with same color tint as text
    image(searchIcon, x+(height/2), y+(height/2), height*0.75, height*0.75);
    
    fill(plainText); 
    textFont(fontTitle); 
    textAlign(LEFT, CENTER);                                //main title "HackerNews"
    text("HackerNews", 50, ((WIDGET_HEIGHT*3)/2));
    
    if(this.bannerScreenType != SCREEN_SUBCOMMENT)               //space to display the current query.
    {
      fill(lerpColor(backgroundColor, widgetBackgroundColor, 0.5)); noStroke();
      rect(0, bannerHeightValue + WIDGET_HEIGHT, SCREENX, WIDGET_HEIGHT*1.5);
      
      fill(plainText); 
      textFont(fontQuery); 
      textSize(35);
      textAlign(LEFT, TOP);
      if(queryLabelOnScreen.length() > 35) currentQueryLabel = queryLabelOnScreen.substring(0, 35) + "...\"";
      else currentQueryLabel = queryLabelOnScreen;
      text(currentQueryLabel, 50, WIDGET_HEIGHT*4.5);
      int resultSize = queryStoryBackup.size();
      textAlign(LEFT, TOP);
      if(currentScreenType == SCREEN_STORY) text ("Results found: " + resultSize, SCREENX-textWidth("Results found: 99999")-10, WIDGET_HEIGHT*4.5);
    }
    
    fill(widgetBackgroundColor); stroke(widgetItemColor);      // blank bar behind the widgets, just for asthetics.
    rect(0, bannerHeightValue, SCREENX, WIDGET_HEIGHT);

    //draws the text cursor (blinking line after text). Determines if it should draw the line using the framecount and the TEXT_CURSOR_SPEED constant (to create blinking effect), OR if the 
    //user is currently typingv(solid line). Every time the user enters a new character, a "timeSinceLastTyped" int is restored to TEXT_CURSOR_TYPING, and this will be decremented every frame, so that
    //the text cursor will not blink if the user has typed within the last 20 frames (or whatever value TEXT_CURSOR_TYPING is set to).

    if ((blink && frameCount%(2*TEXT_CURSOR_SPEED)<=TEXT_CURSOR_SPEED)||(blink && timeSinceLastTyped>0))
    {
      textFont(fontWidget);
      float blinkerXPos = textWidth(textInput)-scrollEffect+2;
      stroke(widgetItemColor); strokeWeight(1); textFont(fontWidget);
      line(x+height+blinkerXPos, y+0.25*height, x+height+textWidth(textInput)-scrollEffect+2, y+0.75*height);
    }

    timeSinceLastTyped--;  //always decrement by one so we know how long since the user last typed
  }

  void typing(char nextKey)
  {
    textFont(fontWidget);
    if (key>=' ' && key<='~' && textWidth(textInput) < SEARCH_BAR_CHAR_LIMIT)   //if key entered is a printable key, then add to textInput string
    {
      textInput = textInput + nextKey;
      timeSinceLastTyped = TEXT_CURSOR_TYPING;

      if (textWidth(textInput) > width-height-5) scrollEffect = scrollEffect+(textWidth(nextKey));
    } 
    else if (nextKey == BACKSPACE)                                              //if user presses backspace, then reduce scrollEffect by width of last character, 
    {                                                                           //and remove this last character from string
      if (textInput.length() > 0) 
      {
        if (scrollEffect>0) scrollEffect = scrollEffect-textWidth(textInput.substring(textInput.length()-1));
        textInput = textInput.substring(0, textInput.length() - 1);

        /* increment scrollEffect by width of new character, if necessary.
         * Uses "width-height-5" because height is the same as the width of the 
         * magnifying glass icon, so we need to include this, and the -5 is just for
         * padding of the left hand side of the searchBox.
         */
      }

      timeSinceLastTyped = TEXT_CURSOR_TYPING;
    } else if (nextKey == DELETE)                                                //if user presses DEL, then clears searchBox and the textInput string.
    {
      textInput = ""; 
      scrollEffect = 0;
    }
  }

  void activateBlinker(boolean blink)
  {
    this.blink = blink;
  }

  String getSearchQuery()
  {
    return textInput;            //in main, keyPressed() calls this function when user presses ENTER. This returns the text they entered in searchBox as a String.
  }
}
