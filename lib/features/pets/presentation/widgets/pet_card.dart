import 'package:flutter/material.dart';
import 'package:flutter_pet_adopt/app_data/constants.dart';
import 'package:flutter_pet_adopt/features/pets/domain/entities/pet_entity.dart';

class PetCard extends StatelessWidget {
  const PetCard({
    super.key,
    required this.pet,
    required this.onTap,
  });

  final PetEntity pet;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: const Color.fromARGB(211, 255, 255, 255),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(10),
                ),
                child: pet.primaryImage.isEmpty
                    ? const _PetImageFallback()
                    : Image.network(
                        pet.primaryImage,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        errorBuilder: (_, __, ___) {
                          return const _PetImageFallback();
                        },
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          pet.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: mainColor,
                          ),
                        ),
                      ),
                      Icon(
                        pet.gender?.toLowerCase() == 'male'
                            ? Icons.male
                            : Icons.female,
                        color: mainColor,
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    pet.age == null ? 'Age unavailable' : '${pet.age} years',
                  ),
                  Text(pet.breed ?? 'Breed unavailable'),
                  Text(
                    pet.color == null
                        ? 'Color unavailable'
                        : 'Color: ${pet.color}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PetImageFallback extends StatelessWidget {
  const _PetImageFallback();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF3F3F3),
      alignment: Alignment.center,
      child: const Icon(
        Icons.pets,
        size: 40,
        color: mainColor,
      ),
    );
  }
}
