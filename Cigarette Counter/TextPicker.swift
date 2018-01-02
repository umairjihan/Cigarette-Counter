//
//  TextPicker.swift
//  Cigarette Counter
//
//  Created by Abu Umair Jihan on 1/1/18.
//  Copyright © 2018 Abu Umair Jihan. All rights reserved.
//

import UIKit

protocol TextPickerDelegate {
    func pickerView(inputAccessoryViewFor pickerView: TextPicker) -> UIView?
    func pickerView(didSelect value: String, inRow row: Int, inComponent component: Int, delegatedFrom pickerView: TextPicker)
}

class TextPicker: NSObject {
    
    var delegate: TextPickerDelegate? {
        didSet {
            textView.inputAccessoryView = delegate?.pickerView(inputAccessoryViewFor: self)
        }
    }
    
    fileprivate let pickerView = UIPickerView()
    fileprivate var textView = UITextField()
    fileprivate weak var parentViewController: UIViewController?
    public fileprivate(set) var items: [[String]] = []
    
    init (parentViewController: UIViewController) {
        self.parentViewController = parentViewController
        super.init()
        setupPickerView()
    }
    
    deinit {
        textView.removeFromSuperview()
    }
}

// MARK: - Getter and Setter

extension TextPicker {
    
    func set(items: [[String]]) {
        self.items = items
        pickerView.reloadAllComponents()
    }
    
    var selectedItems: [AnyObject] {
        var result = [AnyObject]()
        for index in 0..<pickerView.numberOfComponents {
            let selectedRow = pickerView.selectedRow(inComponent: index)
            if index < items.count && selectedRow < items[index].count {
                result.append(items[index][selectedRow] as AnyObject)
                result.append(selectedRow as AnyObject)
            }
        }
        return result
    }
}


// MARK: - setup Views

extension TextPicker {
    
    fileprivate func setupPickerView() {
        pickerView.dataSource = self
        pickerView.delegate = self
        textView.inputView = pickerView
        parentViewController?.view.addSubview(textView)
    }
    
    func startPicking() {
        textView.becomeFirstResponder()
    }
    
    func endPicking() {
        textView.resignFirstResponder()
    }
    
}


// MARK: - UIPickerViewDataSource

extension TextPicker: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return items.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return items[component].count
    }
    
    
}

// MARK: - UIPickerViewDelegate

extension TextPicker: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return items[component][row]
    }
//    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
//        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 37))
//        label.text = items[component][row]
//        label.textAlignment = .center
//        //Changed to NS as UI is deprecated.
//        label.backgroundColor = UIColor.clear
//        return label;
//    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        delegate?.pickerView(didSelect: items[component][row], inRow: row, inComponent: component, delegatedFrom: self)
    }
    
}
