import '../../domain/entities/home_content.dart';

class HomeState {
  const HomeState(this.content);
  final HomeContent content;
  String get appointmentDate {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    final date = content.appointment.startsAt;
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  String get appointmentTime {
    final date = content.appointment.startsAt;
    final hour = date.hour % 12 == 0 ? 12 : date.hour % 12;
    return '$hour:${date.minute.toString().padLeft(2, '0')} ${date.hour < 12 ? 'AM' : 'PM'}';
  }

  String get credit => 'RM${content.account.credit.toStringAsFixed(2)}';
}
