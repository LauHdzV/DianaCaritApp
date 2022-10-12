//
//  AdminProjectsViewController.swift
//  CaritAppLogin
//
//  Created by Alumno on 29/09/22.
//

import UIKit

class AdminProjectsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let nombres = ["Ricardo", "Jorge", "Diana", "Alberto"]
    let horarios = ["17:05 pm", "12:12 pm", "9:01 am", "8:00 am"]
    let horarioS = ["20:05 pm", "15:12 pm", "12:01 pm", "11:02"]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nombres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "postUno", for: indexPath) as! Post1
        cell.nombre.text = nombres[indexPath.row]
        cell.horario.text = horarios[indexPath.row]
        cell.horarioS.text = horarioS[indexPath.row]
        
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
    @IBOutlet weak var horarioS: UILabel!
    
    
    override func awakeFromNib(){
        background.layer.cornerRadius = 12
    }
}
