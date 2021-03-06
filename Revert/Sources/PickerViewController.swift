//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import UIKit

final class PickerViewController: RevertViewController {
  private let collection = CollectableCollection<Country>(items: .CountriesCapitals)
}

// MARK:- UIPickerViewDataSource
extension PickerViewController: UIPickerViewDataSource {
  func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
    return 1
  }

  func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return self.collection[component].countOfItems
  }
}

// MARK:- UIPickerViewDelegate
extension PickerViewController: UIPickerViewDelegate {
  func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return self.collection.items.first?[row].name
  }
}
