//
//  ViewController.swift
//  PokemonAlamofireApp
//
//  Created by Jorge Amores Ortiz on 28/09/2019.
//  Copyright © 2019 Jorge Amores Ortiz. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var jsonArray: NSArray?
    var nameArray: Array<String> = []
    var imageURLArray: Array<String> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Asignamos el Delegado y el DataSource de nuestra Tabla
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        //Llamamos al a función que realizará la descarga de datos de la API
        downloadDataFromAPI()
    }
    
    //Función que descargará los datos de nuestra API alojada en Apiary
    func downloadDataFromAPI(){
        //1.
        Alamofire.request("http://private-4c65fa-pokemonappalamofire.apiary-mock.com/pokemonList").responseJSON { response in
             //2.
             if let JSON = response.result.value{
                //3.
                self.jsonArray = JSON as? NSArray
                //4.
                for item in self.jsonArray! as! [NSDictionary]{
                   //5.
                   let name = item["name"] as? String
                   let imageURL = item["image"] as? String
                   self.nameArray.append((name)!)
                   self.imageURLArray.append((imageURL)!)
                }
                //6.
                self.tableView.reloadData()
        
             }
          }
    }

    // MARK: - Funciones propias de nuestra Tabla
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PokemonCell
        
          cell.pokemonName.text = self.nameArray[indexPath.row]
        
          let url = URL(string: self.imageURLArray[indexPath.row])
          cell.pokemonImage.af_setImage(withURL: url!)
        
          return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let bounds = UIScreen.main.bounds
        let height = bounds.size.height
        
        return height/3
    }

}

