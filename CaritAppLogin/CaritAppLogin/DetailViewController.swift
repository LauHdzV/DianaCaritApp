//
//  DetailViewController.swift
//  CaritAppLogin
//
//  Created by Alberto Estrada on 22/09/22.
//

import UIKit

class DetailViewController: UIViewController {

    
    @IBOutlet weak var project: UILabel!
    
    @IBOutlet weak var switchFav: UISwitch!
    
    @IBOutlet weak var botonReserva: UIButton!
    
    @IBOutlet weak var popUpHorario: UIButton!

    var datoMostrar: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPopupButton()
        project.text = datoMostrar
        // Do any additional setup after loading the view.
    }
    
    
    
    
    @IBAction func switchPressed(_ sender: Any) {
        if(switchFav.isOn){
            
        }else{
            
        }
            
    }
    
    func setPopupButton(){
        let optionClosure = {(action : UIAction) in print(action.title)}
        popUpHorario.menu = UIMenu(children : [
            UIAction(title : "Cualquier Horario", state : .on, handler: optionClosure),
            UIAction(title : "Horario Matutino 9:00 AM - 12:00 PM", handler: optionClosure),
            UIAction(title : "Horario Despertino 17:00 PM - 21:00 PM", handler: optionClosure)])
        popUpHorario.showsMenuAsPrimaryAction = true
        popUpHorario.changesSelectionAsPrimaryAction = true
    }
    
    
    @IBAction func botonReservaPressed(_ sender: Any) {
        let alerta = UIAlertController(title: "¡Listo!", message: "Tus datos han sido registrados, pronto recibiras confirmación de tu voluntariado", preferredStyle: .alert)
        let botonCancel = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alerta.addAction(botonCancel)
        self.present(alerta, animated: true)
    }
    

}
