USE ecotravel;

-- Insert Admin and User
INSERT IGNORE INTO
    users (
        id,
        username,
        password,
        email,
        role
    )
VALUES (
        1,
        'admin',
        'admin123',
        'admin@ecotravel.com',
        'admin'
    ),
    (
        2,
        'john_doe',
        'pass123',
        'john@example.com',
        'user'
    );

-- Insert Destinations in Karnataka
INSERT IGNORE INTO
    destinations (
        id,
        name,
        description,
        eco_score,
        image_url,
        base_price,
        map_embed
    )
VALUES (
        1,
        'Kudremukh National Park',
        'Named after a peak resembling a horse\'s face, this area in Chikmagalur is a vital corridor of biodiversity, featuring rolling hills and grasslands.',
        9,
        'https://www.bynekaadu.com/wp-content/uploads/2024/01/1-1.png',
        1500.00,
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d15546.68!2d75.2573!3d13.1360!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3bbabe5db694c9ad%3A0xe104ff9ee11029ba!2sKudremukh!5e0!3m2!1sen!2sin!4v170000!5m2!1sen!2sin" width="100%" height="250" style="border:0;" allowfullscreen="" loading="lazy"></iframe>'
    ),
    (
        2,
        'Kumara Parvatha Trek (Pushpagiri)',
        'One of the most challenging and rewarding treks in Karnataka, taking you through dense forests and ancient temples in the Pushpagiri Wildlife Sanctuary.',
        10,
        'https://images.openai.com/static-rsc-4/Yc5Zbeb0arO93ZTCypzvBR1lOiNzcvzRkx-SqUHKNIRRICdv1dn7ApxwW06623eod5g4KYn9fdgNCyyEEWA7trrntgxOkzDZ8pjf-WnB7NYXy8RQiVxDZckdIkiasMoJcE9AIx0JBoQ9eaERQVq1WQ-D_Fz5XudepjAywrcWUM3w5tHo0Aib-XezSkPB_a-m?purpose=fullsize',
        1200.00,
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d31131.78!2d75.6666!3d12.6685!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3ba4e6b5d92c7331%3A0xf69cbad5a7fe7b25!2sKumara%20Parvatha!5e0!3m2!1sen!2sin!4v170000!5m2!1sen!2sin" width="100%" height="250" style="border:0;" allowfullscreen="" loading="lazy"></iframe>'
    ),
    (
        3,
        'Dandeli Wildlife Safari',
        'Known for white water rafting and thick evergreen forests along the Kali River. A premier destination for eco-conscious wildlife lovers.',
        8,
        'https://images.openai.com/static-rsc-4/DVgLU8NgX920ykB-kFDjD5ls1eVdtsAi_qF4U5ww2bCXSMzhDwVz-6S3toBFfu_Cr11MxVBm7g7W0XWk0D4dFrWu5y90bIrJiW239vgd7QtfCco_NnwXVfDXa7cVJjcEdblXV0yPunUmMA0KsVviAuWI8VEdG8vZXuizBKxMjxuBsyVDblDtkk9bH3FPU0v5?purpose=fullsize',
        2000.00,
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d61688.08!2d74.5802!3d15.2443!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3bbfb1e428c0eaff%3A0xd61a58eb8dacc73b!2sDandeli!5e0!3m2!1sen!2sin!4v170000!5m2!1sen!2sin" width="100%" height="250" style="border:0;" allowfullscreen="" loading="lazy"></iframe>'
    ),
    (
        4,
        'Agumbe Rainforest (Shimoga)',
        'The "Cherrapunji of the South" is a high-altitude village famous for its dense rainforests, waterfalls, and as a habitat for the King Cobra.',
        10,
        'https://tse2.mm.bing.net/th/id/OIP.wplXdYd6HUPNEbrRdpjbGQHaEO?pid=Api&P=0&h=180',
        1800.00,
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d15531.0!2d75.09!3d13.5!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3bbaf50!2sAgumbe!5e0!3m2!1sen!2sin!4v170000!5m2!1sen!2sin" width="100%" height="250" style="border:0;" allowfullscreen="" loading="lazy"></iframe>'
    ),
    (
        7,
        'Chikmagalur',
        'The birthplace of coffee in India, offering stunning green slopes and trekking spots like Mullayanagiri.',
        8,
        'https://tse3.mm.bing.net/th/id/OIP.EX-PejMSedCOn1c8r9LDxgHaC8?pid=Api&P=0&h=180',
        2000.00,
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d62118.23659215593!2d75.74325671523232!3d13.32601237768763!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3bbad762c8a889dd%3A0xb3cf49155294be16!2sChikkamagaluru%2C%20Karnataka!5e0!3m2!1sen!2sin!4v1777570235674!5m2!1sen!2sin" width="600" height="450" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>'
    ),
    (
        8,
        'Sakleshpur',
        'A serene hill town in the Western Ghats, Sakleshpur is surrounded by plantations of coffee, cardamom, and pepper, often called the Switzerland of Karnataka.',
        7,
        'https://images.openai.com/static-rsc-4/i1h6edAkA1xx1CxIKwHbBHznXi2Tk_LPTcNDcoqMsVJZZfTuZH59TeXIYLUFSDioRLlD98j2qBQqLpvhDYHGUw-Dzk7byZW94BcI6xTsRdHabGpxkZMp1aZ6wkodIrGp3chG0Ha3KueHSGvAxgSqCI1Acdvv66hrkE13WpqJTNxLrHNbxiNz_l7hqdfe-drd?purpose=fullsize',
        1500.00,
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d31107.094551169845!2d75.77025874612355!3d12.947081741405967!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3ba526157a5ffa5d%3A0xfb6485aceb860292!2sSakleshpura%2C%20Karnataka!5e0!3m2!1sen!2sin!4v1777570607394!5m2!1sen!2sin" width="600" height="450" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>'
    ),
    (
        9,
        'Kemmanagundi',
        'A hill station that served as the summer retreat for the Mysore Maharaja, it offers mist-laden hills and well-manicured gardens.',
        8,
        'http://4.bp.blogspot.com/_nnVgxz4T4cI/TPtNRv1cfSI/AAAAAAAAGnA/jhsSGgEXIj4/s1600/SAT_6451.jpg',
        2500.00,
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d15515.060196413962!2d75.73970024544951!3d13.54999953913607!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3bbae1ad75b03e01%3A0xf02202b4b92cffbc!2sKemmangundi%2C%20Karnataka%20577129!5e0!3m2!1sen!2sin!4v1777571067749!5m2!1sen!2sin" width="600" height="450" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>'
    ),
    (
        10,
        'Ranganathittu Bird Sanctuary',
        'Located near Srirangapatna, this is a beautiful green sanctuary formed by a chain of small island on the Cauvery River.',
        8,
        'https://d6qyz3em3b312.cloudfront.net/upload/images/media/2023/04/19/shutterstock_1709528638.2048x1024.jpg',
        2000.00,
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3896.3803327528603!2d76.65377427483169!3d12.424360287842926!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3baf7777dd032e0b%3A0xdfd27aad93e2bc43!2sRanganathittu%20Bird%20Sanctuary!5e0!3m2!1sen!2sin!4v1777571249857!5m2!1sen!2sin" width="600" height="450" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>'
    ),
    (
        11,
        'Coorg',
        'Often called the "Scotland of India, "Coorg is a mountainous district adorned with sprawling coffee plantations, dense tropical forests, and misty valleys.',
        8,
        'https://www.tourmyindia.com/blog/wp-content/uploads/2015/11/best-things-to-do-in-coorg.jpg',
        3000.00,
        '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d15574.776694930833!2d75.66786284517163!3d12.602396152879013!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3ba4e2d26515b679%3A0x4ad0261ce59e827e!2sCoorg!5e0!3m2!1sen!2sin!4v1777571998011!5m2!1sen!2sin" width="600" height="450" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>'
    );;;

-- Insert Eco-friendly Hotels with better details
CREATE TABLE IF NOT EXISTS bookings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    destination_id INT NOT NULL,
    hotel_id INT NOT NULL,
    transport_id INT NOT NULL,
    contact_name VARCHAR(100) NOT NULL,
    contact_mobile VARCHAR(15) NOT NULL,
    email VARCHAR(100) NOT NULL,
    total_cost DECIMAL(10, 2) NOT NULL,
    status VARCHAR(50) DEFAULT 'Pending',
    booking_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT IGNORE INTO
    hotels (
        id,
        destination_id,
        name,
        description,
        image_url,
        eco_rating,
        price_per_night
    )
VALUES (
        1,
        1,
        'Kudremukh Eco Homestay (Solar Powered)',
        'Nestled in the heart of the Western Ghats, this homestay uses 100% solar energy and serves organic local food.',
        'https://images.unsplash.com/photo-1566073771259-6a8506099945?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
        5,
        800.00
    ),
    (
        2,
        2,
        'Pushpagiri Wildlife Eco-Tents',
        'Experience raw nature by staying in waterproof eco-tents near the sanctuary base. Minimal carbon footprint.',
        'https://images.unsplash.com/photo-1499793983690-e29da59ef1c2?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
        4,
        500.00
    ),
    (
        3,
        3,
        'Kali River Green Tree Lodge',
        'Luxury treehouses overlooking the Kali River. Famous for sustainable architecture and bird watching.',
        'https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
        5,
        1500.00
    ),
    (
        4,
        1,
        'Chikmagalur Coffee Estate Retreat',
        'A heritage property situated inside a lush coffee plantation. Offers guided nature walks.',
        'chikkamagalur-1.jpg',
        4,
        1200.00
    ),
    (
        5,
        2,
        'Coorg Spice Trails Homestay',
        'Stay amidst black pepper and cardamom plantations. A true sensory experience of Coorg greenery.',
        'https://images.unsplash.com/photo-1445019980597-93fa8acb246c?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
        5,
        1800.00
    ),
    (
        6,
        3,
        'Dandeli Jungle Bamboo Huts',
        'Eco-friendly bamboo cottages designed for wildlife enthusiasts. Safe and serene environment.',
        'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
        5,
        750.00
    ),
    (
        7,
        4,
        'Agumbe Rainforest Research Lodge',
        'A unique stay focused on education and conservation. Learn about rainforest biodiversity.',
        'https://images.unsplash.com/photo-1518732714860-b62714ce0c59?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
        5,
        1000.00
    ),
    (
        8,
        5,
        'Kodachadri Peak-view Resort',
        'A budget-friendly eco-resort offering the best sunrise and sunset views in the Malnad region.',
        'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
        4,
        900.00
    ),
    (
        9,
        6,
        'Dubare River-side Eco-Lodge',
        'Wooden cottages on the river bank, using recycled materials and traditional architecture.',
        'https://images.unsplash.com/photo-1590523277543-a94d2e4eb00b?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
        5,
        1300.00
    );
