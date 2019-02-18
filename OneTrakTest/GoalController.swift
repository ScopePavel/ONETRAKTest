//
//  GoalController.swift
//  OneTrakTest
//
//  Created by Pavel Scope on 11/02/2019.
//  Copyright © 2019 Paronkin Pavel. All rights reserved.
//

import UIKit

class GoalController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var goalLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    let companies = ["1000","2000","3000","4000","5000","6000","7000","8000","9000","10000"]
    var goalValue : Int?
    override func viewDidLoad() {
        super.viewDidLoad()

        self.goalLabel.text = "goal: \(UserDefaults.standard.integer(forKey: "Key"))"
    }
    
    @IBAction func addGoal(_ sender: UIBarButtonItem) {
        UserDefaults.standard.set(goalValue, forKey: "Key")
        self.goalLabel.text = "goal: \(UserDefaults.standard.integer(forKey: "Key"))"
    }
    

    
    

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.companies.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       

        return self.companies[row]
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(self.companies[row])
        self.goalValue = (self.companies[row] as NSString).integerValue
        

    }
}
