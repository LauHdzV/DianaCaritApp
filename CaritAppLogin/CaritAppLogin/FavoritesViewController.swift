//
//  FavoritesViewController.swift
//  CaritAppLogin
//
//  Created by Alberto Estrada on 07/09/22.
//

import UIKit

class FavoritesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    let images = ["vestido", "ducha"]
    let titles = ["Dignamente Vestido 👔", "Ducha-T 🚿"]
    let location = ["San Pedro Garza Garcia, N.L.","San Pedro Garza Garcia, N.L."]
    let descripcion = ["Programa que se implementó pensando principalmente en nuestros hermanos migrantes que no cuentan con vestido y calzado en condiciones dignas.", "Programa que va dirigido a personas en situación de calle y migrantes. Consiste en brindar un espacio digno adecuado con regaderas, baños y vestidores, en donde se les proporciona ropa y zapatos en buen estado."]

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "post2", for: indexPath) as! Post2
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
        
        if segue.identifier == "detailProject1" {
            if let destino = segue.destination as? DetailViewController, let index = myCollectionView.indexPathsForSelectedItems?.first {
                destino.tituloMostrar = titles[index.row]
                destino.imagenMostrar = images[index.row]
                destino.desc = descripcion[index.row]
            }
        }
        
        
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

class Post2: UICollectionViewCell {
    
    
    @IBOutlet weak var background: UIView!
    
    @IBOutlet weak var image: UIImageView!
    
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var location: UILabel!
    
    override func awakeFromNib() {
        background.layer.cornerRadius = 12
        image.layer.cornerRadius = 20
        
    }
}
