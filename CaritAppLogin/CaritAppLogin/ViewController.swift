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
        
        apiCall()
        
        if tfUsuario.text == "user" && tfPassword.text == "123"{
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
            
        }
    }
    

}

