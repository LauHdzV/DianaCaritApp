//
//  ValidarVoluntarioViewController.swift
//  CaritAppLogin
//
//  Created by Alberto Estrada on 14/10/22.
//

import UIKit

class ValidarVoluntarioViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let nombres = ["Alberto", "Jorge", "Diana", "Ricardo", "Eduardo"]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nombres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "post20", for: indexPath) as! Post20
        cell.nombre.text = nombres[indexPath.row]
        
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

class Post20: UICollectionViewCell{
    
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var nombre: UILabel!
    @IBOutlet weak var btnConf: UIButton!
    @IBOutlet weak var btnDec: UIButton!
    
    override func awakeFromNib() {
        background.layer.cornerRadius = 12
    }
    
    
}
