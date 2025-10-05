# Icon Setup Guide for NutriQuest

## 🎨 Custom Icon Assets

### Badge Icons (`assets/icons/badges/`)

1. **first_quiz.png** - First Quiz Badge
   - Design: Simple quiz icon with "1" or star
   - Colors: Green background with white icon
   - Size: 64x64 pixels

2. **quiz_master.png** - Quiz Master Badge
   - Design: Crown or trophy with quiz elements
   - Colors: Gold background with dark icon
   - Size: 64x64 pixels

3. **healthy_eater.png** - Healthy Eater Badge
   - Design: Apple or healthy food icon
   - Colors: Green background with white icon
   - Size: 64x64 pixels

4. **meal_builder.png** - Meal Builder Badge
   - Design: Plate or meal icon
   - Colors: Orange background with white icon
   - Size: 64x64 pixels

5. **streak_master.png** - Streak Master Badge
   - Design: Fire or flame icon
   - Colors: Red background with white icon
   - Size: 64x64 pixels

### Achievement Icons (`assets/icons/achievements/`)

1. **level_1.png** - Level 1 Achievement
   - Design: Simple star or number "1"
   - Colors: Bronze/gold background
   - Size: 64x64 pixels

2. **level_5.png** - Level 5 Achievement
   - Design: Star with "5" or crown
   - Colors: Silver background
   - Size: 64x64 pixels

3. **level_10.png** - Level 10 Achievement
   - Design: Diamond or "10" with special effects
   - Colors: Gold background
   - Size: 64x64 pixels

### Game Icons (`assets/icons/games/`)

1. **quiz_icon.png** - Quiz Game Icon
   - Design: Question mark or brain icon
   - Colors: Blue background with white icon
   - Size: 64x64 pixels

2. **food_sort_icon.png** - Food Sort Game Icon
   - Design: Sorting or categorization icon
   - Colors: Green background with white icon
   - Size: 64x64 pixels

3. **meal_builder_icon.png** - Meal Builder Game Icon
   - Design: Plate or meal icon
   - Colors: Orange background with white icon
   - Size: 64x64 pixels

4. **learning_icon.png** - Learning Hub Icon
   - Design: Book or graduation cap icon
   - Colors: Purple background with white icon
   - Size: 64x64 pixels

## 🛠️ Creating the Icons

### Design Guidelines

1. **Size**: All icons should be 64x64 pixels
2. **Format**: PNG with transparency support
3. **Style**: Rounded square with subtle shadow
4. **Colors**: Use the NutriQuest color palette:
   - Primary Green: #4CAF50
   - Accent Orange: #FF9800
   - Accent Yellow: #FFC107
   - Blue: #2196F3
   - Purple: #9C27B0
   - Red: #F44336

### Tools for Creating Icons

1. **Figma** (Recommended)
   - Create 64x64 artboard
   - Use rounded rectangle as base
   - Add icon in center
   - Export as PNG

2. **Adobe Illustrator**
   - Create 64x64 document
   - Design icon with proper colors
   - Export as PNG

3. **Canva**
   - Use 64x64 template
   - Add icon elements
   - Download as PNG

### Usage in Flutter

```dart
// Badge icon
Image.asset(
  'assets/icons/badges/first_quiz.png',
  width: 32,
  height: 32,
)

// Achievement icon
Image.asset(
  'assets/icons/achievements/level_1.png',
  width: 48,
  height: 48,
)

// Game icon
Image.asset(
  'assets/icons/games/quiz_icon.png',
  width: 64,
  height: 64,
)
```

### Integration Examples

#### Badge Display
```dart
class BadgeWidget extends StatelessWidget {
  final String badgeName;
  final String iconPath;
  final bool isUnlocked;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: isUnlocked ? Colors.green : Colors.grey,
      ),
      child: Image.asset(
        iconPath,
        width: 32,
        height: 32,
        color: isUnlocked ? null : Colors.grey,
      ),
    );
  }
}
```

#### Game Icon Display
```dart
class GameIcon extends StatelessWidget {
  final String gameName;
  final String iconPath;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              iconPath,
              width: 40,
              height: 40,
            ),
            SizedBox(height: 4),
            Text(
              gameName,
              style: TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
```

## 🚨 Troubleshooting

- **Icons not showing**: Check file paths and pubspec.yaml assets
- **Wrong colors**: Ensure PNG files have correct colors
- **Size issues**: Verify all icons are 64x64 pixels
- **Performance**: Consider using cached images for better performance

---
**Your NutriQuest app now has beautiful custom icons! 🎉**
