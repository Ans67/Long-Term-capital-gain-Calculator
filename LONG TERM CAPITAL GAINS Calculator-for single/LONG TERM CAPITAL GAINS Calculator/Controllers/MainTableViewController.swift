//
//  MainTableViewController.swift
//  LONG TERM CAPITAL GAINS Calculator
//
//  Created by Anas Mansuri on 20/07/19.
//  Copyright © 2019 Anas Mansuri. All rights reserved.
//

import UIKit

struct AddData : Codable{
    var itemNo : Int
    var stockName : String?
    var qty : Int?
    var dateofPurchase : String?
    var buyPrice : Double?
    var fairmarketValue : Double?
    var dateofSale : String?
    var sellPrice : Double?
    var costofAcquistion : String?
    var ltcg : Double?
}

class MainTableViewController: UITableViewController {

    @IBOutlet var emptyView: UIView!
    @IBOutlet weak var lblLTCGValue: UILabel!
    @IBOutlet weak var lbltax: UILabel!
    @IBOutlet weak var txtLtc: UITextField!
    @IBOutlet weak var txtStockname: UITextField!
    @IBOutlet weak var txtQuantity: UITextField!
    @IBOutlet weak var txtdateofpurchsed: UITextField!
    @IBOutlet weak var txtFairmarketvalue: UITextField!
    @IBOutlet weak var txtDateofsale: UITextField!
    @IBOutlet weak var txtSellprice: UITextField!
    @IBOutlet weak var txtcostofacqustion: UITextField!
    @IBOutlet weak var txtBuyprice: UITextField!
    
    var passedObject = AddData(itemNo: 0, stockName: "", qty: 0, dateofPurchase: "", buyPrice: 0, fairmarketValue: 0, dateofSale: "", sellPrice: 0, costofAcquistion: "", ltcg: 0)
    var arrAdddata = [AddData]()
    
    var datePickerView = UIDatePicker()
    var datePickersellView = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeValue()
        
        txtQuantity.tag = 5001
        txtdateofpurchsed.tag = 5002
        txtBuyprice.tag = 5003
        txtFairmarketvalue.tag = 5004
        txtDateofsale.tag = 5005
        txtSellprice.tag = 5006
        txtcostofacqustion.tag = 5007
        txtStockname.tag = 5000
        txtLtc.tag = 5009
        
        txtStockname.delegate = self
        txtQuantity.delegate = self
        txtdateofpurchsed.delegate = self
        txtBuyprice.delegate = self
        txtFairmarketvalue.delegate = self
        txtDateofsale.delegate = self
        txtSellprice.delegate = self
        txtcostofacqustion.delegate = self
        txtLtc.delegate = self
        
        configDatePicker()
    
        let mytapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(myTapAction))
        tableView.addGestureRecognizer(mytapGestureRecognizer)
    }

    @objc func myTapAction(recognizer: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    func initializeValue(){
        
        if AddManager.shared.totalItems.count == 0{
            let newIndex = AddManager.shared.totalItems.count
            let newObj = AddData(itemNo: newIndex + 1, stockName: "", qty: 0, dateofPurchase: "", buyPrice: 0, fairmarketValue: 0, dateofSale: "", sellPrice: 0, costofAcquistion: "", ltcg: 0)
            AddManager.shared.add(new: newObj)
            self.tableView.reloadData()
        }
    }
    func configDatePicker(){
        
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        datePickerView.datePickerMode = .date
        datePickerView.addTarget(self, action: #selector(handleDatePicker(sender:)), for: UIControl.Event.valueChanged)
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(DoneButton(sender:)));
        toolbar.setItems([doneButton], animated: false)
        txtdateofpurchsed.inputAccessoryView = toolbar
        txtdateofpurchsed.inputView = datePickerView
        
        let toolbar1 = UIToolbar();
        toolbar1.sizeToFit()
        datePickersellView.datePickerMode = .date
        datePickersellView.addTarget(self, action: #selector(handleDatePickerSelldate(sender:)), for: UIControl.Event.valueChanged)
        let doneButtonsell = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(DoneButtonSellDate(sender:)));
        toolbar1.setItems([doneButtonsell], animated: false)
        txtDateofsale.inputAccessoryView = toolbar1
        txtDateofsale.inputView = datePickersellView
    }
    
    func update(){
        let newIndex = AddManager.shared.totalItems.count
        let newObj = AddData(itemNo: newIndex + 1, stockName: "", qty: 0, dateofPurchase: "", buyPrice: 0, fairmarketValue: 0, dateofSale: "", sellPrice: 0, costofAcquistion: "", ltcg: 0)
        AddManager.shared.add(new: newObj)
        self.tableView.reloadData()
    }
    
    
    @objc func handleDatePicker(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        txtdateofpurchsed.text = dateFormatter.string(from: sender.date)
    }
    
    @objc func handleDatePickerSelldate(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        txtDateofsale.text = dateFormatter.string(from: sender.date)
    }
    
    @IBAction func DoneButton(sender: UIButton) {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        txtdateofpurchsed.text = formatter.string(from: datePickerView.date)
        txtdateofpurchsed.resignFirstResponder()
    }
    
    @IBAction func DoneButtonSellDate(sender: UIButton) {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        txtDateofsale.text = formatter.string(from: datePickersellView.date)
        txtDateofsale.resignFirstResponder()
    }
    
//    // MARK: - Table view data source
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 250
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let modelData = AddManager.shared.totalItems[indexPath.row]
//        if let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as? ListCell{
//            cell.selectionStyle = .none
//            //cell.config(model: modelData)
//            return cell
//        }
//        return UITableViewCell()
//    }
//
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        let myButton = UIButton(type: .custom)
        myButton.setTitle("Calculate", for: .normal)
        myButton.addTarget(self, action: #selector(calculateAction(_:)), for: .touchUpInside)
        myButton.frame = CGRect(x: 0, y: 0, width:UIScreen.main.bounds.width, height: 40)
        footerView.addSubview(myButton)
        footerView.backgroundColor = UIColor.blue
        return footerView
    }
    
    @objc func calculateAction(_ sender : AnyObject) {
        print("clicked")
        
        if txtQuantity.text == "" && txtdateofpurchsed?.text?.isEmpty ?? false && txtBuyprice.text == "" && txtDateofsale.text?.isEmpty ?? false{
            showAlertView("All fields are required")
        }else{
            
            if let quantity = txtQuantity.text, let buyPrice = txtBuyprice.text, let sellPrice = txtSellprice.text{
                
                guard  let quantityvalue = Int(quantity) else{return}
                guard  let buypriceValue = Double(buyPrice) else {return}
                guard  let sellValue = Double(sellPrice) else {return}
                
                let val = Calculations.calculateValues(quantity: quantityvalue, buyingPrice: buypriceValue, sellingPrice: sellValue)
                print(val)
                
                passedObject.ltcg = val.0
                lblLTCGValue.text = String(val.0)
                lbltax.text = String(val.1)
                txtLtc.text = String(val.0)
                txtcostofacqustion.text = txtBuyprice.text
                self.view.endEditing(true)
                
                ResultViewController.present(totalLTCGText: String(val.0), totalCesstax: String(val.1), from: self)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }

    
    @IBAction func btnClear_clicked(_ sender: UIBarButtonItem) {
        clearAllfields()
    }
    
    func clearAllfields(){
        txtStockname.text = ""
        txtQuantity.text = String(0)
        txtdateofpurchsed.text = ""
        txtBuyprice.text = String(0)
        txtFairmarketvalue.text = String(0)
        txtDateofsale.text = ""
        txtSellprice.text = String(0)
        txtcostofacqustion.text = String(0)
        txtLtc.text = String(0)
        
        lblLTCGValue.text = String(0)
        lbltax.text = String(0)
    }

    func showAlertView(_ message : String, title : String = "", okString : String! = "", handler : ((UIAlertAction) -> Swift.Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle:.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: handler))
        present(alert, animated: true, completion: nil)
    }

}

extension MainTableViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print(textField.tag)
        
        if textField.tag == 5004 || textField.tag == 5009 || textField.tag == 5007{
            textField.isUserInteractionEnabled = false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
}


