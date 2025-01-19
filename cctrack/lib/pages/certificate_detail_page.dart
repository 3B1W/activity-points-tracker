import 'package:cctrack/models/certificate_model.dart';
import 'package:flutter/material.dart';

class CertificateDetailPage extends StatelessWidget {
  final Certificate certificate;

  const CertificateDetailPage({required this.certificate, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          certificate.eventName,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.04, // Increased size
          ),
        ),
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        foregroundColor: theme.colorScheme.onSurface,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: 16), // Increased padding
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Created At (Date of Event)
              InfoRowWithIcon(
                icon: Icons.calendar_today,
                label: certificate.createdAt, // Date of Event
              ),
              const SizedBox(height: 16),

              // Move everything after the Date to the center of the screen
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category
                  EditableField(
                    label: 'Category',
                    value: certificate.category,
                  ),
                  const SizedBox(height: 16),

                  // Sub Category
                  EditableField(
                    label: 'Sub Category',
                    value: certificate.subCategory,
                  ),
                  const SizedBox(height: 16),

                  // Level/Role
                  EditableField(
                    label: 'Level/Role',
                    value: certificate.levelRole,
                  ),
                  const SizedBox(height: 16),

                  // Duration/Date (Updated label)
                  EditableField(
                    label: 'Duration/Date',
                    value: certificate.durationDate, // Duration or Date
                  ),
                  const SizedBox(height: 16),

                  // Proof Certificate (If any)
                  EditableField(
                    label: 'Certificate link',
                    value: certificate.proofCertificate,
                  ),
                  const SizedBox(height: 16),

                  // Points Earned
                  EditableField(
                    label: 'Points Earned',
                    value: certificate.pointsEarned.toString(),
                  ),
                  const SizedBox(height: 32),

                  // View Certificate Button
                  Center(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(screenWidth * 0.75, 56), // Increased button size
                        backgroundColor: theme.colorScheme.secondary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'View Certificate',
                        style: TextStyle(
                          color: theme.colorScheme.surface,
                          fontSize: screenWidth * 0.04, // Increased font size
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Edit Certificate Button
                  Center(
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size(screenWidth * 0.75, 56), // Increased button size
                        side: BorderSide(color: theme.colorScheme.primary),
                        backgroundColor: theme.colorScheme.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Edit Certificate Info',
                        style: TextStyle(
                          color: theme.colorScheme.surface,
                          fontSize: screenWidth * 0.04, // Increased font size
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InfoRowWithIcon extends StatelessWidget {
  final IconData icon;
  final String label;

  const InfoRowWithIcon({
    required this.icon,
    required this.label,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start, // Align to left side
      children: [
        Icon(icon, size: 20, color: theme.colorScheme.primary), // Increased icon size
        const SizedBox(width: 12),
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.primary, // Set text color to primary
            fontSize: 16, // Increased text size
          ),
        ),
      ],
    );
  }
}

class EditableField extends StatelessWidget {
  final String label;
  final String value;

  const EditableField({
    required this.label,
    required this.value,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Align label to left
      children: [
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 16, // Increased text size
            color: theme.colorScheme.primary, // Set label color to primary
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.only(left: 7),
          child: Container(
            width: screenWidth * 0.85, // Matching width
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06, vertical: 12), // Increased padding
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              border: Border.all(color: theme.colorScheme.inversePrimary), // Border color set to inversePrimary
              borderRadius: BorderRadius.circular(12), // Increased radius
            ),
            child: Text(
              value.isNotEmpty ? value : 'N/A',
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: 16, // Increased text size
                color: theme.colorScheme.inversePrimary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
