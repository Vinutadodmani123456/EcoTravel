USE ecotravel;

-- Insert Admin and User
INSERT IGNORE INTO users (id, username, password, email, role) VALUES 
(1, 'admin', 'admin123', 'admin@ecotravel.com', 'admin'),
(2, 'john_doe', 'pass123', 'john@example.com', 'user');

-- Insert Destinations in Karnataka
INSERT IGNORE INTO destinations (id, name, description, eco_score, image_url, base_price, map_embed) VALUES
(1, 'Kudremukh Trek (Chikmagalur)', 'A pristine mountain peak in the Western Ghats, famed for its lush green hills and strict plastic-free eco-policies. Perfect for nature trekking.', 9, 'https://images.unsplash.com/photo-1596423735880-5c62b9bba014?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80', 1500.00, '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d15546.68!2d75.2573!3d13.1360!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3bbabe5db694c9ad%3A0xe104ff9ee11029ba!2sKudremukh!5e0!3m2!1sen!2sin!4v170000!5m2!1sen!2sin" width="100%" height="250" style="border:0;" allowfullscreen="" loading="lazy"></iframe>'),
(2, 'Kumara Parvatha Trek (Pushpagiri)', 'One of the most challenging and rewarding treks in Karnataka, taking you through dense forests and ancient temples in the Pushpagiri Wildlife Sanctuary.', 10, 'https://images.unsplash.com/photo-1620662736427-b8a198ee64d2?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80', 1200.00, '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d31131.78!2d75.6666!3d12.6685!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3ba4e6b5d92c7331%3A0xf69cbad5a7fe7b25!2sKumara%20Parvatha!5e0!3m2!1sen!2sin!4v170000!5m2!1sen!2sin" width="100%" height="250" style="border:0;" allowfullscreen="" loading="lazy"></iframe>'),
(3, 'Dandeli Wildlife Safari', 'Known for white water rafting and thick evergreen forests along the Kali River. A premier destination for eco-conscious wildlife lovers.', 8, 'https://images.unsplash.com/photo-1606214532588-4e8910072d63?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80', 2000.00, '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d61688.08!2d74.5802!3d15.2443!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3bbfb1e428c0eaff%3A0xd61a58eb8dacc73b!2sDandeli!5e0!3m2!1sen!2sin!4v170000!5m2!1sen!2sin" width="100%" height="250" style="border:0;" allowfullscreen="" loading="lazy"></iframe>'),
(4, 'Agumbe Rainforest (Shimoga)', 'The "Cherrapunji of the South" is a high-altitude village famous for its dense rainforests, waterfalls, and as a habitat for the King Cobra.', 10, 'https://images.unsplash.com/photo-1502082553048-f009c37129b9?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80', 1800.00, '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d15531.0!2d75.09!3d13.5!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3bbaf50!2sAgumbe!5e0!3m2!1sen!2sin!4v170000!5m2!1sen!2sin" width="100%" height="250" style="border:0;" allowfullscreen="" loading="lazy"></iframe>'),
(5, 'Kodachadri Peak (Shivamogga)', 'A natural heritage site featuring rolling hills and clouds touching the peaks. Home to the Mookambika Wildlife Sanctuary.', 9, 'https://images.unsplash.com/photo-1542332213-9b5a5a3fad35?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80', 1400.00, '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d15525.0!2d74.8!3d13.8!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3bbad50!2sKodachadri!5e0!3m2!1sen!2sin!4v170000!5m2!1sen!2sin" width="100%" height="250" style="border:0;" allowfullscreen="" loading="lazy"></iframe>'),
(6, 'Dubare Elephant Camp (Coorg)', 'Located on the banks of the Kaveri River, this eco-camp offers a unique chance to interact with elephants in their natural forest home.', 8, 'https://images.unsplash.com/photo-1581009146145-b5ef03a7401c?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80', 1600.00, '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d15565.0!2d75.9!3d12.4!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3ba4e60!2sDubare!5e0!3m2!1sen!2sin!4v170000!5m2!1sen!2sin" width="100%" height="250" style="border:0;" allowfullscreen="" loading="lazy"></iframe>');

-- Insert Eco-friendly Hotels with better details
INSERT IGNORE INTO hotels (id, destination_id, name, description, image_url, eco_rating, price_per_night) VALUES
(1, 1, 'Kudremukh Eco Homestay (Solar Powered)', 'Nestled in the heart of the Western Ghats, this homestay uses 100% solar energy and serves organic local food.', 'https://images.unsplash.com/photo-1566073771259-6a8506099945?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80', 5, 800.00),
(2, 2, 'Pushpagiri Wildlife Eco-Tents', 'Experience raw nature by staying in waterproof eco-tents near the sanctuary base. Minimal carbon footprint.', 'https://images.unsplash.com/photo-1499793983690-e29da59ef1c2?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80', 4, 500.00),
(3, 3, 'Kali River Green Tree Lodge', 'Luxury treehouses overlooking the Kali River. Famous for sustainable architecture and bird watching.', 'https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80', 5, 1500.00),
(4, 1, 'Chikmagalur Coffee Estate Retreat', 'A heritage property situated inside a lush coffee plantation. Offers guided nature walks.', 'https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80', 4, 1200.00),
(5, 2, 'Coorg Spice Trails Homestay', 'Stay amidst black pepper and cardamom plantations. A true sensory experience of Coorg greenery.', 'https://images.unsplash.com/photo-1445019980597-93fa8acb246c?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80', 5, 1800.00),
(6, 3, 'Dandeli Jungle Bamboo Huts', 'Eco-friendly bamboo cottages designed for wildlife enthusiasts. Safe and serene environment.', 'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80', 5, 750.00),
(7, 4, 'Agumbe Rainforest Research Lodge', 'A unique stay focused on education and conservation. Learn about rainforest biodiversity.', 'https://images.unsplash.com/photo-1518732714860-b62714ce0c59?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80', 5, 1000.00),
(8, 5, 'Kodachadri Peak-view Resort', 'A budget-friendly eco-resort offering the best sunrise and sunset views in the Malnad region.', 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80', 4, 900.00),
(9, 6, 'Dubare River-side Eco-Lodge', 'Wooden cottages on the river bank, using recycled materials and traditional architecture.', 'https://images.unsplash.com/photo-1590523277543-a94d2e4eb00b?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80', 5, 1300.00);

-- Insert Green Transport Options
INSERT IGNORE INTO transport (id, destination_id, type, carbon_footprint, price) VALUES
(1, 1, 'KSRTC Electric Bus (Bangalore to Kalasa)', 'Low', 600.00),
(2, 2, 'Shared Jeep Safari (Subrahmanya Base)', 'Medium', 400.00),
(3, 3, 'Private EV Cab (Hubballi to Dandeli)', 'Zero', 1200.00),
(4, 4, 'Bicycle Rental Hub (Local Trails)', 'Zero', 200.00),
(5, 5, 'Shared EV Shuttle Service', 'Low', 350.00),
(6, 6, 'Solar Powered River Boat', 'Zero', 500.00),
(7, 4, 'Rainforest EV Shuttle', 'Low', 450.00),
(8, 5, 'Shared Trekking Hybrid Van', 'Medium', 550.00),
(9, 6, 'Solar Bamboo Raft (River Crossing)', 'Zero', 300.00);
