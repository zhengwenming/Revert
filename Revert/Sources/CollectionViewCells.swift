//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var subheadLabel: UILabel!
}

class TextFieldControlCell: CollectionViewCell {
  @IBOutlet private weak var textField: UITextField!
  
  @IBAction func textFieldDidEndOnExit(sender: UITextField) {
    sender.resignFirstResponder()
  }
}

final class TextFieldControlCustomInputCell: TextFieldControlCell, UIPickerViewDelegate {
  override func awakeFromNib() {
    super.awakeFromNib()
    
    self.textField.inputView = self.textFieldInputView
    self.textField.inputAccessoryView = self.textFieldInputAccessoryView
  }
  
  private var textFieldInputView: UIDatePicker {
    let picker = UIDatePicker()
    
    picker.datePickerMode = .Date
    picker.addTarget(self, action: "datePickerChanged:", forControlEvents: .ValueChanged)
    picker.autoresizingMask = [.FlexibleHeight, .FlexibleWidth]
    return picker
  }

  private var textFieldInputAccessoryView: UIView {
    let size = CGSize(width: UIScreen.mainScreen().bounds.size.width, height: 44)
    let toolBar = UIToolbar(frame: CGRect(origin: CGPointZero, size: size))
    let doneBarButtonItem = UIBarButtonItem(title: "Done", style: .Done, target: self, action: "doneButtonTapped:")
    let flexibleBarButtonItem = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)

    doneBarButtonItem.tintColor = UIColor.revertTintColor()
    toolBar.items = [
      flexibleBarButtonItem,
      doneBarButtonItem
    ]
    return toolBar
  }
  
  func doneButtonTapped(sender: UIBarButtonItem) {
    self.textField.resignFirstResponder()
  }
  
  func datePickerChanged(datePicker: UIDatePicker) {
    self.textField.text = Static.DateFormatter.ddmmyy.stringFromDate(datePicker.date)
  }
}