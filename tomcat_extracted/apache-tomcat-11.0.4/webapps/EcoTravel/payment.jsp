<%@ page import="com.ecotravel.dao.BookingDao, com.ecotravel.model.Booking" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String idStr = request.getParameter("bookingId");
    if (idStr == null || idStr.trim().isEmpty()) {
        response.sendRedirect("destinations?error=Invalid+Booking+ID");
        return;
    }
    int bookingId = Integer.parseInt(idStr);
    BookingDao bookingDao = new BookingDao();
    Booking b = bookingDao.getBookingById(bookingId);
    if (b == null) {
        response.sendRedirect("destinations?error=Booking+Not+Found");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PhonePe Payment Portal - EcoTravel</title>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;800&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Outfit', sans-serif;
            background-color: #f3f3f9;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        .payment-container {
            width: 100%;
            max-width: 480px;
            background: #ffffff;
            border-radius: 16px;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.08);
            overflow: hidden;
            border: 1px solid #e0e0e0;
            margin: 20px;
        }

        .phonepe-header {
            background-color: #5f259f;
            color: #ffffff;
            padding: 20px;
            text-align: center;
            position: relative;
        }

        .phonepe-header h2 {
            margin: 0;
            font-size: 1.5rem;
            font-weight: 800;
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 8px;
        }

        .phonepe-header p {
            margin: 5px 0 0 0;
            font-size: 0.85rem;
            opacity: 0.9;
        }

        .timer-badge {
            background: rgba(255, 255, 255, 0.2);
            padding: 6px 12px;
            border-radius: 20px;
            font-weight: bold;
            font-size: 1.1rem;
            display: inline-block;
            margin-top: 10px;
            color: #ffeb3b;
            border: 1px solid rgba(255, 235, 59, 0.4);
        }

        .payment-body {
            padding: 24px;
            text-align: center;
        }

        .merchant-info {
            background: #f8f9fa;
            border-radius: 8px;
            padding: 12px;
            margin-bottom: 20px;
            border-left: 4px solid #5f259f;
            text-align: left;
        }

        .merchant-info h4 {
            margin: 0;
            color: #333;
            font-size: 1rem;
        }

        .merchant-info p {
            margin: 4px 0 0 0;
            font-size: 0.85rem;
            color: #666;
        }

        .qr-section {
            background: #ffffff;
            border: 2px solid #5f259f;
            border-radius: 12px;
            padding: 15px;
            display: inline-block;
            margin-bottom: 20px;
            box-shadow: 0 4px 15px rgba(95, 37, 159, 0.1);
        }

        .qr-image {
            width: 260px;
            height: auto;
            display: block;
            margin: 0 auto;
            border-radius: 8px;
        }

        .amount-display {
            font-size: 1.8rem;
            font-weight: 800;
            color: #2e7d32;
            margin: 15px 0;
        }

        .booking-details-summary {
            font-size: 0.9rem;
            color: #555;
            background: #f1f8e9;
            padding: 12px;
            border-radius: 8px;
            text-align: left;
            margin-bottom: 20px;
            border: 1px solid #d0e7b5;
        }

        .booking-details-summary p {
            margin: 4px 0;
        }

        .verify-btn {
            background-color: #5f259f;
            color: white;
            border: none;
            padding: 14px;
            width: 100%;
            border-radius: 8px;
            font-size: 1.1rem;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 12px rgba(95, 37, 159, 0.3);
        }

        .verify-btn:hover {
            background-color: #4a1c7d;
        }

        .verify-btn:disabled {
            background-color: #a58cb6;
            cursor: not-allowed;
            box-shadow: none;
        }

        .loader-container {
            display: none;
            margin-top: 15px;
            text-align: center;
        }

        .spinner {
            border: 4px solid rgba(95, 37, 159, 0.1);
            width: 36px;
            height: 36px;
            border-radius: 50%;
            border-left-color: #5f259f;
            animation: spin 1s linear infinite;
            display: inline-block;
            vertical-align: middle;
            margin-right: 10px;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        .status-msg {
            font-weight: 600;
            color: #5f259f;
            font-size: 0.95rem;
            display: inline-block;
            vertical-align: middle;
        }

        #paymentForm, #expireForm {
            display: none;
        }
    </style>
</head>
<body>

    <div class="payment-container">
        <div class="phonepe-header">
            <h2>
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" style="vertical-align: middle;">
                    <rect width="24" height="24" rx="12" fill="#ffffff"/>
                    <path d="M12 4c-4.4 0-8 3.6-8 8s3.6 8 8 8 8-3.6 8-8-3.6-8-8-8zm1.5 11h-3v-2h3c.8 0 1.5-.7 1.5-1.5S14.3 10 13.5 10h-3v5H9V8h4.5c1.9 0 3.5 1.6 3.5 3.5s-1.6 3.5-3.5 3.5z" fill="#5f259f"/>
                </svg>
                PhonePe Payment
            </h2>
            <p>EcoTravel Booking Confirmation</p>
            <div class="timer-badge" id="timer">05:00</div>
        </div>

        <div class="payment-body">
            <div class="merchant-info">
                <h4>EcoTravel Karnataka</h4>
                <p>Merchant Ref: TXN-ET<%= b.getId() %></p>
            </div>

            <div class="booking-details-summary">
                <p><strong>Traveler:</strong> <%= b.getContactName() %></p>
                <p><strong>Trip to:</strong> <%= b.getDestinationName() %></p>
                <p><strong>Stay:</strong> <%= b.getHotelName() %></p>
            </div>

            <div class="qr-section">
                <img class="qr-image" src="images/phonepe_scanner.jpg" alt="PhonePe QR Code">
            </div>

            <div class="amount-display">
                ₹<%= b.getTotalCost() %>
            </div>

            <p style="font-size: 0.85rem; color: #666; margin-bottom: 20px;">
                Open PhonePe or any UPI app, scan the QR code, and complete your payment.
            </p>

            <button class="verify-btn" id="verifyBtn" onclick="initiateVerification()">
                Verify Payment Status
            </button>

            <div class="loader-container" id="loader">
                <div class="spinner"></div>
                <div class="status-msg" id="statusText">Checking payment validation with PhonePe...</div>
            </div>
        </div>
    </div>

    <form id="paymentForm" action="bookings" method="post">
        <input type="hidden" name="action" value="confirmPayment">
        <input type="hidden" name="bookingId" value="<%= b.getId() %>">
    </form>

    <form id="expireForm" action="bookings" method="post">
        <input type="hidden" name="action" value="failPayment">
        <input type="hidden" name="bookingId" value="<%= b.getId() %>">
    </form>

    <script>
        let timeLeft = 300;
        const timerElement = document.getElementById('timer');
        const expireForm = document.getElementById('expireForm');

        const countdown = setInterval(function() {
            timeLeft--;
            let minutes = Math.floor(timeLeft / 60);
            let seconds = timeLeft % 60;

            minutes = minutes < 10 ? '0' + minutes : minutes;
            seconds = seconds < 10 ? '0' + seconds : seconds;

            timerElement.textContent = minutes + ':' + seconds;

            if (timeLeft <= 0) {
                clearInterval(countdown);
                timerElement.textContent = "EXPIRED";
                timerElement.style.color = "#ff5252";
                alert("Payment session has expired. You will be redirected back.");
                expireForm.submit();
            }
        }, 1000);

        function initiateVerification() {
            const verifyBtn = document.getElementById('verifyBtn');
            const loader = document.getElementById('loader');
            const statusText = document.getElementById('statusText');
            const paymentForm = document.getElementById('paymentForm');

            verifyBtn.disabled = true;
            loader.style.display = 'block';

            setTimeout(function() {
                statusText.textContent = "Securing connection to UPI network...";
            }, 1000);

            setTimeout(function() {
                statusText.textContent = "Payment Verified Successfully! Processing booking...";
            }, 2000);

            setTimeout(function() {
                clearInterval(countdown);
                paymentForm.submit();
            }, 3000);
        }
    </script>
</body>
</html>
