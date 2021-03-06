/**
 * 
 */
package com.lms.domain.sub;

import org.smslib.AGateway;
import org.smslib.IInboundMessageNotification;
import org.smslib.InboundMessage;
import org.smslib.Message.MessageTypes;

/**
 * @author Sudarsan
 * 
 */
public class InboundNotification implements IInboundMessageNotification {

	public void process(AGateway gateway, MessageTypes msgType,
			InboundMessage msg) {
		if (msgType == MessageTypes.INBOUND) {
			System.out
					.println(">>> New Inbound message detected from Gateway: "
							+ gateway.getGatewayId());
		} else if (msgType == MessageTypes.STATUSREPORT) {
			System.out
					.println(">>> New Inbound Status Report message detected from Gateway: "
							+ gateway.getGatewayId());
		}
		System.out.println(msg);
	}
}
