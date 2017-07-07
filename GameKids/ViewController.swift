//
//  ViewController.swift
//  GameKids
//
//  Created by Bruno Augusto Mendes Barreto Alves on 1/18/16.
//  Copyright © 2016 Bruno Augusto Mendes Barreto Alves. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource,UIPickerViewDelegate, UIAlertViewDelegate {

    var seg = 0
    var tentativas = 0
    var question = 1
    let questions = ["Animal peludo que faz miau?","Objeto redondo que é usado no futebol?", "Pais sede da copa do mundo de 2014"]
    let answer = ["gato","bola","brasil"]
    let abc = ["a","b","c","d","e","f","g","h","i","j","l","m","n","o","p","q","r","s","t","u","v","x","z"]
    //111+alertView.height
    @IBOutlet weak var tempo: UILabel!
    @IBOutlet weak var ViewAlert: UIView!
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var alertView: NSLayoutConstraint!
    @IBOutlet weak var buttonTips: UIButton!
    @IBOutlet weak var textQuestions: UILabel!
    @IBOutlet weak var pickerAnswer: UIPickerView!
    @IBOutlet weak var textAnswer: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.layoutIfNeeded()
        self.ViewAlert.layoutIfNeeded()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "letras")!)
        var timer = Timer();
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(ViewController.update), userInfo: nil, repeats: true)

        self.pickerAnswer.delegate = self
        self.pickerAnswer.dataSource = self
        self.fillScreen()
        
    }
    func update(){
        seg += 1
        self.tempo.text = String(seg)
        print(seg)
    }
    func fillScreen(){
        self.star1.isHidden = true
        self.star2.isHidden = true
        self.star3.isHidden = true
        
        UIView.animate(withDuration: 5.0, animations: { () -> Void in
            self.view.layoutIfNeeded()
            self.ViewAlert.layoutIfNeeded()
            self.alertView.constant = -280
          })
        
        
        seg=0
        
        //self.ViewAlert.hidden = true
        self.textQuestions.text = self.questions[question]
        self.textAnswer.text = self.answer[question]
        self.textAnswer.isHidden = true
        self.pickerAnswer.reloadAllComponents()
        tentativas = self.answer[question].characters.count
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        tentativas = self.answer[question].characters.count
        return self.answer[question].characters.count
    }

    @IBAction func showResp(_ sender: AnyObject) {
        self.textAnswer.isHidden = false
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.abc.count
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return abc[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        var resp = ""
        for a in 0  ..< self.answer[question].characters.count {
           resp += abc[self.pickerAnswer.selectedRow(inComponent: a)]
        }
        tentativas -= 1
        
        print(resp)
        if resp == answer[question] {
            let alert = UIAlertView(title: "Parabéns", message: "Você acertou!!", delegate: self, cancelButtonTitle: "OK")
            //self.ViewAlert.hidden = false
            
           self.ViewAlert.setNeedsLayout()

            UIView.animate(withDuration: Double(2), delay: 1.0, options: UIViewAnimationOptions(), animations: { () -> Void in
                self.view.layoutIfNeeded()
                self.ViewAlert.layoutIfNeeded()
                if self.seg > 20 && self.seg<=40{
                    self.star1.isHidden = false
                    self.star2.isHidden = false
                    self.star3.isHidden = true
                }else if self.seg > 40{
                    self.star1.isHidden = false
                    self.star2.isHidden = true
                    self.star3.isHidden = true
                }else{
                    self.star1.isHidden = false
                    self.star2.isHidden = false
                    self.star3.isHidden = false
                }
                self.alertView.constant = 100
                
                
                }, completion: { (finished: Bool) -> Void in
            })
            
//            UIView.animateWithDuration(7.0, delay: 1.0, usingSpringWithDamping: 0.5,
//                initialSpringVelocity: 0.5, options: [], animations: {
//                }, completion: nil)
            
            //alert.show()

        }else{
            let alert = UIAlertView(title: "Ops", message: "Você ainda não acertou, continue tentando!!!", delegate: self, cancelButtonTitle: "OK")
            if tentativas == 0{
                alert.show()
            }
        }
        
    }
    
    @IBAction func ok(_ sender: UIButton) {
//        self.pickerAnswer.reloadAllComponents()
        let component = self.pickerAnswer.numberOfComponents
        
        for i in 0..<component {
            self.pickerAnswer.selectRow(0, inComponent: i, animated: true)
        }
        
        var randNumber = Int(arc4random_uniform(3))
        while(self.question == randNumber) {
            randNumber = Int(arc4random_uniform(3))
        }
        self.question = randNumber
        self.fillScreen()

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

