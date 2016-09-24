//
//  ViewController.swift
//  TrafficSim
//
//  Created by Chris Weld on 4/29/16.
//  Copyright © 2016 Chris Weld. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController/*, UIPickerViewDelegate, UIPickerViewDataSource */ {
   
    
    
   // let header = ["Authorization": "Bearer c1yejXSE1zYOQcD0UuEwreLuvlPjX1obsLh4wp06SbE9OvfA3XvRWqEfqdJVEkzUEvzMPAY46aLzKviwTlNjrM",
   //               "Content-Type":"application/json"]
    
    
    let header = ["Authorization": "Bearer 9myIixOr5gjLiipryXpHmIkQr0fWuymMMAIQXodTba8vpYJ9JyHpMfi0NeweS04DrS524LjfUbxLlgcaNmDX8T",
                  "Content-Type":"application/json"]
    
    @IBOutlet weak var sendSolarPanelEvent: UIButton!
    
    /* Device Id */
    
    @IBOutlet weak var device_id: UITextField!
    

    /* Power Generated */
    
    @IBOutlet weak var power_generated: UISlider!
    @IBOutlet weak var power_generated_value: UILabel!
    
    @IBAction func power_generated_changed(sender: AnyObject) {
        
        //self.power_generated_value.text = "\(self.power_generated.value)"

        let currentVal = Int(power_generated.value)
        power_generated_value.text = "\(currentVal)"    
        
    }
    
    /* Power Ordinary */
    
    @IBOutlet weak var power_ordinary: UISlider!
    @IBOutlet weak var power_ordinary_value: UILabel!
    
    
    @IBAction func power_ordinary_changed(sender: AnyObject) {
        
        let currentVal = Int(power_ordinary.value)
        power_ordinary_value.text = "\(currentVal)"
        
    }
    
    /* Power Demand */
    
    
    @IBOutlet weak var power_demand: UISlider!
    @IBOutlet weak var power_demand_value: UILabel!
    
    
    @IBAction func power_demand_changed(sender: AnyObject) {
        
        let currentVal = Int(power_demand.value)
        power_demand_value.text = "\(currentVal)"
        
    }

    
    /* Remaining Time */
    
    @IBOutlet weak var remaining_time: UISlider!
    @IBOutlet weak var remaining_time_value: UILabel!

    @IBAction func remaining_time_changed(sender: AnyObject) {
        
        let currentVal = Int(remaining_time.value)
        remaining_time_value.text = "\(currentVal)"
        
    }
    
    /* Saving CO2 */
    
    @IBOutlet weak var saving_co2: UISlider!
    @IBOutlet weak var saving_co2_value: UILabel!
    
    @IBAction func saving_co2_changed(sender: AnyObject) {
        
        let currentVal = Int(saving_co2.value)
        saving_co2_value.text = "\(currentVal)"
        
    }
    
    /* Total Energy */
    
    @IBOutlet weak var total_energy: UISlider!
    @IBOutlet weak var total_energy_value: UILabel!

    @IBAction func total_energy_changed(sender: AnyObject) {
        
        let currentVal = Int(total_energy.value)
        total_energy_value.text = "\(currentVal)"
        
    }
    
   /* Total Monthly Energy */
    
    @IBOutlet weak var total_monthly_energy: UISlider!
    @IBOutlet weak var total_monthly_energy_value: UILabel!
    
    @IBAction func total_monthly_energy_changed(sender: AnyObject) {
        
        let currentVal = Int(total_monthly_energy.value)
        total_monthly_energy_value.text = "\(currentVal)"
        
    }
    
    /* Free Minutes */
    
    @IBOutlet weak var free_minutes: UISlider!
    @IBOutlet weak var free_minutes_value: UILabel!
    
    @IBAction func free_minutes_changed(sender: AnyObject) {
        
        let currentVal = Int(free_minutes.value)
        free_minutes_value.text = "\(currentVal)"
        
    }
    
    /* Battery Backup */
    
    @IBOutlet weak var battery_backup: UISlider!
    @IBOutlet weak var battery_backup_value: UILabel!
    
    @IBAction func battery_backup_changed(sender: AnyObject) {
        
        let currentVal = Int(345) //Int(battery_backup.value)
        battery_backup_value.text = "\(currentVal)"
        
    }
    
    /* Battery Strength */
    
    @IBOutlet weak var battery_strength: UISlider!
    @IBOutlet weak var battery_strength_value: UILabel!
    
    @IBAction func battery_strength_changed(sender: AnyObject) {
        
        let currentVal = Int(battery_strength.value)
        battery_strength_value.text = "\(currentVal)"
        
    }
    
    /* Battery Charging */
    
    @IBOutlet weak var battery_charging: UISlider!
    @IBOutlet weak var battery_charging_value: UILabel!
    
    @IBAction func battery_charging_changed(sender: AnyObject) {
        
        let currentVal = Int(battery_charging.value)
        battery_charging_value.text = "\(currentVal)"
        
    }
    
    /* Engergy Source */
    
    @IBOutlet weak var energy_source_button: UIButton!
    
    var energySource = "panel"
    
    @IBAction func energy_source_click(sender: AnyObject) {

        if(energy_source_button.titleLabel!.text == "Panel") {
            energySource = "battery"
            energy_source_button.setTitle("Battery", forState: .Normal)
        }
        if(energy_source_button.titleLabel!.text == "Battery") {
            energySource = "panel"
            energy_source_button.setTitle("Panel", forState: .Normal)
        }
    }
    
    /*
    
    var pickArray = ["panel","battery"]
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickArray[row]
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickArray.count
    }
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if(row == 0) {
            energy_source_value.text = "panel"
        }
        if(row == 1) {
            energy_source_value.text = "battery"
        }
        
    }
     
    */
    
    /* Error */
    
    @IBOutlet weak var error_value: UITextField!

    
    override func viewDidAppear(animated: Bool) {

        sendSolarPanelEvent.addTarget(self, action: #selector(ViewController.sendPanelEvent(_:)), forControlEvents: .TouchUpInside)
    }
    
    func sendPanelEvent(sender: UIButton) {
  
        let url = "https://ingestion-nspa59aanxnx.us3.sfdcnow.com/streams/cloudplugs001/solar_power_endpo001/event"
        let URL = NSURL(string: url)!
        
        let powergenint = Int(self.power_generated.value)
        let powerOrd = Int(self.power_ordinary.value)
        let powerDemand = Int(self.power_demand.value)
        let remainTime = Int(self.remaining_time.value)
        let savingCo2 = Int(self.saving_co2.value)
        let totalenergy = Int(self.total_energy.value)
        let totalmonthlyenergy = Int(self.total_monthly_energy.value)
        let freeminutes = Int(self.free_minutes.value)
        let batterybackup =  Int(345) // Int(self.battery_backup.value)
        let batterstrength = Int(self.battery_strength.value)
        let batterycharging = Int(self.battery_charging.value)

        let data = [ "Device_Id__c":self.device_id.text!,
                     "Date_Survey__c": "1462837064792",
                     "Power_Generated__c": powergenint,
                     "Power_Ordinary__c": powerOrd,
                     "Power_Demand__c": powerDemand,
                     "Remaining_Time__c": remainTime,
                     "SavingCO2__c": savingCo2,
                     "Total_Energy__c": totalenergy,
                     "Total_Monthly_Energy__c": totalmonthlyenergy,
                     "Free_Minutes__c": freeminutes,
                     "Battery_Backup__c": batterybackup,
                     "Battery_Strength__c": batterstrength,
                     "Battery_Charging__c": batterycharging,
                     "Energy_Source__c": self.energySource,
                     "Next_Load_Shedding__c": "1462837064792",
                     "Error__c": self.error_value.text!
        ]
        
        print(data)
        
        let dubug = Alamofire.request(.POST, URL, parameters: data as? [String : AnyObject], encoding: ParameterEncoding.JSON, headers: header)
        //debugPrint(dubug)
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //energy_source_picker.delegate = self
        //energy_source_picker.dataSource = self
        device_id.text = "15234A023B23X1"
        // Do any additional setup after loading the view, typically from a nib.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

