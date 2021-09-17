//
//  CalculatorViewController.swift
//  BasicUIComponents
//
//  Created by Semih Emre ÜNLÜ on 11.09.2021.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    
    //@IBOutlet var digitButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    private var isTyping: Bool = false
    private let symbols : [Character] = ["+", "-", "*", "/"]
    
    @IBAction func digitButtonTapped(_ sender: UIButton) {
        let digit = String(sender.tag)
        addResultLabel(text: digit)
    }
    
    @IBAction func actionButtonTapped(_ sender: UIButton) {
        
        let value = NSString(string: resultLabel.text ?? "0").doubleValue
        resultLabel.text = String(sqrt(value))
    }
    
    @IBAction func operationButtonsTapped(_ sender: UIButton) {
        
        let symbol = sender.currentTitle ?? ""
        addResultLabel(text: symbol)
    }
    
    func addResultLabel( text : String){
        let displayText = resultLabel.text ?? ""
        
        if isTyping {
            resultLabel.text = displayText + text
        } else {
            resultLabel.text = text
            isTyping.toggle()
        }
    }
    @IBAction func equalButtonTapped(_ sender: UIButton) {
        
        let result = resultLabel.text ?? ""
        
        if result == "0" || !existOperationSymbol(text: result){
            return
        }
        
        let symbol = getOperationSymbol(text : result)
        let numbers = result.split(separator: symbol)
        
        if numbers.count<2 || numbers.count>2 {
            return
        }
        
        let number1 : Double = Double(numbers[0]) ??  0
        let number2 : Double = Double(numbers[1]) ?? 0
        
        var resultEqual : Double = 0
        if symbol == "+"{
            resultEqual = number1 + number2
        }
        else if symbol == "-"{
            resultEqual = number1 - number2
        }
        else if symbol == "*"{
            resultEqual = number1 * number2
        }
        else if symbol == "/"{
            resultEqual = number1 / number2
        }
        
        resultLabel.text = String(resultEqual)
            
    }
    
    func getOperationSymbol(text : String) -> Character{
            
        for index in 0...symbols.count {
            let symbol = symbols[index]
            if text.contains(symbol){
                return symbol
            }
         }

        return Character("")
    }
    
    
    func existOperationSymbol(text : String) -> Bool{
            
        for index in 0...symbols.count {
            if text.contains(symbols[index]){
                return true
            }
         }

        return false
    }
    
    @IBAction func allClearButtonTapped(_ sender: UIButton) {
        resultLabel.text="0"
        isTyping = false
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
