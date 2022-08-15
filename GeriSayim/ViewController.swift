import UIKit

class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var liste = [Etkinlik]()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
      
        veriTabanıKopyala()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        liste = EtkinlikDao().tumEtkinliklerAL()
        tableView.reloadData()
    }
    func veriTabanıKopyala(){
        let bundleYolu = Bundle.main.path(forResource: "EtkinlikDB", ofType: ".db")
        let hedefYolu = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let fileManager = FileManager.default
        
        let kopyalanacakYer = URL(fileURLWithPath: hedefYolu).appendingPathComponent("EtkinlikDB.db")
        
        if fileManager.fileExists(atPath: kopyalanacakYer.path){
            print("VeriTabanıZatenKopyalanmış")
        }else{
            do{
                try fileManager.copyItem(atPath: bundleYolu!, toPath: kopyalanacakYer.path)
            }catch{
                print(error.localizedDescription)
            }
        }
    }

    @IBAction func ekleButton(_ sender: Any) {
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return liste.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "hucre", for: indexPath) as! hucreTableViewCell
        
        cell.etkinlikAdiLabel.text = liste[indexPath.row].etkinlikAdi!
        cell.etkinlikTarihiLAbel.text = liste[indexPath.row].etkinlikTarihi!
        
        
        return cell
    }
    
    
}
