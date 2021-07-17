//
//  SettingsOfListViewController.swift
//  TopMovies
//
//  Created by Никита on 13.06.2021.
//

import UIKit

class SettingsOfListViewController: UIViewController {
    
    weak var mainVCdelegate: MainVCPresenterProtocol?
    
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var sortByLabel: UILabel!
    
    @IBOutlet weak var yearPicker: UIPickerView!
    @IBOutlet weak var sortPicker: UIPickerView!
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBAction func saveButtonIsPressed(_ sender: Any) {
        let yearRow = yearPicker.selectedRow(inComponent: 0)
        let yearValue = self.pickerView(yearPicker, titleForRow: yearRow, forComponent: 0)
        SettingsOfListData.shared.choosedYearRow = yearRow
        SettingsOfListData.shared.choosedYear = yearValue ?? ""
        
        let sortRow = sortPicker.selectedRow(inComponent: 0)
        SettingsOfListData.shared.ChoosedSortRow = sortRow
        
        mainVCdelegate?.loadVC()
        
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.topLabel.text = "Top movies of the year:"
        self.sortByLabel.text = "Sort by:"
        
        setSaveButton()
        
        yearPicker.delegate = self
        yearPicker.dataSource = self
        sortPicker.delegate = self
        sortPicker.dataSource = self
        
        setupPickers()
    }
    
    func setSaveButton() {
        self.saveButton.setTitle("Save and search", for: .normal)
        self.saveButton.setTitleColor(.white, for: .normal)
        self.saveButton.backgroundColor = .systemGray2
        self.saveButton.layer.cornerRadius = 5
    }
}

extension SettingsOfListViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func getCurrenYear() -> Int {
        let date = Date()
        let calendar = Calendar.current
        return calendar.component(.year, from: date)
    }
    
    func setupPickers() {
        self.yearPicker.tag = 1
        self.sortPicker.tag = 2
        
        let currentYear = getCurrenYear()
        if SettingsOfListData.shared.yearPickerOptions == [] {
            for year in 1990...currentYear {
                SettingsOfListData.shared.yearPickerOptions.append(year)
            }
        }
        if SettingsOfListData.shared.choosedYearRow == -1 {
            SettingsOfListData.shared.choosedYearRow = SettingsOfListData.shared.yearPickerOptions.count - 1
        }
        self.yearPicker.selectRow(SettingsOfListData.shared.choosedYearRow, inComponent: 0, animated: false)
        self.sortPicker.selectRow(SettingsOfListData.shared.ChoosedSortRow, inComponent: 0, animated: false)
        SettingsOfListData.shared.choosedYear = self.pickerView(yearPicker, titleForRow: SettingsOfListData.shared.choosedYearRow, forComponent: 0) ?? ""
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return SettingsOfListData.shared.yearPickerOptions.count
        } else {
            return SettingsOfListData.shared.sortPickerOptions.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
            return "\(SettingsOfListData.shared.yearPickerOptions[row])"
        } else {
            return "\(SettingsOfListData.shared.sortPickerOptions[row])"
        }
    }
}
