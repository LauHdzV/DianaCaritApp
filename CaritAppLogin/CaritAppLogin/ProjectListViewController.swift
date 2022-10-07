//
//  ProjectListViewController.swift
//  CaritAppLogin
//
//  Created by Alberto Estrada on 06/10/22.
//

import UIKit

class ProjectListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let images = ["alimentos", "ropa", "medicamentos", "emergencia"]
    let titles = ["Banco de alimentos", "Banco de Ropa", "Banco de Medicamentos", "Campañas de Emergencia"]
    let location = ["LU MA MI 9:00 am a 10:00 am","LU JU VI 10:00 am a 11:00 am", "MI JU VI 11:00 am a 12:00 pm", "MA MI JU 13:00 pm a 14:00 pm"]
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cel = collectionView.dequeueReusableCell(withReuseIdentifier: "post10", for: indexPath) as! Post10
        cel.image.image = UIImage(named: images[indexPath.row])
        cel.pTitle.text = titles[indexPath.row]
        cel.pDir.text = location[indexPath.row]
        return cel
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

class Post10: UICollectionViewCell{
    
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var pTitle: UILabel!
    @IBOutlet weak var pDir: UILabel!
    
    override func awakeFromNib() {
        background.layer.cornerRadius = 12
        image.layer.cornerRadius = 12
    }
    
}
