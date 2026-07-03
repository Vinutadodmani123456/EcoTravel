package com.ecotravel.util;

import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.util.Properties;

public class EmailUtil {

    private static final String SENDER_EMAIL = "ecotravel.karnataka@gmail.com";
    private static final String APP_PASSWORD = "slzr rnjo srdv rzcw"; 

    public static void sendPlainEmail(String recipientEmail, String subject, String body) {
        new Thread(() -> {
            System.out.println("\n>>> [EMAIL-TASK] Starting Plain Email Process for: " + recipientEmail);
            
            Properties props = new Properties();
            props.put("mail.smtp.host", "smtp.gmail.com");
            props.put("mail.smtp.port", "465");
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.ssl.enable", "true");
            props.put("mail.smtp.ssl.protocols", "TLSv1.2");

            Session session = Session.getInstance(props, new Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(SENDER_EMAIL, APP_PASSWORD);
                }
            });

            try {
                Message message = new MimeMessage(session);
                message.setFrom(new InternetAddress(SENDER_EMAIL, "EcoTravel Karnataka"));
                message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipientEmail));
                message.setSubject(subject);
                message.setText(body);
                message.setSentDate(new java.util.Date());

                Transport.send(message);
                System.out.println(">>> [SYSTEM-SUCCESS] Plain email sent successfully to " + recipientEmail);

            } catch (Exception e) {
                System.err.println(">>> [SYSTEM-ERROR] Plain email failed! " + e.getMessage());
            }
        }).start();
    }

    public static void sendBookingEmail(String recipientEmail, String passengerName, String destinationName, String hotelName, double totalCost) {
        new Thread(() -> {
            System.out.println("\n>>> [EMAIL-TASK] Starting Confirmation Email Process for: " + recipientEmail);
            
            Properties props = new Properties();
            props.put("mail.smtp.host", "smtp.gmail.com");
            props.put("mail.smtp.port", "465");
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.ssl.enable", "true");
            props.put("mail.smtp.ssl.protocols", "TLSv1.2");

            Session session = Session.getInstance(props, new Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(SENDER_EMAIL, APP_PASSWORD);
                }
            });

            try {
                Message message = new MimeMessage(session);
                message.setFrom(new InternetAddress(SENDER_EMAIL, "EcoTravel Karnataka"));
                message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipientEmail));
                message.setSubject("Booking Confirmed - EcoTravel Karnataka");

                String bannerUrl = "https://images.unsplash.com/photo-1501854140801-50d01698950b?auto=format&fit=crop&w=600&q=80";
                String orderId = "ECO" + System.currentTimeMillis();
                String currentDate = new java.text.SimpleDateFormat("dd-MM-yyyy").format(new java.util.Date());
                
                String content = "<!DOCTYPE html>\n" +
                    "<html>\n" +
                    "<head>\n" +
                    "    <meta charset=\"utf-8\">\n" +
                    "    <title>Booking Confirmed</title>\n" +
                    "</head>\n" +
                    "<body style=\"margin: 0; padding: 0; background-color: #f4f4f4; font-family: 'Segoe UI', Arial, sans-serif;\">\n" +
                    "    <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"max-width: 600px; margin: 20px auto; background-color: #ffffff; border-radius: 8px; overflow: hidden; box-shadow: 0 4px 10px rgba(0,0,0,0.1);\">\n" +
                    "        <tr>\n" +
                    "            <td>\n" +
                    "                <img src=\"" + bannerUrl + "\" alt=\"EcoTravel Karnataka\" width=\"100%\" style=\"display: block; width: 100%; height: auto; max-height: 200px; object-fit: cover;\">\n" +
                    "            </td>\n" +
                    "        </tr>\n" +
                    "        <tr>\n" +
                    "            <td style=\"background-color: #1b5e20; color: #ffffff; padding: 20px;\">\n" +
                    "                <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">\n" +
                    "                    <tr>\n" +
                    "                        <td width=\"50%\" style=\"font-size: 16px;\">\n" +
                    "                            <strong>Booking ID:</strong><br>\n" +
                    "                            #" + orderId + "\n" +
                    "                        </td>\n" +
                    "                        <td width=\"50%\" style=\"font-size: 16px; text-align: right;\">\n" +
                    "                            <strong>Date of Booking:</strong><br>\n" +
                    "                            " + currentDate + "\n" +
                    "                        </td>\n" +
                    "                    </tr>\n" +
                    "                </table>\n" +
                    "            </td>\n" +
                    "        </tr>\n" +
                    "        <tr>\n" +
                    "            <td style=\"padding: 30px 20px; color: #333333;\">\n" +
                    "                <h2 style=\"margin-top: 0; color: #1b5e20;\">Hi " + passengerName + ",</h2>\n" +
                    "                <p style=\"font-size: 16px; line-height: 1.6;\">Your booking has been successfully confirmed. We are thrilled to host you for your upcoming green adventure in Karnataka.</p>\n" +
                    "                \n" +
                    "                <div style=\"background-color: #f9f9f9; padding: 15px; border-left: 4px solid #fbc02d; margin: 20px 0;\">\n" +
                    "                    " + (destinationName != null && !destinationName.isEmpty() ? "<p style=\"margin: 5px 0;\"><strong>Destination:</strong> " + destinationName + "</p>" : "") + "\n" +
                    "                    " + (hotelName != null && !hotelName.isEmpty() ? "<p style=\"margin: 5px 0;\"><strong>Property:</strong> " + hotelName + "</p>" : "") + "\n" +
                    "                    <p style=\"margin: 5px 0;\"><strong>Total Paid:</strong> ₹" + totalCost + "</p>\n" +
                    "                </div>\n" +
                    "                \n" +
                    "                <p style=\"font-size: 16px; line-height: 1.6;\">Rest assured, we've already informed the property to prepare for your arrival. Remember to carry your eco-friendly travel essentials!</p>\n" +
                    "                <p style=\"font-size: 16px; margin-top: 30px;\">Warm regards,<br><strong>Team EcoTravel</strong></p>\n" +
                    "            </td>\n" +
                    "        </tr>\n" +
                    "        <tr>\n" +
                    "            <td style=\"background-color: #eeeeee; padding: 15px; text-align: center; color: #888888; font-size: 12px;\">\n" +
                    "                &copy; " + new java.text.SimpleDateFormat("yyyy").format(new java.util.Date()) + " EcoTravel Karnataka. All rights reserved.<br>\n" +
                    "                You received this because you booked a trip on our portal.\n" +
                    "            </td>\n" +
                    "        </tr>\n" +
                    "    </table>\n" +
                    "</body>\n" +
                    "</html>";

                message.setContent(content, "text/html; charset=utf-8");
                message.setSentDate(new java.util.Date());

                Transport.send(message);
                System.out.println(">>> [SYSTEM-SUCCESS] Email sent successfully to " + recipientEmail);

            } catch (Exception e) {
                System.err.println(">>> [SYSTEM-ERROR] Email failed! " + e.getMessage());
            }
        }).start();
    }
}
