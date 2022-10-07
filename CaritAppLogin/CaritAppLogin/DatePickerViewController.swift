//
//  DatePickerViewController.swift
//  CaritAppLogin
//
//  Created by Alumno on 27/09/22.
//

import UIKit

class DatePickerViewController: UIViewController {

    

    @IBOutlet weak var tfFecha2: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        tfFecha2.text = formatter.string(from: date)
        tfFecha2.textColor = .caritasAzulO
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(sender:)), for: UIControl.Event.editingChanged)
        datePicker.frame.size = CGSize(width: 0, height: 250)
        tfFecha2.inputView = datePicker
        
    }
    
    @objc func datePickerValueChanged(sender: UIDatePicker)
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        tfFecha2.text = formatter.string(from: sender.date)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
