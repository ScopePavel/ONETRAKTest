//
//  MainTableViewController.swift
//  OneTrakTest
//
//  Created by Pavel Scope on 05/02/2019.
//  Copyright © 2019 Paronkin Pavel. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
    var mySteps: [Steps] = []
    var arrIndexPath = [IndexPath]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        self.fillTableView()
        
    }
    
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = mySteps.count
        return count*2-1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let space = indexPath.row%2
        var spaceCell: Bool
        
        if space == 0 {
            spaceCell = true
        } else {
            spaceCell = false
        }
        
        
        
        if(spaceCell) {
            let allStepsNumber = (self.mySteps[indexPath.row/2].aerobic + self.mySteps[indexPath.row/2].run + self.mySteps[indexPath.row/2].walk) as NSNumber
            
            let aerobicNumber   = self.mySteps[indexPath.row/2].aerobic as NSNumber
            let runNumber       = self.mySteps[indexPath.row/2].run     as NSNumber
            let walkNumber      = self.mySteps[indexPath.row/2].walk    as NSNumber
            let date            = self.mySteps[indexPath.row/2].date    as NSNumber
            
            let width = self.view.frame.width
            let height = self.view.frame.height
            let delta = width/100
            
            let walkLength       = width * CGFloat(walkNumber.doubleValue)/CGFloat(allStepsNumber.doubleValue) - 2*delta
            let acrobicLength    = width * CGFloat(aerobicNumber.doubleValue)/CGFloat(allStepsNumber.doubleValue)  - 2*delta
            let runLength        = width * CGFloat(runNumber.doubleValue)/CGFloat(allStepsNumber.doubleValue)  - 2*delta
            
            
            
            
            let acrobicPointX   = walkLength  + 3*delta
            let runPointX       = acrobicLength+walkLength + 4*delta
            
            let walkRect = CGRect.init(x:2*delta, y: 0, width: walkLength, height: height/100)
            let acrobicRect = CGRect.init(x:acrobicPointX , y: 0, width: acrobicLength, height: height/100)
            let runRect = CGRect.init(x: runPointX, y: 0, width: runLength, height: height/100)
            
            let walk = UIView.init(frame: walkRect)
            let aerobic = UIView.init(frame: acrobicRect)
            let run = UIView.init(frame: runRect)
            
            walk.backgroundColor    = .walk
            aerobic.backgroundColor = .aerobic
            run.backgroundColor     = .run
            
            walk.layer.cornerRadius = delta/2
            walk.clipsToBounds = true
            walk.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
            
            
            
            run.layer.cornerRadius = delta/2
            
            run.clipsToBounds = true
            run.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
            
            var valueGoal = 1000
            
            
            
            if UserDefaults.standard.integer(forKey: "Key") == 0 {
                valueGoal = 5000
                UserDefaults.standard.set(5000, forKey: "Key")
            } else {
                valueGoal = UserDefaults.standard.integer(forKey: "Key")
            }
            
            
            
            
            
            if allStepsNumber.intValue < valueGoal {
                
                let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: "Identifier", for: indexPath)
                guard let cell = dequeuedCell as? CustomCell else {
                    return dequeuedCell
                }
                cell.dateLabel.text = self.createDateString(dateDouble: date.doubleValue)
                cell.aerobicLabel.text  = aerobicNumber.stringValue
                cell.allStepsLabel.text = allStepsNumber.stringValue + " / \(valueGoal) steps"
                cell.runLabel.text      = runNumber.stringValue
                cell.walkLabel.text     = walkNumber.stringValue
                
                cell.progressView.addSubview(walk)
                cell.progressView.addSubview(aerobic)
                cell.progressView.addSubview(run)
                
                

               
                if arrIndexPath.contains(indexPath) == false {
                    var positions : [CGFloat] = []
                    for view in cell.progressView.subviews {
                        positions.append(view.center.x)
                        view.center.x = -view.center.x
                    }
                    
                    UIView.animate(withDuration: 2) {
                        
                        cell.progressView.subviews[0].center.x += 2*positions[0]
                        cell.progressView.subviews[1].center.x += 2*positions[1]
                        cell.progressView.subviews[2].center.x += 2*positions[2]
                    }
                    arrIndexPath.append(indexPath)
                }
                

                
                
                return cell
            } else {
                
                let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: "Identifier2", for: indexPath)
                guard let cell = dequeuedCell as? CustomCell2 else {
                    return dequeuedCell
                }
                cell.dateLabel.text = self.createDateString(dateDouble: date.doubleValue)
                cell.aerobicLabel.text  = aerobicNumber.stringValue
                cell.allStepsLabel.text = allStepsNumber.stringValue + " / \(valueGoal) steps"
                cell.runLabel.text      = runNumber.stringValue
                cell.walkLabel.text     = walkNumber.stringValue
                
                cell.progressView.addSubview(walk)
                cell.progressView.addSubview(aerobic)
                cell.progressView.addSubview(run)
                
                if arrIndexPath.contains(indexPath) == false {
                var positions : [CGFloat] = []
                for view in cell.progressView.subviews {
                    positions.append(view.center.x)
                    view.center.x = -view.center.x
                }
                cell.goalImageView.center.y = -view.center.y
                
                UIView.animate(withDuration: 2) {
                    cell.progressView.subviews[0].center.x += 2*positions[0]
                    cell.progressView.subviews[1].center.x += 2*positions[1]
                    cell.progressView.subviews[2].center.x += 2*positions[2]
                    cell.goalImageView.center.y -= 2*self.view.center.y
                }
                    arrIndexPath.append(indexPath)
                }
                
                return cell
            } } else {
            
            let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: "Identifier3", for: indexPath)
            guard let cell = dequeuedCell as? CustomCell3 else {
                return dequeuedCell
            }
            
            
            return cell
        }
        
        
    }
    
    func createDateString(dateDouble:Double) -> String {
        let date = Date(timeIntervalSince1970: dateDouble/1000)
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let formatDateString = formatter.string(from: date as Date)
        return formatDateString
    }
    
    
    func fillTableView() {
        ServerManager.shared.getSteps { (steps, _) in
            self.mySteps = steps
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    

    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let valueGoal = UserDefaults.standard.integer(forKey: "Key")
        
        let allStepsNumber = (self.mySteps[indexPath.row/2].aerobic + self.mySteps[indexPath.row/2].run + self.mySteps[indexPath.row/2].walk) as NSNumber
        
        let space = indexPath.row%2
        
        if space == 0 {
            if allStepsNumber.intValue < valueGoal {
                return 148
            } else {
                return 212
            }
        } else {
            return 37
        }
        
        
        
    }
    
}
