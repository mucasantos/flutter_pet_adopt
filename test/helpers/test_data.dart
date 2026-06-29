import 'package:flutter_pet_adopt/features/auth/data/models/auth_session_model.dart';
import 'package:flutter_pet_adopt/features/auth/data/models/auth_user_model.dart';
import 'package:flutter_pet_adopt/features/auth/domain/entities/auth_session_entity.dart';
import 'package:flutter_pet_adopt/features/auth/domain/entities/auth_user_entity.dart';
import 'package:flutter_pet_adopt/features/pets/data/models/category_model.dart';
import 'package:flutter_pet_adopt/features/pets/data/models/pet_model.dart';
import 'package:flutter_pet_adopt/features/pets/domain/entities/category_entity.dart';
import 'package:flutter_pet_adopt/features/pets/domain/entities/pet_entity.dart';

const sampleCategoryModel = CategoryModel(
  id: 'cat',
  name: 'Cat',
  imageUrl: 'https://example.com/cat.png',
);

const sampleDogCategoryModel = CategoryModel(
  id: 'dog',
  name: 'Dog',
  imageUrl: 'https://example.com/dog.png',
);

const samplePetModel = PetModel(
  id: 'pet-1',
  name: 'Milo',
  images: ['https://example.com/milo.png'],
  age: 2,
  weight: 4,
  color: 'Orange',
  gender: 'male',
  breed: 'Tabby',
  story: 'Friendly cat that loves naps.',
  categoryId: 'cat',
  categoryName: 'Cat',
  isVerified: true,
  available: true,
);

const sampleDogPetModel = PetModel(
  id: 'pet-2',
  name: 'Buddy',
  images: ['https://example.com/buddy.png'],
  age: 5,
  weight: 18,
  color: 'Brown',
  gender: 'male',
  breed: 'Mixed Breed',
  story: 'Energetic dog that loves to play fetch.',
  categoryId: 'dog',
  categoryName: 'Dog',
  isVerified: false,
  available: true,
);

const sampleCategory = CategoryEntity(
  id: 'cat',
  name: 'Cat',
  imageUrl: 'https://example.com/cat.png',
);

const sampleDogCategory = CategoryEntity(
  id: 'dog',
  name: 'Dog',
  imageUrl: 'https://example.com/dog.png',
);

const samplePet = PetEntity(
  id: 'pet-1',
  name: 'Milo',
  images: ['https://example.com/milo.png'],
  age: 2,
  weight: 4,
  color: 'Orange',
  gender: 'male',
  breed: 'Tabby',
  story: 'Friendly cat that loves naps.',
  categoryId: 'cat',
  categoryName: 'Cat',
  isVerified: true,
  available: true,
);

const sampleDogPet = PetEntity(
  id: 'pet-2',
  name: 'Buddy',
  images: ['https://example.com/buddy.png'],
  age: 5,
  weight: 18,
  color: 'Brown',
  gender: 'male',
  breed: 'Mixed Breed',
  story: 'Energetic dog that loves to play fetch.',
  categoryId: 'dog',
  categoryName: 'Dog',
  isVerified: false,
  available: true,
);

const samplePets = [samplePet, sampleDogPet];
const sampleCategories = [sampleCategory, sampleDogCategory];

const sampleAuthUserModel = AuthUserModel(
  userId: 'user-1',
  name: 'Samuel Santos',
  email: 'samuel@example.com',
  phone: '+55 11 99999-0000',
  imageUrl: 'https://example.com/avatar.png',
);

const sampleAuthSessionModel = AuthSessionModel(
  token: 'token-1234567890',
  user: sampleAuthUserModel,
  pets: [samplePetModel],
);

const sampleAuthUser = AuthUserEntity(
  userId: 'user-1',
  name: 'Samuel Santos',
  email: 'samuel@example.com',
  phone: '+55 11 99999-0000',
  imageUrl: 'https://example.com/avatar.png',
);

const sampleAuthSession = AuthSessionEntity(
  token: 'token-1234567890',
  user: sampleAuthUser,
  pets: [samplePet],
);
