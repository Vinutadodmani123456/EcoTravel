USE ecotravel;

-- Update Nandi Hills destination with proper map embed
UPDATE destinations SET
  map_embed = '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d31090.123!2d77.6833!3d13.3667!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3bb1f379447b25c5%3A0x2de1d74e4fb07e26!2sNandi%20Hills!5e0!3m2!1sen!2sin!4v170000!5m2!1sen!2sin" width="100%" height="250" style="border:0;" allowfullscreen="" loading="lazy"></iframe>'
WHERE id = 12;

-- Insert all 13 hotels for Nandi Hills (destination_id = 12)
INSERT INTO hotels (destination_id, name, description, image_url, eco_rating, price_per_night) VALUES

-- Luxury Resorts & Premium Stay
(12, 'JW Marriott Bengaluru Prestige Golfshire Resort & Spa',
 '📍 Nandi Hills Road, Devanahalli, Bengaluru\n\nFamous for luxury stay, golf course, spa, and hill views. A premier eco-conscious luxury experience.',
 'https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&w=800&q=80', 5, 15000.00),

(12, 'Mulberry Shades Bengaluru Nandi Hills, A Tribute Portfolio Resort',
 '📍 Kemathimmanahalli Village, Devanahalli\n\nPeaceful wellness resort near Nandi foothills. Combines holistic living with luxurious green spaces.',
 'https://images.unsplash.com/photo-1544551763-46a013bb70d5?auto=format&fit=crop&w=800&q=80', 5, 12000.00),

(12, 'Summer House Nandi Foothills',
 '📍 Sulthanpet, Chikkaballapur\n\nModern premium hotel close to the hills, featuring eco-friendly architecture and scenic surroundings.',
 'https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?auto=format&fit=crop&w=800&q=80', 4, 4000.00),

-- Budget & Mid-Range Hotels
(12, 'Hotel Mayura Pinetop - Nandi Betta',
 '📍 On top of Nandi Hills\n\nOne of the most popular stays directly on the hilltop. Offers unmatched early morning sunrise and mist views.',
 'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?auto=format&fit=crop&w=800&q=80', 4, 2800.00),

(12, 'Nandi Resort',
 '📍 Nandi Hills Main Road, Devanahalli\n\nGood option for families and weekend trips. Offers spacious layouts and nature proximity.',
 'https://images.unsplash.com/photo-1499793983690-e29da59ef1c2?auto=format&fit=crop&w=800&q=80', 4, 3200.00),

(12, 'Hotel Sri Sierra',
 '📍 BB Road, Chikkaballapur\n\nBudget-friendly stay near Nandi Hills entrance, offering excellent comfort for all travellers.',
 'https://images.unsplash.com/photo-1555854877-bab0e564b8d5?auto=format&fit=crop&w=800&q=80', 3, 1500.00),

(12, 'Satya Anantham Eco Retreat Mystic Hotels',
 '📍 Madakuhosahalli, foothills of Nandi Hills\n\nNature-style eco retreat with peaceful surroundings, organic farming, and meditation options.',
 'https://images.unsplash.com/photo-1518732714860-b62714ce0c59?auto=format&fit=crop&w=800&q=80', 5, 4500.00),

-- Homestays & Nature Retreats
(12, 'Viewtopia - Luxury Homestay',
 '📍 Singatakadirenahalli Village, Nandi Post\n\nScenic luxury homestay with valley views, private lawns, and organic home-cooked food.',
 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?auto=format&fit=crop&w=800&q=80', 5, 6000.00),

(12, 'Nandi Sahyadri Home Stay',
 '📍 Skandagiri County, Muddenahalli\n\nCalm homestay ideal for trekking visitors. Quiet surroundings and clean, fresh atmosphere.',
 'https://images.unsplash.com/photo-1518733057094-95b53143d2a7?auto=format&fit=crop&w=800&q=80', 4, 2000.00),

(12, 'Jhari Retreat',
 '📍 Doddarayappanahalli, Doddaballapura Taluk\n\nQuiet resort stay surrounded by greenery, nature trails, and fresh agricultural fields.',
 'https://images.unsplash.com/photo-1471115853179-bb1d604434e0?auto=format&fit=crop&w=800&q=80', 4, 3500.00),

-- Adventure & Group Stay Resorts
(12, 'Discovery Village Nandi Foot Hills',
 '📍 Sulthanpet, next to Kanive Nandeeshwara Temple\n\nPopular for team outings, camping, adventure activities, and eco-friendly outdoor group games.',
 'https://images.unsplash.com/photo-1590523277543-a94d2e4eb00b?auto=format&fit=crop&w=800&q=80', 4, 5000.00),

(12, 'Wild Valley Nandi Hills Resorts',
 '📍 Kanivepura, near Nandi Hills\n\nResort with outdoor activities, nature views, and comfortable eco-cottages for families and groups.',
 'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?auto=format&fit=crop&w=800&q=80', 4, 3500.00),

(12, 'VAMA Retreats',
 '📍 Foothills of Nandi Hills\n\nCozy nature stay suitable for couples and groups. Features pet-friendly gardens and organic meals.',
 'https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&w=800&q=80', 4, 4200.00);
