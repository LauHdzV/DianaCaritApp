//
//  RegisterViewController.swift
//  CaritAppLogin
//
//  Created by Alumno on 06/09/22.
//

import UIKit

class RegisterViewController: UIViewController {
    
    
  
    
    @IBOutlet weak var tfUsuarioReg: UITextField!
    
    @IBOutlet weak var tfEmailReg: UITextField!
    
    @IBOutlet weak var tfContrasenaReg: UITextField!
    
    @IBOutlet weak var tfConfContrasenaReg: UITextField!
    
    struct Mensaje: Decodable{
        let mensaje: String
        let creado: Bool
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func buttonReturnToLogIn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func registrar(_ sender: Any) {
        print("AASDASDAFAEEAEF3AWE")
        let usuarioNombre = tfUsuarioReg.text!
        let usuarioMail = tfEmailReg.text!
        let usuarioContrasena = tfContrasenaReg.text!
        let usuarioConf = tfConfContrasenaReg.text!
        
        if(usuarioContrasena == usuarioConf){
            let urlHttps = "https://equipo04.tc2007b.tec.mx:10202/users"
            let url = URL(string: urlHttps)
            var request = URLRequest(url: url!)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-type")
            let body: [String: AnyHashable] = ["nombre":usuarioNombre, "correo":usuarioMail, "contrasena": usuarioContrasena, "celular":"NULL", "edad":0,"domicilio":"NULL"]
            let finalBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
            request.httpBody = finalBody
            let task = URLSession.shared.dataTask(with: request){
                data, response, error in
                let decoder2 = JSONDecoder()
                do{
                    let userEncontrado = try decoder2.decode(Mensaje.self, from: data!)
                    DispatchQueue.main.async{
                        if userEncontrado.creado == true {
                                    /* REGRESA A SIGN IN  */
                            let alerta = UIAlertController(title: "SI SE CREO USUARIO", message: "Excelente", preferredStyle: .alert)
                            let botonCancel = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                            alerta.addAction(botonCancel)
                            self.present(alerta, animated: true)
                            }else{

                                    // Pop Up Alerta
                                    let alerta = UIAlertController(title: "NO SE CREO USUARIO", message: "Favor de insertar los valores correctos", preferredStyle: .alert)
                                    let botonCancel = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                                    alerta.addAction(botonCancel)
                                    self.present(alerta, animated: true)
                            }
                    }
                }
                catch{
                    print(error)
                }
            }
            task.resume()
        } else {
            let alerta = UIAlertController(title: "NO SE CREO USUARIO", message: "Favor de insertar los valores correctos", preferredStyle: .alert)
            let botonCancel = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alerta.addAction(botonCancel)
            self.present(alerta, animated: true)
        }
        
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
