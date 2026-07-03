package com.ecotravel.util;

/**
 * Simple placeholder utility for sending WhatsApp messages.
 * In a real deployment replace the stub with an HTTP call to the WhatsApp Business API.
 */
public class WhatsAppUtil {
    /**
     * Sends a text message to the given mobile number.
     * @param mobile Mobile number in international format (e.g., +919876543210)
     * @param text   Message body
     */
    public static void sendMessage(String mobile, String text) {
        // Placeholder implementation – just logs to console.
        System.out.println("[WhatsApp] To " + mobile + ": " + text);
    }
}
