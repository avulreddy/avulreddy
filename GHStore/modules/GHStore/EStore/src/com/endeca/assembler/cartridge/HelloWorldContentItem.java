package com.endeca.assembler.cartridge;


import com.endeca.infront.assembler.BasicContentItem;
import com.endeca.infront.assembler.ContentItem;

public class HelloWorldContentItem extends BasicContentItem {
  public static final String MSG_KEY = "welcomeMessage";

  public HelloWorldContentItem(ContentItem pConfig) {
    super(pConfig);
  }

  public String getWelcomeMessage() {
    return getTypedProperty(MSG_KEY);
  }

  public void setWelcomeMessage(String pWelMsg) {
    put(MSG_KEY, pWelMsg);
  }
}
