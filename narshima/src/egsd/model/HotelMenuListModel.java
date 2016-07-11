package egsd.model;

public class HotelMenuListModel {
	
	String MenuDesc;
	
	int MenuQuan;
	String ItemAction;
	int ItemQuan;
	String actionType;
	public String getActionType() {
		return actionType;
	}

	public void setActionType(String actionType) {
		this.actionType = actionType;
	}

	
	
	public HotelMenuListModel(String menuDesc, int menuQuan, String itemAction,
			int itemQuan, String actionType) {
		super();
		MenuDesc = menuDesc;
		MenuQuan = menuQuan;
		ItemAction = itemAction;
		ItemQuan = itemQuan;
		this.actionType = actionType;
	}

	@Override
	public String toString() {
		return "HotelMenuListModel [MenuDesc=" + MenuDesc + ", MenuQuan="
				+ MenuQuan + ", ItemAction=" + ItemAction + ", ItemQuan="
				+ ItemQuan + ", actionType=" + actionType + "]";
	}

	public String getMenuDesc() {
		return MenuDesc;
	}
	public void setMenuDesc(String menuDesc) {
		MenuDesc = menuDesc;
	}
	public int getMenuQuan() {
		return MenuQuan;
	}
	public void setMenuQuan(int menuQuan) {
		MenuQuan = menuQuan;
	}
	public String getItemAction() {
		return ItemAction;
	}
	public void setItemAction(String itemAction) {
		ItemAction = itemAction;
	}
	public int getItemQuan() {
		return ItemQuan;
	}
	public void setItemQuan(int itemQuan) {
		ItemQuan = itemQuan;
	}

}
