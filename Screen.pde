class Screen {                  // Written by Stephen & Adam. Instance of a screen. Draws all story widgets or comment widgets first, then draws all the relevant widgets on top. //<>// //<>// //<>//
  ScrollBar scrollBar;
  Widget backButton;
  int screenType;               // used to determine which ArrayList of story/comment widgets it should draw
  int offset=60;
  float screenTotalHeightAllContent;  // created by makeStoryWidgets or addComments in main, and passed as parameters to be remembered by this instance of screen.
  float screenRatioSliderToBar;       // same as above
  int arrayListSize;
  boolean dropDownOnScreen;

  Screen(float totalHeightAllContent, float ratioSliderToBar, int screenType) //written by stephen, will write a description in The next few days about this and add it to the shared doc. IGNORE SCROLL BAR FOR THE MOMENT, IT'S NOT WORKING
  { 
    this.screenType = screenType;
    screenTotalHeightAllContent = totalHeightAllContent;
    screenRatioSliderToBar = ratioSliderToBar;
    dropDownOnScreen = false;

    //scrollBar is created here because each screen will have a unique scroll bar. Back button is created here because we don't want a back button on storyScreen.
    scrollBar = new ScrollBar(SCREENX - SCROLL_BAR_WIDTH, BANNER_TOTAL_HEIGHT, SCROLL_BAR_WIDTH, SCROLL_BAR_HEIGHT, screenRatioSliderToBar*SCROLL_BAR_HEIGHT, screenTotalHeightAllContent, EVENT_SCROLL_BAR);
    backButton = new Widget(WIDGET_HEIGHT*2+WIDGET_WIDTH, WIDGET_HEIGHT*3, WIDGET_WIDTH, WIDGET_HEIGHT, "BACK", iconLeftArrow, EVENT_BACK);
  }

  void draw()
  {
    background(backgroundColor);

    if (currentScreenType == SCREEN_SUBCOMMENT && subCommentDisplay.size()>1)    //draws the lines beside the subcomments to easily see what subcomment is replying to what.
    {
      Comment lastComment = subCommentDisplay.get(subCommentDisplay.size()-1);
      int stopLinePoint = (int) (lastComment.y + lastComment.height);
      for (int i = 0; i < 15; i++)
      {
        strokeWeight(1); 
        fill(widgetItemColor);
        line(COMMENT_INDENT+(20*i), BANNER_TOTAL_HEIGHT+(STORY_PADDING*2), COMMENT_INDENT+(20*i), stopLinePoint);
      }
    }

    //Stephen: this is used to determine the size of the array being draw in this instance of Screen
    if (screenType == SCREEN_STORY) arrayListSize = storyDisplay.size();
    else if (screenType == SCREEN_COMMENT) arrayListSize = commentDisplay.size();
    else if (screenType == SCREEN_SUBCOMMENT)  arrayListSize = subCommentDisplay.size();

    if ((arrayListSize > 0) || (arrayListSize>1 && currentScreenType == SCREEN_SUBCOMMENT))
    {
      for (int index = 0; index < arrayListSize; index++)
      {
        if (screenType == SCREEN_STORY) storyDisplay.get(index).draw();
        else if (screenType == SCREEN_COMMENT) 
        {
          commentDisplay.get(index).draw();
          fill(backgroundColor); 
          noStroke();
          rect(0, BANNER_TOTAL_HEIGHT, SCREENX - scrollBar.barWidth, clickedOnStory.height + 40);  // draws a rectangle around the story that is displayed on the comment screen, so that the comments look better when scrolling on screen
          clickedOnStory.draw();  // draws the story on the top of the comment screen
        } else if (screenType == SCREEN_SUBCOMMENT) 
        {
          subCommentDisplay.get(index).draw();
        }
      }
    }
    else
    {
      if(currentScreenType == SCREEN_COMMENT) 
      {
        clickedOnStory.draw();  //draws story regardless of if it has comments
        textFont(fontQuery); fill(widgetItemColor); textAlign(CENTER, CENTER);
        text("No content here", SCREENX/2, SCREENY/2);
      }
      if(currentScreenType == SCREEN_SUBCOMMENT) 
      {
        commentClicked.setY(STORY_PADDING  + STORY_DEFAULT_Y_POS);
        commentClicked.draw();
      }
      
    }

    scrollBar.draw();

    for (int i = 0; i< widgetList.size(); i++) 
    {
      Widget aWidget = (Widget) widgetList.get(i);
      if (currentScreenType == SCREEN_SUBCOMMENT && aWidget == sortBy) {  //this if statement makes sure that sortBy is not drawn on subcommentScreen.
      } else aWidget.draw();
    }

    if (currentScreenType != SCREEN_STORY)    //this if statement makes sure back button is not draw on storyScreen
      backButton.draw();

    if (currentEvent == EVENT_SORTBY && dropDownOnScreen) sortBy.drawDropDownMenu();     //if last thing the user clicked on was the sort-by button, then display the sort by drop down menu
    else if (currentEvent == EVENT_THEME && dropDownOnScreen) theme.drawDropDownMenu();     //if last thing the user clicked on was the sort-by button, then display the sort by drop down menu  

    if (currentEvent==EVENT_SEARCH) banner.activateBlinker(true);    //if last thing the user clicked on was search bar, then activate the text cursor to show them that they can type
    else banner.activateBlinker(false);

    //coded by Eoin to disiplay the widgets to move back and forth through screens, displaying the appropriate widgets
    if (currentEvent == EVENT_NEXTPAGE)
    {
      for (int index = 4; index<widgetList.size(); index++)
      {
        Widget aWidget = (Widget) widgetList.get(index);
        aWidget.draw();
      }
    }

    if (currentEvent == EVENT_LASTPAGE)
    {
      if (currentStoryPage > 1)
      {
        for (int index = 0; index<widgetList.size(); index++)
        {
          Widget aWidget = (Widget) widgetList.get(index);
          aWidget.draw();
        }
      } else if (currentStoryPage == 1)
      {
        for (int index = 0; index < 4; index++) 
        {
          Widget aWidget = (Widget) widgetList.get(index);
          aWidget.draw();
        }
      }
    }
  }

  void moveScrollBar(float mY)
  {
    scrollBar.move(mY);
  }

  void mousePressed()
  {
    if (currentEvent == EVENT_SORTBY) 
    {
      if (sortBy.getSortByEvent() == EVENT_NULL) dropDownOnScreen = false;
      else changeQuery(sortBy.getSortByEvent(), null);
    } else if (currentEvent == EVENT_THEME) 
    {
      if (theme.getDropDownEvent() == EVENT_NULL) dropDownOnScreen = false;
      else switchTheme(theme.getDropDownEvent());
    }

    int event = 0;
    boolean newEvent = false;
    for (Widget aWidget : widgetList) 
    {
      event = aWidget.getEvent(mouseX, mouseY);
      if (event>0) 
      {
        currentEvent = event;
        newEvent = true;
      }
    }    

    if (currentEvent == EVENT_SORTBY || currentEvent == EVENT_THEME) dropDownOnScreen = true;  //this boolean makes sure that no event will occur outside of the dropdown screens while dropdown is on screen. If the user clicks anywhere else, then dropDownOnScreen will be set to false in either SortBy or Theme.
    else dropDownOnScreen = false;

    if (currentEvent == 0 && currentScreenType != SCREEN_STORY)
    {
      currentEvent = backButton.getEvent(mouseX, mouseY);
    }

    if (currentEvent == 0)
    {
      event = this.scrollBar.getEvent(mouseX, mouseY);
      if (event>0) 
      {
        currentEvent = event;
        this.moveScrollBar(mouseY);
        newEvent = true;
      }
    }

    if (currentEvent == EVENT_HOME) 
    {
      currentScreenType = SCREEN_STORY;     //if the user clicks home, they will be immediately returned to the story screen
      changeQuery(EVENT_SEARCH, "");        //will find the absolute latest posts of the entire original story JSON arraylist.
      currentStoryPage = 1;
      makeStoryWidgets();
      storyScreen = new Screen(totalHeightAllContent, ratioSliderToBar, SCREEN_STORY);
    }

    if (currentEvent == EVENT_FOOTER)  currentEvent = footer.getEvent(mouseX, mouseY);

    if (currentEvent == EVENT_NEXTPAGE && queryStoryBackup.size()>currentStoryPage*20) 
    {
      currentStoryPage+=1;
      makeStoryWidgets();
      this.screenTotalHeightAllContent = totalHeightAllContent; //gets totalHeightAllContent and ratioSliderToBar from main that has been changed when next page is clicked
      this.screenRatioSliderToBar = ratioSliderToBar;
      scrollBar.sliderYPos = scrollBar.y;      //resets the scrollbar so it is at the top when page has changed
      currentEvent = 0;
    } else if (currentEvent == EVENT_LASTPAGE && currentStoryPage > 1)
    {
      currentStoryPage-=1;
      makeStoryWidgets();
      this.screenTotalHeightAllContent = totalHeightAllContent;
      this.screenRatioSliderToBar = ratioSliderToBar;
      scrollBar.sliderYPos = scrollBar.y;    //resets the scrollbar so it is at the top when page has changed
      currentEvent = 0;
    }

    if (currentScreenType != SCREEN_STORY)      // if there is a back button, then allow the user to return to the previous Screen (it can be either from subComment to Comment, or Comment to Story).
    {
      if (backButton.getEvent(mouseX, mouseY) == EVENT_BACK) 
      {
        if (currentScreenType == SCREEN_SUBCOMMENT)
        {
          currentScreenType = SCREEN_COMMENT;
          currentQueryList.clear();                  //bug fix, completely clears currentQueryList and subCommentDisplay when back button is pressed so the subcomments from a different story are not left over in the arraylists and displays unintentionally
          subCommentDisplay.clear();
          currentQueryList = queryCommentBackup;      //resets currentQueryList to the comment list, so that we can sort the main comments again, and subcomments are disregarded
          subCommentScreen.scrollBar.sliderYPos = subCommentScreen.scrollBar.y;    //resets the scroll bar slider y position of subcomment screen if user has returned to comment screen
          commentScreen.scrollBar.changeStoryHeight();    //small bug fix, when the comment appears on the subcomment screen, it's y pos is changed. When the user returns to the comment screen, the comment will remain in this y pos until the user scrolls. With this new line, the comment widget will revert back to the correct spot immediately.
          currentEvent = 0;
        } else if (currentScreenType == SCREEN_COMMENT) 
        {
          currentScreenType = SCREEN_STORY;
          commentScreen.scrollBar.sliderYPos = commentScreen.scrollBar.y;    //resets the scroll bar slider y position of comment screen if user has returned to story screen
          currentEvent = 0;
          storyScreen.scrollBar.changeStoryHeight();    //small bug fix, when the story appears on the comment screen, it's y pos is changed. When the user returns to the story screen, the story will remain in this y pos until the user scrolls. With this new line, the story widget will revert back to the correct spot immediately.
        }
      }
    }

    if (screenType == SCREEN_STORY)
    {
      if (mouseY > WIDGET_HEIGHT*5.5 && mouseY < footer.y && !dropDownOnScreen)    //gets event for clicked on story
      {
        for (StoryWidget storyOnScreen : storyDisplay)
        {
          if (storyOnScreen.getEvent(mouseX, mouseY)>0) 
          {
            clickedOnStory = storyOnScreen;
            currentScreenType = SCREEN_COMMENT;
            ArrayList<StoryData> descendants = getImmediateDescendants(storyOnScreen.story);
            currentQueryList = descendants;
            if (queryCommentBackup != null) queryCommentBackup.clear();
            if (commentDisplay != null) commentDisplay.clear();
            queryCommentBackup = descendants;
            makeCommentWidgets();
          }
        }
      }
    } else if (screenType == SCREEN_COMMENT)
    {
      if (mouseY > WIDGET_HEIGHT*5.5 + clickedOnStory.height && mouseY < footer.y && !dropDownOnScreen)  //gets event for 
      {
        for (Comment commentOnScreen : commentDisplay)
        {
          if (commentOnScreen.getEvent(mouseX, mouseY)>0 && !dropDownOnScreen) 
          {
            commentClicked = commentOnScreen;
            currentScreenType = SCREEN_SUBCOMMENT;
            ArrayList<StoryData> totalDescendants = getImmediateDescendants(commentClicked.commentData);  //first we need to find the comments immediate descendants, and this arraylist will be passed into the recursive function getCommentDescendants();
            for(int i = 0; i < totalDescendants.size(); i++)    //this for loop indents all the immediate descendants by 1, so that they are distince from the parent comment inthe subcomment screen
            {
              totalDescendants.get(i).setSubCommentIndentValue(1);
            }
            if (totalDescendants.size() > 0) totalDescendants.addAll(getCommentDescendants(totalDescendants, 2));      //the comment clicked, its immediate descendants, and the descendants of all these descendants are not in an ArrayList.
            totalDescendants.add(0, commentClicked.commentData);          //adds commented clicked to the top of the arraylist so it is displayed at the top of the subcomments.
            currentQueryList = totalDescendants;
            makeCommentWidgets();
          }
        }
      }
    }
    if (!newEvent) currentEvent = EVENT_NULL;
  }
}
