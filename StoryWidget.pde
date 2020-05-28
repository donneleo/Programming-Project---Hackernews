//The class we can us eto make the stories appear as widgets on the screen, depending on  what query has been called, to be displayed on the relevant page.
//Adam.

class StoryWidget {
  Widget urlWidget;
  StoryData story;
  float x, y, baseY;
  float width, height;
  int event;
  boolean overURL = false;

  String title, user, date, url, type;
  int score, descendants, time;
  color upvoteSpaceColor;

  String postedByAndDateString;
  String numberOfCommentsString;
  String urlString;
  String titleString;
 
  StoryWidget(float x, float y, float width, float height, int event, StoryData story) 
  {
    this.x = x; 
    this.y = y; 
    baseY = y;
    this.width = width; 
    this.height = height;
    this.event = event;
    this.story = story;
    title = story.getTitle();
    user = story.getBy();
    url = story.getURL();
    score  =story.getScore();
    descendants = story.getDescendants();
    time = story.getTime();
    type = story.getType();
    date = format(time);
    this.urlWidget = new Widget (x+UPVOTE_SPACE+40, y+height-50, width, 22, "", null, URL_EVENT);  //coded by Eoin

    
    if(title != null)  //Stephen: Written to judge the height of the the title, which will be added to the total height of the story Widget, so we can make story widgets of various heights if title is long
    {
      textSize(22);
      textLeading(27);
      float totalWidth = ceil(textWidth(title));
      float textWidth = width-65;
      float numberOfLines = ceil(totalWidth/textWidth);
      float totalTitleHeight = numberOfLines*27 - 27;
      
      this.height = height + totalTitleHeight;
    }
  }

  void draw() {
    upvoteSpaceColor = lerpColor(backgroundColor, widgetBackgroundColor, 0.5);

    textAlign(CENTER, TOP);

    fill(widgetBackgroundColor); 
    stroke(widgetBackgroundColor); 
    strokeWeight(20); 
    strokeJoin(ROUND); 
    rect(x, y, width, height);

    fill(upvoteSpaceColor); 
    stroke(upvoteSpaceColor); 
    strokeWeight(20); 
    strokeJoin(ROUND);    
    rect(x, y, (UPVOTE_SPACE/2), height);

    fill(upvoteSpaceColor); 
    stroke(upvoteSpaceColor); 
    strokeWeight(20); 
    strokeJoin(MITER);    
    rect(x+UPVOTE_SPACE, y, (UPVOTE_SPACE)/2, height);

    tint(headerColor); 
    imageMode(CENTER);
    image(iconUpvote, x+(UPVOTE_SPACE/1.25), y+(height/3), 40, 40);

    fill(headerColor);
    textFont(fontWidget); 
    textSize(25);
    textAlign(CENTER, CENTER);
    text(score, x+(UPVOTE_SPACE-7), y+((height/3)*2));


    textAlign(LEFT, TOP);

    postedByAndDateString = "Posted By: " + user + "  Date: " + date;
    fill(widgetItemColor); 
    textFont(fontWidget); 
    textSize(17);
    text(postedByAndDateString, x+UPVOTE_SPACE+40, y+5);

    if (title!=null)
    {
      titleString = title;
      fill(plainText); 
      textFont(fontWidget);
      text(titleString, x+UPVOTE_SPACE+40, y+35, width-80, height-80);
    }

    if (url!=null)                                                            //Prints the url if there's one to show
    {
      if (url.length()>=60) urlString = url.substring(0, 60) + "...";
      else urlString = url;
      fill(COLOR_URL);
      textFont(fontWidget); 
      textSize(17);
      text(urlString, x+UPVOTE_SPACE+40, y+height-50);
      if (overURL)
      {
        if (url!=null)                                                      //Will underline the url, once the mouse is hovering over it.
        {
          strokeWeight(1.5);
          stroke(COLOR_URL);
          line(x+UPVOTE_SPACE+40, y+height-60, x+UPVOTE_SPACE+40 + textWidth(urlString), y+height-60);
        }
      }
    }

    numberOfCommentsString = descendants + ((descendants==1)?" Comment":" Comments");
    fill(widgetItemColor); 
    textFont(fontWidget); 
    textSize(17);
    text(numberOfCommentsString, x+UPVOTE_SPACE+40, y+height-20);
  }
  int getEvent(float mX, float mY) 
  {
    if (mX>x && mX < x+width && mY >y && mY <y+height)
    {
      if(urlWidget.getEvent(mX, mY) == URL_EVENT)
      {
        link(url);
        return 0;
      }
      return event;
    }
    return EVENT_NULL;
  }
  
    void mousePressed()  //Coded by Eoin
  {
    if(overURL)  
    {
      link(url);
    }
  }
  
  void underLineURL() //coded by Eoin
  {
    if (mouseX> x+UPVOTE_SPACE+40 && mouseX < textWidth(urlString) && mouseY > y+height-50 && mouseY < y+height-25)
    {
      overURL = true;
    } else
    {
      overURL = false;
    }
  }

  void moveY(float increment)
  {
    y=baseY-increment;
    urlWidget.moveY(increment);
  }
  
  void setY(float newY)    //Stephen: used for displaying the clicked on story in the comment screen
  {
    y = newY;
    urlWidget.setY(newY+height-50);
  }
}
