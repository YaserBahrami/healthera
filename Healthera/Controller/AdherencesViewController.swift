//
//  AdherencesViewController.swift
//  Healthera
//
//  Created by yaser on 10/1/18.
//  Copyright © 2018 Barsam. All rights reserved.
//

import UIKit

class AdherencesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var notesView: UIView!
    
    @IBOutlet weak var welcome: UILabel!
    @IBOutlet weak var adherencesTableView: UITableView!
    @IBOutlet weak var DateLabel: UILabel!
    
    var scrollDate = 0
    
    var tableData = [AdherencesModel]()
    
    @IBOutlet weak var popLabel1: UILabel!
    @IBOutlet weak var popLabel2: UILabel!
    
    @IBOutlet weak var note: UITextView!
    @IBOutlet weak var statusLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        welcomeText()
        setDateLabel()
        getAdherencesOfDay()
        
        let nib = UINib.init(nibName: "AdherencesTableViewCell", bundle: nil)
        self.adherencesTableView.register(nib, forCellReuseIdentifier: "MyCustomCell")

        self.adherencesTableView.separatorStyle = .none
        self.adherencesTableView.backgroundColor = UIColor.clear
        
        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dissmissPopup))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)

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
    func setDateLabel(){
        var date = Date()
        
        
        if scrollDate > 0 {
                date = date.NextDays(DayToAdd: scrollDate)
        }else{
                date = date.PreviousDays(DayToMinus: scrollDate)
        }
        
        let calender = Calendar.current
        let day = calender.dateComponents([.day], from: date).day
        
        if scrollDate == 0 {
            DateLabel.text = "Today, " + date.monthName() + " " + "\( day!)"
        }else{
            DateLabel.text = date.monthName() + " " + "\(day!)"
        }
    }
    func getAdherencesOfDay(){
        var date = Date()
        if scrollDate > 0 {
            date = date.NextDays(DayToAdd: scrollDate)
        }else{
            date = date.PreviousDays(DayToMinus: scrollDate)
        }
        
        let start = date.startOfDay.timeIntervalSince1970
        let end = date.endOfDay.timeIntervalSince1970
        print(start)
        print(end)
        
        AdherencesService.shared.getAdherences(start: Int(start), end: Int(end)) { (result) in
            switch result {
            case .success(let value):
                self.tableData = value
                self.adherencesTableView.reloadData()
            case .failure(let error):
                print("error")
            }
        }
        
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return tableData.count
        
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
        
        if tableData[indexPath.section].note != ""{
           cell.infoLabel.text = tableData[indexPath.section].note
        }else{
            cell.infoLabel.text = "data not providen"
        }
        
        cell.statusLabel.text = tableData[indexPath.section].action
        
        let date = Date(timeIntervalSince1970: TimeInterval(tableData[indexPath.section].alarm_time!))
        let calendar = Calendar.current
        var hour = calendar.component(.hour, from: date)
        
        if hour < 12 {
            cell.timeLabel.text = "\(hour) AM."
        }else{
            hour = hour - 12
            cell.timeLabel.text = "\(hour) PM."

        }
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v = UIView()
        v.backgroundColor = UIColor.clear
        return v
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var remedy_id = tableData[indexPath.section].remedy_id
        var patient_id = KeychainAccess.shared.getUserId()
        
        //fetch data
    
        AdherencesService.shared.getSpecificRemedy(pId: patient_id, rId: remedy_id!) { result in
            switch result {
            case .success(let value):
                self.showPopUp(status: self.tableData[indexPath.section].action!, note: self.tableData[indexPath.section].note!, name: value.medicine_name!, type: value.medicine_type!)
                
            case .failure(let error):
                print("error")
            }
        }
        
    }
    
    func showPopUp(status: String, note: String, name: String, type: String){
        self.view.addSubview(notesView)
        
        /*
         popLabel1: UILabel!
         @IBOutlet weak var popLabel2: UILabel!
         
         @IBOutlet weak var note: UITextView!
         @IBOutlet weak var statusLabel: U
         */
        
        self.popLabel1.text = name
        self.popLabel2.text = type
        self.note.text = note
        self.statusLabel.text = status
        
        notesView.center = self.view.center
        notesView.layer.cornerRadius = 10

        notesView.alpha = 0
        UIView.animate(withDuration: 0.4) {
            self.notesView.alpha = 1
            self.adherencesTableView.isUserInteractionEnabled = false
            
        }
    }
    @objc func dissmissPopup(){
        UIView.animate(withDuration: 0.3) {
            self.notesView.alpha = 0
            self.notesView.removeFromSuperview()
            self.adherencesTableView.isUserInteractionEnabled = true
            
        }
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
    
    @IBAction func previousDay(_ sender: Any) {
        scrollDate = scrollDate - 1
        setDateLabel()
        getAdherencesOfDay()
    }
    
    @IBAction func nextDay(_ sender: Any) {
        scrollDate = scrollDate + 1
        setDateLabel()
        getAdherencesOfDay()
    }
}
