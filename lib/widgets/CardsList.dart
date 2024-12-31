import 'package:flutter/material.dart';
import 'package:medirem/widgets/InfoCard.dart';

class CardsList extends StatelessWidget {
  final List<Map<String, dynamic>> cardData;

  const CardsList({
    super.key,
    required this.cardData,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: cardData.length,
      separatorBuilder: (context, index) => const SizedBox(height: 8.0),
      itemBuilder: (context, index) {
        final data = cardData[index];
        return _buildInfoCard(data);
      },
    );
  }

  /// Builds an individual `InfoCard` from the data
  Widget _buildInfoCard(Map<String, dynamic> data) {
    return InfoCard(
      imagePath: data['imagePath'] ?? 'assets/images/default.png',
      // Default image path
      title: data['title'] ?? 'No Title',
      information: data['information'] ?? 'No Information Available',
      highlight: _formatTakeTimes(data['takeTimes']),
    );
  }

  /// Formats the `takeTimes` list into a string
  String _formatTakeTimes(dynamic takeTimes) {
    if (takeTimes is List<int> && takeTimes.isNotEmpty) {
      return takeTimes.join(' | '); // Convert times to a "9 | 12 | 15" format
    }
    return 'No Schedule';
  }
}
