//
//  TextInputViewController.swift
//  BarCalc
//
//  Created by Mookyung Kwak on 19/11/2016.
//  Copyright © 2016 Mookyung Kwak. All rights reserved.
//

import Cocoa

class TextInputViewController: NSViewController, NSTextFieldDelegate {

    @IBOutlet weak var textField: NSTextField?
    
    var existingExpression: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        textField?.delegate = self
    }
    
    override func controlTextDidBeginEditing(obj: NSNotification) {
        //print("control text did begin editing")
    }
    
    override func controlTextDidEndEditing(obj: NSNotification) {
        //print("control text did end editing")
        if let txtFld = obj.object as? NSTextField {
            let text = txtFld.stringValue
            self.calculateExpression(text)
        }
    }
    
    override func controlTextDidChange(obj: NSNotification) {
    }
    
    func control(control: NSControl, textView: NSTextView, doCommandBySelector commandSelector: Selector) -> Bool {
        print("do command by selector : \(control)")
        if let existing = existingExpression {
            self.textField?.stringValue = existing
            self.existingExpression = nil
        }
        return false
    }
    
    func calculateExpression(values: String) {
        SwiftTryCatch.tryBlock({
            let expression = NSExpression(format: values)
            if let result = expression.expressionValueWithObject(nil, context: nil) as? NSNumber {
                self.textField?.stringValue = "\(expression) = \(result.doubleValue)"
                self.existingExpression = "\(expression)"
            } else {
                self.textField?.stringValue = "Invalid expression"
                self.existingExpression = nil
            }
        }, catchBlock: { (error) in
            self.textField?.stringValue = "Invalid expression"
            self.existingExpression = nil
        }) {
            
        }
    }
}
