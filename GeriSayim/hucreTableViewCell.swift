
import UIKit

class hucreTableViewCell: UITableViewCell {
    @IBOutlet var geriSayimSüreLabel: UILabel!
    @IBOutlet var etkinlikAdiLabel: UILabel!
    @IBOutlet var etkinlikTarihiLAbel: UILabel!
    @IBOutlet var etkinlikEmojiImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func kalanZamanAyarla(indexPath:IndexPath){
        if let listTarih = ViewController.liste[indexPath.row].etkinlikTarihi{
            
            let formatter = DateFormatter()
            formatter.dateFormat = "d-MM-yyyy HH:mm"
        
            let bugun = formatter.date(from: formatter.string(from: Date()))
            
            let etkinlikTarihi = formatter.date(from: listTarih)
            let diffSeconds = etkinlikTarihi!.timeIntervalSinceReferenceDate - bugun!.timeIntervalSinceReferenceDate
            
            let dakika = Double(diffSeconds/60)
            let saat = Double(dakika/60)
            let gün = Double(saat/24)
          
            if saat <= 0{
                geriSayimSüreLabel.text = "Etkinlik Süresi geçti"
            }else{
                if gün < 1{
                    geriSayimSüreLabel.text = "\(Int(round(saat))) Saat Kaldı"
                }else{
                    geriSayimSüreLabel.text = "\(Int(gün)) Gün Kaldı"
                }
            }
        }
    }
    
    func hexStringToUIColor(hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func renkAta(indexPath:IndexPath)-> [UIColor]{
        switch indexPath.row % 5 {
        case 1:
            return   [hexStringToUIColor(hex: "#77d640"),hexStringToUIColor(hex: "#52952b")]
        case 2:
            return   [hexStringToUIColor(hex: "#f19838"),hexStringToUIColor(hex: "#a46d25")]
        case 3:
            return   [hexStringToUIColor(hex: "#112e50"),hexStringToUIColor(hex: "#0a2038")]
        case 4:
            return   [hexStringToUIColor(hex: "#ea455b"),hexStringToUIColor(hex: "#a43040")]
        case 5:
            return   [hexStringToUIColor(hex: "#3679f5"),hexStringToUIColor(hex: "#2254aa")]
        default:
            return [UIColor.blue,UIColor.systemBlue]
        }
    }
}


/*
                            KULLANILAN RENKLER
    GENEL-GERİSAYIM
 #77d640 — #52952b
 #f19838 — #a46d25
 #112e50 — #0a2038
 #ea455b — #a43040
 #3679f5 — #2254aa
 */
