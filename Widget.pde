class Widget     //Written by Eoin
{
  float x, y, width, height, baseY;
  String label; 
  int event;
  PImage widgetIcon;

  Widget(float x, float y, float width, float height, String label, PImage widgetIcon, int event) 
  {
    this.x=x; 
    this.y=y; 
    baseY = y;
    this.width = width; 
    this.height = height;
    this.label=label; 
    this.event=event;
    this.widgetIcon = widgetIcon;
  }

  void draw() 
  {
    
    fill(widgetBackgroundColor); 
    stroke(widgetItemColor); strokeWeight(1);
    rect(x, y, width, height);
    
    //Need two cases, as for LAST PAGE the image must be drawn on the left hand side of the widget. In every other case, the image is drawn on the right hand side of the widget.
    fill(widgetItemColor); 
    textFont(fontWidget);
    textAlign(LEFT, CENTER);
    
    if(label!="LAST PAGE" && label!="BACK")
    {
      text(label, x+10, y+(height/2));
      tint(widgetItemColor); 
      if (widgetIcon!=null) 
      {
        image(widgetIcon, x+width-(height/2), y+(height/2), height*0.75, height*0.75);
      }
    }
    else
    {
      text(label, x+(height*0.75), y+(height/2));
      tint(widgetItemColor); 
      imageMode(CENTER);
      image(widgetIcon, x+(height*0.75/2), y+(height/2), height*0.75, height*0.75);
    }
  }

  int getEvent(float mX, float mY) 
  {
    if (mX>x && mX < x+width && mY >y && mY <y+height)
    {
      return event;
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
