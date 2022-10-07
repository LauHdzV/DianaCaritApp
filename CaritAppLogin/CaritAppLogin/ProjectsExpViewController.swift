//
//  ProjectsExpViewController.swift
//  CaritAppLogin
//
//  Created by Alberto Estrada on 08/09/22.
//

import UIKit

class ProjectsExpViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    let images = ["alimentos", "ropa", "medicamentos", "emergencia"]
    let titles = ["Banco de alimentos", "Banco de Ropa y Artículos Varios", "Banco de Medicamentos", "Campañas de Emergencia"]
    let location = ["📍San Pedro Garza Garcia, N.L.","📍San Pedro Garza Garcia, N.L.", "📍San Pedro Garza Garcia, N.L.", "📍San Pedro Garza Garcia, N.L."]
    
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

class Post: UICollectionViewCell {
    
    
}
