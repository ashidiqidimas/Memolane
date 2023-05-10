import SwiftUI
import UIKit

struct MemoryItem: Identifiable, Hashable {
    public var id: UUID = UUID()
    var image: UIImage?
    var title: String = ""
    var body: String = ""
}

extension MemoryItem {
    static var preview = MemoryItem(
        image: UIImage(named: "concert"),
        title: "Keluar Kantor Macet Banget Guys",
        body: "Keluar kantor doang susah banget padahal w mau jogging sebelum maghrib, tapi ini mah nyampe kosan maghrib tapi yaudahlah"
    )
}
