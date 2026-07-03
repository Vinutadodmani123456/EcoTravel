// app.js
document.addEventListener("DOMContentLoaded", function () {
    const urlParams = new URLSearchParams(window.location.search);

    // Check if the URL has an 'sms' parameter to trigger the confirmation
    if (urlParams.has('sms')) {
        const phoneNumber = urlParams.get('sms');
        const message = "*EcoTravel - Green Tour Planning Portal*\n" +
            "--------------------------------------------\n" +
            "*Booking Confirmed!*\n\n" +
            "Hello, thank you for choosing a sustainable adventure with EcoTravel.\n\n" +
            "Your green trip has been validated and confirmed. We are excited to have you on board for a responsible travel experience!\n\n" +
            "*Booking Status:* Confirmed\n" +
            "*Eco-Score:* High\n\n" +
            "Visit our portal for more details. Have a safe and green journey!\n" +
            "--------------------------------------------\n" +
            "*Travel Responsibly, Travel Green.*";

        // 1. Simulated Browser Pop-up (Option 1)
        alert("Booking Successfully!\n\n💬 Simulation message sent to: +91-" + phoneNumber + "\nYour EcoTravel Green Trip has been validated and confirmed. Have a safe journey!");

        // 2. WhatsApp Redirect (Option 2 - Free & Real)
        // Automatically redirects to WhatsApp on your phone/PC to send the message
        // (Using location.href prevents the browser from blocking it as a pop-up)
        const whatsappUrl = "https://wa.me/91" + phoneNumber + "?text=" + encodeURIComponent(message);
        window.location.href = whatsappUrl;

        /* 
        =========================================================
        3. Real SMS API Integration (Option 3 - Fast2SMS/Twilio)
        =========================================================
        If your college strictly requires a REAL SMS, create a free 
        account at Fast2SMS.com, get your API Key, and paste it below. 
        Then, uncomment this code block!
        
        const apiKey = "YOUR_FAST2SMS_API_KEY_HERE";
        fetch("https://www.fast2sms.com/dev/bulkV2?authorization=" + apiKey + "&route=q&message=" + encodeURIComponent(message) + "&language=english&flash=0&numbers=" + phoneNumber, {
            method: "GET"
        })
        .then(response => response.json())
        .then(data => console.log("Real SMS Sent Successfully!", data))
        .catch(error => console.error("Error sending SMS:", error));
        */
    }
});
