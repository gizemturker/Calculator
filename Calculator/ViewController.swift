//
//  ViewController.swift
//  Calculator
//
//  Created by Konpyūtā on 30.10.2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var holder: UIView!
    
    var firstNumber = 0
    var resultNumber = 0
    var isResultShow = false
    var currentOperations: Operation?
    var currentActions: Action?
    
    enum Operation {
        case add, subtract, multiply, divide
    }
    
    enum Action {
        case delete, absolute, mode
    }
    
    
    private var resultLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .white
        label.textAlignment = .right
        label.font = UIFont(name: "Helvetica", size: 120)
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
  
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupNumberPad()
    }
    
    private func setupNumberPad() {
        let buttonSize: CGFloat = view.frame.size.width / 4
        
        let zeroButton = UIButton(frame: CGRect (x: 10, y: holder.frame.size.height-buttonSize+10, width: (buttonSize*2)-20, height: buttonSize-20))
        
        zeroButton.setTitleColor(.black, for: .normal)
        zeroButton.backgroundColor = .darkGray
        zeroButton.setTitle("0", for: .normal)
        zeroButton.layer.cornerRadius = (zeroButton.bounds.size.width / 4.5)
        zeroButton.clipsToBounds = true
        zeroButton.tag = 1
        holder.addSubview(zeroButton)
        zeroButton.addTarget(self, action: #selector(numberPressed(sender:)), for: .touchUpInside)
        
        let buttondot = UIButton(frame: CGRect (x: (buttonSize*2)+5, y: holder.frame.size.height-buttonSize+5, width: buttonSize-10, height: buttonSize-10))
        
        buttondot.setTitleColor(.black, for: .normal)
        buttondot.backgroundColor = .darkGray
        buttondot.setTitle(".", for: .normal)
        buttondot.layer.cornerRadius = (buttondot.bounds.size.width / 2)
        holder.addSubview(buttondot)
        buttondot.addTarget(self, action: #selector(numberPressed(sender:)), for: .touchUpInside)
        
        
        
        for x in 0..<3 {
            
            let button1 = UIButton(frame: CGRect (x: buttonSize * CGFloat(x)+5, y: holder.frame.size.height-(buttonSize*2)+5, width: buttonSize-10, height: buttonSize-10))
            
            button1.setTitleColor(.black, for: .normal)
            button1.backgroundColor = .darkGray
            button1.setTitle("\(x+1)", for: .normal)
            button1.layer.cornerRadius = (button1.bounds.size.width / 2)
            button1.tag = x+2
            holder.addSubview(button1)
            button1.addTarget(self, action: #selector(numberPressed(sender:)), for: .touchUpInside)
        }
        
        
        
        for x in 0..<3 {
            
            let button2 = UIButton(frame: CGRect (x: buttonSize * CGFloat(x)+5, y: holder.frame.size.height-(buttonSize*3)+5, width: buttonSize-10, height: buttonSize-10))
            
            button2.setTitleColor(.black, for: .normal)
            button2.backgroundColor = .darkGray
            button2.setTitle("\(x+4)", for: .normal)
            button2.layer.cornerRadius = (button2.bounds.size.width / 2)
            holder.addSubview(button2)
            button2.tag = x+5
            button2.addTarget(self, action: #selector(numberPressed(sender:)), for: .touchUpInside)
        }
        
        
        
        for x in 0..<3 {
            
            let button3 = UIButton(frame: CGRect (x: buttonSize * CGFloat(x)+5, y: holder.frame.size.height-(buttonSize*4)+5, width: buttonSize-10, height: buttonSize-10))
            
            button3.setTitleColor(.black, for: .normal)
            button3.backgroundColor = .darkGray
            button3.setTitle("\(x+7)", for: .normal)
            button3.layer.cornerRadius = (button3.bounds.size.width / 2)
            holder.addSubview(button3)
            button3.tag = x+8
            button3.addTarget(self, action: #selector(numberPressed(sender:)), for: .touchUpInside)
            
        }
        
        let actions = ["C", "+/-","%"]
        
        for x in 0..<3 {
            
            let clearButton = UIButton(frame: CGRect (x: buttonSize * CGFloat(x)+5, y: holder.frame.size.height-(buttonSize*5)+5, width: buttonSize-10, height: buttonSize-10))
            
            clearButton.setTitleColor(.black, for: .normal)
            clearButton.backgroundColor = .systemGray
            clearButton.setTitle(actions[x], for: .normal)
            clearButton.layer.cornerRadius = (clearButton.bounds.size.width / 2)
            clearButton.tag = x+1
            clearButton.addTarget(self, action: #selector(actionPressed(sender:)), for: .touchUpInside)
            holder.addSubview(clearButton)
        }
        
        let operations = ["=", "+", "-", "x", "/" ]
        
        for y in 0..<5 {
            
            let button4 = UIButton(frame: CGRect (x: buttonSize * 3+5, y: holder.frame.size.height - (buttonSize * CGFloat(y+1))+5, width: buttonSize-10, height: buttonSize-10))
            
            button4.setTitleColor(.white, for: .normal)
            button4.backgroundColor = .orange
            button4.setTitle(operations[y], for: .normal)
            button4.layer.cornerRadius = (button4.bounds.size.width / 2)
            button4.tag = y+1
            button4.addTarget(self, action: #selector(operationPressed(sender:)), for: .touchUpInside)
            holder.addSubview(button4)
        
}

        
        resultLabel.frame = CGRect (x: 0-10, y: buttonSize-20, width: view.frame.size.width, height: 100)
        holder.addSubview(resultLabel)
        
        
        // Actions
        
        // ------ clearButton.addTarget(self, action: #selector(clearResult), for: .touchUpInside
}
       //  @objc func clearResult()
       // resultLabel.text = "0
    // currentOperations = nil
    // firstNumber = 0
    
    
    
 
    @objc func numberPressed( sender: UIButton) {
        
        let tag = sender.tag-1
        
        if resultLabel.text == "0" {
            resultLabel.text = "\(tag)"
        }
        
        else if let text = resultLabel.text, !isResultShow {
            resultLabel.text = "\(text)\(tag)"
        
        } else {
            resultLabel.text = "\(tag)"
        }
        
        isResultShow = false
    }

    @objc func operationPressed( sender: UIButton) {
        
        let tag = sender.tag
    
        if let text = resultLabel.text, let value = Int(text), firstNumber == 0 {
            
            firstNumber = value
            resultLabel.text = "0"
        }
            
        if tag == 1 {
            debugPrint("equals")
            if let operation = currentOperations {
                var secondNumber = 0
                if let text = resultLabel.text, let value = Int(text) {
                    secondNumber = value
                    resultLabel.text = "0"
                }
                switch operation {
                    
                case .add:
                    let result = firstNumber + secondNumber
                    isResultShow = true
                    resultLabel.text = "\(result)"
                    break
                    
                case .subtract:
                    let result = firstNumber - secondNumber
                    isResultShow = true
                    resultLabel.text = "\(result)"
                    break
                    
                case .multiply:
                    let result = firstNumber * secondNumber
                    isResultShow = true
                    resultLabel.text = "\(result)"
                    break
                    
                case .divide:
                    let result = firstNumber / secondNumber
                    isResultShow = true
                    resultLabel.text = "\(result)"
                    break
                    
                }
            }
            
            
            
        }
        else if tag == 2 {
            debugPrint("add")
            currentOperations = .add
        }
        else if tag == 3 {
            debugPrint("subtract")
            currentOperations = .subtract
        }
        else if tag == 4 {
            debugPrint("multiply")
            currentOperations = .multiply
        }
        else if tag == 5 {
            debugPrint("divide")
            currentOperations = .divide
            
        }
        
      
    }
    
    
    @objc func actionPressed( sender: UIButton){
        var integervalue = 0

        if let text = resultLabel.text, let value = Int(text){
            integervalue = value
        }

        let tag = sender.tag
            
        if tag == 1 {
            resultLabel.text = "0"
        }
        else if tag == 2 {
            let result = integervalue * -1
            resultLabel.text = "\(result)"
            currentActions = .absolute
        }
        else if tag == 3 {
            debugPrint("mode")

            let result = resultNumber / 100
            resultLabel.text = "\(result)"

        }

    }
}

