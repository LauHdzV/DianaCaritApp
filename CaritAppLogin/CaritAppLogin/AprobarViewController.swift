//
//  AprobarViewController.swift
//  CaritAppLogin
//
//  Created by Yuxian Li on 11/10/22.
//

import UIKit

class AprobarViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let images = ["alimentos", "ropa", "medicamentos", "emergencia"]
    let titles = ["Banco de alimentos", "Banco de Ropa", "Banco de Medicamentos", "Campañas de Emergencia"]
    let location = ["Lun Mar Mie 9:00 am a 10:00 am","Lun Jue Vie 10:00 am a 11:00 am", "Mie Jue Vie 11:00 am a 12:00 pm", "Mar Mie Jue 13:00 pm a 14:00 pm"]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cel = collectionView.dequeueReusableCell(withReuseIdentifier: "post12", for: indexPath) as! Post12
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