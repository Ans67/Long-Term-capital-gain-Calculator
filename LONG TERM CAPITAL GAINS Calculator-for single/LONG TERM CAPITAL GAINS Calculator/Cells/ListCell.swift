//
//  ListCell.swift
//  LONG TERM CAPITAL GAINS Calculator
//
//  Created by Anas Mansuri on 22/07/19.
//  Copyright © 2019 Anas Mansuri. All rights reserved.
//

import UIKit

protocol FormUpdateDelegate {
    func updateFormData(cell : ListCell)
}

class ListCell: UITableViewCell {

    @IBOutlet weak var lblItemindex: UILabel!
    @IBOutlet weak var txtStockname: UITextField!
    @IBOutlet weak var txtQuantity: UITextField!
    @IBOutlet weak var txtdateofpurchased: UITextField!
    @IBOutlet weak var txtbyuprice: UITextField!
    @IBOutlet weak var txtfairmarketValue: UITextField!
    @IBOutlet weak var txtdateofSale: UITextField!
    @IBOutlet weak var txtsellprice: UITextField!
    @IBOutlet weak var txtcostofacquistion: UITextField!
   
    var tagTextfield = UITextField()
    var datePickerView = UIDatePicker()
    var datePickersellView = UIDatePicker()
    
    var formDelegate:FormUpdateDelegate? = nil
    var modelData = AddData(itemNo: 0, stockName: "", qty: 0, dateofPurchase: "", buyPrice: 0, fairmarketValue: 0, dateofSale: "", sellPrice: 0, costofAcquistion: "", ltcg: 0)
    override func awakeFromNib() {
        super.awakeFromNib()
      //  configDatePicker()
    }

//    func configDatePicker(){
//        
//        let toolbar = UIToolbar();
//        toolbar.sizeToFit()
//        datePickerView.datePickerMode = .date
//        datePickerView.addTarget(self, action: #selector(handleDatePicker(sender:)), for: UIControl.Event.valueChanged)
//        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(DoneButton(sender:)));
//        toolbar.setItems([doneButton], animated: false)
//        txtdateofpurchased.inputAccessoryView = toolbar
//        txtdateofpurchased.inputView = datePickerView
//        
//        let toolbar1 = UIToolbar();
//        toolbar1.sizeToFit()
//        datePickersellView.datePickerMode = .date
//        datePickersellView.addTarget(self, action: #selector(handleDatePickerSelldate(sender:)), for: UIControl.Event.valueChanged)
//        let doneButtonsell = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(DoneButtonSellDate(sender:)));
//        toolbar1.setItems([doneButtonsell], animated: false)
//        txtdateofSale.inputAccessoryView = toolbar1
//        txtdateofSale.inputView = datePickersellView
//        
//    }
    
    @objc func handleDatePicker(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        txtdateofpurchased.text = dateFormatter.string(from: sender.date)
    }
    
    @objc func handleDatePickerSelldate(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        txtdateofSale.text = dateFormatter.string(from: sender.date)
    }
    
    @IBAction func DoneButton(sender: UIButton) {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        txtdateofpurchased.text = formatter.string(from: datePickerView.date)
        txtdateofpurchased.resignFirstResponder()
    }

    @IBAction func DoneButtonSellDate(sender: UIButton) {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        txtdateofSale.text = formatter.string(from: datePickersellView.date)
        txtdateofSale.resignFirstResponder()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}


extension ListCell: UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        print(textField.tag)

        if textField.tag == 5 || textField.tag == 9{
            textField.isUserInteractionEnabled = false
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        self.formDelegate?.updateFormData(cell: self)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
    
        if textField.tag ==  5001{
            modelData.qty = Int(textField.text!)
        }else if textField.tag == 5002{
            modelData.dateofPurchase = textField.text
        }else if textField.tag == 5003{
            modelData.buyPrice = Double(textField.text!)
        }else if textField.tag == 5004{
            modelData.fairmarketValue = Double(textField.text!)
        }else if textField.tag == 5005{
            modelData.dateofSale = textField.text
        }else if textField.tag == 5006{
            modelData.sellPrice = Double(textField.text!)
        }else if textField.tag == 5007{
            modelData.costofAcquistion = textField.text
        }else if textField.tag == 5008{
            modelData.ltcg = Double(textField.text!)
        }else if textField.tag == 5009{
            modelData.stockName = textField.text
        }
    
        return true
        
    }

}


//LTCG Calculator
