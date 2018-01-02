//
//  AddCostViewController.swift
//  Cigarette Counter
//
//  Created by Abu Umair Jihan on 1/1/18.
//  Copyright © 2018 Abu Umair Jihan. All rights reserved.
//

import UIKit
import CoreData
class AddCostViewController: UIViewController {
    @IBOutlet weak var cigaretteButton: UIButton!
    @IBOutlet weak var storeButton: UIButton!
    @IBOutlet weak var noOfCigarette: UITextField!
    @IBOutlet weak var teaName: UITextField!
    @IBOutlet weak var teaPrice: UITextField!
    @IBOutlet weak var noOfTea: UITextField!
    
    var cigaretteList: [Cigarette] = []
    var cigarette: Cigarette?
    var storeList: [Store] = []
    var store: Store?
    fileprivate var picker: TextPicker?
    var isCigarette:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        picker = TextPicker(parentViewController: self)
        picker?.delegate = self
//        picker?.set(items: [["aaa", "bbb", "ccc"], ["1", "2", "3"]])
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        fetchCigaretteData()
        fetchStoreData()
    }
    @IBAction func backAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func doneAction(_ sender: UIButton) {
        save()
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func cigarettePickerAction(_ sender: UIButton) {
        isCigarette = true
        setPicverViewData(cigaretteList: self.cigaretteList)
        picker?.startPicking()
    }
    @IBAction func storePickerAction(_ sender: UIButton) {
        isCigarette = false
        setPicverViewData(cigaretteList: self.storeList)
        picker?.startPicking()
    }
    
    func save() {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        // 1
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // 2
//        let entity = NSEntityDescription.entity(forEntityName: "Cost", in: managedContext)!
//        let store = NSManagedObject(entity: entity, insertInto: managedContext)
        let cost = Cost(context:managedContext)
        cost.date = Date() as NSDate
        
        // 3
//        store.setValue(Date(), forKeyPath: "date")
        if let name = self.cigarette?.name{
            cost.c_name = name
        } else {
            return
        }
        if let price = self.cigarette?.price{
            cost.c_price = price
        }
        if let noOfCigarette = self.noOfCigarette.text, let c_count = Int64(noOfCigarette) {
            cost.c_count = c_count
        }
        
        if let teaPrice = self.teaPrice.text, let t_price = Float(teaPrice) {
            cost.t_price = t_price
        }
        
        if let noOfTea = self.noOfTea.text, let t_count = Int64(noOfTea) {
            cost.t_count = t_count
        }
        
        if let teaName = self.teaName.text {
            cost.t_name = teaName
        }
        
        if let store = self.store{
            cost.store = store
        }
        
        // 4
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    
    func fetchCigaretteData(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
//        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Cigarette")
        do {
            self.cigaretteList = try managedContext.fetch(Cigarette.fetchRequest())
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func fetchStoreData(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
//        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Store")
        do {
            self.storeList = try managedContext.fetch(Store.fetchRequest())
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func setPicverViewData(cigaretteList: [NSManagedObject]) {
        var items: [[String]] = []
        var names :[String] = []
        for cigarette in cigaretteList {
            if let name = cigarette.value(forKeyPath: "name") as? String{
                names.append(name)
            }
        }
        items.append(names)
        picker?.set(items: items)
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

// MARK: PickerViewDelegate

extension AddCostViewController: TextPickerDelegate {
    
    @objc func pickerCancelAction() {
        picker?.endPicking()
    }
    
    @objc func pickerSetAction() {
        if let selectedItems = picker?.selectedItems {
            if !selectedItems.isEmpty{
                if isCigarette {
                    cigaretteButton.setTitle(selectedItems[0] as? String, for: .normal)
                     self.cigarette = self.cigaretteList[selectedItems[1] as! Int]
                }else{
                    storeButton.setTitle(selectedItems[0] as? String, for: .normal)
                    self.store = self.storeList[selectedItems[1] as! Int]
                }
                
            }
            picker?.endPicking()
        }
    }
    
    func pickerView(inputAccessoryViewFor pickerView: TextPicker) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 30))
        view.backgroundColor = .white
        let buttonWidth: CGFloat = 100
        
        let cancelButton = UIButton(frame: CGRect(x: UIScreen.main.bounds.width - buttonWidth - 10, y: 0, width: buttonWidth, height: 30))
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(.black, for: .normal)
        cancelButton.setTitleColor(.lightGray, for: .highlighted)
        cancelButton.addTarget(self, action: #selector(pickerCancelAction), for: .touchUpInside)
        view.addSubview(cancelButton)
        
        let setButton = UIButton(frame: CGRect(x: 10, y: 0, width: buttonWidth, height: 30))
        setButton.setTitle("Set", for: .normal)
        setButton.setTitleColor(.black, for: .normal)
        setButton.setTitleColor(.lightGray, for: .highlighted)
        setButton.addTarget(self, action: #selector(pickerSetAction), for: .touchUpInside)
        view.addSubview(setButton)
        
        return view
    }
    
    func pickerView(didSelect value: String, inRow row: Int, inComponent component: Int, delegatedFrom pickerView: TextPicker) {
        print("\(value)")
//        if isCigarette {
//            self.cigarette = self.cigaretteList[row]
//        }else{
//            self.store = self.storeList[row]
//        }
    }
    
}
