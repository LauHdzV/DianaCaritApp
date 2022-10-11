//
//  ProjectsViewController.swift
//  CaritAppLogin
//
//  Created by Alberto Estrada on 07/09/22.
//

import UIKit

class ProjectsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    @IBAction func proyectoSeleccionado(_ sender: Any) {
    }
    
    
    
    let images = ["alimentos", "ropa", "medicamentos", "centros", "vestido", "ducha", "emergencia", "peregrino"]
    let titles = ["Banco de alimentos 🍎", "Banco de Ropa 👕", "Banco de Medicamentos 💊", "Reestructuración de Centros 👷🏻‍♂️", "Dignamente Vestido 👔", "Ducha-T 🚿", "Campañas de Emergencia 🏥", "Posada del Peregrino 🛏"]
    let location = ["📍San Pedro Garza Garcia, N.L.","📍San Pedro Garza Garcia, N.L.", "📍San Pedro Garza Garcia, N.L.", "📍San Pedro Garza Garcia, N.L.", "📍San Pedro Garza Garcia, N.L.","📍San Pedro Garza Garcia, N.L.", "📍San Pedro Garza Garcia, N.L.", "📍San Pedro Garza Garcia, N.L."]
    
    let descripcion = ["Servir de enlace entre los donantes y los hermanos que sufren de pobreza, hambre y malnutrición, mejorando su nivel nutricional, optimizando los recursos disponibles y sensibilizando a la comunidad a través de la difusión del espíritu de la caridad.", "Procurar, custodiar y distribuir los donativos en especie de ropa, calzado y artículos varios, y con ello, beneficiar directamente a personas con necesidades básicas de abrigo.", "Gestionar la donación con la industria farmacéutica y brindar un servicio oportuno en la distribución de medicamentos y otros insumos de higiene y salud a sectores de la población con vulnerabilidad social, económica y de salud.", "En Cáritas tenemos más de 200 centros de servicio como: Dispensarios médicos, Comedores, Cáritas Parroquiales, etc. Actividades generales a realizar: Limpiar y pintar los centros de servicio para mantenerlos en buenas condiciones", "Programa que se implementó pensando principalmente en nuestros hermanos migrantes que no cuentan con vestido y calzado en condiciones dignas.", "Programa que va dirigido a personas en situación de calle y migrantes. Consiste en brindar un espacio digno adecuado con regaderas, baños y vestidores, en donde se les proporciona ropa y zapatos en buen estado." ,"Ante situaciones de desastre, Cáritas se solidariza con el hermano que ha sufrido pérdidas materiales y de alimento. Actividades generales a realizar: Recibir, clasificar y seleccionar alimentos y ropa que son donados por la comunidad", "Es un albergue que proporciona servicio asistencial dando alojamiento, alimentación, transportación, asistencia médica y psicológica en forma temporal, a pacientes foráneos de escasos recursos y a sus familiares que acuden a nuestra ciudad en busca de atención médica."]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "post", for: indexPath) as! Post
        cell.image.image = UIImage(named: images[indexPath.row])
        cell.title.text = titles[indexPath.row]
        cell.location.text = location[indexPath.row]
        
        return cell
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "detailProject" {
            if let destino = segue.destination as? DetailViewController, let index = myCollectionView.indexPathsForSelectedItems?.first {
                destino.tituloMostrar = titles[index.row]
                destino.imagenMostrar = images[index.row]
                destino.desc = descripcion[index.row]
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
