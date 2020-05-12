class HomePresenter
  def allBrands
    Brand.all.map { |brand| [brand.name, brand.id] }
  end

  def allCategories
    Category.all.map { |category| [category.name, category.id] }
  end

  def allStores
    Store.all.map { |store| [store.name, store.id] }
  end

end
