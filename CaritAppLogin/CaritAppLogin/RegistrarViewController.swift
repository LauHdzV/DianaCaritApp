//
//  RegistrarViewController.swift
//  CaritAppLogin
//
//  Created by Alberto Estrada on 06/10/22.
//

import UIKit

class RegistrarViewController: UIViewController {
    
    @IBOutlet weak var background2: UIView!
    @IBOutlet weak var background: UIView!
    
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var DatePicker: UIDatePicker!
    
    @IBOutlet weak var DatePicker2: UIDatePicker!
    
    let defaults = UserDefaults.standard
    
    var idVoluntario: Int!
    var idProyecto: Int!
    var horaInicial: String!
    var horaFinal: String!
    
    var tiempo1:String!
    var tiempo2:String!
    
    var horas1:Float!
    var minutos1:Float!
    var horas2:Float!
    var minutos2:Float!
    
    var totalH:Float!
    var stringTotalH:String!

    
    var imagen: String!
    
    struct Mensaje: Decodable{
        var mensaje: String!
    }
    
    override func viewDidLoad() {

        super.viewDidLoad()
        
        
        image.image = UIImage(named: imagen)
        background2.layer.cornerRadius = 24
        

        let time = Date()
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "fi_Fi")
        formatter.dateFormat = "HH:mm"
        
        let timePicker = UIDatePicker()
        timePicker.datePickerMode = .time
        timePicker.addTarget(self, action: #selector(timePickerValueChanged(sender:)), for: UIControl.Event.valueChanged )
        timePicker.frame.size = CGSize(width: 0, height: 250);
        
        
        self.horaInicial = formatter.string(from: time)
        self.horaFinal = formatter.string(from: time)
        
        /*let now = NSDate()
        let components = gregorian.components([.Hour, .Minute], fromDate: now)
        components.hour = 9
        components.minute = 0
        let newDate = gregorian.dateFrom*/
        
        timePicker.setDate(time, animated: false);
        
        

    }
   
    @objc func timePickerValueChanged(sender: UIDatePicker){
        //cuando el tiempo cambie, se pondra aca
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "fi_Fi")
        formatter.dateFormat = "HH:mm"
    }
    
    

    
    @IBAction func bttnRegistrar(_ sender: UIButton) {
        
        self.idVoluntario = defaults.integer(forKey: "idVoluntario")
        self.idProyecto = defaults.integer(forKey: "idProyecto")
        
        //cambiarFav.setImage(uite(named: "heart.fill"), for: .normal)

        let urlHttps = "https://equipo04.tc2007b.tec.mx:10202/visita"
        let url = URL(string: urlHttps)
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-type")
        
        //print(self.horaProyecto)
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let hoy = dateFormatter.string(from: date)
        
        tiempo1 = self.horaInicial
        tiempo2 = self.horaFinal
        
        
        let arrMH1 = tiempo1.split(separator: ":")
        horas1 = Float(String(arrMH1[0]))
        minutos1 = Float(String(arrMH1[1]))
        minutos1 = minutos1/60
        
        let arrMH2 = tiempo2.split(separator: ":")
        horas2 = Float(String(arrMH2[0]))
        minutos2 = Float(String(arrMH2[1]))
        minutos2 = minutos2/60
        
        totalH = ((horas2 + minutos2) - (horas1 + minutos1))
        print("KKKKKKKKKKKKKKKKKKK")
        print(totalH!)
        
        stringTotalH = String(totalH)
        
        let body : [String: AnyHashable] = ["proyecto_id":self.idProyecto, "voluntario_id":self.idVoluntario, "hora_inicio": self.horaInicial, "hora_salida": self.horaFinal, "dia": hoy, "tiempo": ceil(totalH)]

        let finalBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        request.httpBody = finalBody
        let task = URLSession.shared.dataTask(with: request){
            data, response, error in
            let decoder2 = JSONDecoder()
            do{
                let userEncontrado = try decoder2.decode(Mensaje.self, from: data!)
                DispatchQueue.main.async{
                    print(userEncontrado.mensaje)
                    let alerta = UIAlertController(title: userEncontrado.mensaje, message: "Se han registrado las horas", preferredStyle: .alert)
                    let botonCancel = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alerta.addAction(botonCancel)
                    self.present(alerta, animated: true)
                }
            }
            catch{
                print(error)
            }
        }
        task.resume()
        
        //Provisional

        /*let alerta = UIAlertController(title: "Registro Exitoso", message: "Porfavor espere la confirmacion de su coordinador", preferredStyle: .alert)
        let bttnRegistro = UIAlertAction(title: "Continuar", style: .cancel, handler: nil)
                alerta.addAction(bttnRegistro)
        self.present(alerta, animated: true)*/
    }
    

     
    @IBAction func dateAction(_ sender: Any) {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "HH:mm"
        self.horaInicial = dateFormater.string(from: DatePicker.date)
        print(self.horaInicial)
        /*
        lbDate.text = dateFormater.string(from: DatePicker.date)*/
    }
    
    @IBAction func dateAction2(_ sender: Any) {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "HH:mm"
        self.horaFinal = dateFormater.string(from: DatePicker2.date)
        print(self.horaFinal)
        /*
        lbDate2.text = dateFormater.string(from: DatePicker2.date)*/
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
