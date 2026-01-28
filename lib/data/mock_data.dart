import 'package:flutter/material.dart';
import '../models/attraction.dart';
import '../models/event.dart';
import '../models/hotel.dart';
import '../models/location.dart';
import '../models/review.dart';
import '../models/emergency_contact.dart';

class MockData {
  // Emergency Contacts
  static final List<EmergencyContact> emergencyContacts = [
    EmergencyContact(
      id: '1',
      name: 'Police',
      phone: '999',
      icon: Icons.local_police,
      color: const Color(0xFF3B82F6),
    ),
    EmergencyContact(
      id: '2',
      name: 'Fire',
      phone: '995',
      icon: Icons.local_fire_department,
      color: const Color(0xFFEF4444),
    ),
    EmergencyContact(
      id: '3',
      name: 'Ambulance',
      phone: '114',
      icon: Icons.local_hospital,
      color: const Color(0xFF10B981),
    ),
    EmergencyContact(
      id: '4',
      name: 'Tourist Police',
      phone: '213-6969',
      icon: Icons.support_agent,
      color: const Color(0xFF14B8A6),
    ),
    EmergencyContact(
      id: '5',
      name: 'Coastguard',
      phone: '212-3894',
      icon: Icons.waves,
      color: const Color(0xFF0EA5E9),
    ),
  ];

  // Attractions
  static final List<Attraction> attractions = [
    Attraction(
      id: '1',
      name: 'Le Morne Brabant',
      description:
          'A UNESCO World Heritage Site, this iconic mountain offers stunning views and rich cultural history.',
      category: AttractionCategory.nature,
      location: Location(
        lat: -20.4523,
        lng: 57.3158,
        address: 'Le Morne Peninsula, Southwest Mauritius',
        region: Region.south,
      ),
      image: 'https://images.unsplash.com/photo-1589203760676-bac6e27b1490',
      rating: 4.8,
      reviewCount: 532,
      reviews: [
        Review(
          id: 'r1',
          userName: 'Sarah Johnson',
          rating: 5.0,
          comment: 'Absolutely breathtaking! The hike was challenging but worth every step.',
          date: DateTime.now().subtract(const Duration(days: 5)),
          verified: true,
        ),
      ],
      openingHours: '6:00 AM - 6:00 PM',
      phone: '+230 450-1234',
      entryFee: 0,
      tags: ['UNESCO', 'Hiking', 'Nature', 'History'],
    ),
    Attraction(
      id: '2',
      name: 'Chamarel Seven Coloured Earth',
      description:
          'A unique geological formation featuring sand dunes in seven distinct colors.',
      category: AttractionCategory.nature,
      location: Location(
        lat: -20.4250,
        lng: 57.3750,
        address: 'Chamarel, Rivière Noire District',
        region: Region.west,
      ),
      image: 'https://images.unsplash.com/photo-1606640824872-21f2d0c9e7de',
      rating: 4.6,
      reviewCount: 428,
      reviews: [],
      openingHours: '8:30 AM - 5:00 PM',
      phone: '+230 483-4242',
      entryFee: 250,
      tags: ['Geological', 'Photography', 'Nature'],
    ),
    Attraction(
      id: '3',
      name: 'Île aux Cerfs',
      description:
          'A pristine island paradise offering white sandy beaches, crystal clear waters, and water sports.',
      category: AttractionCategory.beach,
      location: Location(
        lat: -20.2773,
        lng: 57.7951,
        address: 'Off the East Coast, Trou d\'Eau Douce',
        region: Region.east,
      ),
      image: 'https://images.unsplash.com/photo-1559827260-dc66d52bef19',
      rating: 4.9,
      reviewCount: 1245,
      reviews: [],
      openingHours: '9:00 AM - 5:00 PM',
      entryFee: 0,
      tags: ['Beach', 'Water Sports', 'Island', 'Paradise'],
    ),
    Attraction(
      id: '4',
      name: 'Grand Baie',
      description:
          'The most popular beach destination with vibrant nightlife, shopping, and water activities.',
      category: AttractionCategory.beach,
      location: Location(
        lat: -20.0104,
        lng: 57.5804,
        address: 'Grand Baie, North Mauritius',
        region: Region.north,
      ),
      image: 'https://images.unsplash.com/photo-1583209443688-6c9d98a9c4f3',
      rating: 4.5,
      reviewCount: 892,
      reviews: [],
      openingHours: '24/7',
      tags: ['Beach', 'Shopping', 'Nightlife'],
    ),
    Attraction(
      id: '5',
      name: 'Aapravasi Ghat',
      description:
          'UNESCO World Heritage Site and immigration depot with immense historical significance.',
      category: AttractionCategory.cultural,
      location: Location(
        lat: -20.1629,
        lng: 57.5018,
        address: '1 Quay Street, Port Louis',
        region: Region.portLouis,
      ),
      image: 'https://images.unsplash.com/photo-1591696331111-ef9586a5b17a',
      rating: 4.3,
      reviewCount: 156,
      reviews: [],
      openingHours: '9:00 AM - 4:00 PM (Mon-Fri)',
      phone: '+230 217-7770',
      entryFee: 100,
      tags: ['UNESCO', 'History', 'Culture', 'Museum'],
    ),
  ];

  // Restaurants (subset of attractions)
  static List<Attraction> get restaurants {
    return [
      Attraction(
        id: 'r1',
        name: 'The Beach House',
        description:
            'Oceanfront dining with fresh seafood and stunning sunset views.',
        category: AttractionCategory.restaurant,
        location: Location(
          lat: -20.0854,
          lng: 57.5904,
          address: 'Coastal Road, Grand Baie',
          region: Region.north,
        ),
        image: 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4',
        rating: 4.7,
        reviewCount: 324,
        reviews: [],
        openingHours: '11:00 AM - 10:00 PM',
        phone: '+230 263-8888',
        website: 'www.beachhousemauritius.com',
        tags: ['Seafood', 'Ocean View', 'Fine Dining'],
      ),
      Attraction(
        id: 'r2',
        name: 'La Table du Château',
        description:
            'Elegant French cuisine in a colonial mansion setting.',
        category: AttractionCategory.restaurant,
        location: Location(
          lat: -20.2104,
          lng: 57.4854,
          address: 'Domaine de Labourdonnais, Mapou',
          region: Region.north,
        ),
        image: 'https://images.unsplash.com/photo-1555939594-58d7cb561ad1',
        rating: 4.8,
        reviewCount: 287,
        reviews: [],
        openingHours: '12:00 PM - 3:00 PM, 7:00 PM - 10:00 PM',
        phone: '+230 266-9533',
        website: 'www.chateaulabourdonnais.com',
        tags: ['French', 'Fine Dining', 'Wine'],
      ),
      Attraction(
        id: 'r3',
        name: 'Domaine Anna',
        description:
            'Farm-to-table dining experience in a tropical garden setting.',
        category: AttractionCategory.restaurant,
        location: Location(
          lat: -20.4273,
          lng: 57.3816,
          address: 'Chamarel Road, Black River',
          region: Region.west,
        ),
        image: 'https://images.unsplash.com/photo-1559339352-11d035aa65de',
        rating: 4.6,
        reviewCount: 412,
        reviews: [],
        openingHours: '12:00 PM - 9:00 PM',
        phone: '+230 483-5047',
        tags: ['Organic', 'Farm-to-Table', 'Garden'],
      ),
    ];
  }

  // Events
  static final List<Event> events = [
    Event(
      id: 'e1',
      name: 'Mauritius International Music Festival',
      description:
          'Annual music festival featuring local and international artists across multiple genres.',
      category: EventCategory.music,
      date: DateTime(2024, 12, 15),
      endDate: DateTime(2024, 12, 17),
      location: Location(
        lat: -20.1629,
        lng: 57.5018,
        address: 'Caudan Waterfront, Port Louis',
        region: Region.portLouis,
      ),
      image: 'https://images.unsplash.com/photo-1459749411175-04bf5292ceea',
      isFree: false,
      price: 1500,
      organizer: 'Mauritius Tourism Authority',
    ),
    Event(
      id: 'e2',
      name: 'Rodrigues Seafood Festival',
      description:
          'Celebrate the best seafood dishes and local delicacies from the island of Rodrigues.',
      category: EventCategory.food,
      date: DateTime(2024, 11, 20),
      endDate: DateTime(2024, 11, 22),
      location: Location(
        lat: -20.4250,
        lng: 57.3750,
        address: 'Port Mathurin, Rodrigues',
        region: Region.east,
      ),
      image: 'https://images.unsplash.com/photo-1544025162-d76694265947',
      isFree: true,
    ),
    Event(
      id: 'e3',
      name: 'Mauritius Marathon',
      description:
          'Annual marathon event with routes through scenic coastal paths.',
      category: EventCategory.sports,
      date: DateTime(2024, 10, 8),
      location: Location(
        lat: -20.0854,
        lng: 57.5904,
        address: 'Starting Point: Grand Baie',
        region: Region.north,
      ),
      image: 'https://images.unsplash.com/photo-1452626038306-9aae5e071dd3',
      isFree: false,
      price: 500,
    ),
    Event(
      id: 'e4',
      name: 'Cavadee Festival',
      description:
          'Traditional Tamil festival celebrated with colorful processions and ceremonies.',
      category: EventCategory.cultural,
      date: DateTime(2024, 9, 25),
      location: Location(
        lat: -20.1629,
        lng: 57.5018,
        address: 'Various temples across Mauritius',
        region: Region.portLouis,
      ),
      image: 'https://images.unsplash.com/photo-1533174072545-7a4b6ad7a6c3',
      isFree: true,
    ),
  ];

  // Hotels
  static final List<Hotel> hotels = [
    Hotel(
      id: 'h1',
      name: 'Shangri-La Le Touessrok',
      description:
          'Luxurious beachfront resort with world-class amenities and stunning ocean views.',
      starRating: 5,
      location: Location(
        lat: -20.2773,
        lng: 57.7951,
        address: 'Trou d\'Eau Douce, East Coast',
        region: Region.east,
      ),
      image: 'https://images.unsplash.com/photo-1566073771259-6a8506099945',
      pricePerNight: 15000,
      rating: 4.9,
      reviewCount: 645,
      reviews: [],
      amenities: [
        'Spa',
        'Golf Course',
        'Private Beach',
        'Multiple Restaurants',
        'Water Sports'
      ],
      phone: '+230 402-7400',
      website: 'www.shangri-la.com',
    ),
    Hotel(
      id: 'h2',
      name: 'LUX* Belle Mare',
      description:
          'Contemporary resort on one of the island\'s most beautiful beaches.',
      starRating: 5,
      location: Location(
        lat: -20.2012,
        lng: 57.7690,
        address: 'Belle Mare, East Coast',
        region: Region.east,
      ),
      image: 'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b',
      pricePerNight: 12500,
      rating: 4.8,
      reviewCount: 523,
      reviews: [],
      amenities: [
        'All-Inclusive',
        'Kids Club',
        'Spa',
        'Beach Access',
        'Fitness Center'
      ],
      phone: '+230 402-2000',
      website: 'www.luxresorts.com',
    ),
    Hotel(
      id: 'h3',
      name: 'Tamassa Resort',
      description:
          'All-inclusive beachfront resort with modern amenities and water sports.',
      starRating: 4,
      location: Location(
        lat: -20.4789,
        lng: 57.3423,
        address: 'Bel Ombre, South Coast',
        region: Region.south,
      ),
      image: 'https://images.unsplash.com/photo-1571896349842-33c89424de2d',
      pricePerNight: 8500,
      rating: 4.6,
      reviewCount: 412,
      reviews: [],
      amenities: [
        'All-Inclusive',
        'Water Sports',
        'Multiple Pools',
        'Beach Bar',
        'Live Entertainment'
      ],
      phone: '+230 605-4000',
      website: 'www.tamassaresort.com',
    ),
    Hotel(
      id: 'h4',
      name: 'Veranda Grand Baie',
      description:
          'Boutique hotel in the heart of Grand Baie with excellent dining.',
      starRating: 3,
      location: Location(
        lat: -20.0104,
        lng: 57.5804,
        address: 'Grand Baie, North Coast',
        region: Region.north,
      ),
      image: 'https://images.unsplash.com/photo-1542314831-068cd1dbfeeb',
      pricePerNight: 4500,
      rating: 4.4,
      reviewCount: 289,
      reviews: [],
      amenities: [
        'Pool',
        'Restaurant',
        'Beach Shuttle',
        'Bar',
        'Free WiFi'
      ],
      phone: '+230 209-1600',
      website: 'www.veranda-resorts.com',
    ),
  ];
}