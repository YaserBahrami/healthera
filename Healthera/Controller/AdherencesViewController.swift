//
//  AdherencesViewController.swift
//  Healthera
//
//  Created by yaser on 10/1/18.
//  Copyright © 2018 Barsam. All rights reserved.
//

import UIKit

class AdherencesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var welcome: UILabel!
    @IBOutlet weak var adherencesTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        welcomeText()
        

        let nib = UINib.init(nibName: "AdherencesTableViewCell", bundle: nil)
        self.adherencesTableView.register(nib, forCellReuseIdentifier: "MyCustomCell")

        self.adherencesTableView.separatorStyle = .none
        self.adherencesTableView.backgroundColor = UIColor.clear

    }
    
    func welcomeText(){
        let date = Date()// Aug 25, 2017, 11:55 AM
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date) //11
        print(hour)
        
        if hour >= 6 && hour < 12{
            welcome.text = "Good Morning!"
        }else if hour >= 12 && hour < 18{
            welcome.text = "Good Afternoon!"
        }else if hour >= 18 && hour < 24{
            welcome.text = "Good Evening!"
        }else{
            welcome.text = "Good Night!"
        }
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 10
        
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCustomCell", for: indexPath) as! AdherencesTableViewCell
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v = UIView()
        v.backgroundColor = UIColor.clear
        return v
    }
    
    @IBAction func logOut(_ sender: Any) {
        
        
        AuthenticationService.shared.logout { (result) in
            if result == true{
                let device_token = KeychainAccess.shared.getDeviceToken()
                KeychainAccess.shared.clearKeychains()
                KeychainAccess.shared.setDeviceToken(device_token: device_token)
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = mainStoryboard.instantiateViewController(withIdentifier: "login")
                UIApplication.shared.keyWindow?.rootViewController = viewController
            }
        }
        
        
    }
    
}
