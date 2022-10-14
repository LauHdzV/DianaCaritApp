//
//  AdminProjectsViewController.swift
//  CaritAppLogin
//
//  Created by Alumno on 29/09/22.
//

import UIKit

class AdminProjectsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    

    @IBOutlet weak var myViewController: UICollectionView!
    let nombres = ["Ricardo", "Jorge", "Diana", "Alberto"]
    let horarios = ["17:05 pm", "12:12 pm", "9:01 am", "8:00 am"]
    let horarioS = ["20:05 pm", "15:12 pm", "12:01 pm", "11:02"]

    struct Visita: Decodable{
        var dia: String!
        var hora_inicio: String!
        var hora_salida: String!
        var id: Int!
        var nombre: String!
        var proyecto_id: Int!
        var tiempo: Float!
        var validado: Int!
        var voluntario_id: Int!
    }
    
    let defaults = UserDefaults.standard
    var listaVisita = [Visita]()
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
        
        getAllVisitas()
        
        self.myViewController.reloadData()
        refresControl.endRefreshing()
        
    }
    
    func getAllVisitas(){
    

        let url3 = "https://equipo04.tc2007b.tec.mx:10202/visita/\(self.idProyectoAdmin!)"
        print(url3)
        guard let url = URL(string: url3) else { return }
        
        let group = DispatchGroup()
        group.enter()
        
        print("WWWWWWWWWWWWWWWWWWWW")
        let task = URLSession.shared.dataTask(with: url){
            data, response, error in
            let decoder2 = JSONDecoder()
            print("JJJJJJJJJJJJJJJJJ")

            do{
                print("JJJJJJJJJJJJJJJJJ")
                let resultadoGeneral = try decoder2.decode([Visita].self, from: data!)
                let Pokelist = resultadoGeneral
                print("XXXXXXXXXX")
                self.listaVisita = Pokelist
                group.leave()

            }
            catch{
                print(error)
            }
        }
        task.resume()
        group.wait()
        myViewController.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listaVisita.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let horaInicio = listaVisita[indexPath.row].hora_inicio
        let horaSalida = listaVisita[indexPath.row].hora_salida
        let nombreUser = listaVisita[indexPath.row].nombre
        let fecha = listaVisita[indexPath.row].dia


        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "postUno", for: indexPath) as! Post1
        cell.nombre?.text = nombreUser
        cell.horario?.text = horaInicio
        cell.horarioS?.text = horaSalida
        cell.fecha?.text = fecha
      
          
        return cell
    }
    

    @IBAction func confirmar(_ sender: Any) {
        print("IIIIIIIIIIIIIIII")
        

        /*let indexPath = self.myViewController.indexPathsForSelectedItems?.last ?? IndexPath(item: 0, section: 0)
        self.myViewController.selectItem(at: indexPath, animated: false, scrollPosition: UICollectionView.ScrollPosition.centeredHorizontally)
         */
        /*let indexS = myViewController.indexPathsForSelectedItems?first
        self.idVisita = listaVisita[indexS!.row].id
        
        print(self.idVisita)*/
        
        /*self.idVoluntario = defaults.integer(forKey: "idVoluntario")
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
        task.resume()*/
        
    }
    
    @IBAction func declinar(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllVisitas()
        // Do any additional setup after loading the view.
        self.myViewController.addSubview(self.refreshControl)

    }
    
    
    
}

class Post1: UICollectionViewCell{
    
    @IBOutlet weak var nombre: UILabel!
    @IBOutlet weak var horario: UILabel!
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var botonConf: UIButton!
    @IBOutlet weak var botonDec: UIButton!   
    @IBOutlet weak var horarioS: UILabel!
    
    
    @IBOutlet weak var fecha: UILabel!
    
    override func awakeFromNib(){
        background.layer.cornerRadius = 12
    }
}
