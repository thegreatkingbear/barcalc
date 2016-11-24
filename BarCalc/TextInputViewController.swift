//
//  TextInputViewController.swift
//  BarCalc
//
//  Created by Mookyung Kwak on 19/11/2016.
//  Copyright © 2016 Mookyung Kwak. All rights reserved.
//

import Cocoa
import MathParser

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
            //print(text)
            self.calculateExpression(text)
        }
    }
    
    override func controlTextDidChange(obj: NSNotification) {
        guard let _ = existingExpression else { return }
        //print("control text did change : \(obj.object)")
        if let _ = obj.object as? NSTextField {
            //print(txtFld.stringValue)
            self.existingExpression = nil
        }
    }
    
    func control(control: NSControl, textView: NSTextView, doCommandBySelector commandSelector: Selector) -> Bool {
        //print("do command by selector : \(control)")
        if let existing = existingExpression {
            self.textField?.stringValue = existing
            self.existingExpression = nil
        }
        return false
    }
    
    func calculateExpression(values: String) {
        //print(values)
        do {
            let expression = try Expression(string: values)
            let evaluator: Evaluator = Evaluator()
            let result = try evaluator.evaluate(expression)
            self.textField?.stringValue = "\(expression) = \(result)"
            self.existingExpression = "\(expression)"
        } catch {
            self.textField?.stringValue = "Invalid expression"
            self.existingExpression = nil
        }
    }
}
