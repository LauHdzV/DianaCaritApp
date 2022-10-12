//
//  DetailViewController.swift
//  CaritAppLogin
//
//  Created by Alberto Estrada on 22/09/22.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var project: UILabel!
    @IBOutlet weak var informacion: UILabel!
    
    @IBOutlet weak var buttonElegirHorario: UIButton!
    
    var tituloMostrar: String!
    var imagenMostrar: String!
    var desc: String!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        project.text = tituloMostrar
        image.image = UIImage(named: imagenMostrar)
        informacion.text = desc
        setPopUpButton()
        
        background.layer.cornerRadius = 24
        // Do any additional setup after loading the view.
    }
    
    func setPopUpButton(){
        let optionClosure = {(action : UIAction) in
            print(action.title)}
        
        buttonElegirHorario.menu = UIMenu(children : [
            UIAction(title : "Horario", state : .on, handler: optionClosure),
            UIAction(title : "Horario Matutino", handler: optionClosure),
            UIAction(title : "Horario Despertino", handler: optionClosure)])
        
        buttonElegirHorario.showsMenuAsPrimaryAction = true
        buttonElegirHorario.changesSelectionAsPrimaryAction = true
    }
    
    
    

}
