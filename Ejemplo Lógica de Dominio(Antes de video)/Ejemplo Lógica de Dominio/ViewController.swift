//
//  ViewController.swift
//  Ejemplo Lógica de Dominio
//
//  Created by danielapps on 19/07/21.
//

/* Ya creo que funciona todo, solo me falto algo en el modifyPopUpView
 queria pasarle el nombre del item seleccionado.
 No puse constrains al layout*/

import UIKit

class ViewController: UIViewController {
    var selectedRowIndex:Int?
    var items : [ItemData]? = []
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        tableView.delegate = self
    }
    
  
    @IBAction func addButtonMainViewPressed(_ sender: UIButton) {
    }
    
    @IBAction func deleteButtonMainViewPressed(_ sender: Any) {
      
        if let selectedRow = selectedRowIndex {
//            print(selectedRow)
            items?.remove(at:selectedRow)
        }
        tableView.reloadData()
        
    }
    
    @IBAction func modifyButtonMainViewPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "toModifyPopUpView", sender: self)
        //en todos esos identifier iba a usar constantes
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAddPopUpView" {
            let popUp = segue.destination as! AddPopUpViewController
            popUp.onSave = { (data) in
                self.items?.append(ItemData(name: data))
                self.tableView.reloadData()

            }
        }
        if segue.identifier == "toModifyPopUpView" {
            let popUp = segue.destination as! ModifyPopUpViewController
            
            if let selectedRow = selectedRowIndex {
                //en la linea de abajo queria pasarle al textfield del modifyPopUp el nombre de la fila seleccionada
                popUp.modifyTextField?.text = items?[selectedRow].name
                popUp.onModify = { (data) in
                    self.items?[selectedRow].name = data
                    self.tableView.reloadData()
                }
            }
        }
    }
}

extension ViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let numberOfItems = items?.count else {return 1}
        return numberOfItems
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
        cell.textLabel?.text = self.items?[indexPath.row].name
        return cell
        
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        selectedRowIndex = tableView.indexPathForSelectedRow?.row
        
        
       
    }
    
    }
