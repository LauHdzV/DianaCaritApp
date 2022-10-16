//
//  MyProjectsViewController.swift
//  CaritAppLogin
//
//  Created by Alberto Estrada on 07/09/22.
//

import UIKit

class MyProjectsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    let images = ["alimentos"]
    let titles = ["Banco de Ropa"]
    let dates = ["9:00 am - 11:00 am Lun Mar Mie Jue Vie"]
    
    @IBOutlet weak var MyCollectionView: UICollectionView!
    let defaults = UserDefaults.standard
    var idVoluntario: Int!
    var listaProyectos = [Proyecto2]()
    var idProyecto: Int!
    
    struct Proyecto2: Decodable{
        let calificacion: Double
        let definicion: String
        let favorito: Int
        let fecha_final: String
        let fecha_inicio: String
        let horario: String
        let horas_cumplidas: Int
        let horas_totales: Int
        let id: Int
        let nombre: String
        let postulado: Int
        let proyecto_id: Int
        let qrlink: String
        let responsable_id: Int
        let ubicacion: String
        let validado: Int
        let voluntario_id: Int
        let horarios: String
        
    }
    
    lazy var refreshControl:UIRefreshControl = {
        let refresControl = UIRefreshControl()
        refresControl.addTarget(self, action: #selector(MyProjectsViewController.actualizarDatos(_:)), for: .valueChanged)
        refresControl.tintColor = UIColor.caritasGris
        return refresControl
    }()
    
    @objc func actualizarDatos(_ refresControl: UIRefreshControl) {
        
        getAllProjects()
        
        self.MyCollectionView.reloadData()
        refresControl.endRefreshing()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listaProyectos.count
    }
    
    func getAllProjects(){
        self.listaProyectos = []
        self.idVoluntario = defaults.integer(forKey: "idVoluntario")
        let url3 = "https://equipo04.tc2007b.tec.mx:10202/proyectos/\(self.idVoluntario!)"
        guard let url = URL(string: url3) else { return }
        
        let group = DispatchGroup()
        group.enter()
        
        //print("WWWWWWWWWWWWWWWWWWWW")
        let task = URLSession.shared.dataTask(with: url){
            data, response, error in
            let decoder2 = JSONDecoder()
            //print("JJJJJJJJJJJJJJJJJ")
            
            do{
                //print("JJJJJJJJJJJJJJJJJ")
                let resultadoGeneral = try decoder2.decode([Proyecto2].self, from: data!)
                let Pokelist = resultadoGeneral
                for itemA in Pokelist{
                    if itemA.validado == 1{
                        self.listaProyectos.append(itemA)
                    }
                }
                //print("XXXXXXXXXX")
                group.leave()
                // self.listaProyectos = Pokelist
                
            }
            catch{
                print(error)
            }
            
        }
        task.resume()
        group.wait()
        MyCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let titleA = listaProyectos[indexPath.row].nombre
        let ubicacionA = listaProyectos[indexPath.row].horario
        
        print(titleA)
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "post5", for: indexPath) as! Post5
        
        if titleA == "Banco de Alimentos" {
            cell.image?.image = UIImage(named: "alimentos")
        }
        if titleA == "Banco de Ropa" {
            cell.image?.image = UIImage(named: "ropa")
        }
        if titleA == "Banco de Medicamentos" {
            cell.image?.image = UIImage(named: "medicamentos")
        }
        if titleA == "Reestructuracion de Centros" {
            cell.image?.image = UIImage(named: "centros")
        }
        if titleA == "Dignamente Vestido" {
            cell.image?.image = UIImage(named: "vestido")
        }
        if titleA == "Ducha-T" {
            cell.image?.image = UIImage(named: "ducha")
        }
        if titleA == "Campañas de Emergencia" {
            cell.image?.image = UIImage(named: "emergencia")
        }
        if titleA == "Posada del Peregrino" {
            cell.image?.image = UIImage(named: "peregrino")
        }
        cell.title?.text = titleA
        cell.date?.text = ubicacionA
        
        return cell
        /*let celli = collectionView.dequeueReusableCell(withReuseIdentifier: "post5", for: indexPath) as! Post5
         celli.image.image = UIImage(named: images[indexPath.row])
         celli.title.text = titles[indexPath.row]
         celli.date.text = dates[indexPath.row]
         
         return celli*/
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getAllProjects()
        
        self.MyCollectionView.addSubview(self.refreshControl)
        // Do any additional setup after loading the view.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailProject22" {
            if let destino = segue.destination as? RegistrarViewController, let index = MyCollectionView.indexPathsForSelectedItems?.first {
                
                self.defaults.setValue(listaProyectos[index.row].favorito, forKey: "idFavorito")
                //print(listaProyectos[index.row].favorito)
                //destino.tituloMostrar = listaProyectos[index.row].nombre
                self.defaults.setValue(listaProyectos[index.row].proyecto_id, forKey: "idProyecto")
                //print("------XXXXXXXXXXXXXXRRRRRRRRRRR------")
                //print(listaProyectos[index.row])
                      
                if listaProyectos[index.row].nombre == "Banco de Alimentos" {
                    destino.imagen = "alimentos"
                }
                if listaProyectos[index.row].nombre == "Banco de Ropa" {
                    destino.imagen = "ropa"
                }
                if listaProyectos[index.row].nombre == "Banco de Medicamentos" {
                    destino.imagen = "medicamentos"
                }
                if listaProyectos[index.row].nombre == "Reestructuracion de Centros" {
                    destino.imagen = "centros"
                }
                if listaProyectos[index.row].nombre == "Dignamente Vestido" {
                    destino.imagen = "vestido"
                }
                if listaProyectos[index.row].nombre == "Ducha-T" {
                    destino.imagen = "ducha"
                }
                if listaProyectos[index.row].nombre == "Campañas de Emergencia" {
                    destino.imagen = "emergencia"
                }
                if listaProyectos[index.row].nombre == "Posada del Peregrino" {
                    destino.imagen = "peregrino"
                }
            }
        }
        
    }
}
    class Post5: UICollectionViewCell {
        
        @IBOutlet weak var background: UIView!
        @IBOutlet weak var image: UIImageView!
        
        @IBOutlet weak var title: UILabel!
        
        
        @IBOutlet weak var date: UILabel!
        override func awakeFromNib() {
            background.layer.cornerRadius = 12
            image.layer.cornerRadius = 12
        }
    }
    
