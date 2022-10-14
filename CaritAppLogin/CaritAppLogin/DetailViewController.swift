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
    var horarios: String!
    
    let defaults = UserDefaults.standard
    
    var idVoluntario: Int!
    var idProyecto: Int!
    var idFavorito: Int!
    var horaProyecto: String!
    
    struct Mensaje: Decodable{
        var mensaje: String
        var status: String
    }
    
    struct MensajePostular: Decodable{
        var mensaje: String
    }
    
    @IBAction func Postular(_ sender: Any) {
        self.idVoluntario = defaults.integer(forKey: "idVoluntario")
        self.idProyecto = defaults.integer(forKey: "idProyecto")
        
        //cambiarFav.setImage(uite(named: "heart.fill"), for: .normal)

        let urlHttps = "https://equipo04.tc2007b.tec.mx:10202/participacion"
        let url = URL(string: urlHttps)
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-type")
        
        //print(self.horaProyecto)
        
        let body : [String: AnyHashable] = ["voluntario_id":self.idVoluntario, "proyecto_id":self.idProyecto,"horario": self.horaProyecto]

        let finalBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        request.httpBody = finalBody
        let task = URLSession.shared.dataTask(with: request){
            data, response, error in
            let decoder2 = JSONDecoder()
            do{
                let userEncontrado = try decoder2.decode(MensajePostular.self, from: data!)
                DispatchQueue.main.async{
                    //print(userEncontrado.mensaje)
                    let alerta = UIAlertController(title: userEncontrado.mensaje, message: "Tu estado en el proyecto ha camiado", preferredStyle: .alert)
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
    
    @IBAction func addFavoritos(_ sender: Any) {
        self.idVoluntario = defaults.integer(forKey: "idVoluntario")
        self.idProyecto = defaults.integer(forKey: "idProyecto")
        self.idFavorito = defaults.integer(forKey: "idFavorito")
        
       
        //cambiarFav.setImage(uite(named: "heart.fill"), for: .normal)

        let urlHttps = "https://equipo04.tc2007b.tec.mx:10202/favoritos"
        let url = URL(string: urlHttps)
        var request = URLRequest(url: url!)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-type")
        
        var body : [String: AnyHashable] = ["proyecto_id":self.idProyecto, "voluntario_id":self.idVoluntario,"favorito":0]
        
        if self.idFavorito == 1{
            body = ["proyecto_id":self.idProyecto, "voluntario_id":self.idVoluntario,"favorito":0]
            self.defaults.setValue(0, forKey: "idFavorito")
            cambiarFav.setTitle("Agregar Favorito", for: .normal)
        } else {
            body = ["proyecto_id":self.idProyecto, "voluntario_id":self.idVoluntario,"favorito":1]
            self.defaults.setValue(1, forKey: "idFavorito")
            cambiarFav.setTitle("Quitar favoritos", for: .normal)
        }
        
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
        
        self.idFavorito = defaults.integer(forKey: "idFavorito")
        print(self.idFavorito!)
                
        if self.idFavorito! == 1{
            cambiarFav.setTitle("Quitar Favoritos", for: .normal)
        } else {
            cambiarFav.setTitle("Agregar Favorito", for: .normal)
        }
        // Do any additional setup after loading the view.
    }
    
    func setPopUpButton(){
        
        print("AHUUUUUUUUU")
        
        let horariosArray : [String] = horarios.components(separatedBy: "/")

        let optionClosure = {(action : UIAction) in self.horaProyecto = self.buttonElegirHorario.currentTitle}
        
        var newArr : [UIAction] = []
        
        for (index, element) in horariosArray.enumerated(){
            if index == 0{
                newArr.append(UIAction(title:horariosArray[index], state: .on, handler: optionClosure))
            } else {
                newArr.append(UIAction(title:horariosArray[index], handler: optionClosure))
            }
        }
        
        buttonElegirHorario.menu = UIMenu(children : newArr)
        print("ABCDEFGHIJK")
        self.horaProyecto = buttonElegirHorario.currentTitle
        print("ABCDEFGHIJK")

        buttonElegirHorario.showsMenuAsPrimaryAction = true
        buttonElegirHorario.changesSelectionAsPrimaryAction = true
    }
    
    
    

}
