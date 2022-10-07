//
//  AdminProjectsViewController.swift
//  CaritAppLogin
//
//  Created by Alumno on 29/09/22.
//

import UIKit

class AdminProjectsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let nombres = ["Ricardo", "Jorge", "Diana"]
    let horarios = ["5pm - 7pm", "2pm - 6pm", "2pm - 3pm"]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nombres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "postUno", for: indexPath) as! Post1
        cell.nombre.text = nombres[indexPath.row]
        cell.horario.text = horarios[indexPath.row]
        
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
}

class Post1: UICollectionViewCell{
    
    @IBOutlet weak var nombre: UILabel!
    @IBOutlet weak var horario: UILabel!
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var botonConf: UIButton!
    @IBOutlet weak var botonDec: UIButton!
    
   
    
    
    override func awakeFromNib(){
        background.layer.cornerRadius = 12
    }
}
