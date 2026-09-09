part of '../home_page.dart';

class _LocationsSection extends StatelessWidget {
  const _LocationsSection({required this.locations});

  static const _mapCenter = (latitude: 3.0957, longitude: 101.6418);

  final List<StoreLocation> locations;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.whiteBackground,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 32, 20, 40),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'LOCATION',
                  style: TextStyle(
                    color: AppColors.textHighlight,
                    fontFamily: AppTypography.fontFamily,
                    fontSize: 14,
                    fontWeight: AppTypography.bold,
                    height: 1.25,
                  ),
                ),
                const SizedBox(height: 8),
                LocationsMap(locations: locations, center: _mapCenter),
                const SizedBox(height: 24),
                for (var index = 0; index < locations.length; index++) ...[
                  if (index > 0) const SizedBox(height: 24),
                  _LocationDetails(location: locations[index]),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LocationDetails extends ConsumerWidget {
  const _LocationDetails({required this.location});

  final StoreLocation location;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          location.name,
          style: const TextStyle(
            color: AppColors.textHighlight,
            fontFamily: AppTypography.fontFamily,
            fontSize: 14,
            fontWeight: AppTypography.bold,
            height: 1.25,
          ),
        ),
        const SizedBox(height: 4),
        _LocationInfoRow(
          icon: Icons.location_on,
          child: Semantics(
            link: true,
            label: 'Open ${location.name} in Google Maps',
            excludeSemantics: true,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => _confirmOpenInGoogleMaps(context, ref),
                borderRadius: BorderRadius.circular(4),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(minHeight: 48),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      location.address,
                      style: const TextStyle(
                        color: AppColors.locationLink,
                        fontFamily: AppTypography.fontFamily,
                        fontSize: 14,
                        fontWeight: AppTypography.regular,
                        height: 1.5,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.locationLink,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        _LocationInfoRow(
          icon: Icons.access_time_filled,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Text(
              location.openingHours,
              style: const TextStyle(
                color: AppColors.secondaryText,
                fontFamily: AppTypography.fontFamily,
                fontSize: 14,
                fontWeight: AppTypography.regular,
                height: 1.4,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _confirmOpenInGoogleMaps(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final shouldContinue = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Continue to Google Maps?'),
        content: Text(
          'Google Maps will open in another app to show ${location.name}.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            style: TextButton.styleFrom(minimumSize: const Size(64, 48)),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            style: FilledButton.styleFrom(minimumSize: const Size(96, 48)),
            child: const Text('Continue'),
          ),
        ],
      ),
    );

    if (shouldContinue != true || !context.mounted) return;
    await _openInGoogleMaps(context, ref);
  }

  Future<void> _openInGoogleMaps(BuildContext context, WidgetRef ref) async {
    final didLaunch = await ref
        .read(homeViewModelProvider.notifier)
        .openLocation(location);
    if (didLaunch || !context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Could not open Google Maps.')),
    );
  }
}

class _LocationInfoRow extends StatelessWidget {
  const _LocationInfoRow({required this.icon, required this.child});

  final IconData icon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Icon(icon, size: 18, color: AppColors.primary),
        ),
        const SizedBox(width: 12),
        Expanded(child: child),
      ],
    );
  }
}
