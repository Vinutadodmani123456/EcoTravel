package com.ecotravel.util;

import java.sql.Connection;
import java.sql.Statement;

public class DBInitializer {
    public static void main(String[] args) {
        System.out.println(">>> [DATABASE] Starting hotel data initialization...");

        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement()) {

            stmt.executeUpdate("DELETE FROM hotels");

            insertHotel(stmt, 1, "Aayana Valley Resorts", "Location: Kalasa Main Road, Chikmagalur\nScenic valley resort with premium rooms and nature views.", "https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&w=800&q=80", 4, 2500);
            insertHotel(stmt, 1, "Kathikan Homestay", "Location: Near Kudremukh, Kalasa\nNature-focused stay suitable for couples and groups.", "https://images.unsplash.com/photo-1518733057094-95b53143d2a7?auto=format&fit=crop&w=800&q=80", 4, 1800);
            insertHotel(stmt, 1, "Adi's Home Waterfall Homestay - Kalasa Chikmagalur", "Location: Kalasa\nKnown for nearby waterfall access and greenery.", "https://images.unsplash.com/photo-1448375240586-882707db888b?auto=format&fit=crop&w=800&q=80", 4, 1500);
            insertHotel(stmt, 1, "Sri Matha Comforts", "Location: Horanadu\nBudget stay option near Kudremukh routes.", "https://images.unsplash.com/photo-1555854877-bab0e564b8d5?auto=format&fit=crop&w=800&q=80", 3, 1000);
            insertHotel(stmt, 1, "Padmashree Stay Horanadu", "Location: Horanadu\nBudget-friendly stay option for families and trekkers.", "https://images.unsplash.com/photo-1571896349842-33c89424de2d?auto=format&fit=crop&w=800&q=80", 3, 900);
            insertHotel(stmt, 1, "Prince Of Kalasa", "Location: Kalasa\nConvenient budget hotel close to Kalasa town routes.", "https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?auto=format&fit=crop&w=800&q=80", 3, 1200);

            insertHotel(stmt, 2, "Kukke Kumaradhara River Valley Home Stay", "Location: Kulkunda Colony, Subrahmanya\nNature-style homestay near the river and trekking area.", "https://images.unsplash.com/photo-1590523277543-a94d2e4eb00b?auto=format&fit=crop&w=800&q=80", 4, 1500);
            insertHotel(stmt, 2, "Gokula Homestay", "Location: Temple Road, Kukke Subrahmanya\nPeaceful homestay suitable for trekkers.", "https://images.unsplash.com/photo-1499793983690-e29da59ef1c2?auto=format&fit=crop&w=800&q=80", 4, 1200);
            insertHotel(stmt, 2, "De Royale Montana Hotel and Resort", "Location: Yenekal, Kukke Subrahmanya\nResort-style stay surrounded by greenery.", "https://images.unsplash.com/photo-1544551763-46a013bb70d5?auto=format&fit=crop&w=800&q=80", 5, 3500);
            insertHotel(stmt, 2, "SLR Residency", "Location: Car Street, near KSRTC Bus Stand\nConvenient budget hotel for overnight trek stays.", "https://images.unsplash.com/photo-1555854877-bab0e564b8d5?auto=format&fit=crop&w=800&q=80", 3, 800);

            insertHotel(stmt, 4, "Ibbani HomeStay", "Location: SH-27, Agumbe\nPeaceful homestay suitable for rainforest travelers.", "https://images.unsplash.com/photo-1518732714860-b62714ce0c59?auto=format&fit=crop&w=800&q=80", 4, 1500);
            insertHotel(stmt, 4, "Male Mane Farmstay", "Location: Car Street, Agumbe\nFarmstay experience with Malnad-style food and rooms.", "https://images.unsplash.com/photo-1471115853179-bb1d604434e0?auto=format&fit=crop&w=800&q=80", 4, 1800);
            insertHotel(stmt, 4, "Annapoorna Lodge", "Location: Agumbe Village\nSimple budget stay for trekkers and backpackers.", "https://images.unsplash.com/photo-1555854877-bab0e564b8d5?auto=format&fit=crop&w=800&q=80", 3, 800);
            insertHotel(stmt, 4, "Buddha Tree Home Stay", "Location: Rushyashringapura, near Agumbe\nEco-style homestay surrounded by forests.", "https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?auto=format&fit=crop&w=800&q=80", 5, 2000);

            insertHotel(stmt, 3, "Wild Planet Jungle Resort, Dandeli", "Location: Near Kali River Bridge, Kogilban\nPopular for jungle stay, safari access, and river activities.", "https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?auto=format&fit=crop&w=800&q=80", 5, 3500);
            insertHotel(stmt, 3, "Dandeli Jungle Resort", "Location: Old Dandeli, Karnataka\nGood option for wildlife and adventure travelers.", "https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?auto=format&fit=crop&w=800&q=80", 4, 2500);
            insertHotel(stmt, 3, "Wild Wings Dandeli", "Location: Phansoli, Dandeli\nKnown for rafting and safari packages.", "https://images.unsplash.com/photo-1499793983690-e29da59ef1c2?auto=format&fit=crop&w=800&q=80", 4, 2000);
            insertHotel(stmt, 3, "Dandeli Serene River Resort", "Location: Near Raghavendra Temple Township\nRiverside stay with adventure activities.", "https://images.unsplash.com/photo-1590523277543-a94d2e4eb00b?auto=format&fit=crop&w=800&q=80", 4, 2800);
            insertHotel(stmt, 3, "Dandeli Luxury River Resort", "Location: Old Dandeli\nNature resort with river-side views.", "https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&w=800&q=80", 5, 4000);

            insertHotel(stmt, 7, "Bindiga Peak Resorts", "Location: Malenahalli Village\nHill-view resort near trekking areas.", "https://images.unsplash.com/photo-1506905925346-21bda4d32df4?auto=format&fit=crop&w=800&q=80", 4, 3000);
            insertHotel(stmt, 7, "Jhari Eco Stay", "Location: Datha Peetha Road, Attigundi\nEco-friendly stay near waterfalls and trekking routes.", "https://images.unsplash.com/photo-1518732714860-b62714ce0c59?auto=format&fit=crop&w=800&q=80", 5, 2500);
            insertHotel(stmt, 7, "Punam Paravasha Resort", "Location: Hirekolale Road\nResort with beautiful lake and hill surroundings.", "https://images.unsplash.com/photo-1544551763-46a013bb70d5?auto=format&fit=crop&w=800&q=80", 5, 4000);
            insertHotel(stmt, 7, "Coffeeberry Hills Chikmagalur", "Location: Chikkolale Village\nCalm plantation resort ideal for nature lovers.", "https://images.unsplash.com/photo-1445019980597-93fa8acb246c?auto=format&fit=crop&w=800&q=80", 4, 2800);
            insertHotel(stmt, 7, "The Bee Hive Homestay", "Location: Karthikere\nCozy homestay experience in greenery.", "https://images.unsplash.com/photo-1518733057094-95b53143d2a7?auto=format&fit=crop&w=800&q=80", 4, 1800);

            insertHotel(stmt, 8, "Neervana Resort, Sakalespura", "Location: Anemahal, Hallibylu, Sakleshpur\nPeaceful nature resort with valley and plantation views.", "https://images.unsplash.com/photo-1571896349842-33c89424de2d?auto=format&fit=crop&w=800&q=80", 4, 2500);
            insertHotel(stmt, 8, "Falling Water Resorts by Travent Mug", "Location: NH-75, Sakleshpur\nPopular for waterfalls, adventure activities, and scenic stay.", "https://images.unsplash.com/photo-1448375240586-882707db888b?auto=format&fit=crop&w=800&q=80", 5, 3500);
            insertHotel(stmt, 8, "Streamedge HomeStay in Sakleshpur", "Location: Devaladakere, Sakleshpur\nWell-known homestay inside greenery and coffee estates.", "https://images.unsplash.com/photo-1471115853179-bb1d604434e0?auto=format&fit=crop&w=800&q=80", 4, 2000);
            insertHotel(stmt, 8, "Sakleshpur Stays", "Location: BM Road, Sakleshpur\nBudget-friendly stay option near the town center.", "https://images.unsplash.com/photo-1555854877-bab0e564b8d5?auto=format&fit=crop&w=800&q=80", 3, 1200);
            insertHotel(stmt, 8, "Sakleshpura Resort Homestay Booking", "Location: Kodihalli, Sakleshpur\nAffordable homestay and resort booking option for groups and families.", "https://images.unsplash.com/photo-1518733057094-95b53143d2a7?auto=format&fit=crop&w=800&q=80", 3, 1500);

            insertHotel(stmt, 9, "Kemmannugundi Hill Resort by Jungle Lodges", "Location: Thigada, Kemmanagundi, Karnataka\nPopular stay near the hill station with trekking access and valley views.", "https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?auto=format&fit=crop&w=800&q=80", 5, 3500);
            insertHotel(stmt, 9, "The Last Resort", "Location: Kaimara, Kemmanagundi\nNature-style homestay surrounded by plantations and greenery.", "https://images.unsplash.com/photo-1499793983690-e29da59ef1c2?auto=format&fit=crop&w=800&q=80", 4, 2200);
            insertHotel(stmt, 9, "The Wildernest Homestay", "Location: Kemmanagundi Road, Kaimara\nPeaceful homestay with mountain and forest surroundings.", "https://images.unsplash.com/photo-1518732714860-b62714ce0c59?auto=format&fit=crop&w=800&q=80", 4, 2000);
            insertHotel(stmt, 9, "Joe's Homestay", "Location: Ballavara, Kallathipura\nGood stay option for trekkers and families visiting waterfalls and viewpoints.", "https://images.unsplash.com/photo-1518733057094-95b53143d2a7?auto=format&fit=crop&w=800&q=80", 4, 1800);
            insertHotel(stmt, 9, "Brundavan Home Stay", "Location: Ballavara, Nandibattlu Colony\nComfortable homestay near major tourist spots.", "https://images.unsplash.com/photo-1471115853179-bb1d604434e0?auto=format&fit=crop&w=800&q=80", 3, 1500);

            insertHotel(stmt, 10, "Manvith's Heritage River Resort", "Location: Puttayyanakoppalu, near Srirangapatna\nRiverside resort close to the sanctuary with peaceful nature surroundings.", "https://images.unsplash.com/photo-1590523277543-a94d2e4eb00b?auto=format&fit=crop&w=800&q=80", 5, 3000);
            insertHotel(stmt, 10, "Hotel Mayura Riverview", "Location: Srirangapatna\nPopular stay near Ranganathittu with river views.", "https://images.unsplash.com/photo-1571896349842-33c89424de2d?auto=format&fit=crop&w=800&q=80", 4, 2000);
            insertHotel(stmt, 10, "Atmaveda Riverside Homestay", "Location: Paschimvahini Road, Srirangapatna\nEco-style riverside homestay ideal for birdwatchers and families.", "https://images.unsplash.com/photo-1448375240586-882707db888b?auto=format&fit=crop&w=800&q=80", 5, 2500);
            insertHotel(stmt, 10, "The Riverside Holiday Resorts", "Location: Paschimavahini, Srirangapatna\nBudget-friendly riverside resort near boating points.", "https://images.unsplash.com/photo-1555854877-bab0e564b8d5?auto=format&fit=crop&w=800&q=80", 3, 1500);

            insertHotel(stmt, 11, "Taj Madikeri Resort & Spa, Coorg", "Location: Galibeedu, Madikeri\nLuxury forest resort with valley views, spa, and private villas.", "https://images.unsplash.com/photo-1544551763-46a013bb70d5?auto=format&fit=crop&w=800&q=80", 5, 15000);
            insertHotel(stmt, 11, "The Tamara Coorg", "Location: Kabbinakad Estate, Napoklu, Madikeri\nPremium eco-luxury resort inside coffee plantations.", "https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&w=800&q=80", 5, 18000);
            insertHotel(stmt, 11, "Coorg Wilderness Resort & Spa", "Location: Mekeri, Madikeri\nPopular luxury stay surrounded by dense greenery and hills.", "https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?auto=format&fit=crop&w=800&q=80", 5, 8000);
            insertHotel(stmt, 11, "The Ibnii", "Location: Ibnivalavadi Village, Madikeri\nKnown for private villas, lake views, and peaceful atmosphere.", "https://images.unsplash.com/photo-1571896349842-33c89424de2d?auto=format&fit=crop&w=800&q=80", 5, 12000);
            insertHotel(stmt, 11, "Coorg Marriott Resort & Spa", "Location: Makkanduru, Madikeri\nPremium resort with modern luxury and scenic surroundings.", "https://images.unsplash.com/photo-1445019980597-93fa8acb246c?auto=format&fit=crop&w=800&q=80", 5, 14000);

            stmt.executeUpdate("INSERT IGNORE INTO destinations (id, name, description, eco_score, image_url, base_price, map_embed) VALUES (12, 'Nandi Hills', 'A misty hill station near Bengaluru known for sunrise views, ancient forts, and cool green surroundings.', 7, 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?auto=format&fit=crop&w=800&q=80', 1500, '<iframe src=\"https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d31090.123!2d77.6833!3d13.3667!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3bb1f379447b25c5%3A0x2de1d74e4fb07e26!2sNandi%20Hills!5e0!3m2!1sen!2sin!4v170000!5m2!1sen!2sin\" width=\"100%\" height=\"250\" style=\"border:0;\" allowfullscreen=\"\" loading=\"lazy\"></iframe>')");
            insertHotel(stmt, 12, "JW Marriott Bengaluru Prestige Golfshire Resort & Spa", "Location: Nandi Hills Road, Devanahalli, Bengaluru\nFamous for luxury stay, golf course, spa, and hill views. A premium eco-conscious luxury stay experience.", "https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&w=800&q=80", 5, 15000);
            insertHotel(stmt, 12, "Mulberry Shades Bengaluru Nandi Hills, A Tribute Portfolio Resort", "Location: Kemathimmanahalli Village, Devanahalli\nPeaceful wellness resort near Nandi foothills. Combines holistic living with luxurious green spaces.", "https://images.unsplash.com/photo-1544551763-46a013bb70d5?auto=format&fit=crop&w=800&q=80", 5, 12000);
            insertHotel(stmt, 12, "Summer House Nandi Foothills", "Location: Sulthanpet, Chikkaballapur\nModern premium hotel close to the hills, featuring eco-friendly architectures.", "https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?auto=format&fit=crop&w=800&q=80", 4, 4000);
            insertHotel(stmt, 12, "Hotel Mayura Pinetop - Nandi Betta", "Location: On top of Nandi Hills\nOne of the most popular stays directly on the hilltop. Offers unmatched early morning sunrise views.", "https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?auto=format&fit=crop&w=800&q=80", 4, 2800);
            insertHotel(stmt, 12, "Nandi Resort", "Location: Nandi Hills Main Road, Devanahalli\nGood option for families and weekend trips. Offers spacious layouts and nature proximity.", "https://images.unsplash.com/photo-1499793983690-e29da59ef1c2?auto=format&fit=crop&w=800&q=80", 4, 3200);
            insertHotel(stmt, 12, "Hotel Sri Sierra", "Location: BB Road, Chikkaballapur\nBudget-friendly stay near Nandi Hills entrance, offering excellent comfort.", "https://images.unsplash.com/photo-1555854877-bab0e564b8d5?auto=format&fit=crop&w=800&q=80", 3, 1500);
            insertHotel(stmt, 12, "Satya Anantham Eco Retreat Mystic Hotels", "Location: Madakuhosahalli, foothills of Nandi Hills\nNature-style eco retreat with peaceful surroundings, organic farming, and meditation options.", "https://images.unsplash.com/photo-1518732714860-b62714ce0c59?auto=format&fit=crop&w=800&q=80", 5, 4500);
            insertHotel(stmt, 12, "Viewtopia - Luxury Homestay", "Location: Singatakadirenahalli Village, Nandi Post\nScenic luxury homestay with valley views, private lawns, and organic home-cooked food.", "https://images.unsplash.com/photo-1506905925346-21bda4d32df4?auto=format&fit=crop&w=800&q=80", 5, 6000);
            insertHotel(stmt, 12, "Nandi Sahyadri Home Stay", "Location: Skandagiri County, Muddenahalli\nCalm homestay ideal for trekking visitors. Quiet surroundings and clean atmosphere.", "https://images.unsplash.com/photo-1518733057094-95b53143d2a7?auto=format&fit=crop&w=800&q=80", 4, 2000);
            insertHotel(stmt, 12, "Jhari Retreat", "Location: Doddarayappanahalli, Doddaballapura Taluk\nQuiet resort stay surrounded by greenery, nature trails, and fresh agricultural fields.", "https://images.unsplash.com/photo-1471115853179-bb1d604434e0?auto=format&fit=crop&w=800&q=80", 4, 3500);
            insertHotel(stmt, 12, "Discovery Village Nandi Foot Hills", "Location: Sulthanpet, next to Kanive Nandeeshwara Temple\nPopular for team outings, camping, activities, and eco-friendly outdoor team games.", "https://images.unsplash.com/photo-1590523277543-a94d2e4eb00b?auto=format&fit=crop&w=800&q=80", 4, 5000);
            insertHotel(stmt, 12, "Wild Valley Nandi Hills Resorts", "Location: Kanivepura, near Nandi Hills\nResort with outdoor activities, nature views, and comfortable eco-cottages.", "https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?auto=format&fit=crop&w=800&q=80", 4, 3500);
            insertHotel(stmt, 12, "VAMA Retreats", "Location: Foothills of Nandi Hills\nCozy nature stay suitable for couples and groups. Features pet-friendly gardens.", "https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&w=800&q=80", 4, 4200);

            System.out.println(">>> [DATABASE] SUCCESS: Requested hotels added with images and locations.");
        } catch (Exception e) {
            System.err.println(">>> [DATABASE] ERROR: " + e.getMessage());
        }
    }

    private static void insertHotel(Statement stmt, int destinationId, String name, String description, String imageUrl, int ecoRating, int pricePerNight) throws Exception {
        String sql = String.format(
            "INSERT INTO hotels (destination_id, name, description, image_url, eco_rating, price_per_night) VALUES (%d, '%s', '%s', '%s', %d, %d)",
            destinationId,
            escape(name),
            escape(description),
            escape(imageUrl),
            ecoRating,
            pricePerNight
        );
        stmt.executeUpdate(sql);
    }

    private static String escape(String value) {
        return value.replace("'", "''");
    }
}
