
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

}
