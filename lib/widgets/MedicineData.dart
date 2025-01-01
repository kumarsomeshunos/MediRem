class MedicineData {
  static final List<Map<String, dynamic>> _cardData = [
    {
      'imagePath': 'images/trupred_drop.png',
      'title': 'Trupred',
      'information':
          '6 times a day (2hrs gap) in left eye starting at 09:00 AM',
      'highlight': 'Mandatory',
      'takeTimes': [11, 13, 17, 19],
    },
    {
      'imagePath': 'images/cellusoothe_drop.png',
      'title': 'CelluSoothe',
      'information':
          '4 times a day (3hrs gap) in both eyes starting at 09:00 AM',
      'highlight': 'Mandatory',
      'takeTimes': [9, 12, 15, 18],
    },
    {
      'imagePath': 'images/moxitobra_drop.png',
      'title': 'Moxitobra',
      'information':
          '4 times a day (3hrs gap) in left eye only starting at 09:00 AM',
      'highlight': 'Mandatory',
      'takeTimes': [9, 12, 15, 18],
    },
    {
      'imagePath': 'images/trupred_drop.png',
      'title': 'Trupred',
      'information':
          '3 times a day (6hrs gap) in both eyes starting at 09:00 AM',
      'highlight': 'Mandatory',
      'takeTimes': [9, 15, 21],
    },
    {
      'imagePath': 'images/mydriasol_drop.png',
      'title': 'Mydriasol',
      'information': 'Once a day at night 09:00 PM',
      'highlight': 'Mandatory',
      'takeTimes': [21],
    },
  ];

  /// Returns all card data
  static List<Map<String, dynamic>> getAllCardData() {
    return List<Map<String, dynamic>>.from(_cardData);
  }

  /// Returns medicines that need to be taken at the current hour
  static List<Map<String, dynamic>> getDynamicCardData() {
    final currentHour = DateTime.now().hour;

    return _cardData.where((item) {
      final List<int> takeTimes = item['takeTimes'] as List<int>;
      return takeTimes.contains(currentHour);
    }).toList();
  }

  /// Returns medicines with `takeTimes` updated to only the current hour
  static List<Map<String, dynamic>> getDynamicCardDataWithOnlyCurrentTime() {
    final currentHour = DateTime.now().hour;

    return _cardData.where((item) {
      final List<int> takeTimes = item['takeTimes'] as List<int>;
      return takeTimes.contains(currentHour);
    }).map((item) {
      // Create a copy of the item and update the takeTimes
      final updatedItem = Map<String, dynamic>.from(item);
      updatedItem['takeTimes'] = [currentHour];
      return updatedItem;
    }).toList();
  }
}
