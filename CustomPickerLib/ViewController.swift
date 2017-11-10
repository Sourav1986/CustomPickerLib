//
//  ViewController.swift
//  CustomPickerLib
//
//  Created by Sourav@Beas on 08/11/17.
//  Copyright © 2017 personal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let picker = customPicker(rootView: view, selectedDate: Date(), minDate: nil, maxDate: nil, toolBtnTitle: "Done", ishidden: false)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

