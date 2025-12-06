import 'package:game_test/core/constants/app_images.dart';

class EggConfig {
  final int id;
  final String name;
  final int price;
  final String asset;

  const EggConfig({
    required this.id,
    required this.name,
    required this.price,
    required this.asset,
  });
}

const eggsList = [
  EggConfig(id: 0, name: "Striped Egg", price: 100, asset: AppImages.egg0),
  EggConfig(id: 1, name: "Candy Egg", price: 150, asset: AppImages.egg1),
  EggConfig(id: 2, name: "Star Egg", price: 500, asset: AppImages.egg2),
  EggConfig(id: 3, name: "Magic Purple Egg", price: 700, asset: AppImages.egg3),

  EggConfig(id: 4, name: "Orange Shine Egg", price: 970, asset: AppImages.egg4),
  EggConfig(id: 5, name: "Flame Core Egg", price: 1300, asset: AppImages.egg5),
  EggConfig(id: 6, name: "Crystal Egg", price: 1750, asset: AppImages.egg6),
  EggConfig(id: 7, name: "Royal Egg", price: 2100, asset: AppImages.egg7),

  EggConfig(id: 8, name: "Inferno Egg", price: 3450, asset: AppImages.egg8),
  EggConfig(id: 9, name: "Golden Egg", price: 6000, asset: AppImages.egg9),
  EggConfig(id: 10, name: "Toxic Egg", price: 7200, asset: AppImages.egg10),
  EggConfig(id: 11, name: "Turbo Egg", price: 11500, asset: AppImages.egg11),
];

/// 🔥 Мапа для швидкого доступу
final Map<int, EggConfig> eggsMap = {for (final egg in eggsList) egg.id: egg};

/// Допоміжний метод
EggConfig getEggById(int id) => eggsMap[id]!;
