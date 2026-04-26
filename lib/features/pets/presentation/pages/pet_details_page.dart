import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pet_adopt/app_data/constants.dart';
import 'package:flutter_pet_adopt/core/presentation/widgets/app_button.dart';
import 'package:flutter_pet_adopt/features/pets/domain/entities/pet_entity.dart';
import 'package:flutter_pet_adopt/features/pets/presentation/widgets/pet_info_tile.dart';

class PetDetailsPage extends StatelessWidget {
  const PetDetailsPage({
    super.key,
    required this.pet,
  });

  final PetEntity pet;

  @override
  Widget build(BuildContext context) {
    final galleryItems = pet.images.isEmpty
        ? const [_DetailsImageFallback()]
        : pet.images.map((imageUrl) {
            return Image.network(
              imageUrl,
              fit: BoxFit.cover,
              width: MediaQuery.sizeOf(context).width,
              errorBuilder: (_, __, ___) => const _DetailsImageFallback(),
            );
          }).toList(growable: false);

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
                stretch: true,
                backgroundColor: Colors.white,
                flexibleSpace: CarouselSlider(
                  options: CarouselOptions(
                    autoPlayInterval: const Duration(seconds: 10),
                    viewportFraction: 1,
                    height: MediaQuery.sizeOf(context).height * 0.55,
                    autoPlay: galleryItems.length > 1,
                  ),
                  items: galleryItems,
                ),
                floating: true,
                snap: true,
                expandedHeight: 250,
                forceElevated: innerBoxIsScrolled,
              ),
            ),
          ];
        },
        body: Builder(
          builder: (context) {
            return CustomScrollView(
              slivers: [
                SliverOverlapInjector(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  pet.name,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: mainColor,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Icon(
                                  pet.gender?.toLowerCase() == 'male'
                                      ? Icons.male
                                      : Icons.female,
                                  color: mainColor,
                                  size: 25,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            PetInfoTile(
                              title: pet.breed ?? 'Breed unavailable',
                              info: 'Breed',
                            ),
                            PetInfoTile(
                              title: pet.age == null ? 'Unknown' : '${pet.age}',
                              info: 'Age',
                            ),
                            const PetInfoTile(
                              title: 'Fit',
                              info: 'Health',
                            ),
                            PetInfoTile(
                              title: pet.weight == null
                                  ? 'Unknown'
                                  : '${pet.weight}kg',
                              info: 'Weight',
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Row(
                          children: [
                            Icon(Icons.place_outlined),
                            SizedBox(width: 8),
                            Text('2.7Km Away'),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'My Story',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: mainColor,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          pet.story ?? 'No story available.',
                          textAlign: TextAlign.justify,
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'My Qualities',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: mainColor,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            PetInfoTile(info: 'Good with kids'),
                            PetInfoTile(info: 'Healthy'),
                            PetInfoTile(info: 'House-trained'),
                            PetInfoTile(info: 'Knows commands'),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const AppButton(
                          title: 'Adopt me',
                          onPressed: _noop,
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _DetailsImageFallback extends StatelessWidget {
  const _DetailsImageFallback();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF3F3F3),
      alignment: Alignment.center,
      child: const Icon(
        Icons.pets,
        size: 72,
        color: mainColor,
      ),
    );
  }
}

void _noop() {}
