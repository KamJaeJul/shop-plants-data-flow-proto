class ServiceItem {
  const ServiceItem({
    required this.imageAsset,
    required this.eyebrow,
    required this.title,
    required this.price,
  });

  final String imageAsset;
  final String eyebrow;
  final String title;
  final double price;
}

class DiscoveryItem {
  const DiscoveryItem({
    required this.imageAsset,
    required this.eyebrow,
    required this.title,
  });

  final String imageAsset;
  final String eyebrow;
  final String title;
}

class StoreLocation {
  const StoreLocation({
    required this.name,
    required this.address,
    required this.openingHours,
    required this.latitude,
    required this.longitude,
  });

  final String name;
  final String address;
  final String openingHours;
  final double latitude;
  final double longitude;
}

class Appointment {
  const Appointment({required this.startsAt, required this.address});
  final DateTime startsAt;
  final String address;
}

class AccountSummary {
  const AccountSummary({
    required this.credit,
    required this.points,
    required this.packages,
  });
  final double credit;
  final int points;
  final int packages;
}

class HomeContent {
  HomeContent({
    required List<ServiceItem> services,
    required List<DiscoveryItem> discoveries,
    required List<StoreLocation> locations,
    required this.appointment,
    required this.account,
  }) : services = List.unmodifiable(services),
       discoveries = List.unmodifiable(discoveries),
       locations = List.unmodifiable(locations);
  final List<ServiceItem> services;
  final List<DiscoveryItem> discoveries;
  final List<StoreLocation> locations;
  final Appointment appointment;
  final AccountSummary account;
}
