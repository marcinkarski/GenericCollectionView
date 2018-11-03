import UIKit

class GenericCollectionViewController<T, Cell: UICollectionViewCell>: UICollectionViewController {
    
    var items: [T]
    var configure: (Cell, T) -> Void
    var selectHandler: (T) -> Void
    
    init?(items: [T], configure: @escaping (Cell, T) -> Void, selectHandler: @escaping (T) -> Void) {
        self.items = items
        self.configure = configure
        self.selectHandler = selectHandler
        super.init(collectionViewLayout: UICollectionViewLayout())
        self.collectionView.register(Cell.self, forCellWithReuseIdentifier: "Cell")
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! Cell
        let item = items[indexPath.item]
        configure(cell, item)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let item = items[indexPath.item]
        selectHandler(item)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
