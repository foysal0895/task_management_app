
import 'package:flutter/material.dart';

class ListViewCustomCard extends StatelessWidget {
  const ListViewCustomCard({
    super.key,
    required this.color,
    required this.title,
    required this.description,
  });

  final String title;
  final String description;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final textSize = Theme.of(context);
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 4,
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: textSize.textTheme.titleLarge,
            ),
            const SizedBox(height: 4),

            Text(
              description,
              style: textSize.textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  backgroundColor:color,
                  padding: EdgeInsets.zero,
                  label: Text(
                    "New",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),

                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(width: 4),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}