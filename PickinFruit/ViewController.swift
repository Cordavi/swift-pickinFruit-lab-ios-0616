//
//  ViewController.swift
//  PickinFruit
//
//  Created by Flatiron School on 7/17/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
   
   @IBOutlet weak var spinButton: UIButton!
   @IBOutlet weak var resultLabel: UILabel!
   @IBOutlet weak var fruitPicker: UIPickerView!
   
   var fruitsArray = ["🍎", "🍊", "🍌", "🍐", "🍇", "🍉", "🍓", "🍒", "🍍"]
   var numberOfRows = 1000
   var numberOfComponents = 3
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      self.fruitPicker.accessibilityLabel = Constants.FRUIT_PICKER
      self.spinButton.accessibilityLabel = Constants.SPIN_BUTTON
      
      fruitPicker.delegate = self
      fruitPicker.dataSource = self
      
   }
   
   func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
      return numberOfComponents
   }
   
   func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
      return numberOfRows
   }
   
   func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
      return fruitsArray[row % self.fruitsArray.count]
   }
   
   @IBAction func spinButtonTapped(sender: UIButton) {
      spinWheel()
      checkForWin()
   }
   
   func spinWheel() {
      fruitPicker.selectRow(Int(arc4random_uniform(UInt32(numberOfRows))), inComponent: 0, animated: true)
      fruitPicker.selectRow(Int(arc4random_uniform(UInt32(numberOfRows))), inComponent: 1, animated: true)
      fruitPicker.selectRow(Int(arc4random_uniform(UInt32(numberOfRows))), inComponent: 2, animated: true)
   }
   
   func checkForWin() {
      let firstFruit = pickerView(fruitPicker, titleForRow: fruitPicker.selectedRowInComponent(0), forComponent: 0)
      let secondFruit = pickerView(fruitPicker, titleForRow: fruitPicker.selectedRowInComponent(1), forComponent: 1)
      let thirdFruit = pickerView(fruitPicker, titleForRow: fruitPicker.selectedRowInComponent(2), forComponent: 2)
      
      if firstFruit == secondFruit && secondFruit == thirdFruit {
         resultLabel.text = "WINNER!"
      } else {
         resultLabel.text = "TRY AGAIN"
      }
   }
}

// MARK: Set Up
extension ViewController {
   
   override func viewDidLayoutSubviews() {
      if self.spinButton.layer.cornerRadius == 0.0 {
         configureButton()
      }
   }
   
   func configureButton()
   {
      self.spinButton.layer.cornerRadius = 0.5 * self.spinButton.bounds.size.width
      self.spinButton.layer.borderColor = UIColor.whiteColor().CGColor
      self.spinButton.layer.borderWidth = 4.0
      self.spinButton.clipsToBounds = true
   }
   
}



