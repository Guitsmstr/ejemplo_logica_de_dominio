//
//  ModifyPopUpViewController.swift
//  Ejemplo Lógica de Dominio
//
//  Created by danielapps on 19/07/21.
//

import UIKit

class ModifyPopUpViewController : UIViewController {
    
    var onModify:((_ data: String)->())?
    @IBOutlet weak var modifyTextField: UITextField!
    
    
    @IBAction func modifyPopUpButtonPressed(_ sender: UIButton) {
        if let nameModify = modifyTextField.text {
            onModify?(nameModify)
            
            dismiss(animated: true)
        }
    }
    
    @IBAction func cancelPopUpButtonPressed(_ sender: UIButton) {
        dismiss(animated:true)
    }
    
    
    
}
