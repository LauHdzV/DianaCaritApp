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
                destino.datoMostrar = titles[index.row]
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
