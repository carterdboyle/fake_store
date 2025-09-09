# This seeds file will create 20 products. Make sure the 20 JPEGs (image1.jpeg..image20.jpeg)
# are placed in your Rails app's `public/` directory before running `bin/rails db:seed`.
# If you already have products, you may want to run `bin/rails db:reset` (CAUTION: wipes data).

products = [
  {
    title: "Converse Shoes",
    description: "Comfortable, stylish canvas shoes. The original chic look.",
    amount: nil,
    price: 0.6998e2,
    image_url: "/images/item1.png",
  },
  {
    title: "Umbrella",
    description: "Stops rain...",
    amount: 0,
    price: 0.2e2,
    image_url: "/images/item2.png",
  },
  {
    title: "Dog food",
    description: "Keeps the pup going strong and healthy!",
    amount: 23,
    price: 0.1449e2,
    image_url: "/images/item3.png",
  },
  {
    title: "Cat food",
    description: "Keeps the kitty satiated. For now...",
    amount: 25,
    price: 0.1549e2,
    image_url: "/images/item4.png",
  },
  {
    title: "Onimusha (PS4)",
    description: "The newest Onimusha on the PlayStation 4!",
    amount: 1000,
    price: 0.8099e2,
    image_url: "/images/item5.png",
  },
  {
    title: "The best product in the world that you could imagine",
    description: "You buy this product and you'll be happy! Untold riches will befall whomever has access to such a treasure.",
    amount: 1,
    price: 0.1e7,
    image_url: nil
  },
  {
    title: "Wireless Earbuds",
    description: "Noise-cancelling and long battery life.",
    amount: 50,
    price: 0.599e2,
    image_url: "/images/item7.png",
  },
  {
    title: "Gaming Mouse",
    description: "High precision sensor with RGB lighting.",
    amount: 34,
    price: 0.429e2,
    image_url: "/images/item8.png",
  },
  {
    title: "Bluetooth Speaker",
    description: "Portable sound system with deep bass.",
    amount: 12,
    price: 0.999e2,
    image_url: "/images/item9.png",
  },
  {
    title: "Mechanical Keyboard",
    description: "Tactile switches and customizable backlighting.",
    amount: 20,
    price: 0.1199e2,
    image_url: "/images/item10.png",
  },
  {
    title: "Travel Backpack",
    description: "Durable, waterproof, and spacious.",
    amount: 15,
    price: 0.749e2,
    image_url: "/images/item11.png",
  },
  {
    title: "Yoga Mat",
    description: "Non-slip and eco-friendly material.",
    amount: 80,
    price: 0.349e2,
    image_url: "/images/item12.png",
  },
  {
    title: "Ceramic Mug",
    description: "Perfect for your morning coffee or tea.",
    amount: 60,
    price: 0.129e2,
    image_url: "/images/item13.png",
  },
  {
    title: "Phone Stand",
    description: "Adjustable angle and foldable for portability.",
    amount: 100,
    price: 0.99e1,
    image_url: "/images/item14.png",
  },
  {
    title: "Power Bank",
    description: "10000mAh for on-the-go charging.",
    amount: 47,
    price: 0.399e2,
    image_url: "/images/item15.png",
  },
  {
    title: "Sports Watch",
    description: "Tracks steps, heart rate, and workouts.",
    amount: 30,
    price: 0.1499e2,
    image_url: "/images/item16.png",
  },
  {
    title: "Sunglasses",
    description: "Polarized lenses with UV protection.",
    amount: 75,
    price: 0.599e1,
    image_url: "/images/item17.png",
  },
  {
    title: "Baseball Cap",
    description: "Classic fit with adjustable strap.",
    amount: 40,
    price: 0.199e1,
    image_url: "/images/item18.png",
  },
  {
    title: "Portable Tripod",
    description: "Lightweight aluminum tripod for cameras and phones.",
    amount: 28,
    price: 0.549e2,
    image_url: "/images/item19.png",
  },
  {
    title: "LED Desk Lamp",
    description: "Dimmable with touch controls.",
    amount: 33,
    price: 0.449e2,
    image_url: "/images/item20.png",
  }
]

products.each do |attrs|
  Product.create!(attrs)
end

puts "Seeded #{products.size} products"
