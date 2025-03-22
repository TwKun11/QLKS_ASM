package constant;

/**
 *
 * @author ADMIN
 */
public class Iconstant {
    public static final String GOOGLE_CLIENT_ID = System.getenv("GOOGLE_CLIENT_ID") != null 
        ? System.getenv("GOOGLE_CLIENT_ID") 
        : "default-client-id"; // Thay default-client-id bằng giá trị mặc định nếu cần

    public static final String GOOGLE_CLIENT_SECRET = System.getenv("GOOGLE_CLIENT_SECRET") != null 
        ? System.getenv("GOOGLE_CLIENT_SECRET") 
        : "default-client-secret"; // Thay default-client-secret bằng giá trị mặc định nếu cần

    public static final String GOOGLE_REDIRECT_URI = System.getenv("GOOGLE_REDIRECT_URI") != null 
        ? System.getenv("GOOGLE_REDIRECT_URI") 
        : "http://localhost:8080/roombooking/LoginServlet";

    public static final String GOOGLE_GRANT_TYPE = "authorization_code";

    public static final String GOOGLE_LINK_GET_TOKEN = "https://accounts.google.com/o/oauth2/token";

    public static final String GOOGLE_LINK_GET_USER_INFO = "https://www.googleapis.com/oauth2/v1/userinfo?access_token=";
}