//
//  DetailViewController.swift
//  CaritAppLogin
//
//  Created by Alberto Estrada on 22/09/22.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var cambiarFav: UIButton!
    
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var project: UILabel!
    @IBOutlet weak var informacion: UILabel!
    
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var buttonElegirHorario: UIButton!
    
    var bRec:Bool = true
    
    var tituloMostrar: String!
    var imagenMostrar: String!
    var locationMostrar: String!
    var desc: String!
    
    let defaults = UserDefaults.standard
    
    var idVoluntario: Int!
    var idProyecto: Int!
    
    struct Mensaje: Decodable{
        var mensaje: String
    }
    
    @IBAction func addFavoritos(_ sender: Any) {
        self.idVoluntario = defaults.integer(forKey: "idVoluntario")
        self.idProyecto = defaults.integer(forKey: "idProyecto")
       
        cambiarFav.setImage(UIImage(named: "heart.fill"), for: .normal)


        let urlHttps = "https://equipo04.tc2007b.tec.mx:10202/favoritos"
        let url = URL(string: urlHttps)
        var request = URLRequest(url: url!)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-type")
        
        let body: [String: AnyHashable] = ["proyecto_id":self.idProyecto, "voluntario_id":self.idVoluntario,"favorito":1]
        
        let finalBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        request.httpBody = finalBody
        let task = URLSession.shared.dataTask(with: request){
            data, response, error in
            let decoder2 = JSONDecoder()
            do{
                let userEncontrado = try decoder2.decode(Mensaje.self, from: data!)
                DispatchQueue.main.async{
                    print(userEncontrado.mensaje)
                    let alerta = UIAlertController(title: userEncontrado.mensaje, message: "Bien ahi", preferredStyle: .alert)
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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        project.text = tituloMostrar
        image.image = UIImage(named: imagenMostrar)
        informacion.text = desc
        location.text = locationMostrar
        setPopUpButton()
        
        background.layer.cornerRadius = 24
        // Do any additional setup after loading the view.
    }
    
    func setPopUpButton(){
        let optionClosure = {(action : UIAction) in
            print(action.title)}
        
        buttonElegirHorario.menu = UIMenu(children : [
            UIAction(title : "Horario", state : .on, handler: optionClosure),
            UIAction(title : "Horario Matutino", handler: optionClosure),
            UIAction(title : "Horario Despertino", handler: optionClosure)])
        
        buttonElegirHorario.showsMenuAsPrimaryAction = true
        buttonElegirHorario.changesSelectionAsPrimaryAction = true
    }
    
    
    

}
