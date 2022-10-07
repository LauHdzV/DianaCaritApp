//
//  RegistrarViewController.swift
//  CaritAppLogin
//
//  Created by Alberto Estrada on 06/10/22.
//

import UIKit

class RegistrarViewController: UIViewController {
    
    
    @IBOutlet weak var DatePicker: UIDatePicker!
    
    @IBOutlet weak var DatePicker2: UIDatePicker!
    
    @IBOutlet weak var lbDate: UILabel!
    
    @IBOutlet weak var lbDate2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let time = Date()
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_gb")
        formatter.dateFormat = "HH:mm"
        
        let timePicker = UIDatePicker()
        timePicker.datePickerMode = .time
        timePicker.addTarget(self, action: #selector(timePickerValueChanged(sender:)), for: UIControl.Event.valueChanged )
        timePicker.frame.size = CGSize(width: 0, height: 250)

    }
   
    @objc func timePickerValueChanged(sender: UIDatePicker){
        //cuando el tiempo cambie, se pondra aca
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_gb")
        formatter.dateFormat = "HH:mm"
    }

    
    @IBAction func bttnRegistrar(_ sender: UIButton) {
        //Provisional

        let alerta = UIAlertController(title: "Registro Exitoso", message: "Porfavor espere la confirmacion de su coordinador", preferredStyle: .alert)
        let bttnRegistro = UIAlertAction(title: "Continuar", style: .cancel, handler: nil)
                alerta.addAction(bttnRegistro)
        self.present(alerta, animated: true)
    }
    

     
    @IBAction func dateAction(_ sender: Any) {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "hh:mm"
        lbDate.text = dateFormater.string(from: DatePicker.date)
    }
    
    @IBAction func dateAction2(_ sender: Any) {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "hh:mm"
        lbDate2.text = dateFormater.string(from: DatePicker2.date)
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
