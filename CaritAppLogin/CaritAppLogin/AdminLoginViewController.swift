//
//  AdminLoginViewController.swift
//  CaritAppLogin
//
//  Created by Alberto Estrada on 14/10/22.
//

import UIKit

class AdminLoginViewController: UIViewController {

    
    @IBOutlet weak var user: UITextField!
    
    @IBOutlet weak var pass: UITextField!
    
    let defaults = UserDefaults.standard
    var adminId: Int!
    
    
    struct Admin: Decodable{
        let id: Int!
        let nombre: String!
        let correo: String!
        let contrasena: String!
        let celular: String!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func login(_ sender: Any) {
        //apiCall()
        
        let correoUser = user.text!
        let passwordUser = pass.text!
                
        if correoUser == "" || passwordUser == ""   {
            let alerta = UIAlertController(title: "Usuario o Contraseña Incorrecta", message: "Favor de insertar los valores correctos", preferredStyle: .alert)
            let botonCancel = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alerta.addAction(botonCancel)
            self.present(alerta, animated: true)
        }
        
        print(correoUser)
        print(passwordUser)

        let urlHttps = "https://equipo04.tc2007b.tec.mx:10202/admin/\(correoUser)"
        print("HHHHHHHHHHHHHHHHH")
        print(urlHttps)
        let url = URL(string: urlHttps)
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-type")
        let body: [String: AnyHashable] = ["correo":correoUser, "contrasena":passwordUser]
        print(body)
        let finalBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        request.httpBody = finalBody
        print("OOOOOOOOOOOOOOO")

        let task = URLSession.shared.dataTask(with: request){
            data, response, error in
            let decoder2 = JSONDecoder()
            do{
                print("OOOOOOOOOOOOOOO")

                let userEncontrado = try decoder2.decode(Admin.self, from: data!)
                print(userEncontrado.correo)
                DispatchQueue.main.async{
                    //print(userEncontrado.correo)
                    
                    if userEncontrado.correo != "a" {
                        print("AAAAAAAAAAAAAAAAAAAAA")
                                self.adminId = userEncontrado.id
                                self.defaults.setValue(userEncontrado.id, forKey: "idAdmin")
                    
                                self.performSegue(withIdentifier: "loginSegueA", sender: nil)
                                
                        }else{
                            //print("BBBBBBBBBBBBBBBBBB")
                            
                                // Pop Up Alerta
                                let alerta = UIAlertController(title: "Usuario o Contraseña Incorrecta", message: "Favor de insertar los valores correctos", preferredStyle: .alert)
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
