package com.endeca.assembler.cartridge.handler;

import com.endeca.assembler.cartridge.HelloWorldContentItem;
import com.endeca.infront.assembler.AbstractCartridgeHandler;
import com.endeca.infront.assembler.CartridgeHandlerException;
import com.endeca.infront.assembler.ContentItem;

public class HelloWorldCartridgeHandler extends AbstractCartridgeHandler {

	public HelloWorldContentItem process(ContentItem pCartridgeConfig)
			throws CartridgeHandlerException {
		HelloWorldContentItem helloWorldItem = new HelloWorldContentItem(
				pCartridgeConfig);
		helloWorldItem.setWelcomeMessage("Hello World !");
		return helloWorldItem;

	}
}
