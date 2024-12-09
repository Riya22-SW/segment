//
//  ViewController.swift
//  SegmentDemo
//
//  Created by admin on 04/12/24.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var jokearr:[JokeModel]=[]
    var catarr:[CatModel]=[]

   @IBOutlet weak var tablesegment: UISegmentedControl!
    
    @IBOutlet weak var tablevc1: UITableView!
    @IBOutlet weak var tablevc2: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        callJokeApi()
        callCatApi()
        reloadUI()
        // Do any additional setup after loading the view.
    }
    
    
    
    func callJokeApi(){
        ApiManager().fetchJokes{ result in
            switch result {
                
            case.success(let data):
                self.jokearr.append(contentsOf: data)
                print(self.jokearr)
                self.tablevc1.reloadData()
                
                
            case.failure(let failure):
                debugPrint("something went wrong in calling API")
                
            }
        }
    }
    
    func callCatApi(){
        ApiManager().fetchcat{ result in
            switch result {
                
            case.success(let data):
                self.catarr.append(contentsOf: data)
                print(self.catarr)
                self.tablevc2.reloadData()
                
                
            case.failure(let failure):
                debugPrint("something went wrong in calling API")
                
            }
        }
    }

    func setup(){
        tablevc1.delegate=self
        tablevc1.dataSource=self
        tablevc1.register(UINib(nibName: "tblCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        tablevc2.delegate=self
        tablevc2.dataSource=self
        tablevc2.register(UINib(nibName: "tblCell", bundle: nil), forCellReuseIdentifier: "cell")
    }
    func reloadUI() {
            DispatchQueue.main.async {
                
                if self.tablesegment.selectedSegmentIndex == 0 {
                    
                    self.tablevc1.isHidden = false
                    self.tablevc1.isHidden = true
                    self.tablevc2.reloadData()

                } else if self.tablesegment.selectedSegmentIndex == 1 {
                    
                    
                    self.tablevc2.isHidden = false
                    self.tablevc1.isHidden = true
                    self.tablevc2.reloadData()

                }
            }
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tablesegment.selectedSegmentIndex == 0 ? jokearr.count:catarr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? tblCell else {
                       return UITableViewCell()
               }
                   
               let currSeg = tablesegment.selectedSegmentIndex
               
               switch currSeg {
               case 0:
                   guard indexPath.row < jokearr.count else {
                       print("Index out of bounds for JokeArr")
                       return cell
                   }
                   let joke = jokearr[indexPath.row]
                   configureCell(cell, with: joke)
                   
               case 1:
                   guard indexPath.row < catarr.count else {
                       print("Index out of bounds for CatArr")
                       return cell
                   }
                   let cat = catarr[indexPath.row]
                   configureCell1(cell, with: cat)
                   
               default:
                   break
               }
               
               return cell
//        let currseg = tablesegment.selectedSegmentIndex
//        let cell = (currseg == 0) ? tablevc1.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! tblCell:
//        tablevc2.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! tblCell
//        if currseg == 0{
//            cell.lbl1.text=String(jokearr[indexPath.row].id)
//            cell.lbl2.text=jokearr[indexPath.row].type
//            cell.lbl3.text=jokearr[indexPath.row].setup
//            
//        }
//        else if currseg == 1{
//            
//            cell.lbl1.text=String(catarr[indexPath.row].id)
//            cell.lbl2.text=catarr[indexPath.row].name
//            cell.lbl3.text=catarr[indexPath.row].origin
//            
//        }
//        return cell
    }
    private func configureCell(_ cell: tblCell, with joke: JokeModel){
        cell.lbl1.text=String(joke.id)
        cell.lbl2.text=joke.type
        cell.lbl3.text=joke.setup
    }
    
    private func configureCell1(_ cell: tblCell, with cat: CatModel){
        cell.lbl1.text=String(cat.id)
        cell.lbl2.text=cat.name
        cell.lbl3.text=cat.origin
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 200
        }
    @IBAction func tableseg(_ sender: Any) {
        print("current selected segment: \(tablesegment.selectedSegmentIndex)")
              reloadUI()
    }
    
    }

    
    
    
   
    


