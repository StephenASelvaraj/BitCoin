//
//  ViewController.swift
//  BitCoin
//
//  Created by Stephen Selvaraj on 6/25/18.
//  Copyright © 2018 Stephen Selvaraj. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    

    let baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    let currencyArray = ["AUD", "INR", "USD"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var BitCoinPrice: UITextField!
    
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyArray.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyArray[row]
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(row)
        print (currencyArray[row])
        let finalURL = baseURL + currencyArray[row]
        print(finalURL)
        
        getBitcoinPrice(url: finalURL)
        
    }
    
    func getBitcoinPrice (url : String) {
        
        Alamofire.request(url, method : .get)
            .responseJSON  {  response in
                if response.result.isSuccess && response.result.value != nil {
                    let price : JSON = JSON (response.result.value)
                    print (price)
                    
                    self.updateBitCoinprice(price)
                    
                } else {
                    print("Error retrieving Bid price")
                }
        }
    }
    
    func updateBitCoinprice (_ JSONdata : JSON) {
        BitCoinPrice.text = JSONdata["bid"].stringValue
    }
    
}

