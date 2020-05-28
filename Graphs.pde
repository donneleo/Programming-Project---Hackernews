//Graph class by Adam. At the moment it just works for the top Score, however will work on allowing 
// it to work for whichever value passed as theType in constructor



//class Graphs{
//  int numberOfBars;
//  ArrayList<StoryData> list = new ArrayList<StoryData>();
//  String theType;
//  int barWidth;
//  int barHeight;
//  int x;
//  int y;
//  Lists userList = new Lists(list);
  
//  Graphs(int number, ArrayList list, String theType){
//    this.numberOfBars = number;
//    this.list = list;
//    this.theType = theType;
//    barWidth = (WINDOW-3*MARGIN) / number;
//    x=MARGIN/2;
//    y=20;
//  }
  
//  void draw(){
//    background(255,255,255);
//    fill(0);
//    stroke(50);
//    fill(100, 180, 244);
//      color(100);
//      text("score", 400, 200);
//    for(int i =0;i<numberOfBars;i++){
//     StoryData story = list.get(i); 
//     //println(story.storyJSON);
//     String user = story.by;                          //get the userName
//     //userList.userComments(user, list);                    //create arrayList in the Lists class of specified user
//     int number = story.score;      //number of comments by this user
//     println(number);
//    // println(number + " " + user);
//     barHeight = number;
//     rect(x,WINDOW-y,barWidth,-barHeight);
   
//     text(number, x+20,WINDOW-y-10-barHeight);
  
//     text(user, x+10,WINDOW-y+20);
//     x=x+barWidth+MARGIN;
//    }
    
    
//  }
//  int search(String aUser){
//    int c =0;
//   for(int i=0;i<list.size();i++){
//      StoryData story = (StoryData)list.get(i);
//       String theUser = story.by;
//       if(theUser!=null){
//       if(theUser.equals(aUser)){
   
//        c++;
//       }    
//     }
//    }
//   println("XXX " +  c);
//   return c;
//  }
  
//}
