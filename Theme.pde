class Theme extends Widget {    //Written by Eoin and Stephen
  ArrayList<Widget> dropDownMenu;
  color widgetBackgroundColor;
  color widgetItemColor;

  Theme(float x, float y, float width, float height, String label, int event)
  {
    super(x, y, width, height, label, iconTheme, event);  

    dropDownMenu = new ArrayList<Widget>();
    Widget blueLight = new Widget(x, y+(height), width, height, "Light/Blue", null, BLUE_LIGHT_THEME);
    dropDownMenu.add(blueLight);    
    Widget redLight = new Widget(x, y+(2*height), width, height, "Light/Red", null, RED_LIGHT_THEME);
    dropDownMenu.add(redLight);   
    Widget blueDark = new Widget(x, y+(3*height), width, height, "Dark/Blue", null, BLUE_DARK_THEME);
    dropDownMenu.add(blueDark);
    Widget redDark = new Widget(x, y+(4*height), width, height, "Dark/Red", null, RED_DARK_THEME);
    dropDownMenu.add(redDark);
    Widget orangeDark = new Widget(x, y+(5*height), width, height, "Dark/Orange", null, ORANGE_DARK_THEME);
    dropDownMenu.add(orangeDark);
  }

  void drawDropDownMenu()
  {
    for (int i = 0; i<dropDownMenu.size(); i++)
    {
      Widget subMenu = dropDownMenu.get(i);
      subMenu.draw();
    }
    
    if(currentScreenType == SCREEN_STORY) storyScreen.dropDownOnScreen = true;
    if(currentScreenType == SCREEN_COMMENT) commentScreen.dropDownOnScreen = true;
    
  }

  int getDropDownEvent()
  {
    int event;
    for (int i = 0; i<dropDownMenu.size(); i++) 
    {
      Widget aDropDown = (Widget) dropDownMenu.get(i);
      event = aDropDown.getEvent(mouseX, mouseY);
      if (event>0)  return event;
    }
    return EVENT_NULL;
  }
}
