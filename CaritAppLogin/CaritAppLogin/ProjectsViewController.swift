//
//  ProjectsViewController.swift
//  CaritAppLogin
//
//  Created by Alberto Estrada on 07/09/22.
//

import UIKit

class ProjectsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    let defaults = UserDefaults.standard
    
    var idVoluntario: Int!
    
    struct Proyecto: Decodable{
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
    
    @IBAction func proyectoSeleccionado(_ sender: Any) {
        
    }
    
    let images = ["alimentos", "ropa", "medicamentos" , "centros", "ducha", "emergencia", "peregrino", "vestido"]
    let titles = ["Banco de alimentos 🍎", "Banco de Ropa 👕", "Banco de Medicamentos 💊", "Reestructuración de Centros 👷🏻‍♂️", "Dignamente Vestido 👔", "Ducha-T 🚿", "Campañas de Emergencia 🏥", "Posada del Peregrino 🛏"]
    let location = ["📍San Pedro Garza Garcia, N.L.","📍San Pedro Garza Garcia, N.L.", "📍San Pedro Garza Garcia, N.L.", "📍San Pedro Garza Garcia, N.L.", "📍San Pedro Garza Garcia, N.L.","📍San Pedro Garza Garcia, N.L.", "📍San Pedro Garza Garcia, N.L.", "📍San Pedro Garza Garcia, N.L."]
    
    let descripcion = ["Servir de enlace entre los donantes y los hermanos que sufren de pobreza, hambre y malnutrición, mejorando su nivel nutricional, optimizando los recursos disponibles y sensibilizando a la comunidad a través de la difusión del espíritu de la caridad.", "Procurar, custodiar y distribuir los donativos en especie de ropa, calzado y artículos varios, y con ello, beneficiar directamente a personas con necesidades básicas de abrigo.", "Gestionar la donación con la industria farmacéutica y brindar un servicio oportuno en la distribución de medicamentos y otros insumos de higiene y salud a sectores de la población con vulnerabilidad social, económica y de salud.", "En Cáritas tenemos más de 200 centros de servicio como: Dispensarios médicos, Comedores, Cáritas Parroquiales, etc. Actividades generales a realizar: Limpiar y pintar los centros de servicio para mantenerlos en buenas condiciones", "Programa que se implementó pensando principalmente en nuestros hermanos migrantes que no cuentan con vestido y calzado en condiciones dignas.", "Programa que va dirigido a personas en situación de calle y migrantes. Consiste en brindar un espacio digno adecuado con regaderas, baños y vestidores, en donde se les proporciona ropa y zapatos en buen estado." ,"Ante situaciones de desastre, Cáritas se solidariza con el hermano que ha sufrido pérdidas materiales y de alimento. Actividades generales a realizar: Recibir, clasificar y seleccionar alimentos y ropa que son donados por la comunidad", "Es un albergue que proporciona servicio asistencial dando alojamiento, alimentación, transportación, asistencia médica y psicológica en forma temporal, a pacientes foráneos de escasos recursos y a sus familiares que acuden a nuestra ciudad en busca de atención médica."]
    
    var listaProyectos = [Proyecto]()
    
    /*func getAllProjects(){
            guard let url = URL(string: "https://equipo04.tc2007b.tec.mx:10202/proyectos/\(idVoluntario)") else { return }
            let task = URLSession.shared.dataTask(with: url){
                data, response, error in
                let decoder2 = JSONDecoder()
                do{
                    let resultadoGeneral = try decoder2.decode([Proyectote].self, from: data!)
                    let Pokelist = resultadoGeneral
                    print("XXXXXXXXXX")
                    for pokeItem in Pokelist{
                        DispatchQueue.main.async {
                            print("ZZZZZZZZZZZZZZZ")
                            self.titlesAPI.append(pokeItem.nombre)
                            self.locationAPI.append(pokeItem.ubicacion)
                            self.descriptionAPI.append(pokeItem.definicion)
                            print(pokeItem.nombre)
                            
                        }
                    }
                }
                catch{
                    print(error)
                }
            }
            task.resume()
        }*/

    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listaProyectos.count
    }
    
    func getAllProjects(){
        self.idVoluntario = defaults.integer(forKey: "idVoluntario")
        let url3 = "https://equipo04.tc2007b.tec.mx:10202/proyectos/\(self.idVoluntario!)"
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
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        /*print("PPPPPPPPPPPPPP")
        
        print("PPPPPPPPPPPPPP")
                        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "post", for: indexPath) as! Post
        cell.image.image = UIImage(named: "alimentos")
        cell.title.text = titlesAPI[indexPath.row]
        cell.location.text = locationAPI[indexPath.row]*/
        
        let titleA = listaProyectos[indexPath.row].nombre
        let ubicacionA = listaProyectos[indexPath.row].ubicacion
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "post", for: indexPath) as! Post
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
        cell.location?.text = ubicacionA
                
        /*let cell = tableView.dequeueReusableCell(withIdentifier: "idCell")
        cell?.textLabel?.text = titleA
        cell?.detailTextLabel?.text = urlPokemon
        cell?.imageView?.image = regresaImagen(urlPokemon)*/

        
        return cell
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getAllProjects()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailProject" {
            if let destino = segue.destination as? DetailViewController, let index = myCollectionView.indexPathsForSelectedItems?.first {
                

                self.defaults.setValue(listaProyectos[index.row].favorito, forKey: "idFavorito")
                destino.tituloMostrar = listaProyectos[index.row].nombre
                destino.desc = listaProyectos[index.row].definicion
                destino.locationMostrar = listaProyectos[index.row].ubicacion
                destino.horarios = listaProyectos[index.row].horarios
                self.defaults.setValue(listaProyectos[index.row].proyecto_id, forKey: "idProyecto")

    
                if listaProyectos[index.row].nombre == "Banco de Alimentos" {
                    destino.imagenMostrar = "alimentos"
                }
                if listaProyectos[index.row].nombre == "Banco de Ropa" {
                    destino.imagenMostrar = "ropa"
                }
                if listaProyectos[index.row].nombre == "Banco de Medicamentos" {
                    destino.imagenMostrar = "medicamentos"
                }
                if listaProyectos[index.row].nombre == "Reestructuracion de Centros" {
                    destino.imagenMostrar = "centros"
                }
                if listaProyectos[index.row].nombre == "Dignamente Vestido" {
                    destino.imagenMostrar = "vestido"
                }
                if listaProyectos[index.row].nombre == "Ducha-T" {
                    destino.imagenMostrar = "ducha"
                }
                if listaProyectos[index.row].nombre == "Campañas de Emergencia" {
                    destino.imagenMostrar = "emergencia"
                }
                if listaProyectos[index.row].nombre == "Posada del Peregrino" {
                    destino.imagenMostrar = "peregrino"
                }
            }
        }
        
        
    }
}
        
        
    

class Post: UICollectionViewCell {
    
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var location: UILabel!
    
    override func awakeFromNib() {
        background.layer.cornerRadius = 12
        image.layer.cornerRadius = 12
    }
}
