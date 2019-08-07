//
//  Extensions.swift
//  Gokada ATM
//
//  Created by Isaac Iniongun on 06/08/2019.
//  Copyright © 2019 Ing Groups. All rights reserved.
//

import Foundation
import UIKit
import Fakery

//MARK: - App Colors
let mainAppColor = UIColor(hexString: "6AB787")

let faker = Faker()

//MARK: - UIViewController Extensions
extension UIViewController {
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))
        
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
}

//MARK: - UIView Inspectables
extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}

//Execute after the said number of seconds
func executeAfter(timeInterval: Double = 5.0, action: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + timeInterval) {
        action()
    }
}

//Generate a random number with specific number of digits
func generateRandomDigits(_ digitNumber: Int) -> String {
    var number = ""
    for i in 0..<digitNumber {
        var randomNumber = arc4random_uniform(10)
        while randomNumber == 0 && i == 0 {
            randomNumber = arc4random_uniform(10)
        }
        number += "\(randomNumber)"
    }
    return number
}

//Generate random accounts to be linked to card
func getLinkedAccounts(numberOfAccounts: Int) -> [Account] {
    var accounts = [Account]()
    
    for _ in 0..<numberOfAccounts {
        accounts.append(Account(type: getAccountType(Int.random(in: 1...3)), number: generateRandomDigits(10), balance: faker.number.randomFloat(min: 1000.0000, max: 100000.9999)))
    }
    
    return accounts
}

//Get a random account type
fileprivate func getAccountType(_ random: Int) -> AccountType {
    switch random {
    case 2:
        return .debit
    case 3:
        return .credit
    default:
        return .savings
    }
}

//Determine whether or not an amount is a multiple of 500 or 1000
func isMultipleOf500Or1000(number: Float) -> Bool {
    return (floor(number/500.00) == number/500.00) || (floor(number/1000.00) == number/1000.00)
}

//Get Current DateTime using a certain format string
func getCurrentDateTime(format: String = "yyyy-MM-dd HH:mm:ss") -> String {
    
    let dateFormatter : DateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    let date = Date()
    
    return dateFormatter.string(from: date)
}

//Get any random address
func getRandomAddress() -> String {
    return faker.address.streetAddress(includeSecondary: true) + ", " + faker.address.city() + ", " + faker.address.state() + ", " + faker.address.country()
}
