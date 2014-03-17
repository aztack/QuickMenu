use controls;
print(controls);
print(ScAlt);
function addItem(name) {
	var item = new TMenuItem(Menu);
	item.Caption = name;
	Menu.Items.Add(item);
	item.OnClick = function(){
		print("a");
	};
}
addItem("a");
addItem("b");
addItem("-");
addItem("c");