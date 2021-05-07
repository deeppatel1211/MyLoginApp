//
//  LogInTableViewController.swift
//  MyLoginApp
//
//  Created by ios on 04/05/21.
//

import UIKit
import FBSDKLoginKit

class LogInTableViewController: UITableViewController {
    
    @IBOutlet weak var btnFacebook: FBLoginButton!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        if let token = AccessToken.current,
        !token.isExpired {
        // User is logged in, do work such as go to next view controller.
        }else{
            btnFacebook.permissions = ["public_profile", "email"]
            btnFacebook.delegate = self
        }
    }
    
    @IBAction func btnLoginClicked(_ sender: UIButton) {
        LoginValidationCode()
    }
    
    @IBAction func btnSignupClicked(_ sender: UIButton) {
        if let signupVC = self.storyboard?.instantiateViewController(identifier: "SignUpTableViewController") as? SignUpTableViewController{
            self.navigationController?.pushViewController(signupVC, animated: true)
        }
    }

}


extension LogInTableViewController{
    //        override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //            return UIScreen.main.bounds.height
    //        }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let tableViewHeight = self.tableView.frame.height
        let contentHeight = self.tableView.contentSize.height
        
        let centeringInset = (tableViewHeight - contentHeight) / 2.0
        let topInset = max(centeringInset, 0.0)
        
        self.tableView.contentInset = UIEdgeInsets(top: topInset, left: 0.0, bottom: 0.0, right: 0.0)
    }
}

extension LogInTableViewController{
    
    fileprivate func LoginValidationCode() {
        if let email = txtEmail.text, let password = txtPassword.text{
            if !email.validateEmailId(){
                openAlert(title: "Alert", message: "Email Address not found", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions:[{ _ in
                    print("Okay Clicked!")
                }])
            }else if !password.validatePassword(){
                openAlert(title: "Alert", message: "Please Enter Valid Password", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions:[{ _ in
                    print("Okay Clicked!")
                }])
            }else{
                //Navigation - Home Screen
            }
        }else{
            openAlert(title: "Alert", message: "Please add Detail.", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions:[{ _ in
                print("Okay Clicked!")
            }])
        }
    }
}

extension LogInTableViewController : LoginButtonDelegate{
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        let token = result?.token?.tokenString
        
        let request = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields": "id, email, name, first_name, middle_name, last_name, short_name, name_format, age_range, picture"], tokenString: token, version: nil, httpMethod: .get)
        request.start { (connection, result, error) in
            print("\(result)")
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("Logout")
    }
    
    
}
