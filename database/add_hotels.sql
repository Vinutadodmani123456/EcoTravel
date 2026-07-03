USE ecotravel;

-- Add Nandi Hills as destination (id=12)
INSERT IGNORE INTO destinations (id, name, description, eco_score, image_url, base_price, map_embed)
VALUES (12, 'Nandi Hills',
  'A misty hill fortress near Bangalore, Nandi Hills offers stunning sunrise views, ancient temples, and lush greenery. Popular for cycling, paragliding, and morning treks.',
  7,
  'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?auto=format&fit=crop&w=800&q=80',
  1500.00,
  '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d31090.123!2d77.6833!3d13.3667!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3bb1f379447b25c5%3A0x2de1d74e4fb07e26!2sNandi%20Hills!5e0!3m2!1sen!2sin!4v170000!5m2!1sen!2sin" width="100%" height="250" style="border:0;" allowfullscreen="" loading="lazy"></iframe>');

-- ============================================================
-- KUDREMUKH NATIONAL PARK (destination_id = 1)
-- ============================================================
INSERT IGNORE INTO hotels (id, destination_id, name, description, image_url, eco_rating, price_per_night) VALUES
(100, 1, 'Aayana Valley Resorts',
 '📍 Kalasa Main Road, Chikmagalur\n\nScenic valley resort with premium rooms and breathtaking nature views of the Western Ghats.',
 'https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&w=800&q=80', 4, 2500.00),

(101, 1, 'Kathikan Homestay',
 '📍 Near Kudremukh, Kalasa\n\nNature-focused homestay surrounded by forests, suitable for couples and trekking groups.',
 'https://images.unsplash.com/photo-1518733057094-95b53143d2a7?auto=format&fit=crop&w=800&q=80', 4, 1800.00),

(102, 1, "Adi's Home Waterfall Homestay",
 '📍 Kalasa, Chikmagalur\n\nKnown for nearby waterfall access, lush greenery, and a homely atmosphere perfect for nature lovers.',
 'https://images.unsplash.com/photo-1448375240586-882707db888b?auto=format&fit=crop&w=800&q=80', 4, 1500.00),

(103, 1, 'Sri Matha Comforts',
 '📍 Horanadu, Chikmagalur\n\nAffordable and clean budget accommodation near the famous Horanadu temple and forest trails.',
 'https://images.unsplash.com/photo-1555854877-bab0e564b8d5?auto=format&fit=crop&w=800&q=80', 3, 1000.00),

(104, 1, 'Padmashree Stay Horanadu',
 '📍 Horanadu, Chikmagalur\n\nBudget-friendly guest house close to religious sites and the dense Western Ghats.',
 'https://images.unsplash.com/photo-1571896349842-33c89424de2d?auto=format&fit=crop&w=800&q=80', 3, 900.00),

(105, 1, 'Prince Of Kalasa',
 '📍 Kalasa, Chikmagalur\n\nPopular budget hotel in the heart of Kalasa town, close to river ghats and trekking start points.',
 'https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?auto=format&fit=crop&w=800&q=80', 3, 1200.00),

(106, 1, 'Kukke Kumaradhara River Valley Home Stay',
 '📍 Kulkunda Colony, Subrahmanya\n\nNature-style homestay near the Kumaradhara River and popular trekking routes to Kumara Parvatha.',
 'https://images.unsplash.com/photo-1590523277543-a94d2e4eb00b?auto=format&fit=crop&w=800&q=80', 4, 1500.00),

(107, 1, 'Gokula Homestay',
 '📍 Temple Road, Kukke Subrahmanya\n\nPeaceful and well-maintained homestay ideal for trekkers visiting Kukke Subrahmanya temple.',
 'https://images.unsplash.com/photo-1499793983690-e29da59ef1c2?auto=format&fit=crop&w=800&q=80', 4, 1200.00),

(108, 1, 'De Royale Montana Hotel and Resort',
 '📍 Yenekal, Kukke Subrahmanya\n\nResort-style property with modern amenities, surrounded by Western Ghats greenery and fresh mountain air.',
 'https://images.unsplash.com/photo-1544551763-46a013bb70d5?auto=format&fit=crop&w=800&q=80', 5, 3500.00),

(109, 1, 'SLR Residency',
 '📍 Car Street, near KSRTC Bus Stand, Subrahmanya\n\nConvenient and affordable budget hotel perfect for overnight stays before early morning treks.',
 'https://images.unsplash.com/photo-1555854877-bab0e564b8d5?auto=format&fit=crop&w=800&q=80', 3, 800.00);

-- ============================================================
-- AGUMBE RAINFOREST (destination_id = 4)
-- ============================================================
INSERT IGNORE INTO hotels (id, destination_id, name, description, image_url, eco_rating, price_per_night) VALUES
(110, 4, 'Ibbani HomeStay',
 '📍 SH-27, Agumbe\n\nPeaceful homestay surrounded by dense rainforest, perfect for wildlife watchers and nature photography.',
 'https://images.unsplash.com/photo-1518732714860-b62714ce0c59?auto=format&fit=crop&w=800&q=80', 4, 1500.00),

(111, 4, 'Male Mane Farmstay',
 '📍 Agumbe Village\n\nAuthentic Malnad-style farmstay offering traditional home-cooked food and rooms amidst coffee and areca plantations.',
 'https://images.unsplash.com/photo-1471115853179-bb1d604434e0?auto=format&fit=crop&w=800&q=80', 4, 1800.00),

(112, 4, 'Annapoorna Lodge',
 '📍 Agumbe Village\n\nSimple and clean budget accommodation for trekkers and backpackers exploring the Agumbe rainforest.',
 'https://images.unsplash.com/photo-1555854877-bab0e564b8d5?auto=format&fit=crop&w=800&q=80', 3, 800.00),

(113, 4, 'Buddha Tree Home Stay',
 '📍 Rushyashringapura, near Agumbe\n\nEco-style homestay surrounded by thick tropical forests, ideal for a peaceful and rejuvenating stay.',
 'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?auto=format&fit=crop&w=800&q=80', 5, 2000.00);

-- ============================================================
-- DANDELI WILDLIFE SAFARI (destination_id = 3)
-- ============================================================
INSERT IGNORE INTO hotels (id, destination_id, name, description, image_url, eco_rating, price_per_night) VALUES
(114, 3, 'Wild Planet Jungle Resort',
 '📍 Near Kali River Bridge, Kogilban, Dandeli\n\nPopular jungle resort offering safari access, rafting on the Kali River, and immersive wildlife experiences.',
 'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?auto=format&fit=crop&w=800&q=80', 5, 3500.00),

(115, 3, 'Dandeli Jungle Resort',
 '📍 Old Dandeli, Karnataka\n\nEstablished resort inside the jungle, ideal for wildlife enthusiasts and adventure travelers.',
 'https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?auto=format&fit=crop&w=800&q=80', 4, 2500.00),

(116, 3, 'Wild Wings Dandeli',
 '📍 Phansoli, Dandeli\n\nSpecialises in rafting and jungle safari packages. Great for adrenaline seekers and group trips.',
 'https://images.unsplash.com/photo-1499793983690-e29da59ef1c2?auto=format&fit=crop&w=800&q=80', 4, 2000.00),

(117, 3, 'Dandeli Serene River Resort',
 '📍 Near Raghavendra Temple Township, Dandeli\n\nRiverside stay with calm surroundings and access to adventure activities including kayaking and nature walks.',
 'https://images.unsplash.com/photo-1590523277543-a94d2e4eb00b?auto=format&fit=crop&w=800&q=80', 4, 2800.00),

(118, 3, 'Dandeli Luxury River Resort',
 '📍 Old Dandeli\n\nPremium nature resort with river-side views, luxury cottages, and curated wildlife safari packages.',
 'https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&w=800&q=80', 5, 4000.00);

-- ============================================================
-- CHIKMAGALUR (destination_id = 7)
-- ============================================================
INSERT IGNORE INTO hotels (id, destination_id, name, description, image_url, eco_rating, price_per_night) VALUES
(119, 7, 'Bindiga Peak Resorts',
 '📍 Malenahalli Village, Chikmagalur\n\nHill-view resort near popular trekking areas. Offers stunning views of the Baba Budangiri range.',
 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?auto=format&fit=crop&w=800&q=80', 4, 3000.00),

(120, 7, 'Jhari Eco Stay',
 '📍 Datha Peetha Road, Attigundi, Chikmagalur\n\nEco-friendly stay near waterfalls and trekking routes with a strong focus on sustainable tourism.',
 'https://images.unsplash.com/photo-1518732714860-b62714ce0c59?auto=format&fit=crop&w=800&q=80', 5, 2500.00),

(121, 7, 'Punam Paravasha Resort',
 '📍 Hirekolale Road, Chikmagalur\n\nPremium resort with beautiful Hirekolale Lake and Mullayanagiri hill views. Luxurious rooms and stunning surroundings.',
 'https://images.unsplash.com/photo-1544551763-46a013bb70d5?auto=format&fit=crop&w=800&q=80', 5, 4000.00),

(122, 7, 'Coffeeberry Hills Chikmagalur',
 '📍 Chikkolale Village, Chikmagalur\n\nCalm plantation resort inside coffee estates, ideal for nature lovers seeking a quiet retreat.',
 'https://images.unsplash.com/photo-1445019980597-93fa8acb246c?auto=format&fit=crop&w=800&q=80', 4, 2800.00),

(123, 7, 'The Bee Hive Homestay',
 '📍 Karthikere, Chikmagalur\n\nCozy and welcoming homestay experience amidst lush greenery with home-cooked Malnad cuisine.',
 'https://images.unsplash.com/photo-1518733057094-95b53143d2a7?auto=format&fit=crop&w=800&q=80', 4, 1800.00);

-- ============================================================
-- SAKLESHPUR (destination_id = 8)
-- ============================================================
INSERT IGNORE INTO hotels (id, destination_id, name, description, image_url, eco_rating, price_per_night) VALUES
(124, 8, 'Neervana Resort',
 '📍 Anemahal, Hallibylu, Sakleshpur\n\nPeaceful nature resort with valley and coffee plantation views, perfect for a relaxing retreat.',
 'https://images.unsplash.com/photo-1571896349842-33c89424de2d?auto=format&fit=crop&w=800&q=80', 4, 2500.00),

(125, 8, 'Falling Water Resorts by Travent Mug',
 '📍 NH-75, Sakleshpur\n\nHighly popular resort known for scenic waterfall access, adventure activities, and stunning Western Ghats views.',
 'https://images.unsplash.com/photo-1448375240586-882707db888b?auto=format&fit=crop&w=800&q=80', 5, 3500.00),

(126, 8, 'Streamedge HomeStay',
 '📍 Devaladakere, Sakleshpur\n\nWell-known homestay inside coffee estates and greenery, offering a serene and authentic experience.',
 'https://images.unsplash.com/photo-1471115853179-bb1d604434e0?auto=format&fit=crop&w=800&q=80', 4, 2000.00),

(127, 8, 'Sakleshpur Stays',
 '📍 BM Road, Sakleshpur\n\nBudget-friendly accommodation near the town centre with easy access to trek routes and tourist spots.',
 'https://images.unsplash.com/photo-1555854877-bab0e564b8d5?auto=format&fit=crop&w=800&q=80', 3, 1200.00),

(128, 8, 'Sakleshpura Resort Homestay',
 '📍 Kodihalli, Sakleshpur\n\nAffordable homestay and resort booking suitable for families and groups exploring the Ghats.',
 'https://images.unsplash.com/photo-1518733057094-95b53143d2a7?auto=format&fit=crop&w=800&q=80', 3, 1500.00);

-- ============================================================
-- KEMMANAGUNDI (destination_id = 9)
-- ============================================================
INSERT IGNORE INTO hotels (id, destination_id, name, description, image_url, eco_rating, price_per_night) VALUES
(129, 9, 'Kemmannugundi Hill Resort by Jungle Lodges',
 '📍 Thigada, Kemmanagundi, Karnataka\n\nMost popular stay near the hill station with forest trekking access and panoramic valley views.',
 'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?auto=format&fit=crop&w=800&q=80', 5, 3500.00),

(130, 9, 'The Last Resort',
 '📍 Kaimara, Kemmanagundi\n\nNature-style homestay surrounded by dense plantations and the mist of the Kemmanagundi hills.',
 'https://images.unsplash.com/photo-1499793983690-e29da59ef1c2?auto=format&fit=crop&w=800&q=80', 4, 2200.00),

(131, 9, 'The Wildernest Homestay',
 '📍 Kemmanagundi Road, Kaimara\n\nPeaceful homestay with mountain and forest surroundings ideal for birdwatching and nature walks.',
 'https://images.unsplash.com/photo-1518732714860-b62714ce0c59?auto=format&fit=crop&w=800&q=80', 4, 2000.00),

(132, 9, "Joe's Homestay",
 '📍 Ballavara, Kallathipura, Kemmanagundi\n\nFriendly homestay for trekkers and families visiting waterfalls and viewpoints around Kemmanagundi.',
 'https://images.unsplash.com/photo-1518733057094-95b53143d2a7?auto=format&fit=crop&w=800&q=80', 4, 1800.00),

(133, 9, 'Brundavan Home Stay',
 '📍 Ballavara, Nandibattlu Colony, Kemmanagundi\n\nComfortable homestay close to major tourist spots, gardens, and trekking trails of Kemmanagundi.',
 'https://images.unsplash.com/photo-1471115853179-bb1d604434e0?auto=format&fit=crop&w=800&q=80', 3, 1500.00);

-- ============================================================
-- RANGANATHITTU BIRD SANCTUARY (destination_id = 10)
-- ============================================================
INSERT IGNORE INTO hotels (id, destination_id, name, description, image_url, eco_rating, price_per_night) VALUES
(134, 10, "Manvith's Heritage River Resort",
 '📍 Puttayyanakoppalu, near Srirangapatna\n\nRiverside heritage resort close to the sanctuary. Offers peaceful nature surroundings and boat ride access.',
 'https://images.unsplash.com/photo-1590523277543-a94d2e4eb00b?auto=format&fit=crop&w=800&q=80', 5, 3000.00),

(135, 10, 'Hotel Mayura Riverview',
 '📍 Srirangapatna\n\nOne of the most popular stays near Ranganathittu, offering scenic river views and comfortable rooms.',
 'https://images.unsplash.com/photo-1571896349842-33c89424de2d?auto=format&fit=crop&w=800&q=80', 4, 2000.00),

(136, 10, 'Atmaveda Riverside Homestay',
 '📍 Paschimvahini Road, Srirangapatna\n\nEco-style riverside homestay ideal for birdwatchers and families. Overlooks the Cauvery River.',
 'https://images.unsplash.com/photo-1448375240586-882707db888b?auto=format&fit=crop&w=800&q=80', 5, 2500.00),

(137, 10, 'The Riverside Holiday Resorts',
 '📍 Paschimavahini, Srirangapatna\n\nBudget-friendly riverside resort close to boating points and the entrance of Ranganathittu.',
 'https://images.unsplash.com/photo-1555854877-bab0e564b8d5?auto=format&fit=crop&w=800&q=80', 3, 1500.00);

-- ============================================================
-- COORG (destination_id = 11)
-- ============================================================
INSERT IGNORE INTO hotels (id, destination_id, name, description, image_url, eco_rating, price_per_night) VALUES
(138, 11, 'Taj Madikeri Resort & Spa',
 '📍 Galibeedu, Madikeri, Coorg\n\nLuxury 5-star forest resort with valley views, award-winning spa, private plunge pools, and premium villas.',
 'https://images.unsplash.com/photo-1544551763-46a013bb70d5?auto=format&fit=crop&w=800&q=80', 5, 15000.00),

(139, 11, 'The Tamara Coorg',
 '📍 Kabbinakad Estate, Napoklu, Madikeri\n\nPremium eco-luxury resort set inside expansive coffee plantations with stunning valley vistas.',
 'https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&w=800&q=80', 5, 18000.00),

(140, 11, 'Coorg Wilderness Resort & Spa',
 '📍 Mekeri, Madikeri, Coorg\n\nPopular luxury stay surrounded by dense greenery and mist-filled hills with spa and nature trails.',
 'https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?auto=format&fit=crop&w=800&q=80', 5, 8000.00),

(141, 11, 'The Ibnii',
 '📍 Ibnivalavadi Village, Madikeri, Coorg\n\nBoutique luxury resort with private villas, a serene lake, and an atmosphere of complete tranquility.',
 'https://images.unsplash.com/photo-1571896349842-33c89424de2d?auto=format&fit=crop&w=800&q=80', 5, 12000.00),

(142, 11, 'Coorg Marriott Resort & Spa',
 '📍 Makkanduru, Madikeri, Coorg\n\nPremium Marriott resort combining modern luxury with scenic Coorg surroundings, forests, and outdoor activities.',
 'https://images.unsplash.com/photo-1445019980597-93fa8acb246c?auto=format&fit=crop&w=800&q=80', 5, 14000.00);

-- ============================================================
-- NANDI HILLS (destination_id = 12)
-- ============================================================
INSERT IGNORE INTO hotels (id, destination_id, name, description, image_url, eco_rating, price_per_night) VALUES
(143, 12, 'JW Marriott Bengaluru Prestige Golfshire Resort & Spa',
 '📍 Nandi Hills Road, Devanahalli, Bengaluru\n\nFamous for luxury stay, golf course, spa, and hill views. A premium eco-conscious luxury stay experience.',
 'https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&w=800&q=80', 5, 15000.00),

(144, 12, 'Mulberry Shades Bengaluru Nandi Hills, A Tribute Portfolio Resort',
 '📍 Kemathimmanahalli Village, Devanahalli\n\nPeaceful wellness resort near Nandi foothills. Combines holistic living with luxurious green spaces.',
 'https://images.unsplash.com/photo-1544551763-46a013bb70d5?auto=format&fit=crop&w=800&q=80', 5, 12000.00),

(145, 12, 'Summer House Nandi Foothills',
 '📍 Sulthanpet, Chikkaballapur\n\nModern premium hotel close to the hills, featuring eco-friendly architectures and scenic surroundings.',
 'https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?auto=format&fit=crop&w=800&q=80', 4, 4000.00),

(146, 12, 'Hotel Mayura Pinetop - Nandi Betta',
 '📍 On top of Nandi Hills\n\nOne of the most popular stays directly on the hilltop. Offers unmatched early morning sunrise and mist views.',
 'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?auto=format&fit=crop&w=800&q=80', 4, 2800.00),

(147, 12, 'Nandi Resort',
 '📍 Nandi Hills Main Road, Devanahalli\n\nGood option for families and weekend trips. Offers spacious layouts and nature proximity.',
 'https://images.unsplash.com/photo-1499793983690-e29da59ef1c2?auto=format&fit=crop&w=800&q=80', 4, 3200.00),

(148, 12, 'Hotel Sri Sierra',
 '📍 BB Road, Chikkaballapur\n\nBudget-friendly stay near Nandi Hills entrance, offering excellent comfort for backpackers.',
 'https://images.unsplash.com/photo-1555854877-bab0e564b8d5?auto=format&fit=crop&w=800&q=80', 3, 1500.00),

(149, 12, 'Satya Anantham Eco Retreat Mystic Hotels',
 '📍 Madakuhosahalli, foothills of Nandi Hills\n\nNature-style eco retreat with peaceful surroundings, organic farming, and meditation options.',
 'https://images.unsplash.com/photo-1518732714860-b62714ce0c59?auto=format&fit=crop&w=800&q=80', 5, 4500.00),

(150, 12, 'Viewtopia - Luxury Homestay',
 '📍 Singatakadirenahalli Village, Nandi Post\n\nScenic luxury homestay with valley views, private lawns, and organic home-cooked food.',
 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?auto=format&fit=crop&w=800&q=80', 5, 6000.00),

(151, 12, 'Nandi Sahyadri Home Stay',
 '📍 Skandagiri County, Muddenahalli\n\nCalm homestay ideal for trekking visitors. Quiet surroundings and clean atmosphere.',
 'https://images.unsplash.com/photo-1518733057094-95b53143d2a7?auto=format&fit=crop&w=800&q=80', 4, 2000.00),

(152, 12, 'Jhari Retreat',
 '📍 Doddarayappanahalli, Doddaballapura Taluk\n\nQuiet resort stay surrounded by greenery, nature trails, and fresh agricultural fields.',
 'https://images.unsplash.com/photo-1471115853179-bb1d604434e0?auto=format&fit=crop&w=800&q=80', 4, 3500.00),

(153, 12, 'Discovery Village Nandi Foot Hills',
 '📍 Sulthanpet, next to Kanive Nandeeshwara Temple\n\nPopular for team outings, camping, activities, and eco-friendly outdoor team games.',
 'https://images.unsplash.com/photo-1590523277543-a94d2e4eb00b?auto=format&fit=crop&w=800&q=80', 4, 5000.00),

(154, 12, 'Wild Valley Nandi Hills Resorts',
 '📍 Kanivepura, near Nandi Hills\n\nResort with outdoor activities, nature views, and comfortable eco-cottages for families.',
 'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?auto=format&fit=crop&w=800&q=80', 4, 3500.00),

(155, 12, 'VAMA Retreats',
 '📍 Foothills of Nandi Hills\n\nCozy nature stay suitable for couples and groups. Features pet-friendly gardens and organic meals.',
 'https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&w=800&q=80', 4, 4200.00);
