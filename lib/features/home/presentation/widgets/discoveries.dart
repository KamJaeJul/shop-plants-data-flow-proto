part of '../home_page.dart';

class _TrendingDiscoveriesSection extends StatelessWidget {
  const _TrendingDiscoveriesSection({required this.discoveries});

  final List<DiscoveryItem> discoveries;

  @override
  Widget build(BuildContext context) {
    final leftColumn = <DiscoveryItem>[];
    final rightColumn = <DiscoveryItem>[];

    for (var index = 0; index < discoveries.length; index++) {
      (index.isEven ? leftColumn : rightColumn).add(discoveries[index]);
    }

    return ColoredBox(
      color: AppColors.trendingBackground,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(
            'assets/image/Trending Discoveries.jpg',
            fit: BoxFit.fitWidth,
            semanticLabel: 'Trending discoveries',
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 720),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _DiscoveryColumn(
                        discoveries: leftColumn,
                        startingIndex: 0,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _DiscoveryColumn(
                        discoveries: rightColumn,
                        startingIndex: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DiscoveryColumn extends StatelessWidget {
  const _DiscoveryColumn({
    required this.discoveries,
    required this.startingIndex,
  });

  final List<DiscoveryItem> discoveries;
  final int startingIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var index = 0; index < discoveries.length; index++) ...[
          if (index > 0) const SizedBox(height: 10),
          _DiscoveryCard(
            discovery: discoveries[index],
            discoveryNumber: startingIndex + (index * 2) + 1,
          ),
        ],
      ],
    );
  }
}

class _DiscoveryCard extends StatelessWidget {
  const _DiscoveryCard({
    required this.discovery,
    required this.discoveryNumber,
  });

  final DiscoveryItem discovery;
  final int discoveryNumber;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Trending discovery $discoveryNumber: ${discovery.title}',
      excludeSemantics: true,
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 0,
        color: AppColors.whiteBackground,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        child: InkWell(
          onTap: () {},
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ExcludeSemantics(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.asset(discovery.imageAsset, fit: BoxFit.cover),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      discovery.eyebrow,
                      style: const TextStyle(
                        color: AppColors.secondaryText,
                        fontFamily: AppTypography.fontFamily,
                        fontSize: 12,
                        fontWeight: AppTypography.regular,
                        height: 1.25,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      discovery.title,
                      style: const TextStyle(
                        color: AppColors.primaryText,
                        fontFamily: AppTypography.fontFamily,
                        fontSize: 14,
                        fontWeight: AppTypography.bold,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
