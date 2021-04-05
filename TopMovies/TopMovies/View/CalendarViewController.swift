//
//  CalendarViewController.swift
//  TopMovies
//
//  Created by Никита on 31.03.2021.
//

import UIKit

class CalendarViewController: UIViewController {

    var movieNameForNotification: String?
    var dateOfNotification: DateComponents?
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
        
        dateOfNotification = DateComponents()
        
        setPushButton.setTitle("Remind me", for: .normal)
        
        let localeID = Locale.preferredLanguages.first
        self.calendarDatePicker.locale = Locale(identifier: localeID!)
        
        presenter = CalendarViewControllerPresenter()
        presenter.delegate = self
    }
}

extension CalendarViewController: CalendarViewControllerProtocol {
    
    func fetchChangesFromDatepicker() {
        let components = self.calendarDatePicker.calendar.dateComponents([.month,.day,.hour,.minute], from: calendarDatePicker.date)
        dateOfNotification?.month = components.month
        dateOfNotification?.day = components.day
        dateOfNotification?.hour = components.hour
        dateOfNotification?.minute = components.minute
    }
}
