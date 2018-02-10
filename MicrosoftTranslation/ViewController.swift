//
//  ViewController.swift
//  MicrosoftTranslation
//
//  Created by Pavan Kumar Reddy on 21/01/18.
//  Copyright © 2018 Nagarjuna. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITextFieldDelegate , XMLParserDelegate
{
    
    @IBOutlet var textFieldSource: UITextField!
    
    @IBOutlet var textFieldTranslation: UITextField!
    
    @IBOutlet var buttonClear: UIButton!
    
    @IBOutlet var buttonTranslate: UIButton!
    
    @IBOutlet var targetSegmentedControl: UISegmentedControl!
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    var sourceLanguage = "en"
    var targetLanguage = "fr"
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        textFieldSource.delegate = self
        textFieldTranslation.delegate = self
        targetSegmentedControl.selectedSegmentIndex = 1
    }
    
    //MARK:- Button actions
    @IBAction func actionTranslate(_ sender: UIButton)
    {
        guard let text = textFieldSource.text , !text.isEmpty else {
            return
        }
        
        print(targetLanguage)
        activityIndicator.startAnimating()
        TransLationModel.shared.translate(sourceText: text, fromLanguage: sourceLanguage, toLanguage: targetLanguage) { (data) in
            
            let xmlParser = XMLParser.init(data: data)
            xmlParser.delegate = self
            xmlParser.parse()
        }
    }
    
    @IBAction func actionClearTextFiledsData(_ sender: Any)
    {
        textFieldSource.text = nil
        textFieldTranslation.text = nil
    }
    
    //MARK:- Segment actions
    @IBAction func actionSourceSelection(_ sender: UISegmentedControl)
    {
        switch sender.selectedSegmentIndex
        {
        case 0:
            sourceLanguage = "en"
        case 1:
            sourceLanguage = "fr"
        case 2:
            sourceLanguage = "de"
        default:
            break
        }
        
        textFieldTranslation.text = nil
        textFieldSource.text = nil
    }
    
    @IBAction func actionTargetSelection(_ sender: UISegmentedControl)
    {
        switch sender.selectedSegmentIndex
        {
        case 0:
            targetLanguage = "en"
        case 1:
            targetLanguage = "fr"
        case 2:
            targetLanguage = "de"
        default:
            break
        }
        
        textFieldTranslation.text = nil
        textFieldSource.text = nil
    }
    
    
    //MARK:- TextFiled delegates
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
    
    //MARK:- XMLParserDelegate
    func  parser(_ parser: XMLParser, foundCharacters string: String)
    {
        print("Text@@@:\(string)")
        if !string.isEmpty
        {
            activityIndicator.stopAnimating()
            textFieldTranslation.text = string
        }
    }
    
}

