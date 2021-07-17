//
//  CalendarViewController.swift
//  TopMovies
//
//  Created by Никита on 31.03.2021.
//

import UIKit

class CalendarViewController: UIViewController {

    private var presenter: CalendarViewControllerPresenter!
    
    @IBOutlet weak var calendarDatePicker: UIDatePicker!
    @IBOutlet weak var setPushButton: UIButton!

    @IBAction func calendarDatePickerChanged(_ sender: Any) {
        fetchChangesFromDatepicker()
    }
    @IBAction func setPushButtonIsPressed(_ sender: Any) {
        presenter.setNotification()
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.isHidden = true
        
        setupSetPushButton()
        
        let localeID = Locale.preferredLanguages.first
        self.calendarDatePicker.locale = Locale(identifier: localeID!)
        
        presenter = CalendarViewControllerPresenter()
    }
    
    func setupSetPushButton() {
        self.setPushButton.setTitle("Remind me", for: .normal)
        self.setPushButton.setTitleColor(.white, for: .normal)
        self.setPushButton.backgroundColor = .systemGray2
        self.setPushButton.layer.cornerRadius = 5
    }
    
    func fetchChangesFromDatepicker() {
        let components = self.calendarDatePicker.calendar.dateComponents([.month,.day,.hour,.minute], from: calendarDatePicker.date)
        CalendarViewControllerData.shared.dateOfNotification.month = components.month
        CalendarViewControllerData.shared.dateOfNotification.day = components.day
        CalendarViewControllerData.shared.dateOfNotification.hour = components.hour
        CalendarViewControllerData.shared.dateOfNotification.minute = components.minute
    }
}
