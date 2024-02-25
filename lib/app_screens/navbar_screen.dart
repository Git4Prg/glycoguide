import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:glycoguide/utils/constants.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => NavBarState();
}

class NavBarState extends State<NavBar> {
  TextEditingController bloodSugarController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Users')
          .doc(emailTextController.text)
          .snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading...");
        }

        String name = snapshot.data!.get('Username');
        String email = snapshot.data!.get('Email ID');
        String age = snapshot.data!.get('Age');
        String height = snapshot.data!.get('Height');
        String weight = snapshot.data!.get('Weight');
        String eatingPref = snapshot.data!.get('Eating Preference');
        String lactoseIntolerance = snapshot.data!.get('Lactose Intolerance');
        String glutenIntolerance = snapshot.data!.get('Gluten Intolerance');

        return Drawer(
          backgroundColor: Colors.grey.shade800,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                accountEmail: Text(
                  email,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                currentAccountPicture: CircleAvatar(
                  child: ClipOval(
                    child: Image.asset('assets/images/anon.jpeg'),
                  ),
                ),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/background4.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 16, bottom: 16),
                    child: Text(
                      'Predecided Prompts',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  ListTile(
                    title: const Text(
                      '1. Create a personalized meal plan considering my dietary preferences',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    onTap: () async {
                      String result = await fetchMeal(age, height, weight,
                          eatingPref, lactoseIntolerance, glutenIntolerance);
                      print(result);
                      setState(() {});
                    },
                  ),
                  ListTile(
                    title: const Text(
                      '2. Recommend snacks that won\'t spike my blood sugar levels',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    onTap: () async {
                      String result = await fetchMeal(age, height, weight,
                          eatingPref, lactoseIntolerance, glutenIntolerance);
                      print(result);
                      setState(() {});
                    },
                  ),
                  ListTile(
                    title: const Text(
                      '3. Please suggest a diabetic-friendly dinner for tonight',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    onTap: () async {
                      String result = await fetchMeal(age, height, weight,
                          eatingPref, lactoseIntolerance, glutenIntolerance);
                      print(result);
                      setState(() {});
                    },
                  ),
                  ListTile(
                    title: const Text(
                      '4. I\'m looking for healthy dessert options suitable for diabetes',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    onTap: () async {
                      String result = await fetchMeal(age, height, weight,
                          eatingPref, lactoseIntolerance, glutenIntolerance);
                      print(result);
                      setState(() {});
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Future<String> fetchMeal(age, height, weight, eatingPreference,
      lactoseIntolerance, glutenIntolerance) async {
    List<Map<String, String>> inputList = [
      {
        'text':
            "input: age - $age , height - $height, weight - $weight, dietary preference - $eatingPreference, lactose intolerance - $lactoseIntolerance, gluten intolerance - $glutenIntolerance"
      },
      {'text': "output: "}
    ];
    try {
      Dio dio = Dio();
      final response = await dio.post(
        "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.0-pro:generateContent?key=${dotenv.env["APIKEY"]}",
        data: {
          "contents": [
            {
              "parts": [
                partsMeal,
                inputList,
              ],
            },
          ],
          "generationConfig": {
            "temperature": 0.4,
            "topK": 1,
            "topP": 1,
            "maxOutputTokens": 2048,
            "stopSequences": []
          },
          "safetySettings": [
            {
              "category": "HARM_CATEGORY_HARASSMENT",
              "threshold": "BLOCK_MEDIUM_AND_ABOVE"
            },
            {
              "category": "HARM_CATEGORY_HATE_SPEECH",
              "threshold": "BLOCK_MEDIUM_AND_ABOVE"
            },
            {
              "category": "HARM_CATEGORY_SEXUALLY_EXPLICIT",
              "threshold": "BLOCK_MEDIUM_AND_ABOVE"
            },
            {
              "category": "HARM_CATEGORY_DANGEROUS_CONTENT",
              "threshold": "BLOCK_MEDIUM_AND_ABOVE"
            }
          ]
        },
      );

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return response
            .data['candidates'].first['content']['parts'].first['text'];
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      log(e.toString());
      return '';
    }
  }

  Future<String> fetchDessert(age, height, weight, eatingPreference,
      lactoseIntolerance, glutenIntolerance) async {
    List<Map<String, String>> inputList = [
      {
        'text':
            "input: age - $age , height - $height, weight - $weight, dietary preference - $eatingPreference, lactose intolerance - $lactoseIntolerance, gluten intolerance - $glutenIntolerance"
      },
      {'text': "output: "}
    ];
    try {
      Dio dio = Dio();
      final response = await dio.post(
        "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.0-pro:generateContent?key=${dotenv.env["APIKEY"]}",
        data: {
          "contents": [
            {
              "parts": [
                partsDessert,
                inputList,
              ],
            },
          ],
          "generationConfig": {
            "temperature": 0.4,
            "topK": 1,
            "topP": 1,
            "maxOutputTokens": 2048,
            "stopSequences": []
          },
          "safetySettings": [
            {
              "category": "HARM_CATEGORY_HARASSMENT",
              "threshold": "BLOCK_MEDIUM_AND_ABOVE"
            },
            {
              "category": "HARM_CATEGORY_HATE_SPEECH",
              "threshold": "BLOCK_MEDIUM_AND_ABOVE"
            },
            {
              "category": "HARM_CATEGORY_SEXUALLY_EXPLICIT",
              "threshold": "BLOCK_MEDIUM_AND_ABOVE"
            },
            {
              "category": "HARM_CATEGORY_DANGEROUS_CONTENT",
              "threshold": "BLOCK_MEDIUM_AND_ABOVE"
            }
          ]
        },
      );

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return response
            .data['candidates'].first['content']['parts'].first['text'];
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      log(e.toString());
      return '';
    }
  }

  Future<String> fetchSnacks(age, height, weight, eatingPreference,
      lactoseIntolerance, glutenIntolerance) async {
    List<Map<String, String>> inputList = [
      {
        'text':
            "input: age - $age , height - $height, weight - $weight, dietary preference - $eatingPreference, lactose intolerance - $lactoseIntolerance, gluten intolerance - $glutenIntolerance"
      },
      {'text': "output: "}
    ];
    try {
      Dio dio = Dio();
      final response = await dio.post(
        "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.0-pro:generateContent?key=${dotenv.env["APIKEY"]}",
        data: {
          "contents": [
            {
              "parts": [
                partsSnacks,
                inputList,
              ],
            },
          ],
          "generationConfig": {
            "temperature": 0.4,
            "topK": 1,
            "topP": 1,
            "maxOutputTokens": 2048,
            "stopSequences": []
          },
          "safetySettings": [
            {
              "category": "HARM_CATEGORY_HARASSMENT",
              "threshold": "BLOCK_MEDIUM_AND_ABOVE"
            },
            {
              "category": "HARM_CATEGORY_HATE_SPEECH",
              "threshold": "BLOCK_MEDIUM_AND_ABOVE"
            },
            {
              "category": "HARM_CATEGORY_SEXUALLY_EXPLICIT",
              "threshold": "BLOCK_MEDIUM_AND_ABOVE"
            },
            {
              "category": "HARM_CATEGORY_DANGEROUS_CONTENT",
              "threshold": "BLOCK_MEDIUM_AND_ABOVE"
            }
          ]
        },
      );

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return response
            .data['candidates'].first['content']['parts'].first['text'];
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      log(e.toString());
      return '';
    }
  }

  Future<String> fetchDinner(age, height, weight, eatingPreference,
      lactoseIntolerance, glutenIntolerance) async {
    List<Map<String, String>> inputList = [
      {
        'text':
            "input: age - $age , height - $height, weight - $weight, dietary preference - $eatingPreference, lactose intolerance - $lactoseIntolerance, gluten intolerance - $glutenIntolerance"
      },
      {'text': "output: "}
    ];
    // final parts = inputPrompt(partsText, input);
    try {
      Dio dio = Dio();
      final response = await dio.post(
        "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.0-pro:generateContent?key=${dotenv.env["APIKEY"]}",
        data: {
          "contents": [
            {
              "parts": [
                partsDinner,
                inputList,
              ],
            },
          ],
          "generationConfig": {
            "temperature": 0.4,
            "topK": 1,
            "topP": 1,
            "maxOutputTokens": 2048,
            "stopSequences": []
          },
          "safetySettings": [
            {
              "category": "HARM_CATEGORY_HARASSMENT",
              "threshold": "BLOCK_MEDIUM_AND_ABOVE"
            },
            {
              "category": "HARM_CATEGORY_HATE_SPEECH",
              "threshold": "BLOCK_MEDIUM_AND_ABOVE"
            },
            {
              "category": "HARM_CATEGORY_SEXUALLY_EXPLICIT",
              "threshold": "BLOCK_MEDIUM_AND_ABOVE"
            },
            {
              "category": "HARM_CATEGORY_DANGEROUS_CONTENT",
              "threshold": "BLOCK_MEDIUM_AND_ABOVE"
            }
          ]
        },
      );

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return response
            .data['candidates'].first['content']['parts'].first['text'];
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      log(e.toString());
      return '';
    }
  }

  List<Map<String, String>> partsMeal = [
    {
      'text':
          "input: I will give you the age, height, weight, dietary preference (vegetarian, non-vegetarian, vegan), any intolerance or allergies and number of times a person works out in a week....... you need to tell me a general meal plan for the person. keep the meals easy to understand, simple, and the phrases should be to the point. give different dishes all the time and increase the variety of dishes. make the dishes more indian. the person will always be diabetic. so make sure to make the diet plan healthy for diabetic patients especially. the diet should be for maintenance calories. add a note at the end for a calorie surplus and calorie deficit as well (like what changes  should be done in the maintenance calorie diet). keep the diet plan in bullets and make sure to be clear a concise."
    },
    {'text': "output: "},
    {
      'text':
          "input: age - 19, height - 171cm, weight - 70kg, dietary preference - vegetarian, intolerance - lactose, allergy - gluten, no. of workouts per week - 6 days"
    },
    {
      'text':
          "output: {\"Sample Meals\": {\"Breakfast\": \"Moong dal cheela with coconut chutney and mixed vegetable raita (modified with lactose-free yogurt)\", \"Lunch\": \"Rajma masala with brown rice and roasted cauliflower\", \"Dinner\": \"Tandoori roti with grilled vegetables and quinoa\", \"Snacks\": \"Makhana (fox nuts) roasted with cumin and pepper\",},\"Calorie Adjustments\": {\"Calorie Surplus\": For a healthy boost, slightly increase portion sizes, include nutritious snacks like nuts or roasted chickpeas, and add healthy fats from avocados or olive oil.\",\"Calorie Deficit\": \"For healthier habits, downsize your meals, choose low-calorie snacks like fruits and veggies, and ditch fried foods and added sugars. Remember, small changes add up.\"}}"
    },
    {
      'text':
          "input: age - 48, height - 160cm, weight - 80kg, dietary preference - vegan, intolerance - none, allergy - none, no. of workouts per week - 0-2 days"
    },
    {
      'text':
          "output: {\"Sample Meals\": {\"Breakfast\": \"Sprouted Mung Dal Cheela with chopped vegetables and chutney\", \"Lunch\": \"Vegetable Makhani with brown rice and a side salad\", \"Dinner\": \"Palak Tofu with whole-wheat roti and roasted cauliflower\", \"Snacks\": \"Roasted makhana (lotus seeds) with spices\"}, \"Calorie Adjustments\": {\"Calorie Surplus\": \"For a boost in energy and nutrition, consider slightly larger portions, healthy snacks like nuts and seeds, and incorporating small amounts of healthy fats like avocado or coconut oil into your diet.\", \"Calorie Deficit\": \"Shrink your plate, fill it with colorful non-starchy veggies, and go easy on oil and added sugars for a healthier (and lighter!) eating style.\"}}"
    },
    {
      'text':
          "input: age - 30, height - 190cm, weight - 70kg, dietary preference - non-vegetarian, intolerance - none, allergy - peanut, no. of workouts per week - 2-4 days"
    },
    {
      'text':
          "output: {\"Sample Meals\": {\"Breakfast\": \"Sprouted Mung Dal Cheela with chopped vegetables and coconut chutney\", \"Lunch\": \"Tandoori Chicken with roasted okra and brown rice\", \"Dinner\": \"Fish Curry (using low-fat yogurt) with spinach and quinoa\", \"Snacks\": \"Roasted Makhana (fox nuts) with mixed spices (exclude peanuts)\"}, \"Calorie Adjustments\": {\"Calorie Surplus\": \"For a healthy boost, slightly increase portion sizes, nibble on mixed nuts (skip peanuts) or seeds as snacks, and drizzle your meals with small amounts of avocado or olive oil.\", \"Calorie Deficit\": \"Downsize your meals, choose low-calorie veggies like cucumber or spinach, and ditch the fatty gravies and fried foods for a lighter, healthier plate!\"}}"
    },
    {
      'text':
          "input: age - 69, height - 165cm, weight - 60kg, dietary preference - non-vegetarian, intolerance - dairy, allergy - none, no. of workouts per week - 0-2 days"
    },
    {
      'text':
          "output: {\"Sample Meals\": {\"Breakfast\": \"Masala oats with mixed nuts and berries\",\"Lunch\": \"Tandoori chicken with roasted vegetables and brown rice\",\"Dinner\": \"Dal makhani with whole wheat roti and steamed greens\",\"Snacks\": \"Roasted makhana (fox nuts) with mixed spices\"}, \"Calorie Adjustments\": {\"Calorie Surplus\": \"For a balanced boost, slightly increase your portions, snack on healthy options like mixed nuts or avocado, and incorporate small amounts of olive oil or other healthy fats into your meals.\", \"Calorie Deficit\": \"Downsize your meals, snack on veggie superstars like cucumber and spinach, and ditch the calorie bombs like fried food and heavy gravies for a lighter, healthier you!\"}}"
    },
    {
      'text':
          "input: age - 20, height - 163cm, weight - 59kg, dietary preference - non-vegetarian, intolerance - almond, allergy - peanut, no. of workouts per week - 0-2 days"
    },
    {
      'text':
          "output: {\"Sample Meals\": {\"Breakfast\": \"Mixed vegetable paratha with low-fat yogurt\", \"Lunch\": \"Grilled fish with roasted vegetables and brown rice\", \"Dinner\": \"Chicken curry (prepared with low-fat yogurt) with quinoa and spinach\", \"Snacks\": \"Roasted makhana (fox nuts) with mixed spices (excluding peanuts)\"}, \"Calorie Adjustments\": { \"Calorie Surplus\": \"For a balanced boost, slightly increase your meal sizes, incorporate healthy snacks like mixed nuts (minus peanuts and almonds) or fruit, and sprinkle in small amounts of healthy fats like avocado or olive oil.\", \"Calorie Deficit\": \"Downsize your meals, prioritize low-calorie veggies like cucumber and spinach, and ditch the heavy gravies and fried foods for a lighter, healthier plate.\"}}"
    },
  ];

  List<Map<String, String>> partsSnacks = [
    {
      'text':
          "input: I'll give you some dietary preferences, allergies and some intolerances of a diabetic person. I want you to suggest some healthy snacks for them which are diabetes friendly as well and also take their dietary preferences, allergies and intolerances into consideration."
    },
    {'text': "output: "},
    {
      'text':
          "input: dietary preference - vegetarian, intolerance - lactose, allergy - gluten"
    },
    {
      'text':
          "output: {  \"Sliced cucumbers with a sprinkle of chia seeds\": \"Low in calories and carbohydrates, refreshing and hydrating.\",  \"Hard-boiled eggs\": \"Good source of protein and healthy fats.\",  \"Trail mix with nuts and seeds (excluding gluten-containing grains)\": \"Make your own using nuts, seeds, and dried fruits.\"}"
    },
    {
      'text':
          "input: dietary preference - vegan, intolerance - none, allergy - none"
    },
    {
      'text':
          "output: {  \"Roasted chickpeas with spices\": \"Crunchy, protein-packed snack with endless flavor possibilities.\",  \"Fruit and nut butter dip with veggie sticks\": \"Creamy and flavorful dip with colorful and crunchy vegetables.\",  \"Guacamole with whole-wheat crackers\": \"Healthy fats and fiber from avocado balanced by fiber-rich crackers.\"}"
    },
    {
      'text':
          "input: dietary preference - non-vegetarian, intolerance - none, allergy - peanut"
    },
    {
      'text':
          "output: {  \"Greek yogurt with berries and granola\": \"Protein-rich yogurt with antioxidants and fiber from berries and granola.\",  \"Turkey roll-ups with avocado and whole-wheat tortillas\": \"Lean protein from turkey paired with healthy fats from avocado wrapped in fiber-rich tortillas.\",  \"Hard-boiled eggs with sliced veggies and hummus\": \"Protein and healthy fats from eggs, with vitamins and fiber from veggies and a chickpea-based dip.\",}"
    },
    {
      'text':
          "input: dietary preference - non-vegetarian, intolerance - dairy, allergy - none"
    },
    {
      'text':
          "output: {  \"Grilled chicken skewers with pineapple salsa\": \"Lean protein from chicken paired with the refreshing sweetness of pineapple salsa (choose salsa without dairy ingredients).\",  \"Edamame pods with chili crisp\": \"Plant-based protein and fiber from edamame with a flavorful chili crisp for a spicy kick.\",  \"Turkey and vegetable lettuce wraps\": \"Lean protein from turkey and the variety of vitamins and fiber from vegetables, all wrapped in a crisp lettuce leaf (instead of dairy-containing wraps).\",}"
    },
    {
      'text':
          "input: dietary preference - non-vegetarian, intolerance - almond, allergy - peanut"
    },
    {
      'text':
          "output: {  \"Grilled chicken with roasted sweet potato and black bean salad\": \"Lean protein from chicken paired with fiber-rich sweet potato and protein-packed black beans in a refreshing salad.\",  \"Turkey and avocado wraps with gluten-free tortillas\": \"Lean protein from turkey and healthy fats from avocado, wrapped in gluten-free tortillas for a convenient and satisfying snack.\",  \"Hard-boiled eggs with sliced apple and sunflower seed butter\": \"Protein and healthy fats from eggs, with sweetness and fiber from apple, and an almond-free alternative with sunflower seed butter.\",}"
    },
  ];

  List<Map<String, String>> partsDessert = [
    {
      'text':
          "input: I'll give you some dietary preferences, allergies and some intolerances of a diabetic person. I want you to suggest 3-5 healthy desserts for them which are diabetes friendly as well and also take their dietary preferences, allergies and intolerances into consideration."
    },
    {'text': "output: "},
    {
      'text':
          "input: dietary preference - vegetarian, intolerance - lactose, allergy - gluten"
    },
    {
      'text':
          "output: {  \"Baked Pears with Spiced Coconut Cream\": \"Naturally sweet pears baked with warming spices and topped with a creamy lactose-free coconut milk sauce.\",  \"Chia Seed Pudding with Mango and Berries\": \"Fiber and protein-packed chia seeds soaked in plant-based milk, layered with fresh mango and berries for a refreshing and nutritious dessert.\",  \"Flourless Chocolate Avocado Mousse\": \"Rich and decadent mousse made with healthy avocado, dark chocolate, and natural sweeteners like agave nectar or stevia.\",  \"Gluten-Free Banana Oatmeal Cookies\": \"Naturally sweetened with bananas, these chewy cookies offer fiber and protein from gluten-free oats, satisfying your sweet tooth with a healthy twist.\",  \"Roasted Cinnamon Apples with Maple Walnut Streusel\": \"Warm and comforting dessert featuring apples, cinnamon, and a gluten-free streusel topping made with walnuts, maple syrup, and oats.\"}"
    },
    {
      'text':
          "input: dietary preference - vegan, intolerance - none, allergy - none"
    },
    {
      'text':
          "output: {  \"Chia Pudding Parfait with Tropical Flavors\": \"Layers of chia pudding with coconut milk, mango, and passion fruit for a refreshing dessert.\",  \"Roasted Figs with Spiced Walnut Topping\": \"Warm caramelized figs with a spiced and crunchy walnut topping for an autumnal dessert.\",  \"Avocado-Based Chocolate Mousse with Berries\": \"Rich and decadent mousse made withavocado and dark chocolate, topped with fresh berries.\",  \"Oatmeal Cookies with Cashew Butter Drizzle\": \"Chewy cookies made with mashed bananas, oats, and nut butter, drizzled with a cashew butter glaze.\",  \"Baked Apples with Almond Streusel and Yogurt\": \"Warm and spiced apples topped with a crunchy almond streusel, served with plant-based yogurt.\"}"
    },
    {
      'text':
          "input: dietary preference - non-vegetarian, intolerance - none, allergy - peanut"
    },
    {
      'text':
          "output: {  \"Spiced Rum Baked Pears\": \"Warm pears with comforting spices (cinnamon, ginger, cloves), optional rum drizzle for deeper flavor.\",  \"Poached Berries with Coconut Cream\": \"Fresh berries poached in light coconut milk syrup, topped with creamy coconut cream for richness.\",  \"Dark Chocolate Avocado Mousse with Almond Butter Drizzle\": \"Healthy avocado and dark chocolate mousse, drizzled with decadent almond butter sauce.\",  \"Individual Apple Crumbles with Pecan Topping\": \"Warm baked apples topped with a crunchy oat and pecan crumble, perfect for fall.\",  \"Grilled Pineapple with Cinnamon-Spiced Yogurt\": \"Sweet and caramelized grilled pineapple, served with refreshing cinnamon-infused yogurt.\"}"
    },
    {
      'text':
          "input: dietary preference - non-vegetarian, intolerance - dairy, allergy - none"
    },
    {
      'text':
          "output: {  \"Citrus Marinated Grilled Chicken Skewers with Pineapple Salsa\": \"Sweet and tangy chicken skewers marinaded in citrus juices, grilled to perfection, and served with a refreshing pineapple salsa. (Gluten-free option: use gluten-free marinade and serve with brown rice or quinoa)\",  \"Pan-Seared Pears with Cardamom and Honey\": \"Warm and spiced pears pan-seared with butter (can be substituted with olive oil) and drizzled with honey and cardamom for a comforting dessert.\",  \"Baked Figs with Port Wine and Toasted Walnuts\": \"Ripe figs baked with a touch of port wine and topped with crunchy toasted walnuts for a luxurious treat.\",  \"Tropical Fruit Salad with Honey-Lime Dressing\": \"Refreshing mix of seasonal tropical fruits drizzled with a light and zesty honey-lime dressing.\",  \"Spiced Roasted Pumpkin Seeds with Honey Glaze\": \"Healthy and satisfying snack made with roasted pumpkin seeds tossed in a sweet and warming honey glaze. (Optional: drizzle with melted dark chocolate for an extra treat)\"}"
    },
    {
      'text':
          "input: dietary preference - non-vegetarian, intolerance - almond, allergy - peanut"
    },
    {
      'text':
          "output: {  \"Spiced Poached Pears with Maple Vanilla Sauce\": \"Warm and comforting pears poached in a spiced syrup with cinnamon, cloves, and star anise, drizzled with a decadent maple vanilla sauce.\",  \"Baked Apples with Cranberry Orange Compote\": \"Sweet and tangy baked apples filled with a vibrant compote of fresh cranberries, oranges, and spices, perfect for fall.\",  \"Dark Chocolate Mousse with Hazelnut Butter Drizzle\": \"Rich and decadent mousse made with dark chocolate and avocado, drizzled with a luxurious hazelnut butter sauce for a unique flavor twist.\",  \"Grilled Pineapple with Rum and Lime Drizzle\": \"Sweet and caramelized pineapple slices grilled to perfection, drizzled with a refreshing rum and lime mixture for a tropical treat.\",  \"Warm Raspberry Crumble with Oat and Walnut Topping\": \"Fresh raspberries baked in a sweet and tart sauce, topped with a crunchy crumble made with oats, walnuts, and spices for a comforting dessert.\"}"
    },
  ];

  List<Map<String, String>> partsDinner = [
    {
      'text':
          "input: I'll give you some dietary preferences, allergies and some intolerances of a diabetic person. I want you to suggest 3-5 healthy dinners for them which are diabetes friendly as well and also take their dietary preferences, allergies and intolerances into consideration."
    },
    {'text': "output: "},
    {
      'text':
          "input: dietary preference - vegetarian, intolerance - lactose, allergy - gluten"
    },
    {
      'text':
          "output: {    \"Spicy Lentil Soup with Vegetables\": \"Hearty and flavorful soup with protein-rich lentils, a variety of vegetables, and warming spices. Serve with gluten-free bread for dipping.\",    \"Coconut Curry Tofu Stir-Fry with Brown Rice\": \"Fragrant stir-fry featuring pan-fried tofu in a creamy coconut curry sauce with colorful vegetables and fluffy brown rice.\",    \"Stuffed Sweet Potatoes with Black Beans and Quinoa\": \"Roasted sweet potatoes filled with a savory mixture of black beans, quinoa, spices, and topped with fresh salsa or your favorite herb and nut crumble.\",}"
    },
    {
      'text':
          "input: dietary preference - vegan, intolerance - none, allergy - none"
    },
    {
      'text':
          "output: {    \"Creamy Tomato Pasta with Roasted Chickpeas\": \"Flavorful pasta tossed in a creamy tomato sauce with protein-packed roasted chickpeas. Top with fresh basil for a satisfying and healthy meal.\",    \"Thai Green Curry with Vegetables and Tofu\": \"Fragrant curry simmered with coconut milk, green curry paste, tofu, and various vegetables. Serve with rice or noodles for a comforting and flavorful dish.\",    \"Lentil Shepherd's Pie with Mashed Sweet Potatoes\": \"Hearty lentil filling seasoned with herbs and spices, topped with creamy mashed sweet potatoes. A delicious and satisfying vegan twist on a classic comfort food.\",    \"Vegan Buddha Bowl with Rainbow Vegetables\": \"Colorful and nutrient-rich bowl filled with roasted vegetables, quinoa, hummus, avocado, and your favorite toppings. Customize it to your liking and enjoy a complete meal in a bowl.\",    \"Stir-Fried Tofu with Sesame Noodles\": \"Marinated tofu stir-fried with colorful vegetables and served over flavorful sesame noodles. A quick and easy option packed with protein and flavor.\"}"
    },
    {
      'text':
          "input: dietary preference - non-vegetarian, intolerance - none, allergy - peanut"
    },
    {
      'text':
          "output: {    \"Baked Salmon with Roasted Vegetables\": \"Flavorful salmon seasoned with herbs and spices, baked to perfection alongside colorful roasted vegetables for a balanced and satisfying meal.\",    \"Chicken Stir-Fry with Brown Rice\": \"Tender chicken stir-fried with your favorite vegetables and a flavorful sauce, served over fluffy brown rice for a quick and protein-packed option.\",    \"Turkey Meatloaf with Sweet Potato Mash\": \"Savory meatloaf made with ground turkey, seasoned with herbs and spices, accompanied by creamy sweet potato mash for a comforting and delicious dinner.\",    \"One-Pan Lemon Herb Chicken with Asparagus\": \"Easy and flavorful chicken dish with lemon, herbs, and asparagus, roasted in one pan for minimal cleanup and maximum convenience.\",    \"Shrimp Scampi with Gluten-Free Pasta\": \"Classic shrimp scampi dish featuring flavorful shrimp in a garlic and white wine sauce, served over your favorite gluten-free pasta for a light and satisfying meal.\"}"
    },
    {
      'text':
          "input: dietary preference - non-vegetarian, intolerance - dairy, allergy - none"
    },
    {
      'text':
          "output: {    \"Spicy Chicken Fajitas with Corn Tortillas\": \"Grilled chicken strips seasoned with Mexican spices, served with corn tortillas, grilled vegetables, and your favorite dairy-free toppings like salsa, guacamole, and pico de gallo.\",    \"Salmon with Lemon and Herbs on Roasted Vegetables\": \"Flavorful salmon seasoned with lemon juice, herbs, and spices, roasted with a variety of colorful vegetables for a nutritious and satisfying meal.\",    \"Moroccan-Spiced Chicken with Couscous\": \"Chicken thighs simmered in a fragrant Moroccan spice blend, served with fluffy couscous and roasted vegetables for a flavorful and exotic dinner.\",    \"Shrimp Stir-Fry with Coconut Milk and Rice Noodles\": \"Shrimp stir-fried with colorful vegetables in a light coconut milk sauce, served over rice noodles for a quick and flavorful option.\",    \"Turkey Burgers with Gluten-Free Buns and Avocado Crema\": \"Lean turkey burgers seasoned with your favorite herbs and spices, served on gluten-free buns with a creamy avocado crema made with dairy-free alternatives like plant-based yogurt or mayonnaise.\"}"
    },
    {
      'text':
          "input: dietary preference - non-vegetarian, intolerance - almond, allergy - peanut"
    },
    {
      'text':
          "output: {    \"Herb-Roasted Chicken with Roasted Sweet Potato and Black Bean Salad\": \"Seasoned chicken roasted with sweet potatoes, paired with a refreshing black bean salad made with olive oil instead of nut-based dressings.\",    \"Turkey Chili with Avocado and Cornbread\": \"Hearty chili loaded with protein-rich turkey, vegetables, and spices. Top with fresh avocado and enjoy gluten-free cornbread made with nut-free alternatives like sunflower seed butter.\",    \"Salmon with Lemon-Dill Sauce and Roasted Asparagus\": \"Flavorful salmon baked with a light and citrusy lemon-dill sauce, accompanied by roasted asparagus for a simple and elegant meal.\",    \"Chicken Stir-Fry with Brown Rice and Sesame Noodles\": \"Tender chicken stir-fried with vegetables in a flavorful sauce, served with brown rice and nut-free sesame noodles (using tahini instead of peanut butter).\",    \"One-Pan Lemon Herb Shrimp with Quinoa\": \"Easy and light dish featuring shrimp seasoned with lemon, herbs, and spices, roasted on a single pan with quinoa for a complete and flavorful meal.\"}"
    },
  ];
}
