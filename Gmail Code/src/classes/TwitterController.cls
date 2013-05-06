public class TwitterController {

    public String username { get; set; }
    public String password { get; set; }
    public String newUpdateText { get; set; }
    
    public Boolean getNeedsLogin() {
        return username == null || username.length() == 0;
    }
    
    public Boolean getHasLogin() {
        return ! getNeedsLogin();
    }
    
    public List<TwitterForce.Status> getFriendsTimeline() {
        if (getNeedsLogin())
            return new TwitterForce.Status[0];
            
        TwitterForce tf = new TwitterForce(username, password);
        return tf.friendsTimeline();
    }
    
    public void postUpdate() {
        if (newUpdateText.length() > 0) {
            TwitterForce tf = new TwitterForce(username, password);
            TwitterForce.Status s = tf.postUpdate(newUpdateText, null);
            System.debug(s);
        }
    }
}