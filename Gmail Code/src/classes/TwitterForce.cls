public virtual class TwitterForce {
    
    //
    // Apex Client wrapper for the Twitter API
    //
    // See Twitter REST API documentation
    // http://apiwiki.twitter.com/REST+API+Documentation#update
    //
    
    public class TwitterException extends Exception {}
    
    /** should extend TwitterException, but doesn't seem to want to compile */
    public class AuthenticationException extends Exception {}
    
    public class User {
        public String id                    { get; set; }
        public String name                  { get; set; }
        public String screenName            { get; set; }
        public String location              { get; set; }
        public String description           { get; set; }
        public string profileImageUrl       { get; set; }
        public String url                   { get; set; }
        public Boolean isProtected          { get; set; }
        public Integer followersCount       { get; set; }
    }
    
    public class Status {
        public /** Date */ String createdAt { get; set; }
        public String id                    { get; set; }
        public String text                  { get; set; }
        public String source                { get; set; }
        public Boolean truncated            { get; set; }
        public String inReplyToStatusId     { get; set; }
        public String inReplyToUserId       { get; set; }
        public Boolean favorited            { get; set; }
        public User user                    { get; set; }
    }
    
    /** create a new Twitter client with these twitter credentials */
    public TwitterForce(String username, String password) {
        this.username = username;
        this.password = password;
    }
     
    protected virtual HttpRequest createRequest(String method, String path) {
        HttpRequest req = new HttpRequest();
        req.setEndpoint('http://twitter.com/' + path);
        req.setMethod(method == null ? 'GET' : method);
      
        Blob headerValue = Blob.valueOf(this.username + ':' + this.password);
        String authorizationHeader = 'Basic ' + EncodingUtil.base64Encode(headerValue);
        req.setHeader('Authorization', authorizationHeader);
        return req;
    }
    
    protected HttpResponse execute(HttpRequest req) {
        HttpResponse res = new http().send(req);
        if (res.getStatusCode() == 401)
            throw new AuthenticationException(res.getBody());
        else if (res.getStatusCode() != 200)
            throw new TwitterException(res.getBody());          
        return res;
    }
    
    /** post an update, inReplyToStatusId can be null if this is not a reply */
    public Status postUpdate(String msg, String inReplyToStatusId) {
        HttpRequest req = createRequest('POST', 'statuses/update.xml');

        String body = '';
        if (inReplyToStatusId != null)
            body += 'in_reply_to_status_id=' + inReplyToStatusId + '&';
        body += 'status=' + msg;
        req.setBody(body);
         
        String xml = execute(req).getBody();
        XmlStreamReader r = new XmlStreamReader(xml);
        r.setCoalescing(true);
        r.nextTag();
        return parseStatus(r);
    }

    public List<Status> friendsTimeline() {
        HttpRequest req = createRequest('GET', 'statuses/friends_timeline.xml');
        return parseStatuses(execute(req).getBody());
    }
    
    protected virtual List<Status> parseStatuses(String xml) {
        XmlStreamReader r = new XmlStreamReader(xml);
        r.setCoalescing(true);
        List<Status> statuses = new List<Status>();
        r.nextTag();        
        if (r.getLocalName().equals('statuses')) {
            while (true) {
                r.nextTag();
                if (r.getLocalName().equals('statuses'))
                    break;
                statuses.add(parseStatus(r));
            }
        }
        return statuses;
    }
    
    /** parses a status structure, assumes the reader is on the status element.*/
    protected Status parseStatus(XmlStreamReader r) {
        Status s = null;
        if (r.getLocalName().equals('status')) {
            s = new Status();
            while (true) {
                r.nextTag();
                if (r.getLocalName().equals('user')) {
                    s.user = parseUser(r);
                    continue;
                } else if (r.getLocalName().equals('status')) {
                    break;
                }
                r.next();
                if (!r.hasText()) continue;
                String c = r.getText();
                r.next();
                String n = r.getLocalName();
                if (n.equals('created_at'))
                    s.createdAt = c;
                else if (n.equals('id'))
                    s.id = c;
                else if (n.equals('text'))
                    s.text = c;
                else if (n.equals('source'))
                    s.source = c;
                else if (n.equals('truncated'))
                    s.truncated = c.equalsIgnoreCase('true');
                else if (n.equals('in_reply_to_status_id'))
                    s.inReplyToStatusId = c;
                else if (n.equals('in_reply_to_user_id'))
                    s.inReplyToUserId = c;
                else if (n.equals('favorited'))
                    s.favorited = c.equalsIgnoreCase('true');
            }
        }
        return s;
    }
    
    protected User parseUser(XmlStreamReader r) {
        User u = null;
        if (r.getLocalName().equals('user')) {
            u = new User();
            while (true) {
                r.nextTag();
                if (r.getLocalName().equals('user'))
                    break;
                r.next();
                if (!r.hasText()) continue;
                String c = r.getText();
                r.next();
                String n = r.getLocalName();
                if (n.equals('id'))
                    u.id = c;
                else if (n.equals('name'))
                    u.name = c;
                else if (n.equals('screen_name'))
                    u.screenName = c;
                else if (n.equals('location'))
                    u.location = c;
                else if (n.equals('description'))
                    u.description = c;
                else if (n.equals('profile_image_url'))
                    u.profileImageUrl = c;
                else if (n.equals('url'))
                    u.url = c;
                else if (n.equals('protected'))
                    u.isProtected = c.equalsIgnoreCase('true');
                else if (n.equals('followers_count'))
                    u.followersCount = Integer.valueOf(c);
            }
        }
        return u;
    }
    
    private final String username, password; 
}