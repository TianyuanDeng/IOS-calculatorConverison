//
//  ConverterViewController.swift
//  Conversion-Calculator
//
//  Created by TianyuanDeng on 12/07/18.
//  Copyright © 2017 Tianyuan Deng. All rights reserved.
//

import UIKit

class ConverterViewController: UIViewController {
    
    var converters = [ Converter(label: "fahrenheit to celcius", inputUnit: "°F", outputUnit: "°C", convert: {x in return ((x-32)/1.8)}),
                       Converter(label: "celcius to fahrenheit", inputUnit: "°C", outputUnit: "°F", convert: {x in return ((x*1.8)+32)}),
                       Converter(label: "miles to kilometers", inputUnit: "mi", outputUnit: "km", convert: {x in return (x*1.609)}),
                       Converter(label: "kilometers to miles", inputUnit: "km", outputUnit: "mi", convert: {x in return (x*0.621)}) ]

    var currentConverter: Converter?
    
    var outputString: String = ""
    var outputUnitString: String = ""
    
    var inputString: String = ""
    var inputUnitString: String = ""
    
    @IBOutlet weak var outputDisplay: UITextField!
    @IBOutlet weak var inputDisplay: UITextField!
    
    @IBAction func convert(_ sender: UIButton) {
        let alert = UIAlertController(title:"Choose Converter", message: "", preferredStyle: UIAlertControllerStyle.actionSheet)
        for converter in converters{
            alert.addAction(UIAlertAction(title: converter.label, style: UIAlertActionStyle.default, handler:{
                 (alertAction) -> Void in
                
                self.inputUnitString = converter.inputUnit
                self.outputUnitString = converter.outputUnit
                self.currentConverter = converter
                
                self.updateCalculator()
            }))
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: Handle input data
    
    @IBAction func addDigit(_ sender: UIButton) {
        if currentConverter == nil {
            return
        }
        
        let button = sender as UIButton
        
        if(button.tag == -1){
            if inputString.contains(".") || inputString.count == 0 {
                return
            }
            
            inputString.append(".")
        } else {
            inputString.append(String(button.tag))
        }
        
        updateCalculator()
    }
    
    @IBAction func clear(_ sender: Any) {
        inputString = ""
        outputString = ""
        
        updateCalculator()
    }
    
    @IBAction func changeSign(_ sender: Any) {
        if inputString.count == 0{
            return
        } else if inputString.contains("-") {
            inputString.remove(at: (inputString.startIndex))
        } else {
            inputString.insert("-", at: (inputString.startIndex))
        }
        
        updateCalculator()
    }
    
    //MARK: Update View
    
    func updateCalculator(){
        guard let converter = currentConverter else {
            return
        }
        
        if(inputString.count == 0){
            inputDisplay.text = inputUnitString
            outputDisplay.text = outputUnitString
            return
        }
        
        var output: Double
        var value: Double
        
        inputDisplay.text = inputString + " " + inputUnitString
        
        value = Double(inputString) ?? 0
        output = converter.convert(value)
        
        outputString = String(format: "%.2f", output)
        
        outputDisplay.text = outputString + " " + outputUnitString
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
