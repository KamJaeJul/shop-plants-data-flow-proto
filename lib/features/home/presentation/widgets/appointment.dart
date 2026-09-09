part of '../home_page.dart';

class _AppointmentHeader extends StatelessWidget {
  const _AppointmentHeader({required this.state});

  final HomeState state;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.primary,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 26),
          child: Column(
            children: [
              const Text(
                'LOGO',
                style: TextStyle(
                  color: AppColors.whiteBackground,
                  fontFamily: AppTypography.fontFamily,
                  fontSize: 42,
                  fontWeight: AppTypography.bold,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 8),
              const Row(
                children: [
                  Expanded(child: _HeaderDivider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18),
                    child: Text(
                      'NEXT APPOINTMENT',
                      style: TextStyle(
                        color: AppColors.whiteBackground,
                        fontFamily: AppTypography.fontFamily,
                        fontSize: 8,
                        fontWeight: AppTypography.medium,
                        letterSpacing: 2.4,
                      ),
                    ),
                  ),
                  Expanded(child: _HeaderDivider()),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    flex: 11,
                    child: _AppointmentDetail(
                      asset: 'assets/icon/Icon - Calender.png',
                      label: state.appointmentDate,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 10,
                    child: _AppointmentDetail(
                      asset: 'assets/icon/Icon -Clock.png',
                      label: state.appointmentTime,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 15,
                    child: _AppointmentDetail(
                      asset: 'assets/icon/Icon -Location.png',
                      label: '${state.content.appointment.address} ...',
                    ),
                  ),
                  Semantics(
                    button: true,
                    label: 'View appointment details',
                    excludeSemantics: true,
                    child: InkResponse(
                      onTap: () => _showAppointmentModal(context),
                      radius: 24,
                      child: SizedBox.square(
                        dimension: 48,
                        child: Center(
                          child: Image.asset(
                            'assets/icon/Icon -Arrow.png',
                            width: 32,
                            height: 32,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              _AccountSummary(state: state),
            ],
          ),
        ),
      ),
    );
  }

  void _showAppointmentModal(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withValues(alpha: 0.54),
      builder: (context) => _AppointmentModal(state: state),
    );
  }
}

class _AppointmentModal extends StatelessWidget {
  const _AppointmentModal({required this.state});

  final HomeState state;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return Material(
      color: AppColors.whiteBackground,
      clipBehavior: Clip.antiAlias,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(24, 12, 24, 24 + bottomInset),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.navigationDivider,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Appointment details',
                    style: TextStyle(
                      color: AppColors.primaryText,
                      fontFamily: AppTypography.fontFamily,
                      fontSize: 22,
                      fontWeight: AppTypography.bold,
                    ),
                  ),
                ),
                Semantics(
                  button: true,
                  label: 'Close appointment details',
                  excludeSemantics: true,
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    tooltip: 'Close',
                    constraints: const BoxConstraints.tightFor(
                      width: 48,
                      height: 48,
                    ),
                    icon: const Icon(Icons.close),
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.greyBackground,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.navigationDivider),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _AppointmentStatus(),
                  SizedBox(height: 20),
                  _AppointmentModalDetail(
                    icon: Icons.calendar_today_outlined,
                    label: 'Date',
                    value: state.appointmentDate,
                  ),
                  SizedBox(height: 16),
                  _AppointmentModalDetail(
                    icon: Icons.schedule_outlined,
                    label: 'Time',
                    value: state.appointmentTime,
                  ),
                  SizedBox(height: 16),
                  _AppointmentModalDetail(
                    icon: Icons.location_on_outlined,
                    label: 'Location',
                    value: state.content.appointment.address,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Please arrive 10 minutes before your appointment.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.secondaryText,
                fontFamily: AppTypography.fontFamily,
                fontSize: 14,
                fontWeight: AppTypography.regular,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(),
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.whiteBackground,
                minimumSize: const Size.fromHeight(48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                textStyle: const TextStyle(
                  fontFamily: AppTypography.fontFamily,
                  fontSize: 16,
                  fontWeight: AppTypography.medium,
                ),
              ),
              child: const Text('Done'),
            ),
          ],
        ),
      ),
    );
  }
}

class _AppointmentStatus extends StatelessWidget {
  const _AppointmentStatus();

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Appointment status: Upcoming',
      excludeSemantics: true,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Text(
          'UPCOMING',
          style: TextStyle(
            color: AppColors.whiteBackground,
            fontFamily: AppTypography.fontFamily,
            fontSize: 11,
            fontWeight: AppTypography.bold,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }
}

class _AppointmentModalDetail extends StatelessWidget {
  const _AppointmentModalDetail({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ExcludeSemantics(child: Icon(icon, size: 24, color: AppColors.primary)),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: AppColors.secondaryText,
                  fontFamily: AppTypography.fontFamily,
                  fontSize: 12,
                  fontWeight: AppTypography.medium,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  color: AppColors.primaryText,
                  fontFamily: AppTypography.fontFamily,
                  fontSize: 16,
                  fontWeight: AppTypography.medium,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _HeaderDivider extends StatelessWidget {
  const _HeaderDivider();

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 1,
      color: AppColors.whiteBackground.withValues(alpha: 0.34),
    );
  }
}

class _AppointmentDetail extends StatelessWidget {
  const _AppointmentDetail({required this.asset, required this.label});

  final String asset;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(asset, width: 14, height: 16, fit: BoxFit.contain),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppColors.whiteBackground,
              fontFamily: AppTypography.fontFamily,
              fontSize: 12,
              fontWeight: AppTypography.regular,
            ),
          ),
        ),
      ],
    );
  }
}

class _AccountSummary extends StatelessWidget {
  const _AccountSummary({required this.state});

  final HomeState state;

  @override
  Widget build(BuildContext context) {
    final textScale = MediaQuery.textScalerOf(
      context,
    ).scale(1).clamp(1, 2).toDouble();

    return ClipRRect(
      borderRadius: BorderRadius.circular(28),
      child: ColoredBox(
        color: AppColors.whiteBackground,
        child: SizedBox(
          height: 44 * textScale,
          child: Row(
            children: [
              Expanded(
                child: _SummaryItem(label: 'CREDIT', value: state.credit),
              ),
              VerticalDivider(width: 1, color: AppColors.navigationDivider),
              Expanded(
                child: _SummaryItem(
                  label: 'POINTS',
                  value: state.content.account.points.toString(),
                ),
              ),
              VerticalDivider(width: 1, color: AppColors.navigationDivider),
              Expanded(
                child: _SummaryItem(
                  label: 'PACKAGE',
                  value: state.content.account.packages.toString(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  const _SummaryItem({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            maxLines: 1,
            style: const TextStyle(
              color: AppColors.textHighlight,
              fontFamily: AppTypography.fontFamily,
              fontSize: 10,
              fontWeight: AppTypography.regular,
              height: 1.1,
            ),
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              value,
              maxLines: 1,
              style: const TextStyle(
                color: AppColors.textHighlight,
                fontFamily: AppTypography.fontFamily,
                fontSize: 14,
                fontWeight: AppTypography.bold,
                height: 1.1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
