import UIKit

class ekleViewController: UIViewController {
    @IBOutlet var etkinlikAdiTextField: UITextField!
    @IBOutlet var detayTextField: UITextField!
    @IBOutlet var etkinlikTarihiTextField: UITextField!
   
    
    var datePicker:UIDatePicker?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .dateAndTime
        etkinlikTarihiTextField.inputView = datePicker
        datePicker?.addTarget(self, action: #selector(tarihGoster(datePicker:)), for: .allEvents)
        
        
    }
    
    @objc func tarihGoster(datePicker:UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d-MM-yyyy HH:mm"
        let alınanTarih = dateFormatter.string(from: datePicker.date)
        etkinlikTarihiTextField.text = alınanTarih
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
    }// ekrana tıklanınca klavyenin yok olması
    
    @IBAction func ekleButton(_ sender: Any) {
        if etkinlikTarihiTextField.text == ""{
            etkinlikTarihiTextField.placeholder = "Lütfen tarih seçimi yapın!!!!"
        }else{
            if let ad = etkinlikAdiTextField.text, let tarih = etkinlikTarihiTextField.text, let detay = detayTextField.text{
                
                let formatter = DateFormatter()
                formatter.dateFormat = "d-MM-yyyy HH:mm"
                
                let bugun = formatter.date(from: formatter.string(from: Date()))
                let etkinlikTarihi = formatter.date(from: tarih)
                let diffSeconds = etkinlikTarihi!.timeIntervalSinceReferenceDate - bugun!.timeIntervalSinceReferenceDate
                // ***Bugün*** gibi değişken olmayan daha spesifik bir tarih ile arasındaki saniyeyi bulmamız gerekiyor bu sistem yanlış. 
                print(diffSeconds)
                EtkinlikDao().etkinlikEkle(etkinlikAdi: ad, etkinlikTarihi: tarih, etkinlikDetay: detay,etkinlikSaniye: Int(diffSeconds))
                navigationController?.popViewController(animated: true)
                
                
                
                
            }
        }
        
    }
}

/*
 if let listTarih = ViewController.liste[indexPath.row].etkinlikTarihi{
 
 let formatter = DateFormatter()
 formatter.dateFormat = "d-MM-yyyy HH:mm"
 
 let bugun = formatter.date(from: formatter.string(from: Date()))
 let etkinlikTarihi = formatter.date(from: listTarih)
 let diffSeconds = etkinlikTarihi!.timeIntervalSinceReferenceDate - bugun!.timeIntervalSinceReferenceDate
 
 let dakika = Double(diffSeconds/60)
 let saat = Double(dakika/60)
 let gün = Double(saat/24)
 
 if gün < 1{
 geriSayimSüreLabel.text = "\(Int(round(saat))) Saat Kaldı"
 }else{
 geriSayimSüreLabel.text = "\(Int(gün)) Gün Kaldı"
 }
 
 }
 
 */
