import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var sıralamaButton: UIBarButtonItem!
    
    
    static var liste = [Etkinlik]()
    
    static var image = "xmark"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        veriTabanıKopyala()
    }
    
    /*
     küçüktür = azdan çoğa
     büyüktür = çoktan aza
     eşittir = sıralamasız
     */
    
    override func viewWillAppear(_ animated: Bool) {
        
        ViewController.liste = EtkinlikDao().tumEtkinliklerAL()
        tableView.reloadData()
        
        
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetay"{
            let GVC = segue.destination as! detayViewController
            GVC.etkinlik = ViewController.liste[sender as! Int]
        }
    }
    @IBAction func sıralamaButton(_ sender: Any) {
        switch ViewController.image {
        case "xmark": ViewController.image = "lessthan"
        case "lessthan": ViewController.image = "greaterthan"
        case "greaterthan": ViewController.image = "xmark"
        default:
            ViewController.image = "xmark"
        }
        sıralamaButton.image = UIImage.init(systemName: ViewController.image)
        ViewController.liste = EtkinlikDao().tumEtkinliklerAL()
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
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
   
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return ViewController.liste.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "hucre", for: indexPath) as! hucreTableViewCell
        
        cell.etkinlikAdiLabel.text = ViewController.liste[indexPath.row].etkinlikAdi!
        cell.etkinlikTarihiLAbel.text = ViewController.liste[indexPath.row].etkinlikTarihi!
        cell.kalanZamanAyarla(indexPath: indexPath)
        cell.backgroundColor =  cell.renkAta(indexPath: indexPath)[0]
        cell.geriSayimSüreLabel.backgroundColor = cell.renkAta(indexPath: indexPath)[1]
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toDetay", sender: indexPath.row)
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let sil = UIContextualAction(style: .destructive, title: "Sil") { action, view, bool in
            if let id = ViewController.liste[indexPath.row].etkinlikId{
                EtkinlikDao().etkinlikSil(etkinlikId:id)
            }
            
            ViewController.liste = EtkinlikDao().tumEtkinliklerAL()
            tableView.reloadData()
        }
        return UISwipeActionsConfiguration(actions: [sil])
    }
    
}
