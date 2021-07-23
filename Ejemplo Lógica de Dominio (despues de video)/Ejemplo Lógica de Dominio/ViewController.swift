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
let kGoToAddBread = "goToAddBread"
let kGoToEditBread = "goToEditBread"
class BakeryViewController: UIViewController {
    var selectedRowIndex:Int?
    var breads : [Bread] = []
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        tableView.delegate = self
    }
  
    @IBAction func addButtonMainViewPressed(_ sender: UIButton) {
    }
    
    @IBAction func didPressDeleteLastBread(_ sender: Any) {
        if !breads.isEmpty {
            breads.removeLast()
        }
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == kGoToAddBread {
            let popUp = segue.destination as! AddBreadModalViewController
            popUp.onSave = { (data) in
                self.breads.append(Bread(name: data))
                self.tableView.reloadData()
            }
        }
        if segue.identifier == kGoToEditBread {
            let popUp = segue.destination as! ModifyBreadModalViewController
            if let selectedRow = selectedRowIndex {
                popUp.bread = breads[selectedRow]
                popUp.onModify = { [weak self](data) in
                    self?.breads[selectedRow].name = data
                    self?.tableView.reloadData()
                }
            }
        }
    }
}

extension BakeryViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  breads.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
        cell.textLabel?.text = self.breads[indexPath.row].name
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        selectedRowIndex = tableView.indexPathForSelectedRow?.row
        performSegue(withIdentifier: kGoToEditBread, sender: self)
    }
}
