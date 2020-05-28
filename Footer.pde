class Footer extends Widget{    //Written by Eoin & Stephen. Draws the Next and Last Page buttons on screen, and the number of the page the user is currently on. 
  
  Footer() 
  {
    super(0.0, SCREENY-(WIDGET_HEIGHT+40), SCREENX, WIDGET_HEIGHT*2, null, null, EVENT_FOOTER);
    nextPage = new Widget(SCREENX-WIDGET_WIDTH-20, SCREENY-WIDGET_HEIGHT-20, WIDGET_WIDTH, WIDGET_HEIGHT, "NEXT PAGE", iconRightArrow, EVENT_NEXTPAGE);  //x,y parameters are so that this always appears at the very bottom right hand side of the screen, with a padding of 20 on both x and y axis.
    lastPage = new Widget(20, SCREENY-WIDGET_HEIGHT-20, WIDGET_WIDTH, WIDGET_HEIGHT, "LAST PAGE", iconLeftArrow, EVENT_LASTPAGE);
    
  }

  void draw() 
  {
    if(currentScreenType == SCREEN_STORY)    //don't want a footer on comment screens
    {
      fill(widgetBackgroundColor);
      rect(0, SCREENY-(WIDGET_HEIGHT+40), SCREENX, WIDGET_HEIGHT*2);
  
      fill(widgetItemColor); textFont(fontWidget); textAlign(CENTER, CENTER);
      text("Page " + currentStoryPage, SCREENX/2, SCREENY-((WIDGET_HEIGHT+40)/2));
      
      if(queryStoryBackup.size() > currentStoryPage*20) nextPage.draw();    //if there are more stories left after this page for a given query, then draw next page.
      
      if(currentStoryPage > 1) lastPage.draw();
    }
  }
  
  int getEvent(float mX, float mY)      //determines if Next Page or Last Page buttons have been pressed
  {
    if(currentScreenType == SCREEN_STORY)    //don't want a footer on comment screens, as they will not have pages, and this will also give more room to display the comments
    {
      int event = EVENT_NULL;
      int nextPageEvent = nextPage.getEvent(mX, mY);
      int lastPageEvent = lastPage.getEvent(mX, mY);
      if(nextPageEvent > 0) event = nextPageEvent;
      else if(lastPageEvent > 0) event = lastPageEvent;
      return event;
    }
    return 0;
    
  }
}
