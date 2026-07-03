<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.ecotravel.model.User, com.ecotravel.model.Hotel" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("user_login.jsp?msg=Please+login+to+book");
        return;
    }

    int hotelId = 0;
    try { hotelId = Integer.parseInt(request.getParameter("hotelId")); } catch(Exception e) {}

    com.ecotravel.dao.DestinationDao destDao = new com.ecotravel.dao.DestinationDao();
    Hotel hotel = destDao.getHotelById(hotelId);
    if (hotel == null) {
        response.sendRedirect("destinations");
        return;
    }

    // Default dates: today → tomorrow
    String checkInParam = request.getParameter("checkIn");
    if (checkInParam == null || checkInParam.isEmpty())
        checkInParam = java.time.LocalDate.now().toString();
    String checkOutParam = request.getParameter("checkOut");
    if (checkOutParam == null || checkOutParam.isEmpty())
        checkOutParam = java.time.LocalDate.now().plusDays(1).toString();

    String adultsParam   = request.getParameter("adults")   != null ? request.getParameter("adults")   : "2";
    String childrenParam = request.getParameter("children") != null ? request.getParameter("children") : "0";
    String roomsParam    = request.getParameter("rooms")    != null ? request.getParameter("rooms")    : "1";

    // Split username for First/Last name input fields if possible
    String fullName = user.getUsername() != null ? user.getUsername() : "";
    String firstName = "";
    String lastName = "";
    if (!fullName.isEmpty()) {
        String[] parts = fullName.split("\\s+", 2);
        firstName = parts[0];
        if (parts.length > 1) {
            lastName = parts[1];
        }
    }

    // Image URL resolution
    String imgRaw = hotel.getImageUrl();
    String ctxPath = request.getContextPath();
    String imgSrc;
    if (imgRaw != null && (imgRaw.startsWith("http://") || imgRaw.startsWith("https://"))) {
        imgSrc = imgRaw;
    } else if (imgRaw != null && !imgRaw.isEmpty()) {
        imgSrc = ctxPath + "/" + imgRaw;
    } else {
        imgSrc = "https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&w=1200&q=80";
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Confirm Your Selection - <%= hotel.getName() %> | EcoTravel</title>
    
    <!-- Premium Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    
    <style>
        :root {
            --booking-blue: #003b95;
            --booking-light-blue: #006ce4;
            --booking-yellow: #febb02;
            --booking-bg: #f5f7fa;
            --text-dark: #1a1a1a;
            --text-muted: #474747;
            --border-color: #d1d5db;
            --green-badge: #15803d;
            --green-bg: #f0fdf4;
            --star-color: #febb02;
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Outfit', sans-serif;
            background-color: var(--booking-bg);
            color: var(--text-dark);
            -webkit-font-smoothing: antialiased;
        }

        /* Navbar */
        .navbar {
            background-color: var(--booking-blue);
            padding: 16px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            color: white;
        }

        .navbar-brand {
            font-size: 1.5rem;
            font-weight: 800;
            color: white;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .navbar-back {
            color: white;
            text-decoration: none;
            font-weight: 500;
            font-size: 0.95rem;
            border: 1px solid white;
            padding: 8px 16px;
            border-radius: 4px;
            transition: background 0.2s;
        }

        .navbar-back:hover {
            background: rgba(255, 255, 255, 0.1);
        }

        /* Search / Filter Bar (Booking.com style) */
        .search-banner-wrapper {
            background-color: var(--booking-blue);
            padding: 0 40px 20px 40px;
        }

        .search-banner {
            background: var(--booking-yellow);
            padding: 4px;
            border-radius: 8px;
            max-width: 1150px;
            margin: 0 auto;
            display: grid;
            grid-template-columns: 1.5fr 1fr 1.2fr;
            gap: 4px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }

        .sb-item {
            background: #fff;
            padding: 12px 16px;
            border-radius: 4px;
            display: flex;
            align-items: center;
            gap: 10px;
            position: relative;
        }

        .sb-icon {
            color: var(--text-muted);
            flex-shrink: 0;
            display: flex;
            align-items: center;
        }

        .sb-item input[type="text"] {
            border: none;
            outline: none;
            font-family: inherit;
            font-size: 0.95rem;
            color: var(--text-dark);
            width: 100%;
            font-weight: 500;
        }

        .sb-date-inputs {
            display: flex;
            align-items: center;
            gap: 8px;
            width: 100%;
        }

        .sb-date-inputs input[type="date"] {
            border: none;
            outline: none;
            font-family: inherit;
            font-size: 0.9rem;
            color: var(--text-dark);
            font-weight: 500;
            width: 100%;
            cursor: pointer;
        }

        .sb-divider {
            color: var(--border-color);
            user-select: none;
        }

        .sb-guest-btn {
            background: none;
            border: none;
            outline: none;
            font-family: inherit;
            font-size: 0.95rem;
            color: var(--text-dark);
            font-weight: 500;
            text-align: left;
            width: 100%;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .sb-search-btn {
            background-color: var(--booking-light-blue);
            color: white;
            border: none;
            padding: 12px 32px;
            font-size: 1.1rem;
            font-weight: 600;
            border-radius: 4px;
            cursor: pointer;
            transition: background 0.2s;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .sb-search-btn:hover {
            background-color: #005bb8;
        }

        /* Guest Selection Dropdown Popup */
        .guest-popup {
            display: none;
            position: absolute;
            top: calc(100% + 8px);
            left: 0;
            right: 0;
            background: white;
            border-radius: 8px;
            box-shadow: 0 8px 24px rgba(0,0,0,0.15);
            border: 1px solid var(--border-color);
            padding: 20px;
            z-index: 100;
        }

        .guest-popup.active {
            display: block;
        }

        .guest-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .guest-row:last-child {
            margin-bottom: 0;
        }

        .guest-label {
            font-weight: 600;
            color: var(--text-dark);
            font-size: 0.95rem;
            display: flex;
            flex-direction: column;
        }

        .guest-sublabel {
            font-size: 0.78rem;
            color: var(--text-muted);
            font-weight: 400;
            margin-top: 2px;
        }

        .counter-controls {
            display: flex;
            align-items: center;
            gap: 14px;
        }

        .counter-btn {
            width: 38px;
            height: 38px;
            border-radius: 4px;
            border: 1px solid var(--booking-light-blue);
            background: white;
            color: var(--booking-light-blue);
            font-size: 1.3rem;
            font-weight: 500;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.2s;
        }

        .counter-btn:disabled {
            border-color: #e5e7eb;
            color: #9ca3af;
            cursor: not-allowed;
        }

        .counter-btn:hover:not(:disabled) {
            background-color: #f0f7ff;
        }

        .counter-value {
            font-weight: 600;
            font-size: 1.05rem;
            min-width: 20px;
            text-align: center;
        }

        /* Steps Indicator */
        .steps-container {
            max-width: 1150px;
            margin: 20px auto 0 auto;
            padding: 0 15px;
            display: flex;
            gap: 24px;
            font-size: 0.9rem;
            font-weight: 600;
            color: var(--text-muted);
        }

        .step-item {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .step-item.active {
            color: var(--booking-light-blue);
        }

        .step-number {
            width: 22px;
            height: 22px;
            border-radius: 50%;
            background: #e5e7eb;
            color: var(--text-muted);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.75rem;
        }

        .step-item.active .step-number {
            background: var(--booking-light-blue);
            color: white;
        }

        .step-item.completed .step-number {
            background: var(--green-badge);
            color: white;
        }

        /* Page Layout */
        .booking-layout {
            max-width: 1150px;
            margin: 20px auto 60px auto;
            padding: 0 15px;
            display: grid;
            grid-template-columns: 360px 1fr;
            gap: 24px;
            align-items: start;
        }

        @media (max-width: 900px) {
            .booking-layout {
                grid-template-columns: 1fr;
            }
        }

        /* Sidebar - Left Column */
        .sidebar {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        /* Hotel Selection Card */
        .card-hotel-select {
            background: white;
            border-radius: 12px;
            border: 1px solid var(--border-color);
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0,0,0,0.04);
        }

        .hotel-img-wrapper {
            width: 100%;
            height: 180px;
            overflow: hidden;
            position: relative;
        }

        .hotel-img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .hotel-select-content {
            padding: 20px;
        }

        .hotel-rating-stars {
            color: var(--star-color);
            font-size: 0.95rem;
            margin-bottom: 6px;
            display: flex;
            align-items: center;
            gap: 2px;
        }

        .thumbs-up-icon {
            background: #ff8f00;
            color: white;
            font-size: 0.7rem;
            padding: 2px 5px;
            border-radius: 3px;
            font-weight: 700;
            margin-left: 6px;
        }

        .hotel-select-name {
            font-size: 1.25rem;
            font-weight: 800;
            color: var(--text-dark);
            line-height: 1.3;
            margin-bottom: 8px;
        }

        .hotel-select-address {
            font-size: 0.88rem;
            color: var(--text-muted);
            line-height: 1.4;
            margin-bottom: 12px;
        }

        .hotel-location-badge {
            color: var(--green-badge);
            font-size: 0.85rem;
            font-weight: 700;
            margin-bottom: 12px;
            display: inline-block;
        }

        .hotel-select-rating-block {
            display: flex;
            align-items: center;
            gap: 8px;
            margin-bottom: 15px;
        }

        .rating-score {
            background: var(--booking-blue);
            color: white;
            font-weight: 700;
            font-size: 0.95rem;
            padding: 5px 8px;
            border-radius: 6px 6px 6px 0;
        }

        .rating-text-summary {
            font-size: 0.88rem;
            font-weight: 700;
            color: var(--text-dark);
        }

        .reviews-count {
            font-size: 0.8rem;
            color: var(--text-muted);
            font-weight: 400;
            margin-top: 1px;
        }

        .hotel-select-amenities {
            display: flex;
            flex-wrap: wrap;
            gap: 6px;
            padding-top: 15px;
            border-top: 1px solid #e5e7eb;
        }

        .amenity-tag {
            background: #f3f4f6;
            color: var(--text-muted);
            font-size: 0.78rem;
            padding: 4px 10px;
            border-radius: 4px;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 4px;
        }

        /* Booking Details Card */
        .card-booking-details {
            background: white;
            border-radius: 12px;
            border: 1px solid var(--border-color);
            padding: 20px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.04);
        }

        .card-booking-details h3 {
            font-size: 1.05rem;
            font-weight: 700;
            margin-bottom: 16px;
            color: var(--text-dark);
        }

        .date-detail-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
            margin-bottom: 16px;
        }

        .date-column {
            display: flex;
            flex-direction: column;
        }

        .date-column-label {
            font-size: 0.82rem;
            color: var(--text-muted);
            margin-bottom: 4px;
            font-weight: 500;
        }

        .date-column-val {
            font-size: 1rem;
            font-weight: 700;
            color: var(--text-dark);
            margin-bottom: 2px;
        }

        .date-column-time {
            font-size: 0.78rem;
            color: var(--text-muted);
        }

        .detail-row-summary {
            font-size: 0.9rem;
            padding: 12px 0;
            border-top: 1px solid #e5e7eb;
            color: var(--text-dark);
        }

        .detail-row-summary p {
            margin-bottom: 6px;
        }

        .detail-row-summary p:last-child {
            margin-bottom: 0;
        }

        .detail-row-summary strong {
            color: var(--text-dark);
        }

        .badge-alert-info {
            background: #fff8e1;
            color: #b78103;
            border: 1px solid #ffe0b2;
            padding: 8px 12px;
            border-radius: 6px;
            font-size: 0.82rem;
            font-weight: 600;
            margin-top: 10px;
            display: flex;
            align-items: center;
            gap: 6px;
        }

        /* Price Summary Card */
        .card-price-summary {
            background: white;
            border-radius: 12px;
            border: 1px solid var(--border-color);
            padding: 20px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.04);
        }

        .card-price-summary h3 {
            font-size: 1.15rem;
            font-weight: 700;
            margin-bottom: 16px;
            color: var(--text-dark);
        }

        .price-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 12px;
            font-size: 0.92rem;
            color: var(--text-muted);
        }

        .price-row.discount-row {
            color: #b91c1c;
        }

        .price-row.discount-row .price-val {
            font-weight: 600;
        }

        .discount-details-note {
            font-size: 0.78rem;
            color: var(--text-muted);
            margin-top: -8px;
            margin-bottom: 12px;
            line-height: 1.3;
        }

        .price-row.final-price-row {
            border-top: 1px solid #e5e7eb;
            padding-top: 16px;
            margin-bottom: 6px;
            align-items: flex-end;
        }

        .final-price-lbl {
            font-size: 1.5rem;
            font-weight: 800;
            color: var(--text-dark);
        }

        .final-price-box {
            text-align: right;
        }

        .final-price-val {
            font-size: 1.7rem;
            font-weight: 800;
            color: var(--text-dark);
            line-height: 1;
        }

        .taxes-fees-note {
            font-size: 0.8rem;
            color: var(--text-muted);
            margin-top: 4px;
        }

        .price-info-card {
            background: #f0f7ff;
            border-radius: 8px;
            padding: 12px;
            margin-top: 16px;
            border: 1px solid #e0f2fe;
        }

        .price-info-title {
            font-size: 0.85rem;
            font-weight: 700;
            color: #0369a1;
            margin-bottom: 6px;
            display: flex;
            align-items: center;
            gap: 4px;
        }

        .price-info-text {
            font-size: 0.78rem;
            color: #0369a1;
            line-height: 1.4;
        }

        /* Right Column Form and Banners */
        .main-content {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        /* Genius Banner */
        .genius-banner {
            background: white;
            border: 1px solid var(--border-color);
            border-radius: 12px;
            padding: 20px;
            display: flex;
            gap: 16px;
            align-items: flex-start;
            box-shadow: 0 2px 8px rgba(0,0,0,0.04);
        }

        .genius-icon {
            width: 48px;
            height: 48px;
            background: #006ce4;
            color: white;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 800;
            font-size: 1.4rem;
            flex-shrink: 0;
        }

        .genius-info h4 {
            font-size: 1rem;
            font-weight: 700;
            color: var(--text-dark);
            margin-bottom: 4px;
        }

        .genius-info p {
            font-size: 0.88rem;
            color: var(--text-muted);
            line-height: 1.4;
        }

        .genius-links {
            margin-top: 10px;
            font-size: 0.88rem;
            font-weight: 600;
        }

        .genius-links a {
            color: var(--booking-light-blue);
            text-decoration: none;
        }

        .genius-links a:hover {
            text-decoration: underline;
        }

        /* Enter Details Card */
        .card-details-form {
            background: white;
            border-radius: 12px;
            border: 1px solid var(--border-color);
            padding: 28px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.04);
        }

        .card-details-form h3 {
            font-size: 1.35rem;
            font-weight: 700;
            color: var(--text-dark);
            margin-bottom: 16px;
        }

        /* Alert Warning Banner */
        .form-warning-alert {
            background: #f3f4f6;
            border-radius: 8px;
            padding: 12px 16px;
            font-size: 0.88rem;
            color: var(--text-dark);
            margin-bottom: 24px;
            display: flex;
            align-items: center;
            gap: 10px;
            border-left: 4px solid var(--text-muted);
        }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        @media (max-width: 600px) {
            .form-grid {
                grid-template-columns: 1fr;
            }
        }

        .form-group {
            display: flex;
            flex-direction: column;
            gap: 6px;
        }

        .form-group.full-width {
            grid-column: span 2;
        }

        @media (max-width: 600px) {
            .form-group.full-width {
                grid-column: span 1;
            }
        }

        .form-group label {
            font-size: 0.88rem;
            font-weight: 600;
            color: var(--text-dark);
        }

        .form-group label span {
            color: #d97706;
            font-weight: 700;
        }

        .form-group input, .form-group select {
            padding: 10px 14px;
            border: 1px solid var(--border-color);
            border-radius: 4px;
            font-family: inherit;
            font-size: 0.95rem;
            color: var(--text-dark);
            background: white;
            outline: none;
            transition: border-color 0.2s;
        }

        .form-group input:focus, .form-group select:focus {
            border-color: var(--booking-light-blue);
            box-shadow: 0 0 0 1px var(--booking-light-blue);
        }

        .phone-input-group {
            display: grid;
            grid-template-columns: 100px 1fr;
            gap: 10px;
        }

        /* Checkbox Optional details */
        .form-checkbox-row {
            display: flex;
            align-items: flex-start;
            gap: 12px;
            margin-top: 10px;
            font-size: 0.88rem;
            line-height: 1.4;
        }

        .form-checkbox-row input[type="checkbox"] {
            margin-top: 3px;
            width: 16px;
            height: 16px;
            cursor: pointer;
            accent-color: var(--booking-light-blue);
        }

        .checkbox-label-block {
            display: flex;
            flex-direction: column;
        }

        .checkbox-main-lbl {
            font-weight: 600;
            color: var(--text-dark);
        }

        .checkbox-sub-lbl {
            color: var(--text-muted);
            font-size: 0.8rem;
        }

        /* Green / Zero-Plastic Pledge block */
        .card-green-pledge {
            background-color: var(--green-bg);
            border: 1px solid #bbf7d0;
            border-left: 5px solid #22c55e;
            border-radius: 8px;
            padding: 18px;
            margin-top: 24px;
            display: flex;
            align-items: flex-start;
            gap: 12px;
        }

        .pledge-checkbox {
            margin-top: 3px;
            width: 18px;
            height: 18px;
            cursor: pointer;
            accent-color: #16a34a;
        }

        .pledge-info-lbl {
            font-size: 0.88rem;
            color: #166534;
            line-height: 1.4;
        }

        .pledge-info-lbl strong {
            color: #14532d;
        }

        /* Special Requests Form Card */
        .card-special-requests {
            background: white;
            border-radius: 12px;
            border: 1px solid var(--border-color);
            padding: 24px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.04);
        }

        .card-special-requests h3 {
            font-size: 1.15rem;
            font-weight: 700;
            color: var(--text-dark);
            margin-bottom: 8px;
        }

        .card-special-requests p {
            font-size: 0.85rem;
            color: var(--text-muted);
            margin-bottom: 16px;
            line-height: 1.4;
        }

        .card-special-requests textarea {
            width: 100%;
            min-height: 100px;
            padding: 12px;
            border: 1px solid var(--border-color);
            border-radius: 4px;
            font-family: inherit;
            font-size: 0.95rem;
            outline: none;
            resize: vertical;
        }

        .card-special-requests textarea:focus {
            border-color: var(--booking-light-blue);
        }

        /* Complete Button Section */
        .btn-submit-booking {
            background-color: var(--booking-light-blue);
            color: white;
            border: none;
            padding: 16px 32px;
            font-size: 1.1rem;
            font-weight: 700;
            border-radius: 4px;
            cursor: pointer;
            width: 100%;
            max-width: 320px;
            align-self: flex-end;
            box-shadow: 0 4px 10px rgba(0, 108, 228, 0.25);
            transition: all 0.2s;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }

        .btn-submit-booking:hover {
            background-color: #0056b3;
            box-shadow: 0 6px 14px rgba(0, 108, 228, 0.35);
        }

        /* SVG Icons */
        .icon-svg {
            fill: currentColor;
            width: 20px;
            height: 20px;
        }

        /* Hidden standard fields for submission */
        #hiddenForm {
            display: none;
        }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar">
    <a href="index.jsp" class="navbar-brand">
        <svg class="icon-svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5">
            <path d="M12 2L2 22h20L12 2z" stroke-linejoin="round" stroke-linecap="round"/>
        </svg>
        EcoTravel Karnataka
    </a>
    <a class="navbar-back" href="javascript:history.back()">← Back to Hotel Details</a>
</nav>

<!-- Date / Guest Filter Banner (Booking.com style) -->
<div class="search-banner-wrapper">
    <div class="search-banner">
        <!-- Hotel Search (Readonly) -->
        <div class="sb-item">
            <div class="sb-icon">
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"/>
                    <polyline points="9 22 9 12 15 12 15 22"/>
                </svg>
            </div>
            <input type="text" value="<%= hotel.getName() %>" readonly title="Selected Hotel">
        </div>

        <!-- Dates Check-In / Check-Out -->
        <div class="sb-item">
            <div class="sb-icon">
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <rect x="3" y="4" width="18" height="18" rx="2" ry="2"/>
                    <line x1="16" y1="2" x2="16" y2="6"/>
                    <line x1="8" y1="2" x2="8" y2="6"/>
                    <line x1="3" y1="10" x2="21" y2="10"/>
                </svg>
            </div>
            <div class="sb-date-inputs">
                <input type="date" id="ciDate" value="<%= checkInParam %>" onchange="recalcDates()" title="Check-in Date">
                <span class="sb-divider">—</span>
                <input type="date" id="coDate" value="<%= checkOutParam %>" onchange="recalcDates()" title="Check-out Date">
            </div>
        </div>

        <!-- Guest Selector Dropdown Trigger -->
        <div class="sb-item">
            <div class="sb-icon">
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/>
                    <circle cx="12" cy="7" r="4"/>
                </svg>
            </div>
            <button class="sb-guest-btn" onclick="toggleGuestPopup(event)">
                <span id="guestDisplay">2 adults · 0 children · 1 room</span>
                <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5">
                    <polyline points="6 9 12 15 18 9"/>
                </svg>
            </button>

            <!-- Guest Popup Card Overlay -->
            <div class="guest-popup" id="guestDropdownPopup" onclick="event.stopPropagation()">
                <div class="guest-row">
                    <div class="guest-label">
                        Adults
                    </div>
                    <div class="counter-controls">
                        <button type="button" class="counter-btn" id="adultDec" onclick="updateGuestCount('adults', -1)">-</button>
                        <span class="counter-value" id="adultVal">2</span>
                        <button type="button" class="counter-btn" id="adultInc" onclick="updateGuestCount('adults', 1)">+</button>
                    </div>
                </div>
                <div class="guest-row">
                    <div class="guest-label">
                        Children
                        <span class="guest-sublabel">Ages 0 - 17</span>
                    </div>
                    <div class="counter-controls">
                        <button type="button" class="counter-btn" id="childDec" onclick="updateGuestCount('children', -1)">-</button>
                        <span class="counter-value" id="childVal">0</span>
                        <button type="button" class="counter-btn" id="childInc" onclick="updateGuestCount('children', 1)">+</button>
                    </div>
                </div>
                <div class="guest-row">
                    <div class="guest-label">
                        Rooms
                    </div>
                    <div class="counter-controls">
                        <button type="button" class="counter-btn" id="roomDec" onclick="updateGuestCount('rooms', -1)">-</button>
                        <span class="counter-value" id="roomVal">1</span>
                        <button type="button" class="counter-btn" id="roomInc" onclick="updateGuestCount('rooms', 1)">+</button>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>

<!-- Steps Bar Indicator -->
<div class="steps-container">
    <div class="step-item completed">
        <div class="step-number">✓</div>
        Your Selection
    </div>
    <div class="step-item active">
        <div class="step-number">2</div>
        Your Details
    </div>
    <div class="step-item">
        <div class="step-number">3</div>
        Final Step
    </div>
</div>

<!-- Main Layout Grid -->
<div class="booking-layout">
    
    <!-- LEFT COLUMN: Summary Widgets -->
    <div class="sidebar">
        
        <!-- Selected Hotel Summary Card -->
        <div class="card-hotel-select">
            <div class="hotel-img-wrapper">
                <img class="hotel-img" src="<%= imgSrc %>" alt="<%= hotel.getName() %>"
                     onerror="this.src='https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&w=1200&q=80'">
            </div>
            <div class="hotel-select-content">
                <div class="hotel-rating-stars">
                    <% for(int i=1; i<=hotel.getEcoRating(); i++) { %>★<% } %>
                    <span class="thumbs-up-icon">✓ Eco Preferred</span>
                </div>
                <h2 class="hotel-select-name"><%= hotel.getName() %></h2>
                <p class="hotel-select-address"><%= hotel.getDescription() %></p>
                <div class="hotel-location-badge">🌿 Highly Recommended Eco-Tourism Spot</div>
                
                <div class="hotel-select-rating-block">
                    <div class="rating-score">
                        <%= String.format("%.1f", 7.0 + hotel.getEcoRating() * 0.5) %>
                    </div>
                    <div class="rating-text-summary">
                        Very Good
                        <div class="reviews-count">332 reviews</div>
                    </div>
                </div>

                <div class="hotel-select-amenities">
                    <span class="amenity-tag">📶 Free WiFi</span>
                    <span class="amenity-tag">🅿️ Parking</span>
                    <span class="amenity-tag">🍴 Restaurant</span>
                    <span class="amenity-tag">♻️ Sustainable</span>
                </div>
            </div>
        </div>

        <!-- Stay Details Summary Card -->
        <div class="card-booking-details">
            <h3>Your booking details</h3>
            <div class="date-detail-grid">
                <div class="date-column">
                    <span class="date-column-label">Check-in</span>
                    <span class="date-column-val" id="ciDisplayVal">Wed, Jun 3, 2026</span>
                    <span class="date-column-time">From 12:00 PM</span>
                </div>
                <div class="date-column">
                    <span class="date-column-label">Check-out</span>
                    <span class="date-column-val" id="coDisplayVal">Thu, Jun 4, 2026</span>
                    <span class="date-column-time">Until 11:00 AM</span>
                </div>
            </div>
            <div class="detail-row-summary">
                <p>Total stay duration: <strong id="lblNights">1 night</strong></p>
                <p>Selected rooms: <strong id="lblRooms">1 room</strong></p>
            </div>
            <div class="badge-alert-info">
                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5">
                    <circle cx="12" cy="12" r="10"></circle>
                    <line x1="12" y1="16" x2="12" y2="12"></line>
                    <line x1="12" y1="8" x2="12.01" y2="8"></line>
                </svg>
                Check-in is today!
            </div>
        </div>

        <!-- Dynamic Price Summary Card -->
        <div class="card-price-summary">
            <h3>Your price summary</h3>
            
            <div class="price-row">
                <span class="price-lbl">Original Price</span>
                <span class="price-val" id="summaryOriginalPrice">₹0.00</span>
            </div>
            
            <!-- Getaway Deal Discount (15% off) -->
            <div class="price-row discount-row">
                <span class="price-lbl">Getaway Deal (Eco Promo)</span>
                <span class="price-val" id="summaryDiscountPrice">-₹0.00</span>
            </div>
            <p class="discount-details-note">
                Applied 15% sustainable travel discount for carrying out green tourism pledges.
            </p>

            <div class="price-row" style="margin-bottom: 20px;">
                <span class="price-lbl">GST (12%)</span>
                <span class="price-val" id="summaryTaxPrice">₹0.00</span>
            </div>

            <div class="price-row final-price-row">
                <span class="final-price-lbl">Price</span>
                <div class="final-price-box">
                    <span class="final-price-val" id="summaryGrandTotal">₹0.00</span>
                    <div class="taxes-fees-note">+₹<span id="summaryTaxesNote">0.00</span> taxes and fees</div>
                </div>
            </div>

            <div class="price-info-card">
                <div class="price-info-title">
                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5">
                        <rect x="2" y="4" width="20" height="16" rx="2" ry="2"/>
                        <line x1="12" y1="4" x2="12" y2="20"/>
                    </svg>
                    Price Information
                </div>
                <div class="price-info-text">
                    Includes ₹<span id="summaryGSTNote">0.00</span> Goods and Services Tax (GST) calculated under standard hotel rules.
                </div>
            </div>
        </div>

    </div>

    <!-- RIGHT COLUMN: Booking Form -->
    <div class="main-content">
        
        <!-- Genius Promo Box -->
        <div class="genius-banner">
            <div class="genius-icon">G</div>
            <div class="genius-info">
                <h4>Save 10% or more on this stay option</h4>
                <p>Welcome back! You are logged in as <strong><%= user.getUsername() %></strong>. Your Green Pass privileges have automatically unlocked active discounts on this trip.</p>
                <div class="genius-links">
                    <a href="profile.jsp">View Member Profile</a>
                </div>
            </div>
        </div>

        <!-- Input Details Form -->
        <div class="card-details-form">
            <h3>Enter your details</h3>

            <!-- Customer Submission Details Form -->
            <form id="bookingDetailsForm" onsubmit="handleFormSubmission(event)">
                <div class="form-grid">
                    <div class="form-group">
                        <label>First name <span>*</span></label>
                        <input type="text" id="custFirstName" value="<%= firstName %>" required 
                               pattern="[A-Za-z\s]+" title="First name must contain only letters"
                               oninput="this.value = this.value.replace(/[^A-Za-z\s]/g, '')">
                    </div>
                    <div class="form-group">
                        <label>Last name <span>*</span></label>
                        <input type="text" id="custLastName" value="<%= lastName %>" required 
                               pattern="[A-Za-z\s]+" title="Last name must contain only letters"
                               oninput="this.value = this.value.replace(/[^A-Za-z\s]/g, '')">
                    </div>
                    <div class="form-group full-width">
                        <label>Email address <span>*</span></label>
                        <input type="email" id="custEmail" value="<%= user.getEmail() != null ? user.getEmail() : "" %>" required>
                    </div>

                    <div class="form-group full-width">
                        <label>Country/Region <span>*</span></label>
                        <select id="custCountry" required>
                            <option value="India" selected>India</option>
                            <option value="Sri Lanka">Sri Lanka</option>
                            <option value="Nepal">Nepal</option>
                            <option value="Maldives">Maldives</option>
                            <option value="United Kingdom">United Kingdom</option>
                            <option value="United States">United States</option>
                        </select>
                    </div>
                    <div class="form-group full-width">
                        <label>Phone number <span>*</span></label>
                        <div class="phone-input-group">
                            <select id="custCountryCode" required>
                                <option value="+91" selected>IN +91</option>
                                <option value="+1">US +1</option>
                                <option value="+44">UK +44</option>
                                <option value="+94">LK +94</option>
                            </select>
                            <input type="text" id="custPhone" placeholder="Enter mobile number" required 
                                   pattern="\d{10}" maxlength="10" title="Please enter exactly 10 digits"
                                   oninput="this.value = this.value.replace(/[^0-9]/g, '')">
                        </div>
                    </div>
                </div>

                <!-- Green Pledge Verification -->
                <div class="card-green-pledge">
                    <input type="checkbox" class="pledge-checkbox" id="greenPledgeCheck" required>
                    <label class="pledge-info-lbl" for="greenPledgeCheck">
                        I officially pledge to carry <strong>ZERO single-use plastics</strong> into this ecosystem. 
                        I understand this pledge acts as my verifiable **Digital Green Pass** required for check-in.
                    </label>
                </div>
            </form>
        </div>

        <!-- Special Requests Card -->
        <div class="card-special-requests">
            <h3>Special requests</h3>
            <p>Special requests cannot be guaranteed – but the property will do its best to meet your needs. You can always make a special request after your booking is complete!</p>
            <label style="display:none;" for="specialRequestsText">Special requests</label>
            <textarea id="specialRequestsText" placeholder="e.g. Quiet room, double bed preference, ground floor room..."></textarea>
        </div>

        <!-- Complete Booking Button -->
        <button type="button" class="btn-submit-booking" onclick="triggerSubmit()">
            Complete Booking
            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5">
                <polyline points="9 18 15 12 9 6"/>
            </svg>
        </button>
    </div>

</div>

<!-- Hidden native servlet submission form -->
<form id="hiddenForm" action="bookings" method="post">
    <input type="hidden" name="action" value="create">
    <input type="hidden" name="bookingType" value="hotel">
    <input type="hidden" name="hotelId" value="<%= hotel.getId() %>">
    <input type="hidden" name="destId" value="<%= hotel.getDestinationId() %>">
    <input type="hidden" name="roomType" id="hiddenRoomType" value="Standard">
    <input type="hidden" name="checkIn" id="hiddenCheckIn">
    <input type="hidden" name="checkOut" id="hiddenCheckOut">
    <input type="hidden" name="adults" id="hiddenAdults">
    <input type="hidden" name="children" id="hiddenChildren">
    <input type="hidden" name="rooms" id="hiddenRooms">
    
    <input type="hidden" name="contactName" id="hiddenContactName">
    <input type="hidden" name="contactMobile" id="hiddenContactMobile">
    <input type="hidden" name="contactEmail" id="hiddenContactEmail">
</form>

<script>
    const pricePerNight = <%= hotel.getPricePerNight() %>;

    // Set initial date picker validation properties
    const todayStr = new Date().toISOString().split('T')[0];
    document.getElementById('ciDate').min = todayStr;
    document.getElementById('coDate').min = todayStr;

    // State Variables
    let state = {
        checkIn: "<%= checkInParam %>",
        checkOut: "<%= checkOutParam %>",
        adults: parseInt("<%= adultsParam %>"),
        children: parseInt("<%= childrenParam %>"),
        rooms: parseInt("<%= roomsParam %>")
    };

    // Initialize layout display
    function init() {
        updateGuestValText();
        recalc();
    }

    // Toggle guest selector dropdown
    function toggleGuestPopup(event) {
        event.stopPropagation();
        const popup = document.getElementById('guestDropdownPopup');
        popup.classList.toggle('active');
    }

    // Close guest dropdown on document click
    document.addEventListener('click', function(event) {
        const popup = document.getElementById('guestDropdownPopup');
        if (popup && popup.classList.contains('active')) {
            popup.classList.remove('active');
        }
    });

    // Update guest popup value controls
    function updateGuestCount(type, delta) {
        if (type === 'adults') {
            state.adults = Math.max(1, Math.min(10, state.adults + delta));
            document.getElementById('adultVal').innerText = state.adults;
        } else if (type === 'children') {
            state.children = Math.max(0, Math.min(10, state.children + delta));
            document.getElementById('childVal').innerText = state.children;
        } else if (type === 'rooms') {
            state.rooms = Math.max(1, Math.min(10, state.rooms + delta));
            document.getElementById('roomVal').innerText = state.rooms;
        }

        updateGuestValText();
    }

    function updateGuestValText() {
        const text = state.adults + ' adult' + (state.adults > 1 ? 's' : '') + ' · ' + 
                     state.children + ' child' + (state.children !== 1 ? 'ren' : '') + ' · ' + 
                     state.rooms + ' room' + (state.rooms > 1 ? 's' : '');
        document.getElementById('guestDisplay').innerText = text;
    }

    // Date calculations and formatter helpers
    function fmtDateString(dateStr) {
        if (!dateStr) return "—";
        const options = { weekday: 'short', month: 'short', day: 'numeric', year: 'numeric' };
        return new Date(dateStr + 'T00:00:00').toLocaleDateString('en-US', options);
    }

    // Recalculates check-in/out logic on selection
    function recalcDates() {
        const ci = document.getElementById('ciDate').value;
        const co = document.getElementById('coDate').value;

        if (ci && co && new Date(co) <= new Date(ci)) {
            const next = new Date(ci);
            next.setDate(next.getDate() + 1);
            document.getElementById('coDate').value = next.toISOString().split('T')[0];
        }

        state.checkIn = document.getElementById('ciDate').value;
        state.checkOut = document.getElementById('coDate').value;
        
        recalc();
    }

    // Main logic for pricing and calculations update
    function recalc() {
        document.getElementById('ciDisplayVal').innerText = fmtDateString(state.checkIn);
        document.getElementById('coDisplayVal').innerText = fmtDateString(state.checkOut);

        let nights = 0;
        if (state.checkIn && state.checkOut) {
            nights = Math.ceil((new Date(state.checkOut) - new Date(state.checkIn)) / 86400000);
            if (nights <= 0) nights = 1;
        }

        document.getElementById('lblNights').innerText = nights + ' night' + (nights > 1 ? 's' : '');
        document.getElementById('lblRooms').innerText = state.rooms + ' room' + (state.rooms > 1 ? 's' : '');

        // Calculate Cost Summary
        const baseCost = pricePerNight * state.rooms * nights;
        const discountVal = baseCost * 0.15; // 15% discount for eco pass
        const roomCharge = baseCost - discountVal;
        const gstVal = roomCharge * 0.12; // 12% GST
        const finalCost = roomCharge + gstVal;

        document.getElementById('summaryOriginalPrice').innerText = '₹' + baseCost.toLocaleString('en-IN', {minimumFractionDigits: 2, maximumFractionDigits: 2});
        document.getElementById('summaryDiscountPrice').innerText = '-₹' + discountVal.toLocaleString('en-IN', {minimumFractionDigits: 2, maximumFractionDigits: 2});
        document.getElementById('summaryTaxPrice').innerText = '₹' + gstVal.toLocaleString('en-IN', {minimumFractionDigits: 2, maximumFractionDigits: 2});
        document.getElementById('summaryGrandTotal').innerText = '₹' + finalCost.toLocaleString('en-IN', {minimumFractionDigits: 2, maximumFractionDigits: 2});
        document.getElementById('summaryTaxesNote').innerText = gstVal.toLocaleString('en-IN', {minimumFractionDigits: 2, maximumFractionDigits: 2});
        document.getElementById('summaryGSTNote').innerText = gstVal.toLocaleString('en-IN', {minimumFractionDigits: 2, maximumFractionDigits: 2});
    }

    // Updates top bar properties when searching
    function triggerUpdate() {
        recalcDates();
        recalc();
    }

    // Validates details form and populates hidden fields before submitting booking
    function triggerSubmit() {
        const detailsForm = document.getElementById('bookingDetailsForm');
        if (!detailsForm.reportValidity()) {
            return;
        }

        const ci = state.checkIn;
        const co = state.checkOut;
        if (!ci || !co || new Date(co) <= new Date(ci)) {
            alert('Please select valid check-in and check-out dates.');
            window.scrollTo({top: 0, behavior: 'smooth'});
            return;
        }

        const fname = document.getElementById('custFirstName').value;
        const lname = document.getElementById('custLastName').value;
        const fullNameCombined = fname.trim() + " " + lname.trim();
        const email = document.getElementById('custEmail').value;
        
        const mobile = document.getElementById('custPhone').value;

        // Set hidden form parameters
        document.getElementById('hiddenCheckIn').value = ci;
        document.getElementById('hiddenCheckOut').value = co;
        document.getElementById('hiddenAdults').value = state.adults;
        document.getElementById('hiddenChildren').value = state.children;
        document.getElementById('hiddenRooms').value = state.rooms;
        document.getElementById('hiddenContactName').value = fullNameCombined;
        document.getElementById('hiddenContactMobile').value = mobile;
        document.getElementById('hiddenContactEmail').value = email;

        // Determine Room Type based on room counters/guests as multiplier
        if (state.adults > state.rooms) {
            document.getElementById('hiddenRoomType').value = "Double";
        } else {
            document.getElementById('hiddenRoomType').value = "Standard";
        }

        const submitForm = document.getElementById('hiddenForm');
        submitForm.submit();
    }

    function handleFormSubmission(event) {
        event.preventDefault();
        triggerSubmit();
    }

    // Auto initialize counters and parameters on load
    window.onload = init;
</script>
</body>
</html>
