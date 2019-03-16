//
//  SelectionController.swift
//  Selection
//
//  Created by mohamed al-ghamdi on 02/03/2019.
//  Copyright © 2019 mohamed al-ghamdi. All rights reserved.
//

import UIKit

class SelectionController: UIStackView {

    enum SelectionType: String {
        case radioButtons = "radio"
        case checkBoxButtons = "checkbox"
    }
    
    var selectionType = SelectionType.checkBoxButtons // default
    
    @available(*, unavailable, message: "This property is reserved for Interface Builder. Use 'shape' instead.")
    
    @IBInspectable var selectionTypeName: String? {
        willSet {

            if let selection = SelectionType(rawValue: newValue?.lowercased() ?? "") {
                selectionType = selection
            }
        }
    }
    @IBInspectable var checkedPictureName: String? {
        willSet {
                checkedPicName = newValue ?? "checkedbox"
        }
    }
    @IBInspectable var uncheckedPictureName: String? {
        willSet {
            uncheckedPicName = newValue ?? "uncheckedbox"
        }
    }
    
    var selectedElementsTag = [Int]()
    var selectedElements = [String]()
    
    var checkedPicName = "checkedbox" 
    var uncheckedPicName = "uncheckedbox"
    override func draw(_ rect: CGRect) {
        let selectionButtons = self.subviews.filter{$0 is UIButton}
        var selctionTag = 1
        for button in selectionButtons {
            if let button = button as? UIButton{
                button.setImage(UIImage(named: uncheckedPicName), for: .normal)
                button.addTarget(self, action: #selector(self.pressed(sender:)), for: .touchUpInside)
                button.tag = selctionTag
                selctionTag = selctionTag + 1
            }
        }
    }
    func setSelection(selectedElement:Int){
        let selectionButtons = self.subviews.filter{$0 is UIButton}
        for button in selectionButtons {
            if let button = button as? UIButton{
                switch selectionType{
                case .checkBoxButtons:
                    if (selectedElement == button.tag){
                        if button.currentImage == UIImage(named:checkedPicName) {
                            button.setImage(UIImage(named: uncheckedPicName), for: .normal)
                            selectedElements.remove(at: selectedElementsTag.index(of:selectedElement) ?? 0)
                            selectedElementsTag = selectedElementsTag.filter { $0 != selectedElement }
                        } else {
                            button.setImage(UIImage(named: checkedPicName), for: .normal)
                            selectedElements.append(button.currentTitle ?? "")
                            selectedElementsTag.append(selectedElement)
                        }
                    }
                case .radioButtons:
                    button.setImage(UIImage(named: uncheckedPicName), for: .normal)
                    if (selectedElement == button.tag){
                        button.setImage(UIImage(named: checkedPicName), for: .normal)
                        selectedElementsTag.removeAll()
                        selectedElements.removeAll()
                        selectedElements.append(button.currentTitle ?? "")
                        selectedElementsTag.append(selectedElement)
                    }

                }
            }
        }
    }
    
    @objc func pressed(sender: UIButton) {
        setSelection(selectedElement:sender.tag)
    }
}
