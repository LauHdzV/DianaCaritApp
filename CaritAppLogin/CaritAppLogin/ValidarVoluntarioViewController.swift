//
//  ValidarVoluntarioViewController.swift
//  CaritAppLogin
//
//  Created by Alberto Estrada on 14/10/22.
//

import UIKit

class ValidarVoluntarioViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    
    let nombres = ["Alberto", "Jorge", "Diana", "Ricardo", "Eduardo"]
    let emails = ["Alberto@gmail.com", "Jorge@gmail.com", "Diana@gmail.com", "Ricardo@gmail.com", "Eduardo@gmail.com"]
    
    struct Postulacion: Decodable{
        var correo: String!
        var favorito: Int!
        var fecha_final: String!
        var fecha_inicio: String!
        var horario: String!
        var horas_cumplidas: Float!
        var horas_totales: Float!
        var id: Int!
        var nombre: String!
        var postulado: Int!
        var proyecto_id: Int!
        var qrlink: String!
        var validado: Int!
        var voluntario_id: Int!
        
    }
    
    struct Mensaje: Decodable{
        var mensaje: String!
    }
    
    let defaults = UserDefaults.standard
    var listaPostulados = [Postulacion]()
    var idAdmin: Int!
    var idVisita: Int!
    var idProyectoAdmin: Int!
    
    lazy var refreshControl:UIRefreshControl = {
        let refresControl = UIRefreshControl()
        refresControl.addTarget(self, action: #selector(FavoritesViewController.actualizarDatos(_:)), for: .valueChanged)
        refresControl.tintColor = UIColor.caritasGris
        return refresControl
    }()
    
    @objc func actualizarDatos(_ refresControl: UIRefreshControl) {
        
        getAllPostulados()
        
        self.myCollectionView.reloadData()
        refresControl.endRefreshing()
        
    }
    
    func getAllPostulados(){
    

        let url3 = "https://equipo04.tc2007b.tec.mx:10202/postulados/\(self.idProyectoAdmin!)"
        print(url3)
        guard let url = URL(string: url3) else { return }
        
        let group = DispatchGroup()
        group.enter()
        
        let task = URLSession.shared.dataTask(with: url){
            data, response, error in
            let decoder2 = JSONDecoder()

            do{
                print("JJJJJJJJJJJJJJJJJ")
                let resultadoGeneral = try decoder2.decode([Postulacion].self, from: data!)
                let Pokelist = resultadoGeneral
                print("XXXXXXXXXX")
                self.listaPostulados = Pokelist
                group.leave()

            }
            catch{
                print(error)
            }
        }
        task.resume()
        group.wait()
        myCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listaPostulados.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "post20", for: indexPath) as! Post20
        cell.nombre.text = nombres[indexPath.row]
        cell.email.text = emails[indexPath.row]
        
        let nombreUser = listaPostulados[indexPath.row].nombre
        let correoUser = listaPostulados[indexPath.row].correo

        cell.nombre?.text = nombreUser
        cell.email?.text = correoUser
      
        return cell
    }
    
    
    @IBAction func confirmar(_ sender: Any) {
        if let index = myCollectionView.indexPathsForSelectedItems?.first {
            let manuel = (listaPostulados[index.row].id)!
            print("rrrrrrrrrr")
            print(manuel)
            
            let urlHttps = "https://equipo04.tc2007b.tec.mx:10202/participacion"
            print(urlHttps)
            let url = URL(string: urlHttps)
            var request = URLRequest(url: url!)
            request.httpMethod = "PUT"
            request.setValue("application/json", forHTTPHeaderField: "Content-type")
            let body : [String: AnyHashable] = ["participacion_id": manuel]

            let finalBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
            request.httpBody = finalBody
            
            print("UUUUUUUUUUUUUUU")

            
            
            let task = URLSession.shared.dataTask(with: request){
                data, response, error in
                let decoder2 = JSONDecoder()
                do{
                    print("UUUUUUUUUUUUUUU")

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
        
    }
    
    @IBAction func declinar(_ sender: Any) {
        
        if let index = myCollectionView.indexPathsForSelectedItems?.first {
            let manuel = (listaPostulados[index.row].id)!
            print("rrrrrrrrrr")
            print(manuel)
            
            let urlHttps = "https://equipo04.tc2007b.tec.mx:10202/canparticipacion"
            print(urlHttps)
            
            let url = URL(string: urlHttps)
            var request = URLRequest(url: url!)
            request.httpMethod = "PUT"
            request.setValue("application/json", forHTTPHeaderField: "Content-type")
            let body : [String: AnyHashable] = ["participacion_id": manuel]

            let finalBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
            request.httpBody = finalBody
            
            print("UUUUUUUUUUUUUUU")
            
            
            
            let task = URLSession.shared.dataTask(with: request){
                data, response, error in
                let decoder2 = JSONDecoder()
                do{
                    print("UUUUUUUUUUUUUUU")
                    
                    let userEncontrado = try decoder2.decode(Mensaje.self, from: data!)
                    DispatchQueue.main.async{
                        print(userEncontrado.mensaje)
                        let alerta = UIAlertController(title: userEncontrado.mensaje, message: "Mal ahi", preferredStyle: .alert)
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
         
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getAllPostulados()
        self.myCollectionView.addSubview(self.refreshControl)
    }
}

class Post20: UICollectionViewCell{
    
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var nombre: UILabel!
    @IBOutlet weak var btnConf: UIButton!
    @IBOutlet weak var btnDec: UIButton!
    
    @IBOutlet weak var email: UILabel!
    
    override func awakeFromNib() {
        background.layer.cornerRadius = 12
    }
    
    
}
