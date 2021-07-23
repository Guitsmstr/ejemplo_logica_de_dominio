//
//  PopUpViewController.swift
//  Ejemplo Lógica de Dominio
//
//  Created by danielapps on 19/07/21.
//

import UIKit

class AddPopUpViewController : UIViewController {
    
    var onSave: ((_ data: String) -> ())?
    @IBOutlet weak var itemNameTextField: UITextField!
    
    
    
    @IBAction func addPopUpButtonPressed(_ sender: UIButton) {
        
        if let itemName = itemNameTextField.text {
            onSave?(itemName)
        }
        
        dismiss(animated: true)
    }
    
    @IBAction func cancelPopUpButtonPressed(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
}
