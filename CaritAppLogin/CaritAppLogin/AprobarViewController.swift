//
//  AprobarViewController.swift
//  CaritAppLogin
//
//  Created by Yuxian Li on 11/10/22.
//

import UIKit

class AprobarViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    let defaults = UserDefaults.standard

    
    let images = ["alimentos", "ropa", "medicamentos" , "centros", "ducha", "emergencia", "peregrino", "vestido"]
    struct Proyecto: Decodable{
        let calificacion: Double
        let definicion: String
        let horarios: String
        let id: Int
        let nombre: String
        let responsable_id: Int
        let ubicacion: String

    }
    
    var listaProyectos = [Proyecto]()
    var idAdmin: Int!

    func getAllProjects(){
        self.idAdmin = defaults.integer(forKey: "idAdmin")
        let url3 = "https://equipo04.tc2007b.tec.mx:10202/proyectos-responsable/\(self.idAdmin!)"
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
                let resultadoGeneral = try decoder2.decode([Proyecto].self, from: data!)
                let Pokelist = resultadoGeneral
                print("XXXXXXXXXX")
                self.listaProyectos = Pokelist
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
        return listaProyectos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let titleA = listaProyectos[indexPath.row].nombre
        let ubicacionA = listaProyectos[indexPath.row].ubicacion
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "post12", for: indexPath) as! Post12
       
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
        cell.pTitle?.text = titleA
        cell.pDir?.text = ubicacionA
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        getAllProjects()

        // Do any additional setup after loading the view.
    }
    

}

class Post12: UICollectionViewCell{
    
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var pTitle: UILabel!
    @IBOutlet weak var pDir: UILabel!
    
    override func awakeFromNib() {
        background.layer.cornerRadius = 12
        image.layer.cornerRadius = 12
    }
    
    
}
