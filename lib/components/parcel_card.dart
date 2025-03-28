import 'package:flutter/material.dart';
import 'package:taabo/model/package.dart';

class ParcelCard extends StatelessWidget {
  const ParcelCard({
    required this.parcel,
    required this.isSelected,
    required this.onSelect,
    super.key,
  });

  final Parcel parcel;
  final bool isSelected;
  final VoidCallback onSelect;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: onSelect,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF1e78c1).withOpacity(0.1)
                    : Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF1e78c1)
                      : const Color(0xFF1e78c1).withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  _getTitleAndValue("Tracking Number", parcel.refNumber),
                  const SizedBox(height: 8),
                  _getTitleAndValue("Name", parcel.recipientName ?? ""),
                  const SizedBox(height: 8),
                  _getTitleAndValue("Weight", "${parcel.kg} kg"),
                  const SizedBox(height: 8),
                  _getTitleAndValue("Store", parcel.store ?? ""),
                ],
              ),
            ),
          ),
        ),
        Checkbox(
          value: isSelected,
          onChanged: (value) => onSelect(), // Toggle selection
          activeColor: Color(0xFF1e78c1),
        ),
      ],
    );
  }

  Widget _getTitleAndValue(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "$title: ",
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey[700],
            fontSize: 14,
          ),
        ),
        Flexible(
          child: Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : const Color(0xFF1e78c1),
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
