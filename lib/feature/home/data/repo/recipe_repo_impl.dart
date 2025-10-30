import 'package:voicecook/feature/home/data/recipe_model.dart';
import 'package:voicecook/feature/home/data/repo/recipe_repo.dart';

class RecipeRepoImpl extends RecipeRepo {
  final List<RecipeModel> recipes = [
    // 1 🍳 Masala Dosa (Breakfast)
    RecipeModel(
      id: '1',
      categoryId: 'Breakfast',
      name: 'Masala Dosa',
      description: 'Crispy rice dosa filled with spiced potato masala.',
      ingredients: [
        '1 cup idli rice',
        '1/4 cup urad dal',
        '1 cup boiled potatoes (mashed)',
        '1 medium onion (thinly sliced)',
        '1-2 green chillies (finely chopped)',
        '1/2 tsp mustard seeds',
        '1/2 tsp turmeric powder',
        '8-10 curry leaves',
        '2 tbsp oil',
        'Salt to taste',
      ],
      steps: [
        'Soak rice and urad dal separately for 4–6 hours.',
        'Grind rice and dal separately to a smooth batter, mix and ferment overnight.',
        'Heat 1 tbsp oil in a pan; add mustard seeds and curry leaves.',
        'Add sliced onion and green chillies; sauté until soft and translucent.',
        'Add turmeric and mashed potatoes; mix, add salt and cook 3–4 minutes to make masala.',
        'Heat a tawa, pour ladle of dosa batter and spread thin; drizzle oil and cook until edges lift.',
        'Place a spoonful of potato masala on dosa, fold and serve hot with chutney and sambar.',
      ],
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSR1-2VM8NUtbI-qgE9srSZWCYv7SXeUWlV6Q&s',
      time: '2h (incl. ferment)',
      difficulty: 'Medium',
      calories: '320',
    ),

    // 2 🍳 Idli with Coconut Chutney (Breakfast)
    RecipeModel(
      id: '2',
      categoryId: 'Breakfast',
      name: 'Idli with Coconut Chutney',
      description: 'Soft steamed idlis paired with fresh coconut chutney.',
      ingredients: [
        '2 cups idli rice',
        '1/2 cup urad dal',
        '1/2 tsp fenugreek seeds',
        '1 cup fresh grated coconut',
        '1 small green chilli',
        '1/4 inch ginger',
        '1/2 tsp mustard seeds',
        '1 tsp oil',
        'Salt to taste',
      ],
      steps: [
        'Soak idli rice and urad dal (with fenugreek) separately for 4–6 hours.',
        'Grind urad dal to a smooth fluffy batter and rice to a slightly coarse batter; mix, add salt and ferment overnight.',
        'Grease idli moulds and steam batter for 10–12 minutes until a toothpick comes out clean.',
        'For chutney: grind coconut, green chilli, ginger and salt to a smooth paste with little water.',
        'Heat oil in pan; add mustard seeds and curry leaves, pour over chutney for tempering.',
        'Serve hot idlis with coconut chutney and sambar.',
      ],
      imageUrl:
          'https://aartimadan.com/wp-content/uploads/2022/01/Poha-Idli-With-Chutney.jpg',
      time: '2h (incl. ferment)',
      difficulty: 'Easy',
      calories: '220',
    ),

    // 3 🍛 Vegetable Biryani (Lunch)
    RecipeModel(
      id: '3',
      categoryId: 'Lunch',
      name: 'Vegetable Biryani',
      description:
          'Layered basmati rice cooked with mixed vegetables and spices.',
      ingredients: [
        '2 cups basmati rice',
        '2 cups mixed vegetables (carrot, beans, peas, potato)',
        '1 large onion (sliced)',
        '2 tomatoes (chopped)',
        '1/2 cup yogurt',
        '1 tbsp ginger-garlic paste',
        '2 tbsp biryani masala',
        '4 cups water',
        '4 tbsp oil/ghee',
        'Salt to taste',
        'Fresh mint and coriander',
      ],
      steps: [
        'Wash and soak basmati rice 30 minutes; drain.',
        'Heat oil/ghee; fry sliced onions until golden and set aside half for garnish.',
        'Add ginger-garlic paste; sauté 1 minute; add tomatoes and cook until soft.',
        'Add mixed vegetables, biryani masala and yogurt; cook 5–7 minutes until veggies are slightly tender.',
        'In a separate pot boil water; add soaked rice and salt; cook until 70% done; drain.',
        'Layer half the rice over veggies, sprinkle mint/coriander and fried onions; add remaining rice and a drizzle of ghee.',
        'Cover tightly and cook on low (dum) for 15–20 minutes.',
        'Gently fluff the biryani and serve with raita.',
      ],
      imageUrl:
          'https://i.ytimg.com/vi/Do7ZdUodDdw/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLAEQctXy1aD1723HT7omylxjn4tMQ',
      time: '1h 15m',
      difficulty: 'Medium',
      calories: '500',
    ),

    // 4 🍛 Paneer Butter Masala (Lunch)
    RecipeModel(
      id: '4',
      categoryId: 'Lunch',
      name: 'Paneer Butter Masala',
      description: 'Creamy tomato-based curry with soft paneer cubes.',
      ingredients: [
        '250g paneer (cubed)',
        '3 large tomatoes (blanched & pureed)',
        '1 large onion (finely chopped)',
        '1 tbsp ginger-garlic paste',
        '2 tbsp butter',
        '1/4 cup fresh cream',
        '1 tsp garam masala',
        '1 tsp red chilli powder',
        '2 tbsp oil',
        'Salt to taste',
        'Kasuri methi (dried fenugreek) pinch',
      ],
      steps: [
        'Heat oil and 1 tbsp butter; sauté onions till golden.',
        'Add ginger-garlic paste; cook 1 minute.',
        'Pour tomato puree; add red chilli powder, salt and cook until oil separates.',
        'Blend cooked masala if needed for smoothness; return to pan.',
        'Add paneer cubes, garam masala, cream and remaining butter; simmer 5–7 minutes.',
        'Crush kasuri methi and sprinkle before serving; serve with naan or rice.',
      ],
      imageUrl:
          'https://i0.wp.com/aartimadan.com/wp-content/uploads/2023/11/Paneer-Butter-Masala-Restaurant-Style.jpg?fit=800%2C449&ssl=1',
      time: '45m',
      difficulty: 'Medium',
      calories: '480',
    ),

    // 5 🌙 Dal Tadka (Dinner)
    RecipeModel(
      id: '5',
      categoryId: 'Dinner',
      name: 'Dal Tadka',
      description: 'Yellow lentils tempered with ghee and spices.',
      ingredients: [
        '1 cup toor dal or yellow moong dal',
        '1 small onion (chopped)',
        '1 tomato (chopped)',
        '1/2 tsp turmeric',
        '1 tsp cumin seeds',
        '2 cloves garlic (sliced)',
        '1 tsp red chilli powder',
        '2 tbsp ghee or oil',
        'Salt to taste',
        'Fresh coriander',
      ],
      steps: [
        'Rinse dal and pressure cook with turmeric and 2 cups water until soft.',
        'Mash dal lightly and keep aside; adjust consistency with water.',
        'Heat ghee in a pan; add cumin seeds and garlic; sauté until fragrant.',
        'Add chopped onion; cook until translucent; add tomato and cook till soft.',
        'Add red chilli powder and salt; pour this tempering into cooked dal and simmer 3–4 minutes.',
        'Garnish with coriander and serve hot with rice.',
      ],
      imageUrl:
          'https://i0.wp.com/www.spiceandcolour.com/wp-content/uploads/2021/05/DSC_0257_editado.jpg?fit=1140%2C760&ssl=1',
      time: '35m',
      difficulty: 'Easy',
      calories: '260',
    ),

    // 6 🌙 Butter Chicken (Dinner)
    RecipeModel(
      id: '6',
      categoryId: 'Dinner',
      name: 'Butter Chicken',
      description: 'Tender chicken cooked in rich tomato and butter gravy.',
      ingredients: [
        '500g chicken pieces (boneless)',
        '1/2 cup yogurt',
        '1 tbsp ginger-garlic paste',
        '1 tsp red chilli powder',
        '2 tbsp butter',
        '2 tomatoes (pureed)',
        '1/4 cup cream',
        '1 tsp garam masala',
        'Salt to taste',
      ],
      steps: [
        'Marinate chicken with yogurt, ginger-garlic paste, chilli powder and salt for 30 min.',
        'Pan-sear or grill marinated chicken until half cooked; set aside.',
        'Heat butter; add tomato puree and cook until oil separates.',
        'Add cooked chicken to gravy, cover and simmer 10–12 minutes.',
        'Stir in cream and garam masala; cook 2–3 minutes more.',
        'Garnish with butter and serve with naan or rice.',
      ],
      imageUrl:
          'https://recipes.timesofindia.com/thumb/53205522.cms?width=1200&height=900',
      time: '1h',
      difficulty: 'Medium',
      calories: '520',
    ),

    // 7 🍪 Samosa (Snacks)
    RecipeModel(
      id: '7',
      categoryId: 'Snacks',
      name: 'Samosa',
      description:
          'Crispy triangular pastries stuffed with spicy potato filling.',
      ingredients: [
        '2 cups all-purpose flour',
        '4 medium potatoes (boiled & mashed)',
        '1 onion (finely chopped)',
        '1 tsp cumin seeds',
        '1 tsp garam masala',
        '1 tsp amchur (dry mango) powder',
        '2 tbsp oil',
        'Salt to taste',
        'Oil for deep frying',
      ],
      steps: [
        'Prepare dough: mix flour, salt and 2 tbsp oil; add water to make firm dough; rest 30 min.',
        'Heat 1 tbsp oil; add cumin seeds and chopped onion; sauté.',
        'Add mashed potatoes, garam masala, amchur and salt; mix and cook 3–4 min; cool.',
        'Divide dough, roll to oval, cut in half, shape cones and fill with potato masala; seal edges.',
        'Deep fry samosas in hot oil on medium heat until golden brown.',
        'Drain on paper and serve with chutney.',
      ],
      imageUrl:
          'https://c.ndtvimg.com/2023-03/0m65kep_samosa_625x300_10_March_23.jpg?im=FaceCrop,algorithm=dnn,width=1200,height=675',
      time: '1h 10m',
      difficulty: 'Medium',
      calories: '340',
    ),

    // 8 🍪 Pakora (Snacks)
    RecipeModel(
      id: '8',
      categoryId: 'Snacks',
      name: 'Onion Pakora',
      description: 'Crispy chickpea flour fritters with onion and spices.',
      ingredients: [
        '2 cups besan (gram flour)',
        '2 large onions (thinly sliced)',
        '1 tsp carom seeds',
        '1/2 tsp turmeric',
        '1 tsp red chilli powder',
        'Salt to taste',
        'Water as needed',
        'Oil for frying',
      ],
      steps: [
        'Mix besan, spices, salt and carom seeds in a bowl.',
        'Add sliced onions and enough water to form a thick batter that coats onions.',
        'Heat oil; drop spoonfuls of batter and fry pakoras until crisp and golden.',
        'Drain on paper, serve hot with chutney or ketchup.',
      ],
      imageUrl:
          'https://static01.nyt.com/images/2024/07/25/multimedia/ND-Pakorarex-clfq/ND-Pakorarex-clfq-googleFourByThree.jpg',
      time: '25m',
      difficulty: 'Easy',
      calories: '290',
    ),

    // 9 🍰 Gulab Jamun (Desserts)
    RecipeModel(
      id: '9',
      categoryId: 'Desserts',
      name: 'Gulab Jamun',
      description: 'Soft fried dumplings soaked in rose-flavored sugar syrup.',
      ingredients: [
        '1 cup milk powder',
        '1/4 cup all-purpose flour',
        '1/2 tsp baking soda',
        '2 tbsp ghee',
        'Milk to make dough',
        '2 cups sugar',
        '2 cups water',
        '1 tsp rose water or cardamom powder',
        'Oil/ghee for frying',
      ],
      steps: [
        'Make syrup: boil sugar and water until slightly sticky; add rose water/cardamom; keep warm.',
        'Mix milk powder, flour, baking soda and ghee; add milk little by little to form soft dough.',
        'Make small smooth balls without cracks.',
        'Heat oil on low-medium; fry balls until light golden (not dark).',
        'Immediately transfer fried balls to warm sugar syrup and let soak for 1–2 hours.',
        'Serve chilled or warm.',
      ],
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRXF3TN0NQaQO_vkZwGoIz9C-qRV7uCJnzNVQ&s',
      time: '1h 30m',
      difficulty: 'Medium',
      calories: '420',
    ),

    // 10 🍰 Rasmalai (Desserts)
    RecipeModel(
      id: '10',
      categoryId: 'Desserts',
      name: 'Rasmalai',
      description: 'Soft paneer discs soaked in sweet saffron milk.',
      ingredients: [
        '1 liter milk (for chenna and milk)',
        '2 tbsp lemon juice (to curdle milk)',
        '1/2 cup sugar',
        'Saffron pinch',
        '1/4 cup sugar (for syrup)',
        'Cardamom powder pinch',
        'Chopped pistachios for garnish',
      ],
      steps: [
        'Boil 1 liter milk and curdle with lemon juice to make chenna; strain and knead to soft dough.',
        'Make small flat discs from chenna and boil them in sugar syrup made with 1/4 cup sugar till they expand; cool.',
        'Boil remaining milk to reduce slightly; add sugar, saffron and cardamom; cool.',
        'Squeeze excess syrup from chenna discs and add to flavored milk; chill for 1–2 hours.',
        'Garnish with pistachios and serve cold.',
      ],
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTT9156aOcdnhPbwB9RK_CRrUS2wJjDxZmJvQ&s',
      time: '2h',
      difficulty: 'Medium',
      calories: '360',
    ),

    // 11 ☕ Masala Chai (Beverages)
    RecipeModel(
      id: '11',
      categoryId: 'Beverages',
      name: 'Masala Chai',
      description: 'Aromatic Indian spiced tea with milk.',
      ingredients: [
        '2 cups water',
        '2 tsp tea leaves',
        '1 cup milk',
        '1 inch ginger (crushed)',
        '2-3 green cardamom pods (crushed)',
        'Sugar to taste',
      ],
      steps: [
        'Boil water with crushed ginger and cardamom for 2 minutes.',
        'Add tea leaves and boil 1 minute.',
        'Pour in milk and sugar; bring to a simmer.',
        'Boil for another minute until color turns rich; strain and serve hot.',
      ],
      imageUrl: 'https://images.unsplash.com/photo-1551024601-bec78aea704b',
      time: '10m',
      difficulty: 'Easy',
      calories: '100',
    ),

    // 12 ☕ Cold Coffee (Beverages)
    RecipeModel(
      id: '12',
      categoryId: 'Beverages',
      name: 'Cold Coffee',
      description: 'Refreshing chilled coffee blended with milk and ice.',
      ingredients: [
        '1 cup chilled milk',
        '2 tbsp instant coffee powder',
        '2 tbsp sugar (adjust)',
        '3 scoops vanilla ice cream (optional)',
        'Ice cubes',
      ],
      steps: [
        'Add chilled milk, coffee, sugar, ice cubes and ice cream into blender.',
        'Blend until frothy and smooth.',
        'Pour into tall glass and top with whipped cream if desired; serve immediately.',
      ],
      imageUrl:
          'https://i.ytimg.com/vi/iRr7jADrwws/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLAupWv0SIF6DOvVdHh5NMn2V87Hvg',
      time: '5m',
      difficulty: 'Easy',
      calories: '180',
    ),

    // 13 🥣 Tomato Soup (Soups)
    RecipeModel(
      id: '13',
      categoryId: 'Soups',
      name: 'Tomato Soup',
      description: 'Creamy tomato soup with herbs and a smooth texture.',
      ingredients: [
        '6 ripe tomatoes (chopped)',
        '1 small onion (chopped)',
        '2 cloves garlic',
        '1 cup vegetable stock',
        '1/4 cup cream (optional)',
        'Salt, pepper, sugar pinch',
        '1 tbsp butter or oil',
      ],
      steps: [
        'Heat butter; sauté onion and garlic until soft.',
        'Add chopped tomatoes and cook until they break down.',
        'Add vegetable stock and simmer 10 minutes.',
        'Blend to a smooth puree and return to pan.',
        'Add cream, salt, pepper and a pinch of sugar; simmer 2–3 minutes and serve hot.',
      ],
      imageUrl:
          'https://www.allrecipes.com/thmb/EGp48npVJqDku38H1CFWwgwfAmM=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/57661-tomato-bisque-iii-VAT-007-4x3-44151fe6eccf42e2b7fecb632f3ff198.jpg',
      time: '30m',
      difficulty: 'Easy',
      calories: '150',
    ),

    // 14 🥣 Sweet Corn Soup (Soups)
    RecipeModel(
      id: '14',
      categoryId: 'Soups',
      name: 'Sweet Corn Soup',
      description:
          'Thick and lightly sweet corn soup, popular Indo-Chinese style.',
      ingredients: [
        '1 cup sweet corn kernels (canned or boiled)',
        '1 small carrot (finely chopped)',
        '1 tbsp cornflour',
        '2 cups vegetable stock',
        '1 tsp soy sauce',
        'Salt and pepper',
        '1 tbsp oil',
        'Spring onion for garnish',
      ],
      steps: [
        'Heat oil and sauté chopped carrot briefly.',
        'Add corn kernels and vegetable stock; simmer 5–7 minutes.',
        'Blend half the mix for thickness or leave whole for texture.',
        'Mix cornflour with water to a slurry; add to soup while stirring to thicken.',
        'Season with soy sauce, salt and pepper; garnish with spring onion and serve.',
      ],
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSO0F9LMgjuHyC6bmCOXe6wLw-7dhO0AB682g&s',
      time: '20m',
      difficulty: 'Easy',
      calories: '160',
    ),

    // 15 🥗 Greek Salad (Salads)
    RecipeModel(
      id: '15',
      categoryId: 'Salads',
      name: 'Greek Salad',
      description: 'Fresh salad with cucumber, tomato, onion and feta cheese.',
      ingredients: [
        '1 cucumber (chopped)',
        '2 tomatoes (chopped)',
        '1 small red onion (sliced)',
        '100g feta cheese (cubed)',
        'Olives',
        '2 tbsp olive oil',
        '1 tbsp lemon juice',
        'Salt and pepper',
      ],
      steps: [
        'Chop cucumber, tomatoes and slice onions into a bowl.',
        'Add cubes of feta and olives.',
        'Whisk olive oil, lemon juice, salt and pepper to make dressing.',
        'Toss salad with dressing and serve chilled.',
      ],
      imageUrl:
          'https://www.simplyrecipes.com/thmb/0NrKQlJ691l6L9tZXpL06uOuWis=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/Simply-Recipes-Easy-Greek-Salad-LEAD-2-4601eff771fd4de38f9722e8cafc897a.jpg',
      time: '10m',
      difficulty: 'Easy',
      calories: '200',
    ),

    // 16 🥗 Fruit Salad (Salads)
    RecipeModel(
      id: '16',
      categoryId: 'Salads',
      name: 'Fruit Salad',
      description: 'Simple seasonal fruit mix with honey and lemon.',
      ingredients: [
        '1 apple (chopped)',
        '1 banana (sliced)',
        '1 cup grapes',
        '1/2 cup berries (optional)',
        '1 tbsp honey',
        '1 tsp lemon juice',
      ],
      steps: [
        'Chop all fruits into bite-sized pieces.',
        'Mix honey and lemon juice in a small bowl.',
        'Toss fruits with honey-lemon dressing and chill before serving.',
      ],
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTDsa97h3F7GwiilRhV-zTxK-PnFNnzgv2xWw&s',
      time: '10m',
      difficulty: 'Easy',
      calories: '150',
    ),

    // 17 🌯 Pani Puri (Street Food)
    RecipeModel(
      id: '17',
      categoryId: 'Street Food',
      name: 'Pani Puri',
      description: 'Crispy puris filled with spiced potato and tamarind water.',
      ingredients: [
        '40 puris (store-bought)',
        '2 cups tamarind water (mix tamarind paste, jaggery, spices)',
        '2 cups boiled and mashed potato',
        '1 tsp chaat masala',
        'Finely chopped coriander',
      ],
      steps: [
        'Prepare tamarind water by mixing tamarind paste, jaggery, roasted cumin and salt; chill.',
        'Mix mashed potato with salt and chaat masala for filling.',
        'Crack a small hole in puri, fill with potato mixture and top with chilled pani; serve immediately.',
      ],
      imageUrl:
          'https://www.natashamohan.com/wp-content/uploads/2025/08/pani-puri-recipe--1024x512.png',
      time: '25m',
      difficulty: 'Easy',
      calories: '220',
    ),

    // 18 🌯 Vada Pav (Street Food)
    RecipeModel(
      id: '18',
      categoryId: 'Street Food',
      name: 'Vada Pav',
      description: 'Spicy potato fritter sandwiched in a pav with chutney.',
      ingredients: [
        '4 pav buns',
        '2 large potatoes (boiled & mashed)',
        '1 cup besan batter (spiced)',
        '1/2 tsp mustard seeds',
        '1/2 tsp turmeric',
        'Oil for frying',
        'Green chutney and dry garlic chutney',
      ],
      steps: [
        'Prepare potato filling: sauté mustard seeds, curry leaves, add mashed potatoes and spices; mix well.',
        'Coat potato balls with besan batter and deep fry until golden.',
        'Slit pav, spread chutneys, place vada inside and serve hot.',
      ],
      imageUrl: 'https://i.ytimg.com/vi/8HQFc64OwUk/maxresdefault.jpg',
      time: '30m',
      difficulty: 'Easy',
      calories: '350',
    ),

    // 19 ✨ Hyderabadi Biryani (Specials)
    RecipeModel(
      id: '19',
      categoryId: 'Specials',
      name: 'Hyderabadi Biryani (Mutton)',
      description:
          'Aromatic layered biryani with marinated mutton and saffron.',
      ingredients: [
        '500g mutton pieces',
        '2 cups basmati rice',
        '1 cup yogurt',
        '2 onions (fried)',
        '2 tbsp ginger-garlic paste',
        '2 tbsp biryani masala',
        'Saffron soaked in milk',
        'Fresh mint & coriander',
        'Ghee and oil',
      ],
      steps: [
        'Marinate mutton with yogurt, ginger-garlic, biryani masala and salt for 2–3 hours.',
        'Fry sliced onions until deep brown; set aside.',
        'Partially cook soaked rice in salted water and drain.',
        'Layer marinated mutton in pot, add half the fried onions, mint and coriander; add rice layer and saffron milk.',
        'Seal pot and cook on low heat (dum) for 40–50 minutes until mutton is tender and rice cooked.',
        'Gently mix and serve with raita.',
      ],
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQsfd98lM5L05Lsx-CACMf5pl_2QA73wFp_MQ&s',
      time: '2h 30m',
      difficulty: 'Hard',
      calories: '700',
    ),

    // 20 ✨ Butter Naan & Curry (Specials)
    RecipeModel(
      id: '20',
      categoryId: 'Specials',
      name: 'Butter Naan & Curry',
      description: 'Soft buttered naan served with a creamy curry.',
      ingredients: [
        '2 cups all-purpose flour',
        '1 tsp yeast',
        '1/2 cup warm milk',
        '2 tbsp yogurt',
        '2 tbsp butter',
        'For curry: tomato, onion, spices, cream',
      ],
      steps: [
        'Activate yeast in warm milk with a pinch of sugar for 10 minutes.',
        'Mix flour, yogurt, activated yeast and knead into soft dough; rest 1 hour.',
        'Divide dough, roll into ovals, cook on hot tawa and apply butter.',
        'Prepare curry of choice (e.g., chicken or paneer butter curry) and serve with hot butter naan.',
      ],
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQbCvsFpsVXSYmGXYt5kh38Dfk_oqqrSAtSRg&s',
      time: '1h 20m',
      difficulty: 'Medium',
      calories: '520',
    ),

    // 21 🥦 Oats Bowl (Healthy)
    RecipeModel(
      id: '21',
      categoryId: 'Healthy',
      name: 'Oats Fruit Bowl',
      description: 'Warm oats porridge topped with fruits and nuts.',
      ingredients: [
        '1/2 cup rolled oats',
        '1 cup milk or water',
        '1 tbsp honey',
        'Assorted fruits (banana, apple, berries)',
        'Nuts and seeds',
      ],
      steps: [
        'Boil milk/water and add oats; cook 3–5 minutes until soft.',
        'Stir in honey; pour into bowl.',
        'Top with chopped fruits, nuts and seeds; serve warm.',
      ],
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaVBAU0tgAuloXzviF1mKPbdoguf9ZcyuizA&s',
      time: '10m',
      difficulty: 'Easy',
      calories: '260',
    ),

    // 22 🥦 Quinoa Salad (Healthy)
    RecipeModel(
      id: '22',
      categoryId: 'Healthy',
      name: 'Quinoa Salad',
      description:
          'Protein-rich quinoa tossed with fresh vegetables and lemon.',
      ingredients: [
        '1 cup quinoa',
        '1 cup cucumber (diced)',
        '1 cup cherry tomatoes (halved)',
        '1/2 cup corn',
        '2 tbsp olive oil',
        '1 tbsp lemon juice',
        'Salt and pepper',
      ],
      steps: [
        'Rinse quinoa and cook in 2 cups water until fluffy; cool.',
        'Mix quinoa with chopped veggies and corn.',
        'Toss with olive oil, lemon juice, salt and pepper; serve chilled.',
      ],
      imageUrl:
          'https://www.allrecipes.com/thmb/AfZ5pJYvZSrlltkHiimLIOdEtjE=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/229156-Zesty-Quinoa-Salad-ddmps-4x3-104421-df647e343ce543769a038cccf4c6419c.jpg',
      time: '20m',
      difficulty: 'Easy',
      calories: '240',
    ),

    // 23 👶 Mini Pizza (Kids)
    RecipeModel(
      id: '23',
      categoryId: 'Kids',
      name: 'Mini Pizza',
      description:
          'Quick mini pizzas made on bread or small bases, topped with cheese.',
      ingredients: [
        '4 slices bread or small pizza bases',
        '1/2 cup pizza sauce',
        '1 cup grated mozzarella',
        'Sliced bell peppers and olives',
        'Italian seasoning',
      ],
      steps: [
        'Preheat oven to 200°C (400°F).',
        'Spread sauce on bread/bases, add toppings and cheese.',
        'Bake 8–10 minutes until cheese melts and edges crisp; serve warm.',
      ],
      imageUrl:
          'https://i.ytimg.com/vi/1X9mjrPFSwo/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLCvKO0aNWXJ4SMcy862xk2CO-z36g',
      time: '20m',
      difficulty: 'Easy',
      calories: '320',
    ),

    // 24 👶 Chocolate Milkshake (Kids)
    RecipeModel(
      id: '24',
      categoryId: 'Kids',
      name: 'Chocolate Milkshake',
      description:
          'Creamy chilled milkshake with chocolate syrup and ice cream.',
      ingredients: [
        '1 cup chilled milk',
        '2 scoops chocolate ice cream',
        '2 tbsp chocolate syrup',
        'Sugar to taste (optional)',
        'Ice cubes',
      ],
      steps: [
        'Add all ingredients to blender and blend until smooth and frothy.',
        'Pour into glass and top with whipped cream or chocolate sprinkles.',
      ],
      imageUrl:
          'https://www.thespruceeats.com/thmb/qB63P8d50_HR5JMhdbwGvcFgKjE=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/chocolate-milkshake-4587581-hero-1-22c8a039103c413dafd75f4f4c39ddd4.JPG',
      time: '5m',
      difficulty: 'Easy',
      calories: '360',
    ),

    // 25 ⚡ Maggi Noodles (Quick & Easy)
    RecipeModel(
      id: '25',
      categoryId: 'Quick & Easy',
      name: 'Maggi Noodles (Masala)',
      description: 'Instant noodles with added vegetables for a quick meal.',
      ingredients: [
        '1 packet Maggi noodles',
        '1 cup mixed vegetables (carrot, peas, capsicum)',
        '2 cups water',
        'Maggi masala (from packet)',
        '1 tbsp oil',
      ],
      steps: [
        'Heat oil; sauté chopped vegetables until slightly tender.',
        'Add water and bring to boil.',
        'Add noodles and tastemaker masala; cook 2–3 minutes until done.',
        'Stir and serve hot.',
      ],
      imageUrl:
          'https://www.nestleprofessional.in/sites/default/files/2022-08/MAGGI-Noodles-Szechuan-Paneer-756x471.jpg',
      time: '5m',
      difficulty: 'Easy',
      calories: '300',
    ),

    // 26 ⚡ Sandwich (Quick & Easy)
    RecipeModel(
      id: '26',
      categoryId: 'Quick & Easy',
      name: 'Grilled Vegetable Sandwich',
      description: 'Toasted sandwich with veggies and melted cheese.',
      ingredients: [
        '2 slices bread',
        'Butter',
        'Sliced tomato, cucumber, capsicum',
        '2 slices cheese',
        'Salt and pepper',
      ],
      steps: [
        'Butter bread slices; layer sliced veggies and cheese.',
        'Grill or toast sandwich until golden and cheese melts.',
        'Cut and serve hot.',
      ],
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRvr__e83WQ7WExyVWdyQM-L_4TCq4Wi6uqqg&s',
      time: '10m',
      difficulty: 'Easy',
      calories: '300',
    ),

    // 27 🌿 Vegan Curry (Vegan)
    RecipeModel(
      id: '27',
      categoryId: 'Vegan',
      name: 'Coconut Vegetable Curry',
      description: 'Creamy coconut-based curry with seasonal vegetables.',
      ingredients: [
        '2 cups mixed vegetables',
        '1 cup coconut milk',
        '1 onion (chopped)',
        '1 tbsp ginger-garlic paste',
        '1 tsp curry powder',
        '2 tbsp oil',
        'Salt to taste',
      ],
      steps: [
        'Heat oil; sauté onion until soft; add ginger-garlic paste.',
        'Add curry powder and chopped vegetables; sauté for 3–4 minutes.',
        'Pour coconut milk and simmer until vegetables are tender.',
        'Adjust seasoning and serve with rice.',
      ],
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSjoO0p8FnQVJIzlVQLsIqbBD78hUBRXKhJQ&s',
      time: '30m',
      difficulty: 'Easy',
      calories: '280',
    ),

    // 28 🌿 Tofu Stir Fry (Vegan)
    RecipeModel(
      id: '28',
      categoryId: 'Vegan',
      name: 'Tofu Stir Fry',
      description: 'Crispy tofu with colorful vegetables in a light soy glaze.',
      ingredients: [
        '200g firm tofu (cubed)',
        '1 cup bell peppers (sliced)',
        '1 cup broccoli florets',
        '2 tbsp soy sauce',
        '1 tbsp sesame oil',
        '1 tbsp cornstarch',
        '1 tsp ginger (minced)',
      ],
      steps: [
        'Toss tofu in cornstarch and shallow fry until crisp; set aside.',
        'Sauté ginger, add vegetables and stir-fry until tender-crisp.',
        'Add tofu, soy sauce and sesame oil; toss to coat and serve hot.',
      ],
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQk_2qKtsGEuSvApnaPPeKpzxrEScSoP4JOJQ&s',
      time: '20m',
      difficulty: 'Easy',
      calories: '300',
    ),

    // 29 🍗 Chicken Curry (Non-Veg)
    RecipeModel(
      id: '29',
      categoryId: 'Non-Veg',
      name: 'Chicken Curry',
      description: 'Classic spicy chicken curry with onion-tomato masala.',
      ingredients: [
        '500g chicken pieces',
        '2 onions (finely chopped)',
        '2 tomatoes (pureed)',
        '1 tbsp ginger-garlic paste',
        '1 tsp turmeric',
        '1 tsp red chilli powder',
        '2 tbsp curry powder or garam masala',
        '3 tbsp oil',
        'Salt to taste',
      ],
      steps: [
        'Heat oil; sauté onions until golden brown.',
        'Add ginger-garlic paste and cook 1 minute.',
        'Add turmeric, chilli powder and tomato puree; cook until oil separates.',
        'Add chicken pieces and salt; stir to coat with masala.',
        'Add half a cup water; cover and simmer until chicken is cooked through.',
        'Sprinkle garam masala, simmer 2 minutes and garnish with coriander.',
      ],
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQpY6Vjt8xmksn3J9yADjrkTQNnoSN41YBOQQ&s',
      time: '50m',
      difficulty: 'Medium',
      calories: '560',
    ),

    // 30 🍗 Fish Fry (Non-Veg)
    RecipeModel(
      id: '30',
      categoryId: 'Non-Veg',
      name: 'Crispy Fish Fry',
      description:
          'Spiced and shallow-fried fish fillets crisp on the outside.',
      ingredients: [
        '4 fish fillets (tilapia, pomfret or similar)',
        '1 tsp turmeric',
        '1 tsp red chilli powder',
        '1 tsp garam masala',
        '1 tbsp lemon juice',
        'Salt to taste',
        'Oil for shallow frying',
      ],
      steps: [
        'Marinate fish with turmeric, chilli powder, garam masala, lemon juice and salt for 15–20 minutes.',
        'Heat oil in a pan on medium heat.',
        'Shallow-fry marinated fillets 3–4 minutes on each side until golden and cooked through.',
        'Drain and serve hot with lemon wedges.',
      ],
      imageUrl:
          'https://c.ndtvimg.com/2020-01/op8grfc_fish_625x300_11_January_20.jpg',
      time: '30m',
      difficulty: 'Easy',
      calories: '410',
    ),
  ];

  @override
  Future<List<RecipeModel>> getRecipe() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return recipes;
  }
}
