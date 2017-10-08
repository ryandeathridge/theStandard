//
//  ViewController.swift
//  theStandard
//
//  Created by RYAN DEATHRIDGE on 4/10/17.
//  Copyright © 2017 RYAN DEATHRIDGE. All rights reserved.
//

import UIKit
import CoreData
import Charts

class PistolVC: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var chartView: LineChartView!
    
    var controller: NSFetchedResultsController<Entry>!
    var stores = [Entry]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        tableView.delegate = self
        tableView.dataSource = self
        
        attemptFetch()
        updateGraph()
        
    
        
    }
    
   
    
    func configureCell(cell: ItemCell, indexPath: NSIndexPath) {
        
       let item = controller.object(at: indexPath as IndexPath)
        cell.configureCell(item: item)
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell") as! ItemCell
        configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
        
        return cell
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let sections = controller.sections {
            return sections.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = controller.sections {
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let objs = controller.fetchedObjects , objs.count > 0 {
            let item = objs[indexPath.row]
            performSegue(withIdentifier: "EditEntry", sender: item)
        }
            
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditEntry" {
            if let destination = segue.destination as? addItemVC {
                if let item = sender as? Entry {
                    destination.itemToEdit = item
                }
            }
        }
    }


    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }


    
    func attemptFetch() {
        let fetchRequest: NSFetchRequest<Entry> = Entry.fetchRequest()
        let dateSort = NSSortDescriptor(key: "created", ascending: false)
        let spreadSort = NSSortDescriptor(key: "spread", ascending: false)
        fetchRequest.sortDescriptors = [dateSort]
        fetchRequest.sortDescriptors = [spreadSort]
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
       
        controller.delegate = self
        self.controller = controller
        
        
        do {
            
            try controller.performFetch()
        
        
        } catch {
            
            let error = error as NSError
            print ("\(error)")
        }
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch(type) {
            
        case.insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
            
        case.delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            break
        case.update:
            if let indexPath = indexPath {
                let cell = tableView.cellForRow(at: indexPath) as! ItemCell
                configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
            }
            break
        case.move:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
            
            
        }
        
    }
    
    
    
    // GRAPH CODE
    
    
    func updateGraph() {
    
        let fetchRequest: NSFetchRequest<Spread> = Spread.fetchRequest()
        let spreadSort = NSSortDescriptor(key: "spread", ascending: true)
        fetchRequest.sortDescriptors = [spreadSort]
       
     
        
      //  let item = Spread(context: context)
            //let spread = item.spread
            var horizontal = [309.0, 401.0, 122.0, 123.0, 225.0, 256.0, 306.0, 401.0, 390.0]

    
        
        var lineChartEntry = [ChartDataEntry]()
        
        for i in 0..<horizontal.count {
            
            let value = ChartDataEntry(x: Double(Float(i)), y: Double(Float(horizontal[i])))
            lineChartEntry.append(value)
        }
        let line1 = LineChartDataSet(values: lineChartEntry, label: "")
        line1.colors = [NSUIColor.red]
        
        let data = LineChartData()
        data.addDataSet(line1)
        
        
        chartView.data = data
        chartView.chartDescription?.text = ""
        chartView.drawBordersEnabled = false
        
        chartView.tintColor = UIColor.red
        
       
        chartView.xAxis.drawGridLinesEnabled = false
        chartView.xAxis.drawLabelsEnabled = false
        
        chartView.leftAxis.drawLabelsEnabled = false
        
        chartView.rightAxis.drawLabelsEnabled = false
        chartView.leftAxis.drawGridLinesEnabled = false
        chartView.rightAxis.drawGridLinesEnabled = false
        
        
    
        
        
        
       
    }
    
 

    
    }

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    


