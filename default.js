function addItem(name) {
	var item = new TMenuItem(Menu);
	item.Caption = name;
	print(item.Caption);
	Menu.Items.Add(item);
}
addItem("name");