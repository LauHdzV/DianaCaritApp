//
//  RegisterViewController.swift
//  CaritAppLogin
//
//  Created by Alumno on 06/09/22.
//

import UIKit

class RegisterViewController: UIViewController {
    
    
    @IBOutlet weak var tfUsuarioReg: UITextField!
    
    @IBOutlet weak var tfEmailReg: UITextField!
    
    @IBOutlet weak var tfContrasenaReg: UITextField!
    
    @IBOutlet weak var tfConfContrasenaReg: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func buttonReturnToLogIn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
