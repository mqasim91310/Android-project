// lib/data/dummy_data.dart

import '../models/coffee_item.dart';

class DummyData {
  static List<CoffeeItem> allItems = [
    // HOT DRINKS
    CoffeeItem(
      id: '1',
      name: 'Classic Espresso',
      description: 'Rich, bold espresso shot with a smooth crema on top. The purist\'s choice for a morning kick.',
      price: 3.50,
      category: 'Hot',
      emoji: '☕',
      rating: 4.8,
      calories: 5,
      sizes: ['Single', 'Double', 'Triple'],
      milkOptions: ['None', 'Whole', 'Oat', 'Almond', 'Soy'],
    ),
    CoffeeItem(
      id: '2',
      name: 'Caramel Latte',
      description: 'Smooth espresso blended with steamed milk and a swirl of golden caramel syrup.',
      price: 5.00,
      category: 'Hot',
      emoji: '🍮',
      rating: 4.9,
      calories: 250,
      sizes: ['Small', 'Medium', 'Large'],
      milkOptions: ['Whole', 'Oat', 'Almond', 'Soy'],
    ),
    CoffeeItem(
      id: '3',
      name: 'Hazelnut Cappuccino',
      description: 'Velvety foam meets rich hazelnut-infused espresso in this classic Italian staple.',
      price: 4.75,
      category: 'Hot',
      emoji: '🫗',
      rating: 4.7,
      calories: 180,
      sizes: ['Small', 'Medium', 'Large'],
      milkOptions: ['Whole', 'Oat', 'Almond', 'Soy'],
    ),
    CoffeeItem(
      id: '4',
      name: 'Vanilla Flat White',
      description: 'Microfoam milk poured over a ristretto shot with a hint of Madagascar vanilla.',
      price: 4.50,
      category: 'Hot',
      emoji: '🤍',
      rating: 4.6,
      calories: 150,
      sizes: ['Small', 'Medium'],
      milkOptions: ['Whole', 'Oat', 'Almond', 'Soy'],
    ),
    // COLD DRINKS
    CoffeeItem(
      id: '5',
      name: 'Cold Brew',
      description: 'Steeped for 24 hours in cold water for a smooth, concentrated coffee with low acidity.',
      price: 5.50,
      category: 'Cold',
      emoji: '🧊',
      rating: 4.9,
      calories: 10,
      sizes: ['Medium', 'Large'],
      milkOptions: ['None', 'Whole', 'Oat', 'Almond'],
    ),
    CoffeeItem(
      id: '6',
      name: 'Iced Caramel Macchiato',
      description: 'Espresso poured over vanilla-flavored milk with a generous drizzle of caramel.',
      price: 5.75,
      category: 'Cold',
      emoji: '🧋',
      rating: 4.8,
      calories: 300,
      sizes: ['Medium', 'Large', 'XL'],
      milkOptions: ['Whole', 'Oat', 'Almond', 'Soy'],
    ),
    CoffeeItem(
      id: '7',
      name: 'Frappuccino Mocha',
      description: 'Blended ice, espresso, mocha sauce, and milk topped with whipped cream.',
      price: 6.25,
      category: 'Cold',
      emoji: '🥤',
      rating: 4.7,
      calories: 420,
      sizes: ['Medium', 'Large'],
      milkOptions: ['Whole', 'Oat', 'Almond'],
    ),
    CoffeeItem(
      id: '8',
      name: 'Iced Matcha Latte',
      description: 'Premium ceremonial grade matcha whisked into cold milk over ice.',
      price: 5.25,
      category: 'Cold',
      emoji: '🍵',
      rating: 4.6,
      calories: 200,
      sizes: ['Small', 'Medium', 'Large'],
      milkOptions: ['Whole', 'Oat', 'Almond', 'Soy'],
    ),
    // SNACKS
    CoffeeItem(
      id: '9',
      name: 'Butter Croissant',
      description: 'Flaky, golden croissant baked fresh every morning with premium French butter.',
      price: 3.25,
      category: 'Snacks',
      emoji: '🥐',
      rating: 4.5,
      calories: 320,
      sizes: ['Regular'],
      milkOptions: [],
    ),
    CoffeeItem(
      id: '10',
      name: 'Blueberry Muffin',
      description: 'Moist muffin bursting with fresh blueberries and a crumbly sugar top.',
      price: 3.50,
      category: 'Snacks',
      emoji: '🫐',
      rating: 4.6,
      calories: 380,
      sizes: ['Regular'],
      milkOptions: [],
    ),
    CoffeeItem(
      id: '11',
      name: 'Avocado Toast',
      description: 'Sourdough toast with smashed avocado, cherry tomatoes, and a sprinkle of everything bagel seasoning.',
      price: 7.50,
      category: 'Snacks',
      emoji: '🥑',
      rating: 4.7,
      calories: 290,
      sizes: ['Regular'],
      milkOptions: [],
    ),
    CoffeeItem(
      id: '12',
      name: 'Chocolate Brownie',
      description: 'Dense, fudgy chocolate brownie with a crisp top and gooey center.',
      price: 4.00,
      category: 'Snacks',
      emoji: '🍫',
      rating: 4.9,
      calories: 450,
      sizes: ['Regular'],
      milkOptions: [],
    ),
  ];

  static List<CoffeeItem> getByCategory(String category) {
    if (category == 'All') return allItems;
    return allItems.where((item) => item.category == category).toList();
  }

  static List<String> categories = ['All', 'Hot', 'Cold', 'Snacks'];

  static List<Map<String, String>> testimonials = [
    {
      'name': 'Sarah K.',
      'review': 'The Cold Brew is absolutely divine! Best coffee in the city.',
      'avatar': 'S',
    },
    {
      'name': 'Ahmed R.',
      'review': 'Love the customization options. My oat milk latte is perfect every time!',
      'avatar': 'A',
    },
    {
      'name': 'Maria L.',
      'review': 'The ambiance and the app together make this my go-to spot.',
      'avatar': 'M',
    },
  ];
}
