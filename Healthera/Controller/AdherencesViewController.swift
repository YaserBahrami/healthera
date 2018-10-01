//
//  AdherencesViewController.swift
//  Healthera
//
//  Created by yaser on 10/1/18.
//  Copyright © 2018 Barsam. All rights reserved.
//

import UIKit

class AdherencesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var adherencesTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        welcomeText()
        

        let nib = UINib.init(nibName: "AdherencesTableViewCell", bundle: nil)
        self.adherencesTableView.register(nib, forCellReuseIdentifier: "MyCustomCell")
//
//        self.adherencesTableView.separatorStyle = .none
//        self.adherencesTableView.backgroundColor = UIColor.white

    }
    
    func welcomeText(){
        let date = Date()// Aug 25, 2017, 11:55 AM
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date) //11
        print(hour)
        
        if hour >= 6 && hour < 12{
            print("morning")
        }else if hour >= 12 && hour < 18{
            print("afternoon")
        }else if hour >= 18 && hour < 24{
            print("evening")
        }else{
            print("night")
        }
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
//    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 20
//    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCustomCell", for: indexPath) as! AdherencesTableViewCell

        return cell
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v = UIView()
        v.backgroundColor = UIColor.clear
        return v
    }
    

}
