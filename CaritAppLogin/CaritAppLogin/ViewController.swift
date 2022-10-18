//
//  ViewController.swift
//  CaritAppLogin
//
//  Created by Alumno on 06/09/22.
//

import UIKit



class ViewController: UIViewController {
    
    @IBOutlet weak var tfUsuario: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var indicatorLogin: UIActivityIndicatorView!
    
    let defaults = UserDefaults.standard

    
    var VoluntarioInicial: Int!
    
    struct Voluntario: Decodable{
        let celular: String
        let contrasena: String
        let correo: String
        let domicilio: String
        let edad: Int
        let id: Int
        let nombre: String
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func apiCall(){
        
        print("*************************")
        var liga = "https://equipo04.tc2007b.tec.mx:10202/users/\(tfUsuario.text!)"
        print("*************************")
        guard let url = URL(string: liga) else {
            print("*************************")
            return
        }
        print("*************************")
        var request = URLRequest(url: url)
        print("*************************")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        let body: [String: AnyHashable] = [
            "correo": tfUsuario.text,
            "contrasena": tfPassword.text
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do{
                let response = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                print("SUCCESS-------------")
            }catch{
                print("ERROR----------------")
            }
        }
        task.resume()
    }
    
    
    
    
    @IBAction func buttonLogIn(_ sender: Any) {
        indicatorLogin.startAnimating()
        btnLogin.isSelected = true
        
        
        //apiCall()
        
        let correoUser = tfUsuario.text!
        let passwordUser = tfPassword.text!
        
        if correoUser == "" || passwordUser == ""   {
            let alerta = UIAlertController(title: "Usuario o Contraseña Incorrecta", message: "Favor de insertar los valores correctos", preferredStyle: .alert)
            let botonCancel = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alerta.addAction(botonCancel)
            self.present(alerta, animated: true)
        }
        
        
        indicatorLogin.startAnimating()
        btnLogin.isSelected = true
        let urlHttps = "https://equipo04.tc2007b.tec.mx:10202/users/\(correoUser)"
        let url = URL(string: urlHttps)
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-type")
        let body: [String: AnyHashable] = ["correo":correoUser, "contrasena":passwordUser]
        let finalBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        request.httpBody = finalBody
        let task = URLSession.shared.dataTask(with: request){
            data, response, error in
            let decoder2 = JSONDecoder()
            do{
                let userEncontrado = try decoder2.decode(Voluntario.self, from: data!)
                DispatchQueue.main.async{
                    //print(userEncontrado.correo)
                    if userEncontrado.correo != "a" {
                        //print("AAAAAAAAAAAAAAAAAAAAA")
                                self.indicatorLogin.stopAnimating()
                                self.btnLogin.isSelected = false
                                self.VoluntarioInicial = userEncontrado.id
                                self.defaults.setValue(userEncontrado.id, forKey: "idVoluntario")
                    
                                self.performSegue(withIdentifier: "loginSegue", sender: nil)
                                
                        
                        }else{
                            //print("BBBBBBBBBBBBBBBBBB")
                                self.indicatorLogin.stopAnimating()
                                self.btnLogin.isSelected = false
                                // Pop Up Alerta
                                let alerta = UIAlertController(title: "Usuario o Contraseña incorrecta", message: "Favor de ingresar los valores correctos", preferredStyle: .alert)
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
        
        /*if hayVoluntario == true {
            delay(2, closure: { () -> () in
                self.indicatorLogin.stopAnimating()
                self.btnLogin.isSelected = false
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            })
        }else{
            delay(2, closure: { () -> () in
                self.indicatorLogin.stopAnimating()
                self.btnLogin.isSelected = false
                // Pop Up Alerta
                let alerta = UIAlertController(title: "Usuario o Contraseña Incorrecta", message: "Favor de insertar los valores correctos", preferredStyle: .alert)
                let botonCancel = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alerta.addAction(botonCancel)
                self.present(alerta, animated: true)
            })
            
        }*/
    }
    
        

}

