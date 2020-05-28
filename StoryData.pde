class StoryData {    //Written by Oisin and Adam.
  JSONObject storyJSON;
  String type, by, url, title, text;
  int time, descendants, score, parent, id, subCommentIndentValue;
  int kids[];

  StoryData(JSONObject currentJSONObject) {
    storyJSON = currentJSONObject;
    setVariables();
  }

  void setVariables() {

    id = storyJSON.getInt("id");

    time = storyJSON.getInt("time"); 

    type = storyJSON.getString("type");

    by = storyJSON.getString("by");

    url = storyJSON.getString("url");

    title = storyJSON.getString("title");

    if (!storyJSON.isNull("text"))  text = storyJSON.getString ("text");

    if (!storyJSON.isNull("descendants")) descendants = storyJSON.getInt("descendants");

    if (!storyJSON.isNull("parent"))  parent = storyJSON.getInt("parent");

    if (!storyJSON.isNull("score")) score = storyJSON.getInt("score");

    JSONArray kidsArray = storyJSON.getJSONArray("kids");

    if (kidsArray != null)
    {
      kids = new int[kidsArray.size()];
      for (int i = 0; i < kidsArray.size(); ++i) 
      {
        kids[i] = kidsArray.getInt(i);
      }
    }
  }
  
  void setSubCommentIndentValue(int indent)
  {
    subCommentIndentValue = indent;
  }

  int getID()
  {
    return id;
  }

  int getTime()
  {
    return time;
  }

  String getType()
  {
    return type;
  }

  String getBy()
  {
    return by;
  }

  String getURL()
  {
    return url;
  }

  String getTitle()
  {
    return title;
  }

  String getText()
  {
    return text;
  }

  int getDescendants()
  {
    return descendants;
  }

  int getParent()
  {
    return parent;
  }

  int getScore()
  {
    return score;
  }

  int[] getKids()
  {
    return kids;
  }
  
  int getIndentingValue()
  {
    return subCommentIndentValue;
  }
}
