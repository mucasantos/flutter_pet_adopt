# PetAdopt 🐾 - Flutter Clean Architecture Demo

A premium pet adoption mobile application built with **Flutter**, focusing on scalable architecture, test-driven development (TDD), and business-oriented design.

![GitHub License](https://img.shields.io/badge/license-MIT-blue.svg)
![Flutter Version](https://img.shields.io/badge/flutter-3.x-blue.svg)
![Clean Architecture](https://img.shields.io/badge/architecture-Clean%20Arch-green.svg)

## 🌟 Key Features
- **Modern UI/UX**: Clean and intuitive design based on [Figma Inspiration](https://www.figma.com/community/file/1275694472706602668/adopt-me).
- **Pet Management**: Browse, filter, and view details of pets available for adoption.
- **Profile & Auth**: Secure authentication flow with persistence.

## 🏗️ Technical Highlights
- **Clean Architecture**: Strict separation of concerns (Data, Domain, Presentation).
- **State Management**: Robust implementation using **flutter_bloc (Cubit)**.
- **Dependency Injection**: Decoupled components using **GetIt**.
- **BDD (Behavior Driven Development)**: Business rules defined in Gherkin features (`/requirements`).
- **Strict Linting**: Following industry standards for high-quality code.

## 🧪 Testing Strategy
- **Unit Tests**: Domain logic, Entities, and Use Cases.
- **Data Layer Tests**: Repository implementations and Model parsing.
- **State Management Tests**: Cubit states and transitions.
- **Widget Tests**: UI components verification.

## 🛠️ Tech Stack
- **Framework**: Flutter
- **State Management**: Bloc/Cubit
- **Service Locator**: GetIt
- **Functional Programming**: (Optional suggestion: fpdart)
- **Testing**: Mocktail, Bloc Test

## 🚀 Getting Started
1. Clone the repository
2. Run `flutter pub get`
3. Run `flutter test` to verify the logic
4. Run `flutter run`
