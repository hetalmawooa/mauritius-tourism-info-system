class ChatBotService {
  static String getResponse(String userMessage, String languageCode) {
    final message = userMessage.toLowerCase().trim();

    // Language-specific responses
    final Map<String, Map<String, String>> responses = {
      'en': {
        'greeting':
            'Hello! I\'m your Mauritius travel assistant. How can I help you?',
        'beaches': 'Mauritius has stunning beaches! Popular ones include:\n\n'
            '🏖️ Île aux Cerfs - Perfect for water sports\n'
            '🏖️ Belle Mare - Long white sandy beach\n'
            '🏖️ Flic en Flac - Great for families\n'
            '🏖️ Le Morne - World-class kitesurfing',
        'food': 'Mauritian cuisine is a delicious blend of flavors! Try:\n\n'
            '🍛 Dholl puri - Flatbread with curry\n'
            '🍲 Rougaille - Tomato-based curry\n'
            '🍢 Mine frite - Fried noodles\n'
            '🥘 Biryani - Spiced rice dish\n'
            '🍰 Napolitaine - Local cake',
        'weather':
            'Mauritius has a tropical climate:\n\n'
            '☀️ Summer (Nov-Apr): 25-33°C, humid\n'
            '🌤️ Winter (May-Oct): 17-25°C, cooler\n\n'
            'Best time to visit: May to December',
        'transport':
            'Getting around Mauritius:\n\n'
            '🚗 Rental Car - Most flexible option\n'
            '🚕 Taxi - Readily available\n'
            '🚌 Bus - Economical but slower\n'
            '🏍️ Scooter - For adventurous travelers',
        'attractions':
            'Must-see attractions:\n\n'
            '🏔️ Le Morne Brabant - UNESCO site\n'
            '🌈 Chamarel Seven Coloured Earth\n'
            '🏝️ Île aux Cerfs\n'
            '🌊 Black River Gorges National Park\n'
            '🏛️ Aapravasi Ghat',
        'hotels': 'Accommodation options:\n\n'
            '⭐⭐⭐⭐⭐ Luxury resorts (MUR 10,000+)\n'
            '⭐⭐⭐⭐ Mid-range hotels (MUR 5,000-10,000)\n'
            '⭐⭐⭐ Budget hotels (MUR 2,000-5,000)\n'
            '🏠 Guesthouses & B&Bs (MUR 1,000-3,000)',
        'currency':
            'Currency information:\n\n'
            '💰 Mauritian Rupee (MUR)\n'
            '💵 USD 1 ≈ MUR 45\n'
            '💶 EUR 1 ≈ MUR 50\n\n'
            'Credit cards widely accepted.',
        'language':
            'Languages in Mauritius:\n\n'
            '🗣️ English - Official language\n'
            '🇫🇷 French - Widely spoken\n'
            '🇲🇺 Mauritian Creole - Local language\n'
            '🇮🇳 Hindi, Bhojpuri - Also common',
        'activities':
            'Popular activities:\n\n'
            '🤿 Snorkeling & Diving\n'
            '🪂 Kitesurfing & Windsurfing\n'
            '🎣 Deep-sea Fishing\n'
            '🚁 Helicopter Tours\n'
            '🥾 Hiking & Nature Walks\n'
            '🛶 Catamaran Cruises',
        'default':
            'I can help you with information about:\n\n'
            '🏖️ Beaches & Islands\n'
            '🍽️ Food & Restaurants\n'
            '🏨 Hotels & Accommodation\n'
            '🎯 Attractions & Activities\n'
            '🌤️ Weather & Best Time\n'
            '🚗 Transportation\n\n'
            'What would you like to know?',
      },
      'fr': {
        'greeting':
            'Bonjour! Je suis votre assistant de voyage à Maurice. Comment puis-je vous aider?',
        'beaches': 'Maurice a des plages magnifiques! Les plus populaires:\n\n'
            '🏖️ Île aux Cerfs - Parfait pour sports nautiques\n'
            '🏖️ Belle Mare - Longue plage de sable blanc\n'
            '🏖️ Flic en Flac - Idéal pour les familles\n'
            '🏖️ Le Morne - Kitesurf de classe mondiale',
        'food':
            'La cuisine mauricienne est un délicieux mélange de saveurs! Essayez:\n\n'
            '🍛 Dholl puri - Pain plat au curry\n'
            '🍲 Rougaille - Curry à base de tomate\n'
            '🍢 Mine frite - Nouilles frites\n'
            '🥘 Biryani - Riz épicé\n'
            '🍰 Napolitaine - Gâteau local',
        'default':
            'Je peux vous aider avec des informations sur:\n\n'
            '🏖️ Plages & Îles\n'
            '🍽️ Nourriture & Restaurants\n'
            '🏨 Hôtels & Hébergement\n'
            '🎯 Attractions & Activités\n\n'
            'Que voulez-vous savoir?',
      },
      'cr': {
        'greeting':
            'Bonzour! Mo enn asistan vwayaz pou Moris. Kouma mo kapav ed ou?',
        'beaches': 'Moris ena bann laplaz extra! Bann plispopiiler:\n\n'
            '🏖️ Île aux Cerfs - Bon pou spor lamer\n'
            '🏖️ Belle Mare - Long laplaz sab blan\n'
            '🏖️ Flic en Flac - Bon pou fami\n'
            '🏖️ Le Morne - Kitesurfing nivo mondyal',
        'food': 'Manze Morisyen bien bon! Essey:\n\n'
            '🍛 Dholl puri - Farirat ar kari\n'
            '🍲 Rougaille - Kari tomat\n'
            '🍢 Mine frite - Nouiy frir\n'
            '🥘 Biryani - Diri epis\n'
            '🍰 Napolitaine - Gato lokal',
        'default': 'Mo kapav ed ou ar:\n\n'
            '🏖️ Laplaz & Zil\n'
            '🍽️ Manze & Restoran\n'
            '🏨 Otel & Logman\n'
            '🎯 Atrakksion & Aktivite\n\n'
            'Ki ou anvi kone?',
      },
    };

    final langResponses = responses[languageCode] ?? responses['en']!;

    // Check for greetings
    if (message.contains('hello') ||
        message.contains('hi') ||
        message.contains('bonjour') ||
        message.contains('bonzour') ||
        message.contains('hey')) {
      return langResponses['greeting']!;
    }

    // Check for beach queries
    if (message.contains('beach') ||
        message.contains('plage') ||
        message.contains('laplaz') ||
        message.contains('sea') ||
        message.contains('ocean')) {
      return langResponses['beaches']!;
    }

    // Check for food queries
    if (message.contains('food') ||
        message.contains('eat') ||
        message.contains('restaurant') ||
        message.contains('cuisine') ||
        message.contains('manze') ||
        message.contains('nourriture')) {
      return langResponses['food']!;
    }

    // Check for weather queries
    if (message.contains('weather') ||
        message.contains('climate') ||
        message.contains('temperature') ||
        message.contains('météo') ||
        message.contains('letan')) {
      return langResponses['weather'] ?? langResponses['default']!;
    }

    // Check for transport queries
    if (message.contains('transport') ||
        message.contains('car') ||
        message.contains('taxi') ||
        message.contains('bus') ||
        message.contains('voiture')) {
      return langResponses['transport'] ?? langResponses['default']!;
    }

    // Check for attraction queries
    if (message.contains('attraction') ||
        message.contains('visit') ||
        message.contains('see') ||
        message.contains('tour') ||
        message.contains('place')) {
      return langResponses['attractions'] ?? langResponses['default']!;
    }

    // Check for hotel queries
    if (message.contains('hotel') ||
        message.contains('accommodation') ||
        message.contains('stay') ||
        message.contains('resort') ||
        message.contains('hébergement')) {
      return langResponses['hotels'] ?? langResponses['default']!;
    }

    // Check for currency queries
    if (message.contains('currency') ||
        message.contains('money') ||
        message.contains('rupee') ||
        message.contains('exchange')) {
      return langResponses['currency'] ?? langResponses['default']!;
    }

    // Check for language queries
    if (message.contains('language') ||
        message.contains('speak') ||
        message.contains('langue')) {
      return langResponses['language'] ?? langResponses['default']!;
    }

    // Check for activity queries
    if (message.contains('activity') ||
        message.contains('activities') ||
        message.contains('things to do') ||
        message.contains('activité')) {
      return langResponses['activities'] ?? langResponses['default']!;
    }

    // Default response
    return langResponses['default']!;
  }
}