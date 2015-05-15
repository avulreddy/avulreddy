package com.bks.common.batch.dao;
import atg.rest.client.RestClientException;
import atg.rest.client.RestSession;
public class RestClient {
  // Use your own hostname and port.
  private String mHost = "myserver";
  private int mPort = 9876;
  private RestSession mSession = null;
  public RestClientStartSession() {}

  protected void execute() throws RestClientException {

    // Create a RestSession object. Use the constructor that
    // takes only the REST server host and port.
    mSession = RestSession.createSession(mHost, mPort);

    // Invoke the startSession() method.
    mSession.startSession();

    // Verify that the session is started.
    String sessionid = mSession.getSessionId();
    System.out.println("The session ID is: " + sessionid);

    // perform unsecured operations or login here
    // forexample:
    // mSession.login("myusername","mypassword")
  }

  public static void main(String[] args) {
    RestClientStartSession sample = new RestClientStartSession();
    try {
      sample.execute();
    }
    catch (Throwable t) {
      t.printStackTrace(System.out);
    }
  }
}
