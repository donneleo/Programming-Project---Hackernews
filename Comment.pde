class Comment {    //Story comment class written by Adam. Allows us to display the comments on a story.
  StoryData commentData;
  float x, y, baseY;
  float width, height;
  String label; 
  int event, indentingValue, indent;
  boolean stroke;
  
  String url;
  String user;
  int time;
  String text;
  String date;
  int replies;  

  Comment(float x, float y, float width, float height, String label, int event, StoryData commentData) {
    this.x=x; 
    this.y=y; 
    baseY = y;
    this.width = width; 
    this.height = height;
    this.label=label; 
    this.event=event;
    this.commentData = commentData;
    indentingValue = commentData.getIndentingValue();   // variable indentingValue used for subcomments and subcommments of subcomments, etc. Determines by how much a comment should be shifted to the right, below its parent comment.
    
    if(commentData.text != null)  //Stephen: Written to judge the height of the text, which will be added to the total height of the comment Widget, so we can make comment widgets of various heights
    {
      textSize(22);
      textLeading(27);
      float totalWidth = ceil(textWidth(commentData.text));
      float textWidth = width-65;
      float numberOfLines = ceil(totalWidth/textWidth);
      float totalTitleHeight = numberOfLines*27 - 27;
      
      this.height = height + totalTitleHeight + 30;
      
      url=commentData.url;
      user=commentData.by;
      time=commentData.time;
      text=commentData.text;
      date=format(time);
      if(commentData.kids != null) replies = commentData.kids.length;
    }
  }

  void draw() {
    indent = indentingValue*20;
    

    fill(widgetBackgroundColor); 
    stroke(widgetItemColor); strokeWeight(1);
    rect(x+indent, y, width+30-indent, height);
    fill(plainText); 
    textFont(fontWidget); 
    textAlign(LEFT, CENTER);
    text(text, x+indent+20, y + 30, width-indent-10, height-10);
    textAlign(LEFT, CENTER); fill(widgetItemColor);
    text(user, x+indent+20, y+20);
    textAlign(RIGHT, CENTER);
    text(date, x+width-10, y+20);
    textAlign(CENTER, CENTER);
    if(replies != 0);
      if(replies>0 && currentScreenType == SCREEN_COMMENT) text((replies>1)? replies + " Replies" : replies + " Reply", x+(width/2)+indent, y+20);
  }

  int getEvent(float mX, float mY) 
  {
    if(currentScreenType == SCREEN_COMMENT)
    {
      if (mX>x && mX < x+width && mY >y && mY <y+height)
      {
        return event;
      }
    }
      return EVENT_NULL;
  }

  void moveY(float increment)
  {
    y=baseY-increment;
  }
  
  void setY(float newY)    //Stephen: used for displaying the clicked on story in the comment screen
  {
    y = newY;
  }
}
