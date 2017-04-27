//
//  LoginVC.swift
//  JYYTPointAcc
//
//  Created by shjyyt on 2017/3/31.
//  Copyright © 2017年 shjy. All rights reserved.
//

import UIKit

import Alamofire

class LoginVC: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
         phoneNumberTextField.addTarget(self, action: #selector(textFielddidChanged), for: .editingChanged)
         passwordTextField.addTarget(self, action: #selector(textFielddidChanged), for: .editingChanged)

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
         title = "登录"
         
    }
    // MARK: 按钮操作
    @IBAction func clearPhoneNumberButtonClick(_ sender: Any) {
    }
    @IBAction func seePasswodButtonClick(_ sender: Any) {
   
    }
    
    @IBAction func loginButtonClick(_ sender: Any) {
    }
    
    @IBAction func forgetPasswordButtonClick(_ sender: Any) {
    }
    
    @IBAction func goRegistButtonClick(_ sender: Any) {
    }
    
    @objc private func textFielddidChanged(textfield:UITextField){
  
        setSignInButtonStatus(iscanUse: (phoneNumberTextField.text?.lengthOfBytes(using: .utf8))! > 5 && (phoneNumberTextField.text?.lengthOfBytes(using: .utf8))! < 13)
            
    }
    func setSignInButtonStatus(iscanUse:Bool){
        if iscanUse{
            loginButton.isUserInteractionEnabled = true;
            loginButton.backgroundColor =  UIColor.RGB(242, 196, 57)
        }else{
            loginButton.isUserInteractionEnabled = false;
            loginButton.backgroundColor = UIColor.RGB(204, 204, 204)
        }

    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        view.endEditing(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
