//
//  ViewController.swift
//  Employee-Manager
//
//  Created by Khater on 05/09/2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var salaryLabel: UILabel!
    @IBOutlet weak var salaryTextField: UITextField!
    
    
    var person: Person = Person()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: - IB Actions
    @IBAction func employeeButtonPressed(_ sender: UIButton) {
        if !isValidSalary() {
            showAlert()
            return
        }
        
        person = Employee()
        person.salary = Double(salaryTextField.text!)!
        let empSalary = person.getSalary()
        salaryLabel.text = "Salary: \(empSalary)$"
    }
    
    @IBAction func managerButtonPressed(_ sender: UIButton) {
        if !isValidSalary() {
            showAlert()
            return
        }
        
        person = Manager()
        person.salary = Double(salaryTextField.text!)!
        let managerSalary = person.getSalary()
        salaryLabel.text = "Salary: \(managerSalary) $"
    }
    
    
    // MARK: - My Funtions
    private func showAlert() {
        let alert = UIAlertController(title: "Salary", message: "invalide input, make sure you enter a number", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
    
    private func isValidSalary() -> Bool {
        if let salaryText = salaryTextField.text {
            if salaryText.isEmpty {
                return false
            }
            
            // is Number
            return Double(salaryText) != nil
            
        } else {
            return false
        }
    }
}


// MARK: - Peron
class Person {
    var salary: Double = 0.0
    
    func getSalary() -> Double {
        return 0.0
    }
}


// MARK: - Manager
class Manager: Person {
    override func getSalary() -> Double {
        return salary * 2
    }
}



// MARK: - Employee
class Employee: Person {
    override func getSalary() -> Double {
        return salary
    }
}
