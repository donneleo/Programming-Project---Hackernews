//at the moment this only returns an int when a user clicks a particular option. Need to align it up with specific queries at a later point. //<>//

class SortBy extends Widget {

  ArrayList<Widget> dropDownMenu;

  SortBy(float x, float y, float width, float height, String label, int event)
  {
    super(x, y, width, height, label, iconSortBy, event);  

    dropDownMenu = new ArrayList<Widget>();
    Widget latestSB = new Widget(x, y+(height), width, height, "Latest", null, SORT_EVENT_LATEST);
    dropDownMenu.add(latestSB);   
    Widget oldestSB = new Widget(x, y+(2*height), width, height, "Oldest", null, SORT_EVENT_OLDEST);
    dropDownMenu.add(oldestSB);
    Widget mostCommSB = new Widget(x, y+(3*height), width, height, "Most Comments", null, SORT_EVENT_MOST_COMMENTED);
    dropDownMenu.add(mostCommSB);
    Widget leastCommSB = new Widget(x, y+(4*height), width, height, "Least Comments", null, SORT_EVENT_LEAST_COMMENTED);
    dropDownMenu.add(leastCommSB);
    Widget mostLikedSB = new Widget(x, y+(5*height), width, height, "Most Liked", null, SORT_EVENT_MOST_LIKED);
    dropDownMenu.add(mostLikedSB);
    Widget leastLikedSB = new Widget(x, y+(6*height), width, height, "Least Liked", null, SORT_EVENT_LEAST_LIKED);
    dropDownMenu.add(leastLikedSB);
  }

  void drawDropDownMenu()
  {
    if (currentScreenType != SCREEN_SUBCOMMENT)  //Stephen: have to have this if condition, so that sort by isn't drawn on subcomments
    {
      for (int i = 0; i<dropDownMenu.size(); i++)
      {
        Widget subMenu = dropDownMenu.get(i);
        subMenu.draw();
      }
    }

    if (currentScreenType == SCREEN_STORY) storyScreen.dropDownOnScreen = true;
    if (currentScreenType == SCREEN_COMMENT) commentScreen.dropDownOnScreen = true;
  }

  int getSortByEvent()
  {
    if (currentScreenType != SCREEN_SUBCOMMENT)  //Stephen: same condition as above.
    {
      int event;
      for (int i = 0; i<dropDownMenu.size(); i++) 
      {
        Widget aDropDown = (Widget) dropDownMenu.get(i);
        event = aDropDown.getEvent(mouseX, mouseY);
        if (event>0) 
        {
          currentStoryPage = 1;
          return event;
        }
      }
    }
    return EVENT_NULL;
  }
}
