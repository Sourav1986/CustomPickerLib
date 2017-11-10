//
//  customPicker.swift
//  CustomPickerLib
//
//  Created by Sourav@Beas on 08/11/17.
//  Copyright © 2017 personal. All rights reserved.
//

import UIKit

enum pickerType {
    case kdefault
    case kdate
}

protocol CustomPickerDelegate {
    func didSelectPickerView(value:String)
    func didSelectDatePicker(value:Date)
}

public class customPicker: NSObject{
    
    var dataArray = [String]()
    var delegate:CustomPickerDelegate?
    private let datePicker = UIDatePicker()
    private let pickerview = UIPickerView()
    var buttom:NSLayoutConstraint!
    var height:NSLayoutConstraint!
    var type:pickerType = .kdefault
    var showPicker:Bool = false {
        didSet{
            if showPicker == true {
                buttom.constant = 0.0
            }
            else{
                buttom.constant = -height.constant
            }
        }
        
    }
 
    init(rootView:UIView,selectedDate:Date,minDate:Date?,maxDate:Date?,toolBtnTitle:String,ishidden:Bool) {
        super.init()
        //Initializing
        let container = UIView()
//        let datePicker = UIDatePicker()
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(ClickDone(_:)))
        doneBtn.title = toolBtnTitle
        let flxWidth = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let toolbar = UIToolbar()
        toolbar.items = [flxWidth,doneBtn]
        
        container.addSubview(datePicker)
        container.addSubview(toolbar)
        rootView.addSubview(container)
        
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        let toolbartop = toolbar.topAnchor.constraint(equalTo: container.topAnchor)
        let toolbarleft = toolbar.leftAnchor.constraint(equalTo: container.leftAnchor)
        let toolbarright = toolbar.rightAnchor.constraint(equalTo: container.rightAnchor)
        let toolbarHeight = toolbar.heightAnchor.constraint(equalToConstant: 50)
        
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        let datePickerTop = datePicker.topAnchor.constraint(equalTo: toolbar.bottomAnchor)
        let datePickerLeft = datePicker.leftAnchor.constraint(equalTo: container.leftAnchor)
        let datePickerRight = datePicker.rightAnchor.constraint(equalTo: container.rightAnchor)
        let datePickerButtom = datePicker.bottomAnchor.constraint(equalTo: container.bottomAnchor)
    container.addConstraints([toolbartop,toolbarleft,toolbarright,datePickerTop,datePickerLeft,datePickerRight,datePickerButtom])
        toolbar.addConstraint(toolbarHeight)
        
        container.translatesAutoresizingMaskIntoConstraints = false
        buttom = container.bottomAnchor.constraint(equalTo: rootView.bottomAnchor)
        let leading = container.leadingAnchor.constraint(equalTo: rootView.leadingAnchor)
        let trailing = container.trailingAnchor.constraint(equalTo: rootView.trailingAnchor)
        height = container.heightAnchor.constraint(equalToConstant: 250.0)
        
        container.addConstraint(height)
        rootView.addConstraints([buttom,leading,trailing])
        
        showPicker = ishidden
        
    }
    init(rootView:UIView,dataArray:[String],color:UIColor?,customView:UIView?,toolBtnTitle:String,ishidden:Bool) {
        super.init()
        let container = UIView()
        
        pickerview.delegate = self
        pickerview.dataSource = self
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(ClickDone(_:)))
        doneBtn.title = toolBtnTitle
        let flxWidth = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let toolbar = UIToolbar()
        toolbar.items = [flxWidth,doneBtn]
        
        container.addSubview(pickerview)
        container.addSubview(toolbar)
        rootView.addSubview(container)
        
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        let toolbartop = toolbar.topAnchor.constraint(equalTo: container.topAnchor)
        let toolbarleft = toolbar.leftAnchor.constraint(equalTo: container.leftAnchor)
        let toolbarright = toolbar.rightAnchor.constraint(equalTo: container.rightAnchor)
        let toolbarHeight = toolbar.heightAnchor.constraint(equalToConstant: 50)
        
        pickerview.translatesAutoresizingMaskIntoConstraints = false
        let pickerviewTop = pickerview.topAnchor.constraint(equalTo: toolbar.bottomAnchor)
        let pickerviewLeft = pickerview.leftAnchor.constraint(equalTo: container.leftAnchor)
        let pickerviewRight = pickerview.rightAnchor.constraint(equalTo: container.rightAnchor)
        let pickerviewButtom = pickerview.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        container.addConstraints([toolbartop,toolbarleft,toolbarright,pickerviewTop,pickerviewLeft,pickerviewRight,pickerviewButtom])
        toolbar.addConstraint(toolbarHeight)
        
        container.translatesAutoresizingMaskIntoConstraints = false
        buttom = container.bottomAnchor.constraint(equalTo: rootView.bottomAnchor)
        let leading = container.leadingAnchor.constraint(equalTo: rootView.leadingAnchor)
        let trailing = container.trailingAnchor.constraint(equalTo: rootView.trailingAnchor)
        height = container.heightAnchor.constraint(equalToConstant: 250.0)
        
        container.addConstraint(height)
        rootView.addConstraints([buttom,leading,trailing])
        showPicker = ishidden
    }
    @objc func ClickDone(_ sender:AnyObject) {
        if type == .kdate {
            if delegate != nil {
                delegate?.didSelectDatePicker(value:datePicker.date)
            }
        }
        else{
            let row = pickerview.selectedRow(inComponent: 0)
            let data = dataArray[row]
            if delegate != nil {
                delegate?.didSelectPickerView(value: data)
            }
        }
        
        
    }
}

extension customPicker:UIPickerViewDataSource,UIPickerViewDelegate{
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataArray.count
    }
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataArray[row]
    }
//    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        let data = dataArray[row]
//
//        if delegate != nil {
//            delegate?.didSelectPickerView(value: data)
//        }
//    }
}
