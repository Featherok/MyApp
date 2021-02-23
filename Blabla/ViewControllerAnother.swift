//
//  ViewControllerAnother.swift
//  Blabla
//
//  Created by Robert Pervushen on 27.01.2021.
//

import UIKit
import AudioToolbox
import AVFoundation

class ViewControllerAnother: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var y: UIImpactFeedbackGenerator.FeedbackStyle = .soft
    let systemSoundID: SystemSoundID = 1104
    static var personChoise = true
    override func viewDidLoad() {
        
        super.viewDidLoad()
            let tap = UITapGestureRecognizer(target: self, action: #selector(ViewControllerAnother.onClickReset))
            counter.isUserInteractionEnabled = true
            counter.addGestureRecognizer(tap)
        ViewControllerAnother.temp = 0
        tableView.dataSource = self
        tableView.delegate = self
        

        // Do any additional setup after loading the view.
    }
    
    let taps = ["Soft", "Rigid", "Light", "Medium"]
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var counter: UILabel!
    @IBAction func scoresPage(_ sender: Any) {
    }
    
    @objc func onClickReset () { // reset the counter to 0
        if ViewControllerAnother.personChoise == false { // just in case to refresh the variable
            ViewControllerAnother.personChoise = false
        }
        else {
//            print(ViewControllerAnother.personChoise)
            ViewController.score.append(String(ViewControllerAnother.temp))
            TableView.scoreForThis = ViewController.score
            ViewControllerAnother.temp = 0
            counter.text = "0"
//            print("its worked")
        }
    }
    override func viewDidDisappear(_ animated: Bool) {
        ViewController.score.append(String(ViewControllerAnother.temp))
        TableView.scoreForThis = ViewController.score
        ViewControllerAnother.temp = 0
        counter.text = "0"
    }
    static var temp = 0
    @IBAction func onClickIndeed() {
        ViewControllerAnother.temp += 1
        counter.text = String(ViewControllerAnother.temp)
        UIImpactFeedbackGenerator(style: y).impactOccurred()
     
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taps.count
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        switch indexPath.row {
        case 0:
            UIImpactFeedbackGenerator(style: .soft).impactOccurred()
            AudioServicesPlaySystemSound(systemSoundID)
            y = .soft
        case 1:
            UIImpactFeedbackGenerator(style: .rigid).impactOccurred()
            AudioServicesPlaySystemSound(systemSoundID)
            y = .rigid
        case 2:
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
            y = .light
            AudioServicesPlaySystemSound(systemSoundID)
        case 3:
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
            y = .medium
            AudioServicesPlaySystemSound(systemSoundID)
        default:
            UIImpactFeedbackGenerator(style: y).impactOccurred()
            y = .soft
            AudioServicesPlaySystemSound (systemSoundID)
        }
        print(indexPath.row)

//        self.performSegue(withIdentifier: "segueToUserForm", sender: taps[indexPath.row])
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        
        cell.textLabel!.text = taps[indexPath.row]
        return cell
    }

    
}

