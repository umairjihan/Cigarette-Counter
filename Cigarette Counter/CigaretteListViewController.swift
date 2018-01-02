//
//  CigaretteListViewController.swift
//  Cigarette Counter
//
//  Created by Abu Umair Jihan on 1/1/18.
//  Copyright © 2018 Abu Umair Jihan. All rights reserved.
//

import UIKit
import CoreData
class CigaretteListViewController: UIViewController {

    var cigaretteList: [Cigarette] = []
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "CigaretteTableViewCell", bundle: nil), forCellReuseIdentifier: "CigaretteTableViewCell")
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        fetchData()
    }
    @IBAction func addCigaretteAction(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add Cigarette", message: "Enter a cigarette name and price", preferredStyle: .alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.placeholder = "name"
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "price"
        }
        
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            //            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            //            print("Text field: \(String(describing: textField?.text))")
            if let name = alert?.textFields?[0].text, let priceString = alert?.textFields?[1].text, name != "" , let price = Float(priceString) {
                self.save(name: name, price: price)
            }
        }))
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }
    
    func save(name: String, price: Float) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
//        let entity = NSEntityDescription.entity(forEntityName: "Cigarette",
//                                                in: managedContext)!
//
//        let cigarette = NSManagedObject(entity: entity,
//                                     insertInto: managedContext)
        
        let cigarette = Cigarette(context: managedContext)
        cigarette.name = name
        cigarette.price = price
//        cigarette.setValue(name, forKeyPath: "name")
//        cigarette.setValue(price, forKeyPath: "price")
        
        do {
            try managedContext.save()
            cigaretteList.append(cigarette)
             self.tableView.reloadData()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    
    func fetchData(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
//        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Cigarette")
        do {
            self.cigaretteList = try managedContext.fetch(Cigarette.fetchRequest())
            self.tableView.reloadData()
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CigaretteListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cigaretteList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CigaretteTableViewCell", for: indexPath) as! CigaretteTableViewCell
        cell.setDataToCell(shop: self.cigaretteList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    
}
