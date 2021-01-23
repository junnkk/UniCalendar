//
//  HomeViewController.swift
//  TeamProject
//
//  Created by KM on 2021/01/07.
//

import UIKit
import RealmSwift
import Foundation

class HomeViewController: UIViewController , UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var homeNavigationTitle: UINavigationItem!
    
    var events: [Event] = api.callEvent()
    
    var selectedCellBefore: Int = 0
    // 섹션당 row 수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print(eventList.accessibilityElementCount())
        //return eventList.accessibilityElementCount()
        return events.count
    }
    
    // indexPath 각 (section, row)에 맞는 cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as! EventCell
        let event = events[indexPath.row]
        
        cell.eventNameLabel.text = event.eventName
        
        let today = df.date(from: df.string(from : Date.init()))
        let dDay = df.date(from: df.string(from: event.eventDday))!

        let interval = dDay.timeIntervalSince(today!)
        let d = Int(interval / 86400)
        cell.dDayLabel.text = "D - " + String(d)
        
        cell.importanceLabel.text = "중요해요"
        //cell.importanceImageLabel.text = String(event.events[indexPath.row].)
        
        cell.progressLabel.text = "영차영차"
        
        var progressPercent: Float = 0
        if event.subEvents.count != 0 {
            var subIsDoneNum = 0
            
            subIsDoneNum = event.subEvents.filter(
                { (sub: SubEvent) -> Bool in return
                sub.subEventIsDone == true }).count
            
            progressPercent = Float(subIsDoneNum) / Float(event.subEvents.count)
           
            cell.progressView.setProgress(progressPercent, animated: false)
            

        }
        cell.progressPercentLabel.text = String(round(progressPercent*1000)/10) + "%"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "moveToDetail", sender: indexPath.row)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // DetailView로 데이터 넘기기
        guard let destinationController: HomeDetailViewController = segue.destination as? HomeDetailViewController else { return }
        guard let row = sender as? Int else { return }


        // let event = events[row]
        
        // destinationController.dDay = event.eventDday
        // destinationController.eventName = event.eventName
        
        // selectedCellBefore =  tableView.indexPathForSelectedRow!.row

        destinationController.selectedCell = row


        // print("Selected Cell Before: \(tableView.indexPathForSelectedRow!.row)")
    
        tableView.deselectRow(at:tableView.indexPathForSelectedRow!, animated: true)

    }

    @IBAction func unwindToHomeFromDetail(_ unwindSegue: UIStoryboardSegue) {
        print("from Detail to Home")
    }
    @IBAction func unwindToHome(segue: UIStoryboardSegue) {
        print("from Add to Home")
        events = api.callEvent()
        // print(events)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        tableView.dataSource = self
        tableView.delegate = self
    
    }

    override func viewWillAppear(_ animated: Bool) {
        let df = DateFormatter()
        df.locale = Locale(identifier: "ko")
        df.dateFormat = "M월 dd일 eeee"
        homeNavigationTitle.title = df.string(from: Date.init())
    }
    
}
