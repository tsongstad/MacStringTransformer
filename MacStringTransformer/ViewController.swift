//
//  ViewController.swift
//  MacStringTransformer
//
//  Created by Tyler Songstad on 11/7/20.
//

import Cocoa

class ViewController: NSViewController, NSTextFieldDelegate {
    @IBOutlet weak var input: NSTextField!
    @IBOutlet weak var type: NSSegmentedControl!
    @IBOutlet weak var output: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        input.delegate = self
        typeChanged(self)

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func CopyToClipboard(_ sender: Any) {
        typeChanged(self)
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString(output.stringValue, forType: .string)
    }
    
    @IBAction func typeChanged(_ sender: Any) {
        switch type.selectedSegment{
        case 0:
            output.stringValue = rot13(input.stringValue)
        case 1:
            output.stringValue = similar(input.stringValue)
        case 2:
            output.stringValue = strike(input.stringValue)
        default:
            output.stringValue = zalgo(input.stringValue)
            
        }
    }
    
    func controlTextDidChange(_ obj: Notification) {
        typeChanged(self)
    }
    
    func rot13(_ input: String) -> String{
        return "Rot13: " + input
    }
    func similar(_ input: String) -> String{
        return "Similar: " + input
    }
    
    func strike(_ input: String) -> String{
        var output = ""
        
        for letter in input{
            output.append(letter)
            output.append("\u{0335}")
        }
        
        return output
    }
    
    func zalgo(_ input: String) -> String{
        return "Zalgo: " + input
    }
}

