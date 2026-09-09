import '../../domain/entities/home_content.dart';

class HomeLocalDataSource {
  const HomeLocalDataSource();
  static const _newServices = [
    ServiceItem(
      imageAsset: 'assets/image/Image - Item.jpg',
      eyebrow: 'Lorem Ipsum',
      title: 'Lorem ipsum dolor sit amet consectetur',
      price: 10,
    ),
    ServiceItem(
      imageAsset: 'assets/image/Image - Item.jpg',
      eyebrow: 'Lorem Ipsum',
      title: 'Lorem ipsum dolor sit amet consectetur',
      price: 10,
    ),
    ServiceItem(
      imageAsset: 'assets/image/Image - Item.jpg',
      eyebrow: 'Lorem Ipsum',
      title: 'Lorem ipsum dolor sit amet consectetur',
      price: 10,
    ),
  ];

  static const _trendingDiscoveries = [
    DiscoveryItem(
      imageAsset: 'assets/image/Image - Item.jpg',
      eyebrow: 'Lorem Ipsum',
      title: 'Lorem ipsum dolor sit amet consectetur adipiscing elit',
    ),
    DiscoveryItem(
      imageAsset: 'assets/image/Image - Item.jpg',
      eyebrow: 'Lorem Ipsum',
      title:
          'Lorem ipsum dolor sit amet consectetur adipiscing elit. Lorem ipsum dolor sit amet',
    ),
    DiscoveryItem(
      imageAsset: 'assets/image/Image - Item.jpg',
      eyebrow: 'Lorem Ipsum',
      title:
          'Lorem ipsum dolor sit amet consectetur adipiscing elit. Lorem ipsum dolor sit amet',
    ),
    DiscoveryItem(
      imageAsset: 'assets/image/Image - Item.jpg',
      eyebrow: 'Lorem Ipsum',
      title: 'Lorem ipsum dolor sit amet consectetur adipiscing elit',
    ),
    DiscoveryItem(
      imageAsset: 'assets/image/Image - Item.jpg',
      eyebrow: 'Lorem Ipsum',
      title: 'Lorem ipsum dolor sit amet consectetur adipiscing elit',
    ),
    DiscoveryItem(
      imageAsset: 'assets/image/Image - Item.jpg',
      eyebrow: 'Lorem Ipsum',
      title:
          'Lorem ipsum dolor sit amet consectetur adipiscing elit. Lorem ipsum dolor sit amet',
    ),
    DiscoveryItem(
      imageAsset: 'assets/image/Image - Item.jpg',
      eyebrow: 'Lorem Ipsum',
      title:
          'Lorem ipsum dolor sit amet consectetur adipiscing elit. Lorem ipsum dolor sit amet',
    ),
    DiscoveryItem(
      imageAsset: 'assets/image/Image - Item.jpg',
      eyebrow: 'Lorem Ipsum',
      title: 'Lorem ipsum dolor sit amet consectetur adipiscing elit',
    ),
  ];

  static const _locations = [
    StoreLocation(
      name: 'Sunway Pyramid',
      address:
          '1 Floor, Lorem Ipsum Mall, Jalan ss23 Lorem, Selangor, Malaysia',
      openingHours: '10am - 10pm',
      latitude: 3.0733,
      longitude: 101.6077,
    ),
    StoreLocation(
      name: 'The Gardens Mall',
      address:
          '10 Floor, Lorem Ipsum Mall, Jalan ss23 Lorem, Selangor, Malaysia',
      openingHours: '10am - 10pm',
      latitude: 3.1180,
      longitude: 101.6760,
    ),
  ];

  HomeContent load() => HomeContent(
    services: _newServices,
    discoveries: _trendingDiscoveries,
    locations: _locations,
    appointment: Appointment(
      startsAt: DateTime(2020, 10, 14, 12, 30),
      address: '123 Plant Street, 1/1',
    ),
    account: const AccountSummary(credit: 100, points: 10, packages: 1),
  );
}
