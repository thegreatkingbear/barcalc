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
    
    override func controlTextDidBeginEditing(_ obj: Notification) {
        //print("control text did begin editing")
    }
    
    override func controlTextDidEndEditing(_ obj: Notification) {
        //print("control text did end editing")
        if let txtFld = obj.object as? NSTextField {
            let text = txtFld.stringValue
            //print(text)
            self.calculateExpression(text)
        }
    }
    
    override func controlTextDidChange(_ obj: Notification) {
        guard let _ = existingExpression else { return }
        //print("control text did change : \(obj.object)")
        if let _ = obj.object as? NSTextField {
            //print(txtFld.stringValue)
            self.existingExpression = nil
        }
    }
    
    func control(_ control: NSControl, textView: NSTextView, doCommandBy commandSelector: Selector) -> Bool {
        //print("do command by selector : \(control)")
        if let existing = existingExpression {
            self.textField?.stringValue = existing
            self.existingExpression = nil
        }
        return false
    }
    
    func calculateExpression(_ values: String) {
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
