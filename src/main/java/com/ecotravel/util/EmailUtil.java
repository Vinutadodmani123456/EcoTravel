package com.ecotravel.util;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

public class EmailUtil {
    private static final Logger LOGGER = Logger.getLogger(EmailUtil.class.getName());

    public static void sendPlainEmail(String recipientEmail, String subject, String body) {
        String username = requiredSetting("MAIL_USERNAME");
        String password = requiredSetting("MAIL_PASSWORD");
        String host = settingOrDefault("MAIL_SMTP_HOST", "smtp.gmail.com");
        String port = settingOrDefault("MAIL_SMTP_PORT", "465");
        String fromAddress = settingOrDefault("MAIL_FROM", username);

        Properties properties = new Properties();
        properties.put("mail.smtp.host", host);
        properties.put("mail.smtp.port", port);
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.ssl.enable", "true");
        properties.put("mail.smtp.ssl.protocols", "TLSv1.2");
        properties.put("mail.smtp.connectiontimeout", "10000");
        properties.put("mail.smtp.timeout", "10000");
        properties.put("mail.smtp.writetimeout", "10000");

        Session session = Session.getInstance(properties, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });

        try {
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(fromAddress, "EcoTravel Karnataka"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipientEmail, true));
            message.setSubject(subject, "UTF-8");
            message.setText(body, "UTF-8");
            message.setSentDate(new Date());
            Transport.send(message);
        } catch (jakarta.mail.MessagingException | UnsupportedEncodingException e) {
            LOGGER.log(Level.SEVERE, "Could not send EcoTravel email to " + recipientEmail, e);
            throw new IllegalStateException("Email delivery failed.", e);
        }
    }

    public static void sendBookingConfirmationEmail(String recipientEmail, String passengerName,
                                                     String destinationName, double totalCost, int bookingId) {
        String body = "Hello " + passengerName + ",\n\n"
                + "Your EcoTravel booking has been confirmed.\n\n"
                + "Booking ID: " + bookingId + "\n"
                + "Destination: " + destinationName + "\n"
                + String.format("Total: ₹%.2f%n", totalCost)
                + "Status: Confirmed\n\n"
                + "Thank you for choosing sustainable travel.\n"
                + "Team EcoTravel Karnataka";
        sendPlainEmail(recipientEmail, "Booking Confirmed - EcoTravel Karnataka", body);
    }

    public static void sendBookingEmail(String recipientEmail, String passengerName,
                                        String destinationName, String hotelName, double totalCost) {
        String placeName = destinationName != null && !destinationName.isEmpty()
                ? destinationName : hotelName;
        String body = "Hello " + passengerName + ",\n\n"
                + "Your EcoTravel booking has been confirmed.\n"
                + "Destination or property: " + placeName + "\n"
                + String.format("Total: ₹%.2f%n", totalCost)
                + "\nThank you for choosing sustainable travel.\n"
                + "Team EcoTravel Karnataka";
        sendPlainEmail(recipientEmail, "Booking Confirmed - EcoTravel Karnataka", body);
    }

    private static String requiredSetting(String name) {
        String value = System.getenv(name);
        if (value == null || value.trim().isEmpty()) {
            throw new IllegalStateException("Required email setting is missing: " + name);
        }
        return value.trim();
    }

    private static String settingOrDefault(String name, String defaultValue) {
        String value = System.getenv(name);
        return value == null || value.trim().isEmpty() ? defaultValue : value.trim();
    }
}
