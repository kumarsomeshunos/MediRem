import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String information;
  final String highlight; // "Now" or "Next"

  const InfoCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.information,
    required this.highlight,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            _buildImage(),
            const SizedBox(width: 16), // Space between image and text
            Expanded(child: _buildCardContent(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.0), // Rounded corners
      child: Image.asset(
        imagePath,
        width: 100, // Desired width
        height: 100, // Desired height
        fit: BoxFit.cover, // Ensure the image covers the container
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: 100,
            height: 100,
            color: Colors.grey.shade200,
            child: const Icon(Icons.broken_image, size: 48, color: Colors.grey),
          );
        },
      ),
    );
  }

  Widget _buildCardContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          information,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.blueAccent,
              ),
        ),
        const SizedBox(height: 12),
        _buildHighlightBadge(),
      ],
    );
  }

  Widget _buildHighlightBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: highlight == 'Now' ? Colors.green : Colors.blue,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        highlight,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
