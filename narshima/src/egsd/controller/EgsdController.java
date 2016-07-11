package egsd.controller;

import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.codehaus.jackson.map.ObjectMapper;
import org.json.JSONArray;
import org.json.JSONObject;
import org.parse4j.Parse;
import org.parse4j.ParseCloud;
import org.parse4j.ParseException;
import org.parse4j.ParseFile;
import org.parse4j.ParseGeoPoint;
import org.parse4j.ParseObject;
import org.parse4j.ParseQuery;
import org.parse4j.ParseUser;
import org.parse4j.util.ParseRegistry;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.google.zxing.WriterException;

import egsd.model.DirectoryDetails;
import egsd.model.DirectoryDetailsModel;
import egsd.model.EgsdDirectoryItemObjects;
import egsd.model.EgsdDirectoryItemParseObject;
import egsd.model.EgsdHotelObjects;
import egsd.model.EgsdLoctionObject;
import egsd.model.EgsdLoginFields;
import egsd.model.EgsdMenuObjects;
import egsd.model.EgsdPhonesObjects;
import egsd.model.EgsdSearchTemplateObjects;
import egsd.model.EgsdStyleObjects;
import egsd.model.EgsdTemplateObjects;
import egsd.model.EgsdUserObjects;
import egsd.model.HotelMenuListModel;
import egsd.model.LocationAdminCount;
import egsd.service.GenerateQRCode;
import egsd.service.GenericComparator;
import egsd.service.PrintImage;
import egsd.service.SendEmail;

@Controller
public class EgsdController {
	List<ParseObject> results = null;
	List<ParseObject> changeLocresults = null;
	List<ParseObject> resultsDirectoryItem = null;

	static ModelAndView mav = new ModelAndView();
		
	static{
		ParseRegistry.registerSubclass(EgsdDirectoryItemParseObject.class);
		ParseRegistry.registerSubclass(EgsdLoginFields.class);
		//String applicationId = "FAbluZyN0hpXGpudGXrt9WOgvUQCxey3KEGALLle";
		//String restAPIKey = "kuw3smoLkqoRfYbNKSPM4btXtlB33sdg9jGaIi65";
		String applicationId = "rVlDUBf2Ekr5Rf3S6wMUozek7U1t18oKKUUUsg6d";
		String restAPIKey = "ddQqY4QaFOfZbZxhEhsS24K4PeKHrkW3xYT3T4Pm";
		System.out.println("b4 initialization");
		System.out.println(Parse.getParseAPIUrl("connect"));
		Parse.initialize(applicationId, restAPIKey);
		//Parse.initialize(new Parse.Configuration.Builder().applicationId(applicationId).clientKey(null).server("https://secure-reef-40094.herokuapp.com/parse/").build());

		System.out.println("aftr initialization");
		System.out.println("----------------------------");

	}

	public static ModelAndView getDataFromParse(HttpServletRequest request) {

		System.out.println("this is from getDataFromParse");

		// ModelAndView mav=new ModelAndView();

		mav.clear();

		System.out.println("userName:" + request.getParameter("userName"));
		System.out.println("user:" + request.getParameter("user"));

		// mav.addObject("user", request.getAttribute("user"));
		// mav.addObject("userName", request.getAttribute("userName"));

		List<ParseObject> results = null;
		List<ParseObject> changeLocresults = null;

		ParseQuery<ParseObject> queryForLocationAdminWasEmpty = ParseQuery.getQuery("_User");
		queryForLocationAdminWasEmpty.whereEqualTo("user", "Location Admin");
		// queryForLocationAdminWasEmpty.whereEqualTo("locationId", "empty");

		List<ParseObject> listOfEmptyAdmins = null;

		try {
			listOfEmptyAdmins = queryForLocationAdminWasEmpty.find();
		} catch (ParseException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		}
		List<EgsdUserObjects> listOfUserObjects = new ArrayList<EgsdUserObjects>(100);

		try {
			Iterator<ParseObject> iteratorForEmptyAdmins = listOfEmptyAdmins.listIterator();

			while (iteratorForEmptyAdmins.hasNext()) {

				ParseObject parseObjectHavingEmptyAdmins = iteratorForEmptyAdmins.next();

				listOfUserObjects.add(new EgsdUserObjects(parseObjectHavingEmptyAdmins.getObjectId(),
						parseObjectHavingEmptyAdmins.getString("username"), null,
						parseObjectHavingEmptyAdmins.getString("email"), parseObjectHavingEmptyAdmins.getString("user"),
						parseObjectHavingEmptyAdmins.getString("locationId"),
						parseObjectHavingEmptyAdmins.getString("firstname"),
						parseObjectHavingEmptyAdmins.getString("lastname"),
						parseObjectHavingEmptyAdmins.getString("phone")));
			}

		} catch (NullPointerException npe) {

			listOfUserObjects
					.add(new EgsdUserObjects("empty", "Please Add Location Admin", null, null, null, null, null, null,null));

		}

		mav.addObject("listOfEmptyLocationAdmins", listOfUserObjects);

		// list of Templates
		ParseQuery<ParseObject> queryForTemplateObjects = ParseQuery.getQuery("Template");
		queryForTemplateObjects.whereNotEqualTo("type", "group");

		List<ParseObject> listOfTemplateObjects = null;

		try {
			listOfTemplateObjects = queryForTemplateObjects.find();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		try {
			Iterator<ParseObject> iteratorForTemplateObjects = listOfTemplateObjects.listIterator();
			List<EgsdTemplateObjects> listOfEgsdTemplateObjects = new ArrayList<EgsdTemplateObjects>(20);

			while (iteratorForTemplateObjects.hasNext()) {

				ParseObject templateObjects = iteratorForTemplateObjects.next();

				listOfEgsdTemplateObjects
						.add(new EgsdTemplateObjects(templateObjects.getObjectId(), templateObjects.getString("Name"),
								templateObjects.getObjectId(), templateObjects.getBoolean("Customized")));

			}

			mav.addObject("listOfEgsdTemplateObjects", listOfEgsdTemplateObjects);

		} catch (NullPointerException npe) {

		}

		// list of Groups
		ParseQuery<ParseObject> queryForGroupObjects = ParseQuery.getQuery("Template");
		queryForGroupObjects.whereEqualTo("type", "group");

		List<ParseObject> listOfGroupObjects = null;

		try {
			listOfGroupObjects = queryForGroupObjects.find();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		try {
			Iterator<ParseObject> iteratorForGroupObjects = listOfGroupObjects.listIterator();
			List<EgsdTemplateObjects> listOfEgsdGroupObjects = new ArrayList<EgsdTemplateObjects>(20);

			while (iteratorForGroupObjects.hasNext()) {

				ParseObject templateObjects = iteratorForGroupObjects.next();

				listOfEgsdGroupObjects
						.add(new EgsdTemplateObjects(templateObjects.getObjectId(), templateObjects.getString("Name"),
								templateObjects.getObjectId(), templateObjects.getBoolean("Customized")));

			}

			mav.addObject("listOfEgsdGroupObjects", listOfEgsdGroupObjects);

		} catch (NullPointerException npe) {

		}

		ParseQuery<ParseObject> changeLocquery = ParseQuery.getQuery("Location");
		// changeLocquery.whereEqualTo("user",
		// request.getParameter("name"));
		try {
			changeLocresults = changeLocquery.find();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println(changeLocresults);
		List<EgsdLoctionObject> changeLoc = new ArrayList<EgsdLoctionObject>(20);

		try {
			Iterator<ParseObject> changeLocIterator = changeLocresults.listIterator();
			while (changeLocIterator.hasNext()) {
				ParseObject locchange = changeLocIterator.next();

				EgsdLoctionObject e =new EgsdLoctionObject();
			    e.setObjectId(locchange.getObjectId());
			    e.setDirectory(locchange.getString("Directories"));
			    e.setName(locchange.getString("Name"));
			    e.setZipcode(locchange.getString("zipcode"));
			    e.setAddress(locchange.getString("Address1"));
			    e.setAddress2(locchange.getString("Address2"));
			    e.setStreet(locchange.getString("Street"));
			    e.setTown(locchange.getString("Town"));
			    e.setSiteId(locchange.getString("GroupSiteId"));
			    e.setGroupName(locchange.getString("GroupName"));
			    e.setCountry(locchange.getString("Country"));
			    e.setParentDirectoryId(locchange.getString("ParentLocationID"));
			    e.setDescription(locchange.getString("description"));

			    changeLoc.add(e);

			}
		} catch (NullPointerException npe) {

		}

		// System.out.println(changeLoc);
		mav.addObject("changeLoc", changeLoc);
		mav.addObject("selectLocObj", changeLoc);

		String directoryIdForLocationId = null;

		if (request.getParameter("objectId") != null) {
			ParseQuery<ParseObject> queryForDirectoryId = ParseQuery.getQuery("DirectoryItem");
			queryForDirectoryId.whereEqualTo("objectId", request.getParameter("objectId"));
			List<ParseObject> listObjectHavingRequiredDirectoryId = null;

			try {
				listObjectHavingRequiredDirectoryId = queryForDirectoryId.find();
			} catch (ParseException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}

			Iterator<ParseObject> iteratorHavingDirectoryId = listObjectHavingRequiredDirectoryId.listIterator();

			ParseObject parseObjectHavingDirectoryId = iteratorHavingDirectoryId.next();

			directoryIdForLocationId = parseObjectHavingDirectoryId.getString("LocationId");
		}

		System.out.println("Location id:" + directoryIdForLocationId);

		ParseQuery<ParseObject> query = ParseQuery.getQuery("Location");
		if (request.getParameter("userName") != null)
			if (request.getParameter("userName").equals("Location Admin"))
				query.whereEqualTo("objectId", directoryIdForLocationId);
		// in case of selecting location
		/*
		 * if(request.getParameter("locId")!=null)
		 * query.whereEqualTo("objectId",request.getParameter("locId"));
		 */
		// in case of editing locations
		if (request.getParameter("objectIdOfLocation") != null)
			if (request.getParameter("userName").equals("Location Admin"))
				query.whereEqualTo("objectId", request.getParameter("objectIdOfLocation"));
		// incase of adding location
		/*
		 * if(request.getParameter("userName")!=null)
		 * if(request.getParameter("userName").equals("Location Admin"))
		 * if(request.getAttribute("locationId")!=null)
		 * query.whereEqualTo("objectId",request.getAttribute("locationId"));
		 * 
		 */

		// query.whereEqualTo("user", request.getParameter("name"));
		// query.whereEqualTo("Name", request.getParameter("locName"));

		try {
			results = query.find();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println(results);
		List<EgsdLoctionObject> hlobj = new ArrayList<EgsdLoctionObject>();
		try {
			Iterator<ParseObject> hlit = results.listIterator();
			ParseObject p = null;
			while (hlit.hasNext()) {
				p = hlit.next();
				/*
				 * System.out.println(p.getObjectId());
				 * System.out.println(p.getString("Directories"));
				 * System.out.println(p.getString("Name"));
				 * System.out.println(p.getString("zipcode"));
				 * System.out.println(p.getString("Address1"));
				 */

				String logo = "No Image To Display";
				if (p.getParseFile("Logo") != null)
					logo = p.getParseFile("Logo").getUrl();

				String qRCode = "No Image To Display";
				if (p.getParseFile("QRCode") != null)
					qRCode = p.getParseFile("QRCode").getUrl();

				String hotelLogo = "No Image To Display";
				if (p.getParseFile("HotelLogo") != null)
					qRCode = p.getParseFile("HotelLogo").getUrl();

				String footerImage = "No Image To Display";
				if (p.getParseFile("footerImage") != null)
					qRCode = p.getParseFile("FooterImage").getUrl();

				EgsdLoctionObject e = new EgsdLoctionObject();

				e.setObjectId(p.getObjectId());
				e.setDirectory(p.getString("Directories"));
				e.setName(p.getString("Name"));
				e.setZipcode(p.getString("zipcode"));
				e.setAddress(p.getString("Address1"));
				e.setAddress2(p.getString("Address2"));
				e.setStreet(p.getString("Street"));
				e.setTown(p.getString("Town"));
				e.setSiteId(p.getString("siteId"));
				e.setGroupName(p.getString("GroupName"));
				e.setCountry(p.getString("Country"));
				e.setLogo(logo);
				e.setqRCode(qRCode);
				e.setParentDirectoryId(p.getString("ParentLocationID"));
				e.setDescription(p.getString("description"));

				hlobj.add(e);

				// hlobj.add(new
				// EgsdHotelAndLocObj(p.getString("hotel_name"),p.getString("location")));
			}
		} catch (NullPointerException npe) {

		}
		System.out.println(hlobj);

		mav.addObject("locObj", hlobj);
		mav.addObject("locObjForEdit", hlobj);
		mav.addObject("locObjForAddDirectoryItems", hlobj);
		mav.addObject("locObjForEditLocation", hlobj);
		mav.addObject("locObjForDeleteLocation", hlobj);
		mav.addObject("locObjForParentHotel", hlobj);

		// this is for directory items objects

		ParseQuery<EgsdDirectoryItemParseObject> queryForDirectoryItem = ParseQuery.getQuery("DirectoryItem");
		if (request.getParameter("locId") != null)
			queryForDirectoryItem.whereEqualTo("LocationId", request.getParameter("locId"));
		// queryForDirectoryItem.whereEqualTo("DirectoryID",p.getString("Directories"));
		queryForDirectoryItem.orderByAscending("Title");
		queryForDirectoryItem.limit(1000);
		List<EgsdDirectoryItemParseObject> directoryItemParseObjectsList = null;
		try {
			directoryItemParseObjectsList = queryForDirectoryItem.find();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		List<EgsdDirectoryItemObjects> directoryItemObjectsList = new ArrayList<EgsdDirectoryItemObjects>(300);
		System.out.println("Directory items are loaded:");
		try {
			Iterator<EgsdDirectoryItemParseObject> iterator = directoryItemParseObjectsList.listIterator();
			System.out.println("objectId" + "---> " + "DirectoryId" + "--->" + "getParentDirectoryId" + "--->"
					+ "getTitle" + "--->" + "getCaption" + "--->" + "getTimings" + "--->" + "getWebsite" + "--->"
					+ "getEmail" + "--->" + "getPhones");
			int count = 1;
			while (iterator.hasNext()) {

				EgsdDirectoryItemParseObject egsd = iterator.next();
				// System.out.println( count++ +" "+ egsd.getObjectId()
				// + "---> " + egsd.getDirectoryId()
				// + "--->" + egsd.getParentDirectoryId()
				// + "--->" + egsd.getTitle()
				// + "--->" + egsd.getCaption()
				// + "--->" + egsd.getTimings()
				// + "--->" + egsd.getWebsite()
				// + "--->" + egsd.getEmail()
				// + "--phoneId->" + egsd.getPhones()
				// + "--->" + egsd.getStyleID() +"<--StyleID ");
				String img = "No Image To Display";
				if (egsd.getParseFile("Picture") != null)
					img = egsd.getParseFile("Picture").getUrl();
				// System.out.print(img);
				String styleId = null;
				ParseObject StyleIdPO = egsd.getParseObject("StyleId");
				if (egsd.getParseObject("StyleId") != null)
					styleId = StyleIdPO.getObjectId();
				// System.out.println(styleId);

				/*
				 * if(StyleIdPO.getObjectId()!=null) System.out.println(
				 * "StyleID AT Directory Items"+StyleIdPO.getObjectId());
				 */

				directoryItemObjectsList.add(new EgsdDirectoryItemObjects(egsd.getObjectId(), egsd.getDirectoryId(),
						egsd.getTitle(), egsd.getCaption(), egsd.getDescription(), egsd.getTimings(), egsd.getWebsite(),
						egsd.getEmail(), egsd.getParentDirectoryId(), img, styleId, egsd.getPhones(),
						egsd.getParentDirectoryId(), egsd.getLocationId(), egsd.getCustomizedOrder()));

			}
		} catch (NullPointerException npe) {

		}

		System.out.println("before adding dir objs");
		mav.addObject("direcObjList", directoryItemObjectsList);
		mav.addObject("subDirObj", directoryItemObjectsList);
		mav.addObject("subsubDirObj", directoryItemObjectsList);
		mav.addObject("DirObjId", directoryItemObjectsList);
		mav.addObject("DiscriptionObjId", directoryItemObjectsList);
		// adding DirectiryItems for editing values
		mav.addObject("showSubDiscriptionObjId", directoryItemObjectsList);
		mav.addObject("showDiscriptionObjId", directoryItemObjectsList);
		mav.addObject("DiscriptionObjForNavBar", directoryItemObjectsList);
		mav.addObject("subDiscriptionObjForNavBar", directoryItemObjectsList);
		// addind directory Items for Adding DirectoryItems
		mav.addObject("subDiscriptionObjForAddDirItems", directoryItemObjectsList);
		mav.addObject("showSubDiscriptionObjIdForDelete", directoryItemObjectsList);

		System.out.println("aftr adding dir objs");

		System.out.println("in select b4 Phones");

		ParseQuery<ParseObject> queryForPhones = ParseQuery.getQuery("Phones");
		queryForPhones.limit(1000);
		List<ParseObject> phonesParseObjectsList = null;
		try {
			phonesParseObjectsList = queryForPhones.find();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		List<EgsdPhonesObjects> phonesObjectsList = new ArrayList<EgsdPhonesObjects>(200);
		System.out.println("Phone Objects  are loaded:");
		// System.out.println(phonesParseObjectsList);
		try {
			Iterator<ParseObject> phoneIterator = phonesParseObjectsList.listIterator();
			int i = 0;
			while (phoneIterator.hasNext()) {

				ParseObject egsdPhonePO = phoneIterator.next();

				// System.out.println(egsdPhonePO.getObjectId()
				// +"-->"+egsdPhonePO.getString("PhoneId")
				// +"-->"+egsdPhonePO.getString("Type")
				// +"-->"+egsdPhonePO.getString("Ext"));
				phonesObjectsList.add(new EgsdPhonesObjects(egsdPhonePO.getObjectId(), egsdPhonePO.getString("PhoneId"),
						egsdPhonePO.getString("Type"), egsdPhonePO.getString("Ext")));

			}
		} catch (NullPointerException npe) {

		}
		// System.out.println(phonesObjectsList);
		mav.addObject("phonesObjectsList", phonesObjectsList);
		mav.addObject("phonesObjectsListForEdit", phonesObjectsList);
		mav.addObject("phonesObjectsListForDelete", phonesObjectsList);

		ParseQuery<ParseObject> queryForMenu = ParseQuery.getQuery("Menu");
		List<ParseObject> menuParseObjectsList = null;
		try {
			menuParseObjectsList = queryForMenu.find();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		List<EgsdMenuObjects> menuObjectsList = new ArrayList<EgsdMenuObjects>(200);
		System.out.println("Menu Items are loaded:");
		// System.out.println(menuParseObjectsList);
		try {
			Iterator<ParseObject> menuIterator = menuParseObjectsList.listIterator();
			while (menuIterator.hasNext()) {

				ParseObject egsdMenuPO = menuIterator.next();
				// System.out.println(egsdMenuPO.getObjectId() + "---> " +
				// egsdMenuPO.getString("MenuId") + "--->"
				// + egsdMenuPO.getString("Description") + "--->" +
				// egsdMenuPO.getString("Price"));
				// System.out.println(egsdMenuPO.getParseObject("StyleID"));
				// ParseObject styleIdObj=egsdMenuPO.getParseObject("StyleID");

				ParseObject ppp = egsdMenuPO.getParseObject("StyleID");
				// System.out.println("menu o.i:
				// "+egsdMenuPO.getObjectId()+"::styleId o.i:
				// "+ppp.getObjectId());

				menuObjectsList.add(new EgsdMenuObjects(egsdMenuPO.getObjectId(), egsdMenuPO.getString("MenuId"),
						egsdMenuPO.getString("Description"), egsdMenuPO.getString("Price"), ppp.getObjectId(), egsdMenuPO.getInt("Sequence")));
			}
		} catch (NullPointerException npe) {

		}
		// System.out.println(menuObjectsList);
		mav.addObject("menuObjectsList", menuObjectsList);
		mav.addObject("menuObjectsListForEdit", menuObjectsList);
		mav.addObject("menuObjectsListForDelete", menuObjectsList);

		// loading StyleId objs
		ParseQuery<ParseObject> queryForStyleID = ParseQuery.getQuery("Style");
		queryForStyleID.limit(1000);
		List<ParseObject> styleIdObjParseObj = null;
		try {
			styleIdObjParseObj = queryForStyleID.find();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		List<EgsdStyleObjects> styleObjects = new ArrayList<EgsdStyleObjects>(200);
		try {
			Iterator<ParseObject> styleIterator = styleIdObjParseObj.listIterator();
			// System.out.println(styleIdObjParseObj);

			while (styleIterator.hasNext()) {
				ParseObject sp = styleIterator.next();
				/*
				 * System.out.println(sp.getObjectId()
				 * +"-->"+sp.getString("TitleFont")
				 * +"-->"+sp.getString("TitleColor")
				 * +"-->"+sp.getString("CaptionFont")
				 * +"-->"+sp.getString("CaptionColor")
				 * +"-->"+sp.getString("DescriptionFont")
				 * +"-->"+sp.getString("DescriptionColor")
				 * +"-->"+sp.getString("PhonesFont")
				 * +"-->"+sp.getString("PhonesColor")
				 * +"-->"+sp.getString("TimingsFont")
				 * +"-->"+sp.getString("TimingsColor")
				 * +"-->"+sp.getString("WebsiteFont")
				 * +"-->"+sp.getString("WebsiteColor")
				 * +"-->"+sp.getString("EmailFont")
				 * +"-->"+sp.getString("EmailColor")
				 * +"-->"+sp.getString("StyleID")
				 * +"-->"+sp.getString("PriceFont")
				 * +"-->"+sp.getString("PriceColor"));
				 */

				styleObjects.add(new EgsdStyleObjects(sp.getObjectId(), sp.getString("TitleFont"),
						sp.getString("TitleColor"), sp.getString("TitleFamily"), sp.getString("CaptionFont"),
						sp.getString("CaptionColor"), sp.getString("CaptionFamily"), sp.getString("DescriptionFont"),
						sp.getString("DescriptionColor"), sp.getString("DescriptionFamily"), sp.getString("PhonesFont"),
						sp.getString("PhonesColor"), sp.getString("PhonesFamily"), sp.getString("TimingsFont"),
						sp.getString("TimingsColor"), sp.getString("TimingsFamily"), sp.getString("WebsiteFont"),
						sp.getString("WebsiteColor"), sp.getString("WebsiteFamily"), sp.getString("EmailFont"),
						sp.getString("EmailColor"), sp.getString("EmailFamily"), sp.getString("StyleID"),
						sp.getString("PriceFont"), sp.getString("PriceColor"), sp.getString("PriceFamily")));

			}
		} catch (NullPointerException npe) {

		}
		// System.out.println(styleObjects);
		System.out.println("Style items are Loaded");
		mav.addObject("styleObjects", styleObjects);
		mav.addObject("styleObjectsForEdit", styleObjects);
		mav.addObject("styleObjectsForMenu", styleObjects);
		mav.addObject("styleObjectsForAddDirItems", styleObjects);
		mav.addObject("styleObjectsForDelete", styleObjects);

		System.out.println("End of Controller");

		return mav;
	}

	@RequestMapping(value = "/print")
	public ModelAndView print(HttpServletRequest request) throws Exception {

		mav.setViewName("SuperAdmin");
		System.out.println(request.getParameter("qrcode"));
		String imgUrl = request.getParameter("qrcode");
		PrintImage image = new PrintImage();
		String res = image.printImage(imgUrl);
		System.out.println(res);
		return mav;
	}

	
	
	/*@RequestMapping(value = "/login", method = RequestMethod.GET)
	public ModelAndView login1(HttpServletRequest request) {
		mav.clear();
		mav.setViewName("login");
		return mav;
		
	}
	*/
	@SuppressWarnings("finally")
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public ModelAndView login(HttpServletRequest request) {

		try {
			ParseUser ps = ParseUser.login(request.getParameter("username"), request.getParameter("password"));

			System.out.println(ps.getString("user"));

			System.out.println("userName:" + ps.getString("user"));
			System.out.println("user:" + request.getParameter("username"));

			request.setAttribute("userName", ps.getString("user"));
			request.setAttribute("user", request.getParameter("username"));

			// EgsdController.getDataFromParse(request);

			// mav.clear();
			if(ps.getBoolean("Status"))
			{
				if (ps.getString("user").equals("CS Admin")) {
					//adminLoad(request);
					mav.setViewName("CSHotelList");
				}
	
				else if (ps.getString("user").equals("IT Admin")) {
					//adminLoad(request);
					mav.setViewName("ITHotelList");
				}
	
				else if (ps.getString("user").equals("Super Admin")) {
	
					//adminLoad(request);
					mav.setViewName("SuperHotelList");
	
				} else {
	
					request.setAttribute("locationId", ps.getObjectId());
					System.out.println(ps.getObjectId());
					mav.clear();
					LocationAdminCount lcount = new LocationAdminCount();
					int count = locationDetails(request);
	
					if (count > 0) {
						mav.setViewName("LocationList");
					} else {
						mav.setViewName("LocationDetails");
					}
	
				}
	
				// mav.addObject(returnObjectsOfMethod);
				mav.addObject("userName", ps.getString("user"));
				mav.addObject("user", request.getParameter("username"));
				mav.addObject("email", ps.getString("email"));
			}
			
			else {
				
				mav.setViewName("Error");
				mav.addObject("errorMsg", "Enter Valid UserName/Password.");
				
			}
				
	
			} catch (ParseException pe) {
				System.out.println(pe);
				mav.setViewName("Error");
				mav.addObject("errorMsg", "Enter Valid UserName/Password.");
			}		
		finally {
			return mav;
		}

	}

	public static void adminLoad(HttpServletRequest request) {

		mav.clear();

		List<ParseObject> results = null;
		List<ParseObject> changeLocresults = null;

		ParseQuery<ParseObject> queryForLocationAdminWasEmpty = ParseQuery.getQuery("_User");
		queryForLocationAdminWasEmpty.whereEqualTo("user", "Location Admin");
		// queryForLocationAdminWasEmpty.whereEqualTo("locationId", "empty");

		List<ParseObject> listOfEmptyAdmins = null;

		try {
			listOfEmptyAdmins = queryForLocationAdminWasEmpty.find();
		} catch (ParseException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		}
		List<EgsdUserObjects> listOfUserObjects = new ArrayList<EgsdUserObjects>(100);

		try {
			Iterator<ParseObject> iteratorForEmptyAdmins = listOfEmptyAdmins.listIterator();

			while (iteratorForEmptyAdmins.hasNext()) {

				ParseObject parseObjectHavingEmptyAdmins = iteratorForEmptyAdmins.next();

				listOfUserObjects.add(new EgsdUserObjects(parseObjectHavingEmptyAdmins.getObjectId(),
						parseObjectHavingEmptyAdmins.getString("username"), null,
						parseObjectHavingEmptyAdmins.getString("email"), parseObjectHavingEmptyAdmins.getString("user"),
						parseObjectHavingEmptyAdmins.getString("locationId"),
						parseObjectHavingEmptyAdmins.getString("firstname"),
						parseObjectHavingEmptyAdmins.getString("lastname"),					
						parseObjectHavingEmptyAdmins.getString("phone")));
				System.out.println(parseObjectHavingEmptyAdmins.getString("firstname") + " firstname and last name "
						+ parseObjectHavingEmptyAdmins.getString("lastname"));
			}

		} catch (NullPointerException npe) {

			listOfUserObjects
					.add(new EgsdUserObjects("empty", "Please Add Location Admin", null, null, null, null, "", "",null));

		}

		mav.addObject("listOfEmptyLocationAdmins", listOfUserObjects);

		// list of admins

		ParseQuery<ParseObject> queryForAdmins = ParseQuery.getQuery("_User");
		// queryForLocationAdminWasEmpty.addAscendingOrder("username");
		queryForAdmins.orderByAscending("user");
		queryForAdmins.whereNotEqualTo("user", "IT Admin");
		// queryForLocationAdminWasEmpty.whereEqualTo("locationId", "empty");

		List<ParseObject> listOfAdmins = null;

		try {

			listOfAdmins = queryForAdmins.find();

		} catch (ParseException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		}
		List<EgsdUserObjects> listOfAdminObjects = new ArrayList<EgsdUserObjects>(100);

		try {
			Iterator<ParseObject> iteratorForEmptyAdmins = listOfAdmins.listIterator();

			while (iteratorForEmptyAdmins.hasNext()) {

				ParseObject parseObjectHavingEmptyAdmins = iteratorForEmptyAdmins.next();

				listOfAdminObjects.add(new EgsdUserObjects(parseObjectHavingEmptyAdmins.getObjectId(),
						parseObjectHavingEmptyAdmins.getString("username"), null,
						parseObjectHavingEmptyAdmins.getString("email"), parseObjectHavingEmptyAdmins.getString("user"),
						parseObjectHavingEmptyAdmins.getString("locationId"),
						parseObjectHavingEmptyAdmins.getString("firstname"),
						parseObjectHavingEmptyAdmins.getString("lastname"),
						parseObjectHavingEmptyAdmins.getString("phone")));

			}

		} catch (NullPointerException npe) {

			listOfAdminObjects
					.add(new EgsdUserObjects("empty", "Please Add Location Admin", null, null, null, null, null, null,null));

		}

		mav.addObject("listOfAdmins", listOfAdminObjects);

		// list of Templates
		ParseQuery<ParseObject> queryForTemplateObjects = ParseQuery.getQuery("Template");
		queryForTemplateObjects.whereNotEqualTo("type", "group");

		List<ParseObject> listOfTemplateObjects = null;

		try {
			listOfTemplateObjects = queryForTemplateObjects.find();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		try {
			Iterator<ParseObject> iteratorForTemplateObjects = listOfTemplateObjects.listIterator();
			List<EgsdTemplateObjects> listOfEgsdTemplateObjects = new ArrayList<EgsdTemplateObjects>(20);

			while (iteratorForTemplateObjects.hasNext()) {

				ParseObject templateObjects = iteratorForTemplateObjects.next();

				listOfEgsdTemplateObjects
						.add(new EgsdTemplateObjects(templateObjects.getObjectId(), templateObjects.getString("Name"),
								templateObjects.getObjectId(), templateObjects.getBoolean("Customized")));

			}

			mav.addObject("listOfEgsdTemplateObjects", listOfEgsdTemplateObjects);

		} catch (NullPointerException npe) {

		}

		// list of Groups
		ParseQuery<ParseObject> queryForGroupObjects = ParseQuery.getQuery("Template");
		queryForGroupObjects.whereEqualTo("type", "group");

		List<ParseObject> listOfGroupObjects = null;

		try {
			listOfGroupObjects = queryForGroupObjects.find();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		try {
			Iterator<ParseObject> iteratorForGroupObjects = listOfGroupObjects.listIterator();
			List<EgsdTemplateObjects> listOfEgsdGroupObjects = new ArrayList<EgsdTemplateObjects>(20);

			while (iteratorForGroupObjects.hasNext()) {

				ParseObject templateObjects = iteratorForGroupObjects.next();

				listOfEgsdGroupObjects
						.add(new EgsdTemplateObjects(templateObjects.getObjectId(), templateObjects.getString("Name"),
								templateObjects.getObjectId(), templateObjects.getBoolean("Customized")));

			}

			mav.addObject("listOfEgsdGroupObjects", listOfEgsdGroupObjects);

		} catch (NullPointerException npe) {

		}

		ParseQuery<ParseObject> changeLocquery = ParseQuery.getQuery("Location");
		changeLocquery.addAscendingOrder("Name");
		
		try {
			changeLocresults = changeLocquery.find();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println(changeLocresults);
		List<EgsdLoctionObject> changeLoc = new ArrayList<EgsdLoctionObject>(20);

		try {
			Iterator<ParseObject> changeLocIterator = changeLocresults.listIterator();
			while (changeLocIterator.hasNext()) {
				ParseObject locchange = changeLocIterator.next();

				EgsdLoctionObject e =new EgsdLoctionObject();
			    e.setObjectId(locchange.getObjectId());
			    e.setDirectory(locchange.getString("Directories"));
			    e.setName(locchange.getString("Name"));
			    e.setZipcode(locchange.getString("zipcode"));
			    e.setAddress(locchange.getString("Address1"));
			    e.setAddress2(locchange.getString("Address2"));
			    e.setStreet(locchange.getString("Street"));
			    e.setTown(locchange.getString("Town"));
			    e.setSiteId(locchange.getString("GroupSiteId"));
			    e.setGroupName(locchange.getString("GroupName"));
			    e.setCountry(locchange.getString("Country"));
			    e.setParentDirectoryId(locchange.getString("ParentLocationID"));
			    e.setDescription(locchange.getString("description"));

			    changeLoc.add(e);

			}
		} catch (NullPointerException npe) {

		}

		// System.out.println(changeLoc);
		mav.addObject("changeLoc", changeLoc);
		mav.addObject("selectLocObj", changeLoc);

		String directoryIdForLocationId = null;

		if (request.getParameter("objectId") != null) {
			ParseQuery<ParseObject> queryForDirectoryId = ParseQuery.getQuery("DirectoryItem");
			queryForDirectoryId.whereEqualTo("objectId", request.getParameter("objectId"));
			List<ParseObject> listObjectHavingRequiredDirectoryId = null;

			try {
				listObjectHavingRequiredDirectoryId = queryForDirectoryId.find();
			} catch (ParseException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}

			Iterator<ParseObject> iteratorHavingDirectoryId = listObjectHavingRequiredDirectoryId.listIterator();

			ParseObject parseObjectHavingDirectoryId = iteratorHavingDirectoryId.next();

			directoryIdForLocationId = parseObjectHavingDirectoryId.getString("LocationId");
		}

		System.out.println("Location id:" + directoryIdForLocationId);

		ParseQuery<ParseObject> query = ParseQuery.getQuery("Location");
		if (request.getParameter("userName") != null)
			if (request.getParameter("userName").equals("Location Admin"))
				query.whereEqualTo("objectId", directoryIdForLocationId);
		
		if (request.getParameter("objectIdOfLocation") != null)
			if (request.getParameter("userName").equals("Location Admin"))
				query.whereEqualTo("objectId", request.getParameter("objectIdOfLocation"));
		

		try {
			results = query.find();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println(results);
		List<EgsdLoctionObject> hlobj = new ArrayList<EgsdLoctionObject>();
		try {
			Iterator<ParseObject> hlit = results.listIterator();
			ParseObject p = null;
			while (hlit.hasNext()) {
				p = hlit.next();
				
				String logo = "No Image To Display";
				if (p.getParseFile("Logo") != null)
					logo = p.getParseFile("Logo").getUrl();

				String qRCode = "No Image To Display";
				if (p.getParseFile("QRCode") != null)
					qRCode = p.getParseFile("QRCode").getUrl();

				String hotelLogo = "No Image To Display";
				if (p.getParseFile("HotelLogo") != null)
					qRCode = p.getParseFile("HotelLogo").getUrl();

				String footerImage = "No Image To Display";
				if (p.getParseFile("footerImage") != null)
					qRCode = p.getParseFile("FooterImage").getUrl();

				EgsdLoctionObject e = new EgsdLoctionObject();

				e.setObjectId(p.getObjectId());
				e.setDirectory(p.getString("Directories"));
				e.setName(p.getString("Name"));
				e.setZipcode(p.getString("zipcode"));
				e.setAddress(p.getString("Address1"));
				e.setAddress2(p.getString("Address2"));
				e.setStreet(p.getString("Street"));
				e.setTown(p.getString("Town"));
				e.setSiteId(p.getString("siteId"));
				e.setGroupName(p.getString("GroupName"));
				e.setCountry(p.getString("Country"));
				e.setLogo(logo);
				e.setqRCode(qRCode);
				e.setParentDirectoryId(p.getString("ParentLocationID"));
				e.setDescription(p.getString("description"));

				hlobj.add(e);
				
			}
		} catch (NullPointerException npe) {

		}
		System.out.println(hlobj);

		mav.addObject("locObj", hlobj);
		mav.addObject("locObjForEdit", hlobj);
		mav.addObject("locObjForAddDirectoryItems", hlobj);
		mav.addObject("locObjForEditLocation", hlobj);
		mav.addObject("locObjForDeleteLocation", hlobj);
		mav.addObject("locObjForParentHotel", hlobj);

	}
	

	public static int locationDetails(HttpServletRequest request) {

		System.out.println("locationId:" + request.getAttribute("locationId"));
		int lcount = 0;

		ParseQuery<ParseObject> queryForGroupLocationAdminHotels = ParseQuery.getQuery("Location");
		queryForGroupLocationAdminHotels.whereEqualTo("GroupId", request.getAttribute("locationId"));

		List<ParseObject> listOfLocationsFromParse = null;

		try {
			listOfLocationsFromParse = queryForGroupLocationAdminHotels.find();

		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		if (listOfLocationsFromParse == null) {
			lcount = 0;
		} else {
			lcount = listOfLocationsFromParse.size();
		}

		try {

			Iterator<ParseObject> iteratorForLocations = listOfLocationsFromParse.listIterator();

			List<EgsdLoctionObject> listOfParseLocationObjects = new ArrayList<EgsdLoctionObject>(10);

			while (iteratorForLocations.hasNext()) {

				ParseObject p = iteratorForLocations.next();
				// p = hlit.next();
				/*
				 * System.out.println(p.getObjectId());
				 * System.out.println(p.getString("Directories"));
				 * System.out.println(p.getString("Name"));
				 * System.out.println(p.getString("zipcode"));
				 * System.out.println(p.getString("Address1"));
				 */

				/*String logo = "No Image To Display";
				if (p.getParseFile("Logo") != null)
					logo = p.getParseFile("Logo").getUrl();

				String qRCode = "No Image To Display";
				if (p.getParseFile("QRCode") != null)
					qRCode = p.getParseFile("QRCode").getUrl();

				String hotelLogo = "No Image To Display";
				if (p.getParseFile("HotelLogo") != null)
					qRCode = p.getParseFile("HotelLogo").getUrl();

				String footerImage = "No Image To Display";
				if (p.getParseFile("footerImage") != null)
					qRCode = p.getParseFile("FooterImage").getUrl();*/

				EgsdLoctionObject e = new EgsdLoctionObject();

				e.setObjectId(p.getObjectId());
				e.setDirectory(p.getString("Directories"));
				e.setName(p.getString("Name"));
				e.setZipcode(p.getString("zipcode"));
				e.setAddress(p.getString("Address1"));
				e.setAddress2(p.getString("Address2"));
				e.setStreet(p.getString("Street"));
				e.setTown(p.getString("Town"));
				e.setSiteId(p.getString("siteId"));
				e.setGroupName(p.getString("GroupName"));
				e.setCountry(p.getString("Country"));
				//e.setLogo(logo);
				//e.setqRCode(qRCode);
				e.setParentDirectoryId(p.getString("ParentLocationID"));
				e.setDescription(p.getString("description"));

				listOfParseLocationObjects.add(e);
				//
				//
				//
				// listOfParseLocationObjects.add(new
				// EgsdLoctionObject(p.getObjectId(),
				// p.getString("Directories"), p.getString("Name"),
				// p.getString("zipcode"), p.getString("Address1"),
				// p.getString("Address2"), p.getString("Street"),
				// p.getString("Town"),p.getString("GroupSiteId"),p.getString("GroupName"),p.getString("Country"),logo,qRCode,p.getString("ParentLocationID"),p.getString("description")));
				//
				//

			}

			mav.addObject("hotelsList", listOfParseLocationObjects.size());

			mav.addObject("selectLocObj", listOfParseLocationObjects);
			mav.addObject("locObjForEdit", listOfParseLocationObjects);
			mav.addObject("locObjForAddDirectoryItems", listOfParseLocationObjects);
			mav.addObject("locObjForEditLocation", listOfParseLocationObjects);
			mav.addObject("locObjForDeleteLocation", listOfParseLocationObjects);
			mav.addObject("locObjForParentHotel", listOfParseLocationObjects);

			System.out.println("End of Controller");

		} catch (NullPointerException npe) {

			System.out.println(npe);
		}
		return lcount;

	}

	public static void locationDetails1(HttpServletRequest request) {

		System.out.println("locationId:" + request.getAttribute("locationId"));

		ParseQuery<ParseObject> queryForGroupLocationAdminHotels = ParseQuery.getQuery("Location");
		queryForGroupLocationAdminHotels.whereEqualTo("GroupId", request.getAttribute("locationId"));

		List<ParseObject> listOfLocationsFromParse = null;

		try {
			listOfLocationsFromParse = queryForGroupLocationAdminHotels.find();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		try {

			Iterator<ParseObject> iteratorForLocations = listOfLocationsFromParse.listIterator();

			List<EgsdLoctionObject> listOfParseLocationObjects = new ArrayList<EgsdLoctionObject>(10);

			while (iteratorForLocations.hasNext()) {

				ParseObject p = iteratorForLocations.next();
				// p = hlit.next();
				/*
				 * System.out.println(p.getObjectId());
				 * System.out.println(p.getString("Directories"));
				 * System.out.println(p.getString("Name"));
				 * System.out.println(p.getString("zipcode"));
				 * System.out.println(p.getString("Address1"));
				 */

				String logo = "No Image To Display";
				if (p.getParseFile("Logo") != null)
					logo = p.getParseFile("Logo").getUrl();

				String qRCode = "No Image To Display";
				if (p.getParseFile("QRCode") != null)
					qRCode = p.getParseFile("QRCode").getUrl();
				String hotelLogo = "No Image To Display";

				if (p.getParseFile("HotelLogo") != null)
					qRCode = p.getParseFile("HotelLogo").getUrl();

				String footerImage = "No Image To Display";
				if (p.getParseFile("FooterImage") != null)
					qRCode = p.getParseFile("FooterImage").getUrl();

				EgsdLoctionObject e = new EgsdLoctionObject();

				e.setObjectId(p.getObjectId());
				e.setDirectory(p.getString("Directories"));
				e.setName(p.getString("Name"));
				e.setZipcode(p.getString("zipcode"));
				e.setAddress(p.getString("Address1"));
				e.setAddress2(p.getString("Address2"));
				e.setStreet(p.getString("Street"));
				e.setTown(p.getString("Town"));
				e.setSiteId(p.getString("siteId"));
				e.setGroupName(p.getString("GroupName"));
				e.setCountry(p.getString("Country"));
				e.setLogo(logo);
				e.setqRCode(qRCode);
				e.setParentDirectoryId(p.getString("ParentLocationID"));
				e.setDescription(p.getString("description"));

				listOfParseLocationObjects.add(e);

				// listOfParseLocationObjects.add(new
				// EgsdLoctionObject(p.getObjectId(),
				// p.getString("Directories"), p.getString("Name"),
				// p.getString("zipcode"), p.getString("Address1"),
				// p.getString("Address2"), p.getString("Street"),
				// p.getString("Town"),p.getString("GroupSiteId"),p.getString("GroupName"),p.getString("Country"),logo,qRCode,p.getString("ParentLocationID"),p.getString("description")));

			}

			mav.addObject("selectLocObj", listOfParseLocationObjects);
			mav.addObject("locObjForEdit", listOfParseLocationObjects);
			mav.addObject("locObjForAddDirectoryItems", listOfParseLocationObjects);
			mav.addObject("locObjForEditLocation", listOfParseLocationObjects);
			mav.addObject("locObjForDeleteLocation", listOfParseLocationObjects);
			mav.addObject("locObjForParentHotel", listOfParseLocationObjects);

			// this is for directory items objects

			ParseQuery<EgsdDirectoryItemParseObject> queryForDirectoryItem = ParseQuery.getQuery("DirectoryItem");
			if (request.getParameter("locId") != null)
				queryForDirectoryItem.whereEqualTo("LocationId", request.getParameter("locId"));
			// queryForDirectoryItem.whereEqualTo("DirectoryID",p.getString("Directories"));
			queryForDirectoryItem.orderByAscending("Title");
			queryForDirectoryItem.limit(1000);
			List<EgsdDirectoryItemParseObject> directoryItemParseObjectsList = null;
			try {
				directoryItemParseObjectsList = queryForDirectoryItem.find();
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			List<EgsdDirectoryItemObjects> directoryItemObjectsList = new ArrayList<EgsdDirectoryItemObjects>(300);
			System.out.println("Directory items are loaded:");
			try {
				Iterator<EgsdDirectoryItemParseObject> iterator = directoryItemParseObjectsList.listIterator();
				System.out.println("objectId" + "---> " + "DirectoryId" + "--->" + "getParentDirectoryId" + "--->"
						+ "getTitle" + "--->" + "getCaption" + "--->" + "getTimings" + "--->" + "getWebsite" + "--->"
						+ "getEmail" + "--->" + "getPhones");
				int count = 1;
				while (iterator.hasNext()) {

					EgsdDirectoryItemParseObject egsd = iterator.next();
					// System.out.println( count++ +" "+ egsd.getObjectId()
					// + "---> " + egsd.getDirectoryId()
					// + "--->" + egsd.getParentDirectoryId()
					// + "--->" + egsd.getTitle()
					// + "--->" + egsd.getCaption()
					// + "--->" + egsd.getTimings()
					// + "--->" + egsd.getWebsite()
					// + "--->" + egsd.getEmail()
					// + "--phoneId->" + egsd.getPhones()
					// + "--->" + egsd.getStyleID() +"<--StyleID ");
					String img = "No Image To Display";
					if (egsd.getParseFile("Picture") != null)
						img = egsd.getParseFile("Picture").getUrl();
					// System.out.print(img);
					String styleId = null;
					ParseObject StyleIdPO = egsd.getParseObject("StyleId");
					if (egsd.getParseObject("StyleId") != null)
						styleId = StyleIdPO.getObjectId();
					// System.out.println(styleId);

					/*
					 * if(StyleIdPO.getObjectId()!=null) System.out.println(
					 * "StyleID AT Directory Items"+StyleIdPO.getObjectId());
					 */

					directoryItemObjectsList.add(
							new EgsdDirectoryItemObjects(egsd.getObjectId(), egsd.getDirectoryId(), egsd.getTitle(),
									egsd.getCaption(), egsd.getDescription(), egsd.getTimings(), egsd.getWebsite(),
									egsd.getEmail(), egsd.getParentDirectoryId(), img, styleId, egsd.getPhones(),
									egsd.getParentDirectoryId(), egsd.getLocationId(), egsd.getCustomizedOrder()));

				}
			} catch (NullPointerException npe) {

			}

			System.out.println("before adding dir objs");
			mav.addObject("direcObjList", directoryItemObjectsList);
			mav.addObject("subDirObj", directoryItemObjectsList);
			mav.addObject("subsubDirObj", directoryItemObjectsList);
			mav.addObject("DirObjId", directoryItemObjectsList);
			mav.addObject("DiscriptionObjId", directoryItemObjectsList);
			// adding DirectiryItems for editing values
			mav.addObject("showSubDiscriptionObjId", directoryItemObjectsList);
			mav.addObject("showDiscriptionObjId", directoryItemObjectsList);
			mav.addObject("DiscriptionObjForNavBar", directoryItemObjectsList);
			mav.addObject("subDiscriptionObjForNavBar", directoryItemObjectsList);
			// addind directory Items for Adding DirectoryItems
			mav.addObject("subDiscriptionObjForAddDirItems", directoryItemObjectsList);
			mav.addObject("showSubDiscriptionObjIdForDelete", directoryItemObjectsList);

			System.out.println("aftr adding dir objs");

			System.out.println("in select b4 Phones");

			ParseQuery<ParseObject> queryForPhones = ParseQuery.getQuery("Phones");
			queryForPhones.limit(1000);
			List<ParseObject> phonesParseObjectsList = null;
			try {
				phonesParseObjectsList = queryForPhones.find();
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			List<EgsdPhonesObjects> phonesObjectsList = new ArrayList<EgsdPhonesObjects>(200);
			System.out.println("Phone Objects  are loaded:");
			// System.out.println(phonesParseObjectsList);
			try {
				Iterator<ParseObject> phoneIterator = phonesParseObjectsList.listIterator();
				int i = 0;
				while (phoneIterator.hasNext()) {

					ParseObject egsdPhonePO = phoneIterator.next();

					// System.out.println(egsdPhonePO.getObjectId()
					// +"-->"+egsdPhonePO.getString("PhoneId")
					// +"-->"+egsdPhonePO.getString("Type")
					// +"-->"+egsdPhonePO.getString("Ext"));
					phonesObjectsList
							.add(new EgsdPhonesObjects(egsdPhonePO.getObjectId(), egsdPhonePO.getString("PhoneId"),
									egsdPhonePO.getString("Type"), egsdPhonePO.getString("Ext")));

				}
			} catch (NullPointerException npe) {

			}
			// System.out.println(phonesObjectsList);
			mav.addObject("phonesObjectsList", phonesObjectsList);
			mav.addObject("phonesObjectsListForEdit", phonesObjectsList);
			mav.addObject("phonesObjectsListForDelete", phonesObjectsList);

			ParseQuery<ParseObject> queryForMenu = ParseQuery.getQuery("Menu");
			List<ParseObject> menuParseObjectsList = null;
			try {
				menuParseObjectsList = queryForMenu.find();
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			List<EgsdMenuObjects> menuObjectsList = new ArrayList<EgsdMenuObjects>(200);
			System.out.println("Menu Items are loaded:");
			// System.out.println(menuParseObjectsList);
			try {
				Iterator<ParseObject> menuIterator = menuParseObjectsList.listIterator();
				while (menuIterator.hasNext()) {

					ParseObject egsdMenuPO = menuIterator.next();
					// System.out.println(egsdMenuPO.getObjectId() + "---> " +
					// egsdMenuPO.getString("MenuId") + "--->"
					// + egsdMenuPO.getString("Description") + "--->" +
					// egsdMenuPO.getString("Price"));
					// System.out.println(egsdMenuPO.getParseObject("StyleID"));
					// ParseObject
					// styleIdObj=egsdMenuPO.getParseObject("StyleID");

					ParseObject ppp = egsdMenuPO.getParseObject("StyleID");
					// System.out.println("menu o.i:
					// "+egsdMenuPO.getObjectId()+"::styleId o.i:
					// "+ppp.getObjectId());

					menuObjectsList.add(new EgsdMenuObjects(egsdMenuPO.getObjectId(), egsdMenuPO.getString("MenuId"),
							egsdMenuPO.getString("Description"), egsdMenuPO.getString("Price"), ppp.getObjectId(), egsdMenuPO.getInt("Sequence")));
				}
			} catch (NullPointerException npe) {

			}
			// System.out.println(menuObjectsList);
			mav.addObject("menuObjectsList", menuObjectsList);
			mav.addObject("menuObjectsListForEdit", menuObjectsList);
			mav.addObject("menuObjectsListForDelete", menuObjectsList);

			// loading StyleId objs
			ParseQuery<ParseObject> queryForStyleID = ParseQuery.getQuery("Style");
			queryForStyleID.limit(1000);
			List<ParseObject> styleIdObjParseObj = null;
			try {
				styleIdObjParseObj = queryForStyleID.find();
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			List<EgsdStyleObjects> styleObjects = new ArrayList<EgsdStyleObjects>(200);
			try {
				Iterator<ParseObject> styleIterator = styleIdObjParseObj.listIterator();
				// System.out.println(styleIdObjParseObj);

				while (styleIterator.hasNext()) {
					ParseObject sp = styleIterator.next();
					/*
					 * System.out.println(sp.getObjectId()
					 * +"-->"+sp.getString("TitleFont")
					 * +"-->"+sp.getString("TitleColor")
					 * +"-->"+sp.getString("CaptionFont")
					 * +"-->"+sp.getString("CaptionColor")
					 * +"-->"+sp.getString("DescriptionFont")
					 * +"-->"+sp.getString("DescriptionColor")
					 * +"-->"+sp.getString("PhonesFont")
					 * +"-->"+sp.getString("PhonesColor")
					 * +"-->"+sp.getString("TimingsFont")
					 * +"-->"+sp.getString("TimingsColor")
					 * +"-->"+sp.getString("WebsiteFont")
					 * +"-->"+sp.getString("WebsiteColor")
					 * +"-->"+sp.getString("EmailFont")
					 * +"-->"+sp.getString("EmailColor")
					 * +"-->"+sp.getString("StyleID")
					 * +"-->"+sp.getString("PriceFont")
					 * +"-->"+sp.getString("PriceColor"));
					 */

					styleObjects
							.add(new EgsdStyleObjects(sp.getObjectId(), sp.getString("TitleFont"),
									sp.getString("TitleColor"), sp.getString("TitleFamily"), sp.getString(
											"CaptionFont"),
									sp.getString("CaptionColor"), sp.getString("CaptionFamily"),
									sp.getString("DescriptionFont"), sp.getString("DescriptionColor"),
									sp.getString("DescriptionFamily"), sp.getString("PhonesFont"),
									sp.getString("PhonesColor"), sp.getString("PhonesFamily"),
									sp.getString("TimingsFont"), sp.getString("TimingsColor"),
									sp.getString("TimingsFamily"), sp.getString("WebsiteFont"),
									sp.getString("WebsiteColor"), sp.getString("WebsiteFamily"),
									sp.getString("EmailFont"), sp.getString("EmailColor"), sp.getString("EmailFamily"),
									sp.getString("StyleID"), sp.getString("PriceFont"), sp.getString("PriceColor"),
									sp.getString("PriceFamily")));

				}
			} catch (NullPointerException npe) {

			}
			// System.out.println(styleObjects);
			System.out.println("Style items are Loaded");
			mav.addObject("styleObjects", styleObjects);
			mav.addObject("styleObjectsForEdit", styleObjects);
			mav.addObject("styleObjectsForMenu", styleObjects);
			mav.addObject("styleObjectsForAddDirItems", styleObjects);
			mav.addObject("styleObjectsForDelete", styleObjects);

			System.out.println("End of Controller");

		} catch (NullPointerException npe) {

		}

	}

	String userName = "";

	@RequestMapping(value = "/select")
	public synchronized ModelAndView select(HttpServletRequest request) throws ParseException {

		System.out.println("User:" + request.getParameter("user"));
		System.out.println("UserName:" + request.getParameter("userName"));
		System.out.println("user:" + request.getAttribute("user"));
		System.out.println("username:" + request.getAttribute("userName"));
		System.out.println("LocId:" + request.getParameter("locId"));
		System.out.println("LocId:" + request.getAttribute("locId"));

		mav.clear();

		

		ParseQuery<ParseObject> query = ParseQuery.getQuery("Location");
		// in case of selecting location
		if (request.getParameter("locId") != null)
			query.whereEqualTo("objectId", request.getParameter("locId"));
		if (request.getAttribute("locId") != null)
			query.whereEqualTo("objectId", request.getAttribute("locId"));

		try {
			results = query.find();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println(results);
		List<EgsdLoctionObject> hlobj = new ArrayList<EgsdLoctionObject>();
		try {
			Iterator<ParseObject> hlit = results.listIterator();
			ParseObject p = null;
			String style=null;
			while (hlit.hasNext()) {
				p = hlit.next();
				

				String logo = "No Image To Display";
				if (p.getParseFile("Logo") != null)
					logo = p.getParseFile("Logo").getUrl();

				String qRCode = "No Image To Display";
				if (p.getParseFile("QRCode") != null)
					qRCode = p.getParseFile("QRCode").getUrl();

				String hotelLogo = "No Image To Display";
				if (p.getParseFile("hotelLogo") != null)
					hotelLogo = p.getParseFile("hotelLogo").getUrl();

				String footerImage = "No Image To Display";
				if (p.getParseFile("footerImage") != null)
					footerImage = p.getParseFile("footerImage").getUrl();
				EgsdLoctionObject e = new EgsdLoctionObject();
				if( p.getParseGeoPoint("Geopoints") != null )
				{
					double latitude = p.getParseGeoPoint("Geopoints").getLatitude();
					double longitude = p.getParseGeoPoint("Geopoints").getLongitude();
					System.out.println(latitude);
					System.out.println(longitude);
					e.setLatitude(latitude);
					e.setLongitude(longitude);
				}
				
				
				e.setObjectId(p.getObjectId());
				e.setDirectory(p.getString("Directories"));
				e.setName(p.getString("Name"));
				e.setZipcode(p.getString("zipcode"));
				e.setAddress(p.getString("Address1"));
				e.setAddress2(p.getString("Address2"));
				
				e.setStreet(p.getString("Street"));
				e.setTown(p.getString("Town"));
				e.setSiteId(p.getString("GroupSiteId"));
				e.setGroupName(p.getString("GroupName"));
				e.setCountry(p.getString("Country"));
				e.setLocObjectId(p.getString("GroupId"));
				e.setLogo(logo);
				e.setFooterLogo(footerImage);
				e.setHotelLogo(hotelLogo);
				e.setqRCode(qRCode);
				e.setParentDirectoryId(p.getString("ParentLocationID"));
				e.setDescription(p.getString("description"));
				e.setFooterText(p.getString("footerText"));
				e.setHotelCaption(p.getString("hotelCaption"));
				
				
				
				
				System.out.println(p.getString("BrandButtonColor"));
				System.out.println(p.getString("BrandFontColor"));
				System.out.println(p.getString("BrandFontFamily"));
				System.out.println(e.getBrandButtonColor());
				System.out.println(e.getBrandFontColor());
				System.out.println(e.getBrandFontFamily());
				
				
				
		

				ParseObject StyleIdPO = p.getParseObject("StyleId");
				if (p.getParseObject("StyleId") != null){
					style = StyleIdPO.getObjectId();
				}
				e.setStyleId(style);
				
				String locationAdminId = p.getString("GroupId");
				ParseQuery<ParseObject> locationAdminsQuery = ParseQuery.getQuery("_User");
				
				locationAdminsQuery.whereEqualTo("objectId", locationAdminId);
				List<ParseObject> adminResults = new ArrayList<ParseObject>();
				
				adminResults = locationAdminsQuery.find();
				
				
				String adminName = adminResults.get(0).getString("username");
				String adminFName = adminResults.get(0).getString("firstname");
				String adminLName = adminResults.get(0).getString("lastname");
				//String adminId = adminResults.get(0).getObjectId();
				
				
				e.setLocationAdmin(adminName);
				e.setLocFirstName(adminFName);
				e.setLocLastName(adminLName);
				
				
				if(style!=null&&!style.equals("")){
				ParseQuery<ParseObject> styleIdQuery = ParseQuery.getQuery("Style");
				styleIdQuery.whereEqualTo("objectId", style);
				List<ParseObject> StyleResults = new ArrayList<ParseObject>();
				try {
					StyleResults = styleIdQuery.find();
				} catch (ParseException ee) {
					// TODO Auto-generated catch block
					ee.printStackTrace();
				}
				try {
					Iterator<ParseObject> StyleList = StyleResults.listIterator();
					ParseObject styleObject = null;
					ParseObject pp = null;
					while (StyleList.hasNext()) {
						pp = StyleList.next();
						
						e.setAddressColor(pp.getString("LocationAddressFontColor"));
						e.setLocationAddressFontFamily(pp.getString("LocationAddressFontFamily"));
						e.setAddressFont(pp.getString("LocationAddressFont"));
						e.setBrandBackgroundColor(pp.getString("LocationBackground"));
						e.setFooterImageBackgroundColor(pp.getString("LocationFooterBackground"));
						e.setFooterTextColor(pp.getString("FooterTextColor"));
						e.setFooterFont(pp.getString("footerFont"));
						e.setFooterFontFamily(pp.getString("footerCaptionFamily"));
						e.setBrandButtonColor(pp.getString("BrandButtonColor"));
						e.setBrandFontColor(pp.getString("BrandFontColor"));
						e.setBrandFontFamily(pp.getString("BrandFontFamily"));
						e.setHotelColor(pp.getString("hotelTitleColor"));
						e.setHotelFont(pp.getString("hotelTitleFont"));
						e.setHotelFontFamily(pp.getString("hotelTitleFontFamily"));
						e.setCaptionColor(pp.getString("hotelCaptionColor"));
						e.setCaptionFont(pp.getString("hotelCaptionFont"));
						e.setCaptionFontFamily(pp.getString("hotelCaptionFontFamily"));
						
						
					}
					
				}
				catch(Exception estyle){
					estyle.printStackTrace();
				}
				}
				
				
				
				
				
				
				hlobj.add(e);

				
			}
		} catch (NullPointerException npe) {

		}
		System.out.println(hlobj);

		mav.addObject("locObj", hlobj);
		mav.addObject("locObjForEdit", hlobj);
		mav.addObject("locObjForAddDirectoryItems", hlobj);
		mav.addObject("locObjForEditLocation", hlobj);
		mav.addObject("locObjForDeleteLocation", hlobj);
		mav.addObject("locObjForParentHotel", hlobj);

		// this is for directory items objects

		ParseQuery<EgsdDirectoryItemParseObject> queryForDirectoryItem = ParseQuery.getQuery("DirectoryItem");
		if (request.getParameter("locId") != null)
			queryForDirectoryItem.whereEqualTo("LocationId", request.getParameter("locId"));
		if (request.getAttribute("locId") != null)
			queryForDirectoryItem.whereEqualTo("LocationId", request.getAttribute("locId"));
		queryForDirectoryItem.orderByAscending("CustomizedOrder");
		// queryForDirectoryItem.whereEqualTo("DirectoryID",p.getString("Directories"));
		
		queryForDirectoryItem.limit(1000);
		List<EgsdDirectoryItemParseObject> directoryItemParseObjectsList = null;
		try {
			
			directoryItemParseObjectsList = queryForDirectoryItem.find();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		List<EgsdDirectoryItemObjects> directoryItemObjectsList = new ArrayList<EgsdDirectoryItemObjects>(1000);
		System.out.println("Directory items are loaded:");
		try {
			Iterator<EgsdDirectoryItemParseObject> iterator = directoryItemParseObjectsList.listIterator();
			
			int count = 1;
			while (iterator.hasNext()) {

				EgsdDirectoryItemParseObject egsd = iterator.next();
				String img = "No Image To Display";
				if (egsd.getParseFile("Picture") != null)
					img = egsd.getParseFile("Picture").getUrl();
				// System.out.print(img);
				String styleId = null;
				ParseObject StyleIdPO = egsd.getParseObject("StyleId");
				if (egsd.getParseObject("StyleId") != null)
					styleId = StyleIdPO.getObjectId();
				
				directoryItemObjectsList.add(new EgsdDirectoryItemObjects(egsd.getObjectId(), egsd.getDirectoryId(),
						egsd.getTitle(), egsd.getCaption(), egsd.getDescription(), egsd.getTimings(), egsd.getWebsite(),
						egsd.getEmail(), egsd.getParentDirectoryId(), img, styleId, egsd.getPhones(),
						egsd.getParentDirectoryId(), egsd.getLocationId(), egsd.getCustomizedOrder()));

			}
		} catch (NullPointerException npe) {

		}

		
		mav.addObject("direcObjList", directoryItemObjectsList);
		mav.addObject("subDirObj", directoryItemObjectsList);
		mav.addObject("subsubDirObj", directoryItemObjectsList);
		mav.addObject("DirObjId", directoryItemObjectsList);
		mav.addObject("DiscriptionObjId", directoryItemObjectsList);
		// adding DirectiryItems for editing values
		mav.addObject("showSubDiscriptionObjId", directoryItemObjectsList);
		mav.addObject("showDiscriptionObjId", directoryItemObjectsList);
		mav.addObject("DiscriptionObjForNavBar", directoryItemObjectsList);
		mav.addObject("subDiscriptionObjForNavBar", directoryItemObjectsList);
		// addind directory Items for Adding DirectoryItems
		mav.addObject("subDiscriptionObjForAddDirItems", directoryItemObjectsList);
		mav.addObject("showSubDiscriptionObjIdForDelete", directoryItemObjectsList);

		

		

		if (request.getParameter("userName").equals("Location Admin")) {
			if (request.getParameter("locId") != null)
				locationAdminLocations(request);
			if (request.getAttribute("locId") != null) {
				List changeLocresults1 = null;
				String groupId = null;
				// list of hotel to corresponding locaiona admin

				System.out.println(request.getAttribute("locId"));
				ParseQuery<ParseObject> changeLocquery1 = ParseQuery.getQuery("Location");
				changeLocquery1.whereEqualTo("objectId", request.getAttribute("locId"));
				try {
					changeLocresults1 = changeLocquery1.find();
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				System.out.println(changeLocresults1);
				List<EgsdLoctionObject> changeLoc1 = new ArrayList<EgsdLoctionObject>(50);

				try {
					Iterator<ParseObject> changeLocIterator1 = changeLocresults1.listIterator();
					while (changeLocIterator1.hasNext()) {
						ParseObject locchange1 = changeLocIterator1.next();

						System.out.println("groupId :" + locchange1.getString("GroupId"));

						groupId = locchange1.getString("GroupId");

					}
				} catch (NullPointerException npe) {

				}

				ParseQuery<ParseObject> queryForGroupLocationAdminHotels = ParseQuery.getQuery("Location");
				queryForGroupLocationAdminHotels.whereEqualTo("GroupId", groupId);

				List<ParseObject> listOfLocationsFromParse = null;

				try {
					listOfLocationsFromParse = queryForGroupLocationAdminHotels.find();
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

				try {

					Iterator<ParseObject> iteratorForLocations = listOfLocationsFromParse.listIterator();

					List<EgsdLoctionObject> listOfParseLocationObjects = new ArrayList<EgsdLoctionObject>(10);

					while (iteratorForLocations.hasNext()) {

						ParseObject p = iteratorForLocations.next();
						

						String logo = "No Image To Display";
						if (p.getParseFile("Logo") != null)
							logo = p.getParseFile("Logo").getUrl();

						String qRCode = "No Image To Display";
						if (p.getParseFile("QRCode") != null)
							qRCode = p.getParseFile("QRCode").getUrl();

						String hotelLogo = "No Image To Display";
						if (p.getParseFile("HotelLogo") != null)
							hotelLogo = p.getParseFile("HotelLogo").getUrl();

						String footerImage = "No Image To Display";
						if (p.getParseFile("footerImage") != null)
							footerImage = p.getParseFile("FooterImage").getUrl();
						
						
						EgsdLoctionObject e = new EgsdLoctionObject();

					    e.setObjectId(p.getObjectId());
					    e.setDirectory(p.getString("Directories"));
					    e.setName(p.getString("Name"));
					    e.setZipcode(p.getString("zipcode"));
					    e.setAddress(p.getString("Address1"));
					    e.setAddress2(p.getString("Address2"));
					    e.setStreet(p.getString("Street"));
					    e.setTown(p.getString("Town"));
					    e.setSiteId(p.getString("GroupSiteId"));
					    e.setGroupName(p.getString("GroupName"));
					    e.setCountry(p.getString("Country"));
					    e.setLogo(logo);
					    e.setqRCode(qRCode);
					    e.setParentDirectoryId(p.getString("ParentLocationID"));
					    e.setDescription(p.getString("description"));
						listOfParseLocationObjects.add(e);

					}

					mav.addObject("adminLocObj", listOfParseLocationObjects);

					System.out.println("End of Controller");

				} catch (NullPointerException npe) {

				}
			}
		}

		System.out.println("select is redireting to getDataFromParse()");
		// EgsdController.getDataFromParse(request);
		System.out.println("getDataFromParse() is redireting to select ");

		if (request.getParameter("userName").equals("Location Admin"))
			mav.setViewName("LocationDetails");

		if (request.getParameter("userName").equals("CS Admin"))
			mav.setViewName("CSAdmin");

		if (request.getParameter("userName").equals("IT Admin"))
			mav.setViewName("ITAdmin");

		if (request.getParameter("userName").equals("Super Admin"))
			mav.setViewName("SuperAdmin");

		mav.addObject("userName", request.getParameter("userName"));
		mav.addObject("user", request.getParameter("user"));

		return mav;

	}

	public void locationAdminLocations(HttpServletRequest request) {

		List changeLocresults1 = null;
		String groupId = null;
		// list of hotel to corresponding locaiona admin

		System.out.println(request.getParameter("locId"));
		ParseQuery<ParseObject> changeLocquery1 = ParseQuery.getQuery("Location");
		changeLocquery1.whereEqualTo("objectId", request.getParameter("locId"));
		try {
			changeLocresults1 = changeLocquery1.find();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println(changeLocresults1);
		List<EgsdLoctionObject> changeLoc1 = new ArrayList<EgsdLoctionObject>(50);

		try {
			Iterator<ParseObject> changeLocIterator1 = changeLocresults1.listIterator();
			while (changeLocIterator1.hasNext()) {
				ParseObject locchange1 = changeLocIterator1.next();

				System.out.println("groupId :" + locchange1.getString("GroupId"));

				groupId = locchange1.getString("GroupId");

			}
		} catch (NullPointerException npe) {

		}

		ParseQuery<ParseObject> queryForGroupLocationAdminHotels = ParseQuery.getQuery("Location");
		queryForGroupLocationAdminHotels.whereEqualTo("GroupId", groupId);

		List<ParseObject> listOfLocationsFromParse = null;

		try {
			listOfLocationsFromParse = queryForGroupLocationAdminHotels.find();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		try {

			Iterator<ParseObject> iteratorForLocations = listOfLocationsFromParse.listIterator();

			List<EgsdLoctionObject> listOfParseLocationObjects = new ArrayList<EgsdLoctionObject>(10);

			while (iteratorForLocations.hasNext()) {

				ParseObject p = iteratorForLocations.next();
				// p = hlit.next();
				/*
				 * System.out.println(p.getObjectId());
				 * System.out.println(p.getString("Directories"));
				 * System.out.println(p.getString("Name"));
				 * System.out.println(p.getString("zipcode"));
				 * System.out.println(p.getString("Address1"));
				 */

				String logo = "No Image To Display";
				if (p.getParseFile("Logo") != null)
					logo = p.getParseFile("Logo").getUrl();

				String qRCode = "No Image To Display";
				if (p.getParseFile("QRCode") != null)
					qRCode = p.getParseFile("QRCode").getUrl();

				String hotelLogo = "No Image To Display";
				if (p.getParseFile("HotelLogo") != null)
					hotelLogo = p.getParseFile("HotelLogo").getUrl();

				String footerImage = "No Image To Display";
				if (p.getParseFile("footerImage") != null)
					footerImage = p.getParseFile("FooterImage").getUrl();
				
				EgsdLoctionObject e = new EgsdLoctionObject();

			    e.setObjectId(p.getObjectId());
			    e.setDirectory(p.getString("Directories"));
			    e.setName(p.getString("Name"));
			    e.setZipcode(p.getString("zipcode"));
			    e.setAddress(p.getString("Address1"));
			    e.setAddress2(p.getString("Address2"));
			    e.setStreet(p.getString("Street"));
			    e.setTown(p.getString("Town"));
			    e.setSiteId(p.getString("GroupSiteId"));
			    e.setGroupName(p.getString("GroupName"));
			    e.setCountry(p.getString("Country"));
			    e.setLogo(logo);
			    e.setqRCode(qRCode);
			    e.setParentDirectoryId(p.getString("ParentLocationID"));
			    e.setDescription(p.getString("description"));
				listOfParseLocationObjects.add(e);

			}

			mav.addObject("adminLocObj", listOfParseLocationObjects);

			System.out.println("End of Controller");

		} catch (NullPointerException npe) {

		}
	}
	
	
	
	@RequestMapping(value = "/editTemplate", headers = "content-type=multipart/*", method = RequestMethod.POST)
	public ModelAndView editTemplate(MultipartHttpServletRequest request) throws ParseException {

		
		ParseQuery<ParseObject> sty = ParseQuery.getQuery("Template");
		sty.whereEqualTo("objectId", request.getParameter("tempId"));
		List<ParseObject> styList = null;
		String style = "";
		try {
			styList = sty.find();
		} catch (Exception e) {
		e.printStackTrace();
		}
		Iterator<ParseObject> stt = styList.listIterator();
		if (stt.hasNext()) {
			ParseObject sssst = stt.next();
			ParseObject StyleIdPO = sssst.getParseObject("StyleId");
			try{
			style = StyleIdPO.getObjectId();
			
			ParseObject styleClass = ParseObject.createWithoutData("Style",style);
			if(request.getParameter("templateTitleColor")!=null&&!request.getParameter("templateTitleColor").equals("")){
				styleClass.put("hotelTitleColor", request.getParameter("templateTitleColor"));
				 }
			 if(request.getParameter("templateTitleFont")!=null&&!request.getParameter("templateTitleFont").equals("")){
				 styleClass.put("hotelTitleFont", request.getParameter("templateTitleFont"));
		     }
		     if(request.getParameter("templateTitleFontFamily")!=null&&!request.getParameter("templateTitleFontFamily").equals("")){
		    	 styleClass.put("hotelTitleFontFamily", request.getParameter("templateTitleFontFamily"));
		     }
		     
		    
		     
		     if(request.getParameter("templateCaptionColor")!=null&&!request.getParameter("templateCaptionColor").equals("")){
		    	 styleClass.put("hotelCaptionColor", request.getParameter("templateCaptionColor"));
				 }
			 if(request.getParameter("templateCaptionFont")!=null&&!request.getParameter("templateCaptionFont").equals("")){
				 styleClass.put("hotelCaptionFont", request.getParameter("templateCaptionFont"));
		     }
		     if(request.getParameter("templateCaptionFontFamily")!=null&&!request.getParameter("templateCaptionFontFamily").equals("")){
		    	 styleClass.put("hotelCaptionFontFamily", request.getParameter("templateCaptionFontFamily"));
		     }
		     
		     if(request.getParameter("templateAddressColor")!=null&&!request.getParameter("templateAddressColor").equals("")){
					styleClass.put("LocationAddressFontColor", request.getParameter("templateAddressColor"));
					 }
				 if(request.getParameter("templateAddressFont")!=null&&!request.getParameter("templateAddressFont").equals("")){
					 styleClass.put("LocationAddressFont", request.getParameter("templateAddressFont"));
			     }
			     if(request.getParameter("templateAddressFamily")!=null&&!request.getParameter("templateAddressFamily").equals("")){
			    	 styleClass.put("LocationAddressFontFamily", request.getParameter("templateAddressFamily"));
			     }
		     
		    
			 if(request.getParameter("templateBrandBGColor")!=null&&!request.getParameter("templateBrandBGColor").equals("")){
				 styleClass.put("LocationBackground", request.getParameter("templateBrandBGColor"));
				 }
			 if(request.getParameter("templateBrandButtonColor")!=null&&!request.getParameter("templateBrandButtonColor").equals("")){
				 styleClass.put("BrandButtonColor", request.getParameter("templateBrandButtonColor"));
		     }
		     if(request.getParameter("templateBrandFontColor")!=null&&!request.getParameter("templateBrandFontColor").equals("")){
		    	 styleClass.put("BrandFontColor", request.getParameter("templateBrandFontColor"));
		     }
		     if(request.getParameter("templateBrandFontFamily")!=null&&!request.getParameter("templateBrandFontFamily").equals("")){
		    	 styleClass.put("BrandFontFamily", request.getParameter("templateBrandFontFamily"));
		    	 }		     
				 
				 if(request.getParameter("templateFooterbgColor")!=null&&!request.getParameter("templateFooterbgColor").equals("")){
					 styleClass.put("LocationFooterBackground", request.getParameter("templateFooterbgColor"));
				 }
				 if(request.getParameter("templateFooterColor")!=null&&!request.getParameter("templateFooterColor").equals("")){
					 styleClass.put("FooterTextColor", request.getParameter("templateFooterColor"));
				 }
				 if(request.getParameter("templateFooterFont")!=null){
					 styleClass.put("footerFont", request.getParameter("templateFooterFont"));
				 }
				 if(request.getParameter("templateFooterCaptionFamily")!=null){
					 styleClass.put("footerCaptionFamily", request.getParameter("templateFooterCaptionFamily"));
				 }
			 try{
				 
				 styleClass.save(); 
			 }
			 catch(Exception e){
				 
				 e.printStackTrace();
			 }
			
			
			
			
			}
			catch(Exception e){
				ParseObject postyle= new ParseObject("Style");
				
				 
				 if(request.getParameter("templateTitleColor")!=null&&!request.getParameter("templateTitleColor").equals("")){
					 postyle.put("hotelTitleColor", request.getParameter("templateTitleColor"));
					 }
				 if(request.getParameter("templateTitleFont")!=null&&!request.getParameter("templateTitleFont").equals("")){
			    	 postyle.put("hotelTitleFont", request.getParameter("templateTitleFont"));
			     }
			     if(request.getParameter("templateTitleFontFamily")!=null&&!request.getParameter("templateTitleFontFamily").equals("")){
			    	 postyle.put("hotelTitleFontFamily", request.getParameter("templateTitleFontFamily"));
			     }
			     
			     if(request.getParameter("templateCaptionColor")!=null&&!request.getParameter("templateCaptionColor").equals("")){
					 postyle.put("hotelCaptionColor", request.getParameter("templateCaptionColor"));
					 }
				 if(request.getParameter("templateCaptionFont")!=null&&!request.getParameter("templateCaptionFont").equals("")){
			    	 postyle.put("hotelCaptionFont", request.getParameter("templateCaptionFont"));
			     }
			     if(request.getParameter("templateCaptionFontFamily")!=null&&!request.getParameter("templateCaptionFontFamily").equals("")){
			    	 postyle.put("hotelCaptionFontFamily", request.getParameter("templateCaptionFontFamily"));
			     }
			     
			     if(request.getParameter("templateAddressColor")!=null&&!request.getParameter("templateAddressColor").equals("")){
			    	 postyle.put("LocationAddressFontColor", request.getParameter("templateAddressColor"));
						 }
					 if(request.getParameter("templateAddressFont")!=null&&!request.getParameter("templateAddressFont").equals("")){
						 postyle.put("LocationAddressFont", request.getParameter("templateAddressFont"));
				     }
				     if(request.getParameter("templateAddressFamily")!=null&&!request.getParameter("templateAddressFamily").equals("")){
				    	 postyle.put("LocationAddressFontFamily", request.getParameter("templateAddressFamily"));
				     }
			     
			    
				 if(request.getParameter("templateBrandBGColor")!=null&&!request.getParameter("templateBrandBGColor").equals("")){
					 postyle.put("LocationBackground", request.getParameter("templateBrandBGColor"));
					 }
				 if(request.getParameter("templateBrandButtonColor")!=null&&!request.getParameter("templateBrandButtonColor").equals("")){
			    	 postyle.put("BrandButtonColor", request.getParameter("templateBrandButtonColor"));
			     }
			     if(request.getParameter("templateBrandFontColor")!=null&&!request.getParameter("templateBrandFontColor").equals("")){
			    	 postyle.put("BrandFontColor", request.getParameter("templateBrandFontColor"));
			     }
			     if(request.getParameter("templateBrandFontFamily")!=null&&!request.getParameter("templateBrandFontFamily").equals("")){
			    	 postyle.put("BrandFontFamily", request.getParameter("templateBrandFontFamily"));
			    	 }		     
					 
					 if(request.getParameter("templateFooterbgColor")!=null&&!request.getParameter("templateFooterbgColor").equals("")){
					 postyle.put("LocationFooterBackground", request.getParameter("templateFooterbgColor"));
					 }
					 if(request.getParameter("templateFooterColor")!=null&&!request.getParameter("templateFooterColor").equals("")){
						 postyle.put("FooterTextColor", request.getParameter("templateFooterColor"));
					 }
					 if(request.getParameter("templateFooterFont")!=null){
						 postyle.put("footerFont", request.getParameter("templateFooterFont"));
					 }
					 if(request.getParameter("templateFooterCaptionFamily")!=null){
						 postyle.put("footerCaptionFamily", request.getParameter("templateFooterCaptionFamily"));
					 }
					 
					 try{
						 postyle.save();						 
					 }
					 catch(Exception ee){
						 ee.printStackTrace();
					 }
					 style=postyle.getObjectId();
				
			}
			
			}
		System.out.println("style id is " + style);

		 

	ParseObject parseObjectForTemplate = ParseObject.createWithoutData("Template", request.getParameter("tempId"));
		if(style!=null&&!style.equals("")){
			parseObjectForTemplate.put("StyleId", ParseObject.createWithoutData("Style",style));			
		}
		
		if (request.getParameter("editTemplateName") != null&&!request.getParameter("editTemplateName").equals(""))
			parseObjectForTemplate.put("Name", request.getParameter("editTemplateName"));
		
		if(request.getParameter("templateCaption")!=null&&!request.getParameter("templateCaption").equals("")){
			parseObjectForTemplate.put("hotelCaption", request.getParameter("templateCaption"));
	     }
		
		if(request.getParameter("templateFooterText")!=null&&!request.getParameter("templateFooterText").equals("")){
			parseObjectForTemplate.put("footerText", request.getParameter("templateFooterText"));
	     }
		
		if (request.getParameter("templateDescription") != null&&!request.getParameter("templateDescription").equals(""))
			parseObjectForTemplate.put("description", request.getParameter("templateDescription"));
		
		ParseFile pf = null;
		MultipartFile multiFile = request.getFile("templateLogo");
		String imageType = multiFile.getContentType();
		
		try {
			System.out.println("File Length:" + multiFile.getBytes().length);
			System.out.println("File Type:" + multiFile.getContentType());
			String fileName = multiFile.getOriginalFilename();
			System.out.println("File Name:" + fileName);
			if (multiFile.getBytes().length > 0) {
				pf = new ParseFile("templateLogo.jpg", multiFile.getBytes());
				try {
					pf.save();
					parseObjectForTemplate.put("templateLogo", pf);
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		} catch (IOException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		}
		ParseFile pf1 = null;
		MultipartFile multiFile1 = request.getFile("templateImage");
		String imageType1 = multiFile.getContentType();
		// just to show that we have actually received the file
		try {
			System.out.println("File Length:" + multiFile1.getBytes().length);
			System.out.println("File Type:" + multiFile1.getContentType());
			String fileName = multiFile1.getOriginalFilename();
			System.out.println("File Name:" + fileName);
			if (multiFile1.getBytes().length > 0) {
				pf1 = new ParseFile("templateImage.jpg", multiFile1.getBytes());
				try {
					pf1.save();
					parseObjectForTemplate.put("templateImage", pf1);
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		} catch (IOException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		}
		ParseFile pf2 = null;
		MultipartFile multiFile2 = request.getFile("templateFooter");
		String imageType2 = multiFile2.getContentType();
		// just to show that we have actually received the file
		try {
			System.out.println("File Length:" + multiFile2.getBytes().length);
			System.out.println("File Type:" + multiFile2.getContentType());
			String fileName = multiFile2.getOriginalFilename();
			System.out.println("File Name:" + fileName);
			if (multiFile2.getBytes().length > 0) {
				pf2 = new ParseFile("templateFooter.jpg", multiFile2.getBytes());
				try {
					pf2.save();
					parseObjectForTemplate.put("templateFooter", pf2);
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		} catch (IOException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		}
			
		
		try {
			parseObjectForTemplate.save();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		// redirecting to home page

		System.out.println("edit location is redireting to getDataFromParse()");
		viewTemplates(request);
		System.out.println("getDataFromParse() is redireting to edit location ");

		

		if (request.getParameter("userName").equals("CS Admin"))
			mav.setViewName("CSAdminTemplates");

		if (request.getParameter("userName").equals("Super Admin"))
			mav.setViewName("SuperAdminTemplates");

		if (request.getParameter("userName").equals("IT Admin"))
			mav.setViewName("ITAdminTemplates");

		mav.addObject("userName", request.getParameter("userName"));
		mav.addObject("user", request.getParameter("user"));

		return mav;

	}

	@RequestMapping(value = "/editLocation", headers = "content-type=multipart/*", method = RequestMethod.POST)
	public ModelAndView editLocation(MultipartHttpServletRequest request) {

		System.out.println("Entered into Edit Location");

		System.out.println("objectId:" + request.getParameter("locId"));
		System.out.println("directoryId:" + request.getParameter("directory"));
		System.out.println("Name:" + request.getParameter("editHotelName"));
		System.out.println("Address1:" + request.getParameter("address"));
		System.out.println("Address2:" + request.getParameter("address2"));
		System.out.println("street:" + request.getParameter("street"));
		System.out.println("town:" + request.getParameter("town"));
		System.out.println("zipcode:" + request.getParameter("zipcode"));
		System.out.println("description:" + request.getParameter("descriptionhtml"));
		System.out.println("user:" + request.getParameter("user"));
		System.out.println("country:" + request.getParameter("country"));
		System.out.println("siteid:" + request.getParameter("siteIdName"));
		System.out.println("logo:" + request.getFile("logo"));
		System.out.println("hotelLogo:" + request.getFile("hotelLogo"));
		System.out.println("hotelFooter:" + request.getFile("hotelFooter"));

		System.out.println("brand " + request.getParameter("brandId"));
		System.out.println("brand color " + request.getParameter("brandBGColor"));
		System.out.println("brand font " + request.getParameter("brandColor"));
		System.out.println("brand font " + request.getParameter("brandFont"));

		System.out.println("footer " + request.getParameter("footerSite"));
		System.out.println("footer color " + request.getParameter("footerbgColor"));
		System.out.println("footer font " + request.getParameter("footerColor"));
		System.out.println("footerCaptionFamily " + request.getParameter("footerCaptionFamily"));

		System.out.println("address " + request.getParameter("addressId"));
		System.out.println("address color " + request.getParameter("addressbgColor"));
		System.out.println("address font " + request.getParameter("addressColor"));
		System.out.println("address font " + request.getParameter("addressFont"));
		System.out.println("address " + request.getParameter("addressId"));
		System.out.println("style id " + request.getParameter("styleId"));
		
		System.out.println("brandButton Color" + request.getParameter("brandButtonColor"));
		System.out.println("brandFont Color" + request.getParameter("brandFontColor"));
		System.out.println("brandFont Color  " + request.getParameter("brandFontColor"));
		
		System.out.println("hotel color " + request.getParameter("hotelTitleColor"));
		System.out.println("hotel font" + request.getParameter("hotelTitleFont"));
		System.out.println("hotel font " + request.getParameter("hotelTitleFontFamily"));
		System.out.println("hotel caption " + request.getParameter("hotelCaption"));
		System.out.println("caption color " + request.getParameter("hotelCaptionColor"));
		System.out.println("caption font " + request.getParameter("hotelCaptionFont"));
		System.out.println("caption font " + request.getParameter("hotelCaptionFontFamily"));
		System.out.println("address family " + request.getParameter("addressFamily"));
		
		
		

		System.out.println("admin:" + request.getParameter("admin"));
		ParseQuery<ParseObject> sty = ParseQuery.getQuery("Location");
		sty.whereEqualTo("objectId", request.getParameter("locId"));
		List<ParseObject> styList = null;
		String style = "";
		try {
			styList = sty.find();
		} catch (Exception e) {
		e.printStackTrace();
		}
		Iterator<ParseObject> stt = styList.listIterator();
		if (stt.hasNext()) {
			ParseObject sssst = stt.next();
			ParseObject StyleIdPO = sssst.getParseObject("StyleId");
			try{
			style = StyleIdPO.getObjectId();
			}
			catch(Exception e){
				ParseObject postyle= new ParseObject("Style");
				 if(request.getParameter("hotelTitleColor")!=null&&!request.getParameter("hotelTitleColor").equals("")){
					 postyle.put("hotelTitleColor", request.getParameter("hotelTitleColor"));
					 }
				 if(request.getParameter("hotelTitleFont")!=null&&!request.getParameter("hotelTitleFont").equals("")){
			    	 postyle.put("hotelTitleFont", request.getParameter("hotelTitleFont"));
			     }
			     if(request.getParameter("hotelTitleFontFamily")!=null&&!request.getParameter("hotelTitleFontFamily").equals("")){
			    	 postyle.put("hotelTitleFontFamily", request.getParameter("hotelTitleFontFamily"));
			     }
			     if(request.getParameter("hotelCaptionColor")!=null&&!request.getParameter("hotelCaptionColor").equals("")){
					 postyle.put("hotelCaptionColor", request.getParameter("hotelCaptionColor"));
					 }
				 if(request.getParameter("hotelCaptionFont")!=null&&!request.getParameter("hotelCaptionFont").equals("")){
			    	 postyle.put("hotelCaptionFont", request.getParameter("hotelCaptionFont"));
			     }
			     if(request.getParameter("hotelCaptionFontFamily")!=null&&!request.getParameter("hotelCaptionFontFamily").equals("")){
			    	 postyle.put("hotelCaptionFontFamily", request.getParameter("hotelCaptionFontFamily"));
			     }
			     
			     
			     if(request.getParameter("brandFontFamily")!=null&&!request.getParameter("brandFontFamily").equals("")){
			    	 postyle.put("BrandFontFamily", request.getParameter("brandFontFamily"));
			     }
				
				 if(request.getParameter("brandBGColor")!=null&&!request.getParameter("brandBGColor").equals("")){
					 postyle.put("LocationBackground", request.getParameter("brandBGColor"));
					 }
				 if(request.getParameter("brandButtonColor")!=null&&!request.getParameter("brandButtonColor").equals("")){
			    	 postyle.put("BrandButtonColor", request.getParameter("brandButtonColor"));
			     }
			     if(request.getParameter("brandFontColor")!=null&&!request.getParameter("brandFontColor").equals("")){
			    	 postyle.put("BrandFontColor", request.getParameter("brandFontColor"));
			     }
			     if(request.getParameter("brandFontFamily")!=null&&!request.getParameter("brandFontFamily").equals("")){
			    	 postyle.put("BrandFontFamily", request.getParameter("brandFontFamily"));
			     }
					 if(request.getParameter("brandFont")!=null){
					 postyle.put("LocationTextFont", request.getParameter("brandFont"));
					 }
					 if(request.getParameter("footerbgColor")!=null&&!request.getParameter("footerbgColor").equals("")){
					 postyle.put("LocationFooterBackground", request.getParameter("footerbgColor"));
					 }
					 if(request.getParameter("footerColor")!=null&&!request.getParameter("footerColor").equals("")){
						 postyle.put("FooterTextColor", request.getParameter("footerColor"));
					 }
					 if(request.getParameter("footerFont")!=null){
						 postyle.put("footerFont", request.getParameter("footerFont"));
					 }
					 if(request.getParameter("footerCaptionFamily")!=null){
						 postyle.put("footerCaptionFamily", request.getParameter("footerCaptionFamily"));
					 }
					 if(request.getParameter("addressFont")!=null){
					 postyle.put("LocationAddressFont", request.getParameter("addressFont"));
					 }
					 if(request.getParameter("addressFamily")!=null){
					 postyle.put("LocationAddressFontFamily", request.getParameter("addressFamily"));
					 }
					 if(request.getParameter("addressColor")!=null&&!request.getParameter("addressColor").equals("")){
					 postyle.put("LocationAddressFontColor", request.getParameter("addressColor"));
					 }	
					 try{
						 postyle.save();						 
					 }
					 catch(Exception ee){
						 ee.printStackTrace();
					 }
					 style=postyle.getObjectId();
				
			}
			
			}
		System.out.println("style id is " + style);

		 ParseObject styleClass = ParseObject.createWithoutData("Style",style);
		 if(request.getParameter("hotelTitleColor")!=null&&!request.getParameter("hotelTitleColor").equals("")){
			 styleClass.put("hotelTitleColor", request.getParameter("hotelTitleColor"));
			 }
		 if(request.getParameter("hotelTitleFont")!=null&&!request.getParameter("hotelTitleFont").equals("")){
			 styleClass.put("hotelTitleFont", request.getParameter("hotelTitleFont"));
	     }
	     if(request.getParameter("hotelTitleFontFamily")!=null&&!request.getParameter("hotelTitleFontFamily").equals("")){
	    	 styleClass.put("hotelTitleFontFamily", request.getParameter("hotelTitleFontFamily"));
	     }
	     if(request.getParameter("hotelCaptionColor")!=null&&!request.getParameter("hotelCaptionColor").equals("")){
	    	 styleClass.put("hotelCaptionColor", request.getParameter("hotelCaptionColor"));
			 }
		 if(request.getParameter("hotelCaptionFont")!=null&&!request.getParameter("hotelCaptionFont").equals("")){
			 styleClass.put("hotelCaptionFont", request.getParameter("hotelCaptionFont"));
	     }
	     if(request.getParameter("hotelCaptionFontFamily")!=null&&!request.getParameter("hotelCaptionFontFamily").equals("")){
	    	 styleClass.put("hotelCaptionFontFamily", request.getParameter("hotelCaptionFontFamily"));
	     }
		 
		 
		 
		 if(request.getParameter("brandBGColor")!=null&&!request.getParameter("brandBGColor").equals("")){
		 styleClass.put("LocationBackground", request.getParameter("brandBGColor"));
		 }
		 if(request.getParameter("brandButtonColor")!=null&&!request.getParameter("brandButtonColor").equals("")){
	    	 styleClass.put("BrandButtonColor", request.getParameter("brandButtonColor"));
	     }
		 if(request.getParameter("brandFontColor")!=null&&!request.getParameter("brandFontColor").equals("")){
	    	 styleClass.put("BrandFontColor", request.getParameter("brandFontColor"));
	     }
		 if(request.getParameter("brandFontFamily")!=null&&!request.getParameter("brandFontFamily").equals("")){
	    	 styleClass.put("BrandFontFamily", request.getParameter("brandFontFamily"));
	     }
		 if(request.getParameter("brandFont")!=null){
		 styleClass.put("LocationTextFont", request.getParameter("brandFont"));
		 }
		 if(request.getParameter("footerbgColor")!=null&&!request.getParameter("footerbgColor").equals("")){
		 styleClass.put("LocationFooterBackground", request.getParameter("footerbgColor"));
		 }
		 if(request.getParameter("footerColor")!=null&&!request.getParameter("footerColor").equals("")){
			 styleClass.put("FooterTextColor", request.getParameter("footerColor"));
		 }
		 if(request.getParameter("footerFont")!=null){
			 styleClass.put("footerFont", request.getParameter("footerFont"));
		 }
		 if(request.getParameter("footerCaptionFamily")!=null){
			 styleClass.put("footerCaptionFamily", request.getParameter("footerCaptionFamily"));
		 }
		 if(request.getParameter("addressFont")!=null){
		 styleClass.put("LocationAddressFont", request.getParameter("addressFont"));
		 }
		 if(request.getParameter("addressFamily")!=null){
		 styleClass.put("LocationAddressFontFamily", request.getParameter("addressFamily"));
		 }
		 if(request.getParameter("addressColor")!=null&&!request.getParameter("addressColor").equals("")){
		 styleClass.put("LocationAddressFontColor", request.getParameter("addressColor"));
		 }
		 try{
			 
			 styleClass.save(); 
		 }
		 catch(Exception e){
			 
			 e.printStackTrace();
		 }

		ParseObject parseObjectForLocation = ParseObject.createWithoutData("Location", request.getParameter("locId"));
		if(style!=null&&!style.equals("")){
			parseObjectForLocation.put("StyleId", ParseObject.createWithoutData("Style",style));
			
		}
		if (request.getParameter("editHotelName") != null&&!request.getParameter("editHotelName").equals(""))
			parseObjectForLocation.put("Name", request.getParameter("editHotelName"));
		if (request.getParameter("address") != null)
			parseObjectForLocation.put("Address1", request.getParameter("address"));
		if (request.getParameter("address2") != null)
			parseObjectForLocation.put("Address2", request.getParameter("address2"));
		if (request.getParameter("street") != null)
			parseObjectForLocation.put("Street", request.getParameter("street"));
		if (request.getParameter("town") != null)
			parseObjectForLocation.put("Town", request.getParameter("town"));
		if (request.getParameter("zipcode") != null)
			parseObjectForLocation.put("zipcode", request.getParameter("zipcode"));
		if (request.getParameter("country") != null)
			parseObjectForLocation.put("Country", request.getParameter("country"));
		if (!request.getParameter("longitude").equals(""))
		{
			double latitude = Double.parseDouble(request.getParameter("latitude"));
			double longitude = Double.parseDouble(request.getParameter("longitude"));
			ParseGeoPoint point = new ParseGeoPoint(latitude, longitude);
			
			parseObjectForLocation.put("Geopoints", point);
		}
		else
		{
			ParseGeoPoint point = new ParseGeoPoint(0.0000, 0.0000);
			
			parseObjectForLocation.put("Geopoints", point);
		}
			
		if (request.getParameter("siteIdName") != null&&!request.getParameter("siteIdName").equals(""))
			parseObjectForLocation.put("GroupSiteId", request.getParameter("siteIdName"));
		if (request.getParameter("descriptionhtml") != null&&!request.getParameter("descriptionhtml").equals(""))
			parseObjectForLocation.put("description", request.getParameter("descriptionhtml"));
		if (request.getParameter("footerSite") != null&&!request.getParameter("footerSite").equals(""))
			parseObjectForLocation.put("footerText", request.getParameter("footerSite"));
		if(request.getParameter("hotelCaption") != null&&!request.getParameter("hotelCaption").equals("")){
			parseObjectForLocation.put("hotelCaption", request.getParameter("hotelCaption"));
		}		
		
		
		ParseFile pf = null;
		MultipartFile multiFile = request.getFile("logo");
		String imageType = multiFile.getContentType();
		
		try {
			System.out.println("File Length:" + multiFile.getBytes().length);
			System.out.println("File Type:" + multiFile.getContentType());
			String fileName = multiFile.getOriginalFilename();
			System.out.println("File Name:" + fileName);
			if (multiFile.getBytes().length > 0) {
				pf = new ParseFile("logo.jpg", multiFile.getBytes());
				try {
					pf.save();
					parseObjectForLocation.put("Logo", pf);
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		} catch (IOException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		}
		ParseFile pf1 = null;
		MultipartFile multiFile1 = request.getFile("hotelLogo");
		String imageType1 = multiFile.getContentType();
		// just to show that we have actually received the file
		try {
			System.out.println("File Length:" + multiFile1.getBytes().length);
			System.out.println("File Type:" + multiFile1.getContentType());
			String fileName = multiFile1.getOriginalFilename();
			System.out.println("File Name:" + fileName);
			if (multiFile1.getBytes().length > 0) {
				pf1 = new ParseFile("logo.jpg", multiFile1.getBytes());
				try {
					pf1.save();
					parseObjectForLocation.put("hotelLogo", pf1);
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		} catch (IOException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		}
		ParseFile pf2 = null;
		MultipartFile multiFile2 = request.getFile("hotelFooter");
		String imageType2 = multiFile2.getContentType();
		// just to show that we have actually received the file
		try {
			System.out.println("File Length:" + multiFile2.getBytes().length);
			System.out.println("File Type:" + multiFile2.getContentType());
			String fileName = multiFile2.getOriginalFilename();
			System.out.println("File Name:" + fileName);
			if (multiFile2.getBytes().length > 0) {
				pf2 = new ParseFile("logo.jpg", multiFile2.getBytes());
				try {
					pf2.save();
					parseObjectForLocation.put("footerImage", pf2);
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		} catch (IOException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		}
		try {
			parseObjectForLocation.save();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		// redirecting to home page

		System.out.println("edit location is redireting to getDataFromParse()");
		// EgsdController.getDataFromParse(request);
		// adminLoad(request);
		try {
			select(request);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("getDataFromParse() is redireting to edit location ");

		if (request.getParameter("userName").equals("Location Admin"))
			mav.setViewName("LocationDetails");

		if (request.getParameter("userName").equals("CS Admin"))
			mav.setViewName("CSAdmin");

		if (request.getParameter("userName").equals("Super Admin"))
			mav.setViewName("SuperAdmin");

		if (request.getParameter("userName").equals("IT Admin"))
			mav.setViewName("ITAdmin");

		mav.addObject("userName", request.getParameter("userName"));
		mav.addObject("user", request.getParameter("user"));

		return mav;

	}


	@RequestMapping(value = "/viewLocation")
	public ModelAndView redirectsToIndividualLocation(HttpServletRequest request) {

		System.out.println("user:" + request.getParameter("user"));
		System.out.println("userName:" + request.getParameter("userName"));
		System.out.println("locId:" + request.getParameter("locId"));

		viewLocation(request);

		if (request.getParameter("userName").equals("CS Admin"))
			mav.setViewName("CSAdminIndividualHotel");

		if (request.getParameter("userName").equals("Super Admin"))
			mav.setViewName("SuperAdminIndividualHotel");

		mav.addObject("userName", request.getParameter("userName"));
		mav.addObject("user", request.getParameter("user"));

		return mav;
	}
	
	
	
	
	
	
	
	

	public static void viewLocation(HttpServletRequest request) {

		System.out.println("In viewLoc()");
		mav.clear();

		System.out.println("user:" + request.getParameter("user"));
		System.out.println("userName:" + request.getParameter("userName"));
		System.out.println("locId:" + request.getParameter("locId"));

		List<ParseObject> results = null;
		List<ParseObject> changeLocresults = null;

		ParseQuery<ParseObject> queryForLocationAdminWasEmpty = ParseQuery.getQuery("_User");
		queryForLocationAdminWasEmpty.whereEqualTo("user", "Location Admin");
		// queryForLocationAdminWasEmpty.whereEqualTo("locationId", "empty");

		List<ParseObject> listOfEmptyAdmins = null;

		try {
			listOfEmptyAdmins = queryForLocationAdminWasEmpty.find();
		} catch (ParseException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		}
		List<EgsdUserObjects> listOfUserObjects = new ArrayList<EgsdUserObjects>(100);

		try {
			Iterator<ParseObject> iteratorForEmptyAdmins = listOfEmptyAdmins.listIterator();

			while (iteratorForEmptyAdmins.hasNext()) {

				ParseObject parseObjectHavingEmptyAdmins = iteratorForEmptyAdmins.next();

				listOfUserObjects.add(new EgsdUserObjects(parseObjectHavingEmptyAdmins.getObjectId(),
						parseObjectHavingEmptyAdmins.getString("username"), null,
						parseObjectHavingEmptyAdmins.getString("user"), parseObjectHavingEmptyAdmins.getString("email"),
						parseObjectHavingEmptyAdmins.getString("locationId"),
						parseObjectHavingEmptyAdmins.getString("firstname"),
						parseObjectHavingEmptyAdmins.getString("lastname"),
						parseObjectHavingEmptyAdmins.getString("phone")));
			}

		} catch (NullPointerException npe) {

			listOfUserObjects
					.add(new EgsdUserObjects("empty", "Please Add Location Admin", null, null, null, null, null, null,null));

		}

		mav.addObject("listOfEmptyLocationAdmins", listOfUserObjects);

		// list of Templates
		ParseQuery<ParseObject> queryForTemplateObjects = ParseQuery.getQuery("Template");
		queryForTemplateObjects.whereNotEqualTo("type", "group");

		List<ParseObject> listOfTemplateObjects = null;

		try {
			listOfTemplateObjects = queryForTemplateObjects.find();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		try {
			Iterator<ParseObject> iteratorForTemplateObjects = listOfTemplateObjects.listIterator();
			List<EgsdTemplateObjects> listOfEgsdTemplateObjects = new ArrayList<EgsdTemplateObjects>(20);

			while (iteratorForTemplateObjects.hasNext()) {

				ParseObject templateObjects = iteratorForTemplateObjects.next();

				listOfEgsdTemplateObjects
						.add(new EgsdTemplateObjects(templateObjects.getObjectId(), templateObjects.getString("Name"),
								templateObjects.getObjectId(), templateObjects.getBoolean("Customized")));

			}

			mav.addObject("listOfEgsdTemplateObjects", listOfEgsdTemplateObjects);

		} catch (NullPointerException npe) {

		}

		// list of Groups
		ParseQuery<ParseObject> queryForGroupObjects = ParseQuery.getQuery("Template");
		queryForGroupObjects.whereEqualTo("type", "group");

		List<ParseObject> listOfGroupObjects = null;

		try {
			listOfGroupObjects = queryForGroupObjects.find();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		try {
			Iterator<ParseObject> iteratorForGroupObjects = listOfGroupObjects.listIterator();
			List<EgsdTemplateObjects> listOfEgsdGroupObjects = new ArrayList<EgsdTemplateObjects>(20);

			while (iteratorForGroupObjects.hasNext()) {

				ParseObject templateObjects = iteratorForGroupObjects.next();

				listOfEgsdGroupObjects
						.add(new EgsdTemplateObjects(templateObjects.getObjectId(), templateObjects.getString("Name"),
								templateObjects.getObjectId(), templateObjects.getBoolean("Customized")));
			}

			mav.addObject("listOfEgsdGroupObjects", listOfEgsdGroupObjects);

		} catch (NullPointerException npe) {

		}

		ParseQuery<ParseObject> changeLocquery = ParseQuery.getQuery("Location");
		// changeLocquery.whereEqualTo("user",
		// request.getParameter("name"));
		try {
			changeLocresults = changeLocquery.find();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println(changeLocresults);
		List<EgsdLoctionObject> changeLoc = new ArrayList<EgsdLoctionObject>(20);

		try {
			Iterator<ParseObject> changeLocIterator = changeLocresults.listIterator();
			while (changeLocIterator.hasNext()) {
				ParseObject locchange = changeLocIterator.next();

				EgsdLoctionObject e =new EgsdLoctionObject();
			    e.setObjectId(locchange.getObjectId());
			    e.setDirectory(locchange.getString("Directories"));
			    e.setName(locchange.getString("Name"));
			    e.setZipcode(locchange.getString("zipcode"));
			    e.setAddress(locchange.getString("Address1"));
			    e.setAddress2(locchange.getString("Address2"));
			    e.setStreet(locchange.getString("Street"));
			    e.setTown(locchange.getString("Town"));
			    e.setSiteId(locchange.getString("GroupSiteId"));
			    e.setGroupName(locchange.getString("GroupName"));
			    e.setCountry(locchange.getString("Country"));
			    e.setParentDirectoryId(locchange.getString("ParentLocationID"));
			    e.setDescription(locchange.getString("description"));

			    changeLoc.add(e);

			}
		} catch (NullPointerException npe) {

		}

		// System.out.println(changeLoc);
		mav.addObject("changeLoc", changeLoc);
		mav.addObject("selectLocObj", changeLoc);

		String directoryIdForLocationId = null;

		if (request.getParameter("objectId") != null) {
			ParseQuery<ParseObject> queryForDirectoryId = ParseQuery.getQuery("DirectoryItem");
			queryForDirectoryId.whereEqualTo("objectId", request.getParameter("objectId"));
			List<ParseObject> listObjectHavingRequiredDirectoryId = null;

			try {
				listObjectHavingRequiredDirectoryId = queryForDirectoryId.find();
			} catch (ParseException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}

			Iterator<ParseObject> iteratorHavingDirectoryId = listObjectHavingRequiredDirectoryId.listIterator();

			ParseObject parseObjectHavingDirectoryId = iteratorHavingDirectoryId.next();

			directoryIdForLocationId = parseObjectHavingDirectoryId.getString("LocationId");
		}

		System.out.println("Location id:" + directoryIdForLocationId);

		ParseQuery<ParseObject> query = ParseQuery.getQuery("Location");
		if (request.getParameter("locId") != null)
			query.whereEqualTo("objectId", request.getParameter("locId"));
		if (request.getAttribute("locId") != null)
			query.whereEqualTo("objectId", request.getAttribute("locId"));
		try {
			results = query.find();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println(results);
		List<EgsdLoctionObject> hlobj = new ArrayList<EgsdLoctionObject>();
		try {
			Iterator<ParseObject> hlit = results.listIterator();
			ParseObject p = null;
			while (hlit.hasNext()) {
				p = hlit.next();
				/*
				 * System.out.println(p.getObjectId());
				 * System.out.println(p.getString("Directories"));
				 * System.out.println(p.getString("Name"));
				 * System.out.println(p.getString("zipcode"));
				 * System.out.println(p.getString("Address1"));
				 */

				String logo = "No Image To Display";
				if (p.getParseFile("Logo") != null)
					logo = p.getParseFile("Logo").getUrl();

				String qRCode = "No Image To Display";
				if (p.getParseFile("QRCode") != null)
					qRCode = p.getParseFile("QRCode").getUrl();

				String hotelLogo = "No Image To Display";
				if (p.getParseFile("HotelLogo") != null)
					hotelLogo = p.getParseFile("HotelLogo").getUrl();

				String footerImage = "No Image To Display";
				if (p.getParseFile("FooterImage") != null)
					footerImage = p.getParseFile("FooterImage").getUrl();

				EgsdLoctionObject e = new EgsdLoctionObject();

				e.setObjectId(p.getObjectId());
				e.setDirectory(p.getString("Directories"));
				e.setName(p.getString("Name"));
				e.setZipcode(p.getString("zipcode"));
				e.setAddress(p.getString("Address1"));
				e.setAddress2(p.getString("Address2"));
				e.setStreet(p.getString("Street"));
				e.setTown(p.getString("Town"));
				e.setSiteId(p.getString("siteId"));
				e.setGroupName(p.getString("GroupName"));
				e.setCountry(p.getString("Country"));
				e.setLogo(logo);
				e.setqRCode(qRCode);
				e.setParentDirectoryId(p.getString("ParentLocationID"));
				e.setDescription(p.getString("description"));

				hlobj.add(e);

				// hlobj.add(new EgsdLoctionObject(p.getObjectId(),
				// p.getString("Directories"), p.getString("Name"),
				// p.getString("zipcode"), p.getString("Address1"),
				// p.getString("Address2"), p.getString("Street"),
				// p.getString("Town"),p.getString("GroupSiteId"),p.getString("GroupName"),p.getString("Country"),logo,qRCode,p.getString("ParentLocationID"),p.getString("description")));

				// hlobj.add(new
				// EgsdHotelAndLocObj(p.getString("hotel_name"),p.getString("location")));
			}
		} catch (NullPointerException npe) {

		}
		System.out.println(hlobj);

		mav.addObject("locObj", hlobj);
		mav.addObject("locObjForEdit", hlobj);
		mav.addObject("locObjForAddDirectoryItems", hlobj);
		mav.addObject("locObjForEditLocation", hlobj);
		mav.addObject("locObjForDeleteLocation", hlobj);
		mav.addObject("locObjForParentHotel", hlobj);

		// this is for directory items objects

		ParseQuery<EgsdDirectoryItemParseObject> queryForDirectoryItem = ParseQuery.getQuery("DirectoryItem");
		if (request.getParameter("locId") != null)
			queryForDirectoryItem.whereEqualTo("LocationId", request.getParameter("locId"));
		if (request.getAttribute("locId") != null)
			queryForDirectoryItem.whereEqualTo("LocationId", request.getAttribute("locId"));

		// queryForDirectoryItem.whereEqualTo("DirectoryID",p.getString("Directories"));
		queryForDirectoryItem.orderByAscending("Title");
		queryForDirectoryItem.limit(1000);
		List<EgsdDirectoryItemParseObject> directoryItemParseObjectsList = null;
		try {
			directoryItemParseObjectsList = queryForDirectoryItem.find();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		List<EgsdDirectoryItemObjects> directoryItemObjectsList = new ArrayList<EgsdDirectoryItemObjects>(300);
		System.out.println("Directory items are loaded:");
		try {
			Iterator<EgsdDirectoryItemParseObject> iterator = directoryItemParseObjectsList.listIterator();
			System.out.println("objectId" + "---> " + "DirectoryId" + "--->" + "getParentDirectoryId" + "--->"
					+ "getTitle" + "--->" + "getCaption" + "--->" + "getTimings" + "--->" + "getWebsite" + "--->"
					+ "getEmail" + "--->" + "getPhones");
			int count = 1;
			while (iterator.hasNext()) {

				EgsdDirectoryItemParseObject egsd = iterator.next();
				// System.out.println( count++ +" "+ egsd.getObjectId()
				// + "---> " + egsd.getDirectoryId()
				// + "--->" + egsd.getParentDirectoryId()
				// + "--->" + egsd.getTitle()
				// + "--->" + egsd.getCaption()
				// + "--->" + egsd.getTimings()
				// + "--->" + egsd.getWebsite()
				// + "--->" + egsd.getEmail()
				// + "--phoneId->" + egsd.getPhones()
				// + "--->" + egsd.getStyleID() +"<--StyleID ");
				String img = "No Image To Display";
				if (egsd.getParseFile("Picture") != null)
					img = egsd.getParseFile("Picture").getUrl();
				// System.out.print(img);
				String styleId = null;
				ParseObject StyleIdPO = egsd.getParseObject("StyleId");
				if (egsd.getParseObject("StyleId") != null)
					styleId = StyleIdPO.getObjectId();
				// System.out.println(styleId);

				/*
				 * if(StyleIdPO.getObjectId()!=null) System.out.println(
				 * "StyleID AT Directory Items"+StyleIdPO.getObjectId());
				 */

				directoryItemObjectsList.add(new EgsdDirectoryItemObjects(egsd.getObjectId(), egsd.getDirectoryId(),
						egsd.getTitle(), egsd.getCaption(), egsd.getDescription(), egsd.getTimings(), egsd.getWebsite(),
						egsd.getEmail(), egsd.getParentDirectoryId(), img, styleId, egsd.getPhones(),
						egsd.getParentDirectoryId(), egsd.getLocationId(), egsd.getCustomizedOrder()));

			}
		} catch (NullPointerException npe) {

		}

		System.out.println("before adding dir objs");
		mav.addObject("direcObjList", directoryItemObjectsList);
		mav.addObject("subDirObj", directoryItemObjectsList);
		mav.addObject("subsubDirObj", directoryItemObjectsList);
		mav.addObject("DirObjId", directoryItemObjectsList);
		mav.addObject("DiscriptionObjId", directoryItemObjectsList);
		// adding DirectiryItems for editing values
		mav.addObject("showSubDiscriptionObjId", directoryItemObjectsList);
		mav.addObject("showDiscriptionObjId", directoryItemObjectsList);
		mav.addObject("DiscriptionObjForNavBar", directoryItemObjectsList);
		mav.addObject("subDiscriptionObjForNavBar", directoryItemObjectsList);
		// addind directory Items for Adding DirectoryItems
		mav.addObject("subDiscriptionObjForAddDirItems", directoryItemObjectsList);
		mav.addObject("showSubDiscriptionObjIdForDelete", directoryItemObjectsList);

		System.out.println("aftr adding dir objs");

		System.out.println("in select b4 Phones");

		ParseQuery<ParseObject> queryForPhones = ParseQuery.getQuery("Phones");
		if (request.getParameter("locId") != null)
			queryForPhones.whereEqualTo("LocationId", request.getParameter("locId"));
		if (request.getAttribute("locId") != null)
			queryForPhones.whereEqualTo("LocationId", request.getAttribute("locId"));

		queryForPhones.limit(1000);
		List<ParseObject> phonesParseObjectsList = null;
		try {
			phonesParseObjectsList = queryForPhones.find();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		List<EgsdPhonesObjects> phonesObjectsList = new ArrayList<EgsdPhonesObjects>(200);
		System.out.println("Phone Objects  are loaded:");
		// System.out.println(phonesParseObjectsList);
		try {
			Iterator<ParseObject> phoneIterator = phonesParseObjectsList.listIterator();
			int i = 0;
			while (phoneIterator.hasNext()) {

				ParseObject egsdPhonePO = phoneIterator.next();

				// System.out.println(egsdPhonePO.getObjectId()
				// +"-->"+egsdPhonePO.getString("PhoneId")
				// +"-->"+egsdPhonePO.getString("Type")
				// +"-->"+egsdPhonePO.getString("Ext"));
				phonesObjectsList.add(new EgsdPhonesObjects(egsdPhonePO.getObjectId(), egsdPhonePO.getString("PhoneId"),
						egsdPhonePO.getString("Type"), egsdPhonePO.getString("Ext")));

			}
		} catch (NullPointerException npe) {

		}
		// System.out.println(phonesObjectsList);
		mav.addObject("phonesObjectsList", phonesObjectsList);
		mav.addObject("phonesObjectsListForEdit", phonesObjectsList);
		mav.addObject("phonesObjectsListForDelete", phonesObjectsList);

		ParseQuery<ParseObject> queryForMenu = ParseQuery.getQuery("Menu");
		List<ParseObject> menuParseObjectsList = null;
		try {
			menuParseObjectsList = queryForMenu.find();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		List<EgsdMenuObjects> menuObjectsList = new ArrayList<EgsdMenuObjects>(200);
		System.out.println("Menu Items are loaded:");
		// System.out.println(menuParseObjectsList);
		try {
			Iterator<ParseObject> menuIterator = menuParseObjectsList.listIterator();
			while (menuIterator.hasNext()) {

				ParseObject egsdMenuPO = menuIterator.next();
				// System.out.println(egsdMenuPO.getObjectId() + "---> " +
				// egsdMenuPO.getString("MenuId") + "--->"
				// + egsdMenuPO.getString("Description") + "--->" +
				// egsdMenuPO.getString("Price"));
				// System.out.println(egsdMenuPO.getParseObject("StyleID"));
				// ParseObject styleIdObj=egsdMenuPO.getParseObject("StyleID");

				ParseObject ppp = egsdMenuPO.getParseObject("StyleID");
				// System.out.println("menu o.i:
				// "+egsdMenuPO.getObjectId()+"::styleId o.i:
				// "+ppp.getObjectId());

				menuObjectsList.add(new EgsdMenuObjects(egsdMenuPO.getObjectId(), egsdMenuPO.getString("MenuId"),
						egsdMenuPO.getString("Description"), egsdMenuPO.getString("Price"), ppp.getObjectId(), egsdMenuPO.getInt("Sequence")));
			}
		} catch (NullPointerException npe) {

		}
		// System.out.println(menuObjectsList);
		mav.addObject("menuObjectsList", menuObjectsList);
		mav.addObject("menuObjectsListForEdit", menuObjectsList);
		mav.addObject("menuObjectsListForDelete", menuObjectsList);

		// loading StyleId objs
		ParseQuery<ParseObject> queryForStyleID = ParseQuery.getQuery("Style");
		if (request.getParameter("locId") != null)
			queryForStyleID.whereEqualTo("LocationId", request.getParameter("locId"));
		if (request.getAttribute("locId") != null)
			queryForStyleID.whereEqualTo("LocationId", request.getAttribute("locId"));
		queryForStyleID.limit(1000);
		List<ParseObject> styleIdObjParseObj = null;
		try {
			styleIdObjParseObj = queryForStyleID.find();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		List<EgsdStyleObjects> styleObjects = new ArrayList<EgsdStyleObjects>(200);
		try {
			Iterator<ParseObject> styleIterator = styleIdObjParseObj.listIterator();
			// System.out.println(styleIdObjParseObj);

			while (styleIterator.hasNext()) {
				ParseObject sp = styleIterator.next();
				/*
				 * System.out.println(sp.getObjectId()
				 * +"-->"+sp.getString("TitleFont")
				 * +"-->"+sp.getString("TitleColor")
				 * +"-->"+sp.getString("CaptionFont")
				 * +"-->"+sp.getString("CaptionColor")
				 * +"-->"+sp.getString("DescriptionFont")
				 * +"-->"+sp.getString("DescriptionColor")
				 * +"-->"+sp.getString("PhonesFont")
				 * +"-->"+sp.getString("PhonesColor")
				 * +"-->"+sp.getString("TimingsFont")
				 * +"-->"+sp.getString("TimingsColor")
				 * +"-->"+sp.getString("WebsiteFont")
				 * +"-->"+sp.getString("WebsiteColor")
				 * +"-->"+sp.getString("EmailFont")
				 * +"-->"+sp.getString("EmailColor")
				 * +"-->"+sp.getString("StyleID")
				 * +"-->"+sp.getString("PriceFont")
				 * +"-->"+sp.getString("PriceColor"));
				 */

				styleObjects.add(new EgsdStyleObjects(sp.getObjectId(), sp.getString("TitleFont"),
						sp.getString("TitleColor"), sp.getString("TitleFamily"), sp.getString("CaptionFont"),
						sp.getString("CaptionColor"), sp.getString("CaptionFamily"), sp.getString("DescriptionFont"),
						sp.getString("DescriptionColor"), sp.getString("DescriptionFamily"), sp.getString("PhonesFont"),
						sp.getString("PhonesColor"), sp.getString("PhonesFamily"), sp.getString("TimingsFont"),
						sp.getString("TimingsColor"), sp.getString("TimingsFamily"), sp.getString("WebsiteFont"),
						sp.getString("WebsiteColor"), sp.getString("WebsiteFamily"), sp.getString("EmailFont"),
						sp.getString("EmailColor"), sp.getString("EmailFamily"), sp.getString("StyleID"),
						sp.getString("PriceFont"), sp.getString("PriceColor"), sp.getString("PriceFamily")));

			}
		} catch (NullPointerException npe) {

		}
		// System.out.println(styleObjects);
		System.out.println("Style items are Loaded");
		mav.addObject("styleObjects", styleObjects);
		mav.addObject("styleObjectsForEdit", styleObjects);
		mav.addObject("styleObjectsForMenu", styleObjects);
		mav.addObject("styleObjectsForAddDirItems", styleObjects);
		mav.addObject("styleObjectsForDelete", styleObjects);

	}

	@RequestMapping(value = "/addDirectory", headers = "content-type=multipart/*", method = RequestMethod.POST)
	public ModelAndView addDirectory(MultipartHttpServletRequest request) {

		System.out.println(request.getParameter("objectId"));

		System.out.println("Entered into Add Directories");

		System.out.println("objectId:" + request.getParameter("objectIdOfLocation"));
		System.out.println("directoryId:" + request.getParameter("directoryId"));
		System.out.println("userName:" + request.getParameter("userName"));
		System.out.println("styleId:" + request.getParameter("styleId"));
		System.out.println("phones:" + request.getParameter("phones"));
		System.out.println("---------------------------------------------");

		System.out.println("Displaying Title");
		System.out.println("title:" + request.getParameter("title"));
		System.out.println("titleColor:" + request.getParameter("titleColor"));
		System.out.println("titleFont:" + request.getParameter("titleFont"));
		System.out.println("---------------------------------------------");
		System.out.println("Displaying Caption");
		System.out.println("caption:" + request.getParameter("caption"));
		System.out.println("captionColor:" + request.getParameter("captionColor"));
		System.out.println("captionFont:" + request.getParameter("captionFont"));
		System.out.println("---------------------------------------------");

		System.out.println("Displaying Timings");
		System.out.println("timings:" + request.getParameter("timings"));
		System.out.println("timingsColor:" + request.getParameter("timingsColor"));
		System.out.println("timingsFont:" + request.getParameter("timingsFont"));
		System.out.println("---------------------------------------------");

		System.out.println("Displaying Website");
		System.out.println("website:" + request.getParameter("website"));
		System.out.println("websiteColor:" + request.getParameter("websiteColor"));
		System.out.println("websiteFont:" + request.getParameter("websiteFont"));
		System.out.println("---------------------------------------------");

		System.out.println("Displaying Email");
		System.out.println("email:" + request.getParameter("email"));
		System.out.println("emailColor:" + request.getParameter("emailColor"));
		System.out.println("emailFont:" + request.getParameter("emailFont"));
		System.out.println("---------------------------------------------");

		System.out.println("description:" + request.getParameter("description"));
		System.out.println("descriptionFont:" + request.getParameter("descriptionFont"));
		System.out.println("descriptionColor:" + request.getParameter("descriptionColor"));
		System.out.println("---------------------------------------------");

		System.out.println("phonesFont:" + request.getParameter("phonesFont"));
		System.out.println("phonesColor:" + request.getParameter("phonesColor"));
		System.out.println("phonesType:" + request.getParameter("type"));
		System.out.println("phonesext:" + request.getParameter("ext"));

		System.out.println("---------------------------------------------");
		System.out.println("priceFont:" + request.getParameter("customizeNumber"));
		System.out.println("priceFont:" + request.getParameter("priceFont"));
		System.out.println("priceColor:" + request.getParameter("priceColor"));
		System.out.println("---------------------------------------------");

		// Adding Style object
		ParseObject styleObject = new ParseObject("Style");
		if (request.getParameter("titleFont") != null)
			styleObject.put("TitleFont", request.getParameter("titleFont"));

		if (request.getParameter("titleColor") != null)
			styleObject.put("TitleColor", request.getParameter("titleColor"));

		if (request.getParameter("titleFamily") != null)
			styleObject.put("TitleFamily", request.getParameter("titleFamily"));

		if (request.getParameter("captionFont") != null)
			styleObject.put("CaptionFont", request.getParameter("captionFont"));

		if (request.getParameter("captionFamily") != null)
			styleObject.put("CaptionFamily", request.getParameter("captionFamily"));

		if (request.getParameter("captionColor") != null)
			styleObject.put("CaptionColor", request.getParameter("captionColor"));

		if (request.getParameter("descriptionFont") != null)
			styleObject.put("DescriptionFont", request.getParameter("descriptionFont"));

		if (request.getParameter("descriptionColor") != null)
			styleObject.put("DescriptionColor", request.getParameter("descriptionColor"));

		if (request.getParameter("descriptionFamily") != null)
			styleObject.put("DescriptionFamily", request.getParameter("descriptionFamily"));

		if (request.getParameter("phonesFont") != null)
			styleObject.put("PhonesFont", request.getParameter("phonesFont"));

		if (request.getParameter("phonesColor") != null)
			styleObject.put("PhonesColor", request.getParameter("phonesColor"));

		if (request.getParameter("phonesFamily") != null)
			styleObject.put("PhonesFamily", request.getParameter("phonesFamily"));

		if (request.getParameter("timingsFont") != null)
			styleObject.put("TimingsFont", request.getParameter("timingsFont"));

		if (request.getParameter("timingsColor") != null)
			styleObject.put("TimingsColor", request.getParameter("timingsColor"));

		if (request.getParameter("timingsFamily") != null)
			styleObject.put("TimingsFamily", request.getParameter("timingsFamily"));

		if (request.getParameter("websiteFont") != null)
			styleObject.put("WebsiteFont", request.getParameter("websiteFont"));

		if (request.getParameter("websiteColor") != null)
			styleObject.put("WebsiteColor", request.getParameter("websiteColor"));

		if (request.getParameter("websiteFamily") != null)
			styleObject.put("WebsiteFamily", request.getParameter("websiteFamily"));

		if (request.getParameter("emailFont") != null)
			styleObject.put("EmailFont", request.getParameter("emailFont"));

		if (request.getParameter("emailColor") != null)
			styleObject.put("EmailColor", request.getParameter("emailColor"));

		if (request.getParameter("emailFamily") != null)
			styleObject.put("EmailFamily", request.getParameter("emailFamily"));

		styleObject.put("LocationId", request.getParameter("objectIdOfLocation"));

		// styleObject.put("PriceFont", request.getParameter("priceFont"));
		// styleObject.put("PriceColor", request.getParameter("priceColor"));
		System.out.println(styleObject);

		try {
			styleObject.save();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		System.out.println(styleObject.getObjectId());

		ParseObject parseObjectForDirectoryItem = new ParseObject("DirectoryItem");

		if (request.getParameter("objectIdOfLocation") != null)
			parseObjectForDirectoryItem.put("DirectoryID", request.getParameter("objectIdOfLocation"));
		parseObjectForDirectoryItem.put("ParentReferrence", request.getParameter("objectIdOfLocation"));
		if (request.getParameter("title") != null)
			parseObjectForDirectoryItem.put("Title", request.getParameter("title"));
		if (request.getParameter("caption") != null)
			parseObjectForDirectoryItem.put("Caption", request.getParameter("caption"));
		if (request.getParameter("description") != null)
			parseObjectForDirectoryItem.put("Description", request.getParameter("description"));
		if (request.getParameter("timings") != null)
			parseObjectForDirectoryItem.put("Timings", request.getParameter("timings"));
		if (request.getParameter("website") != null)
			parseObjectForDirectoryItem.put("Website", request.getParameter("website"));
		if (request.getParameter("email") != null)
			parseObjectForDirectoryItem.put("Email", request.getParameter("email"));
		if (request.getParameter("customizeNumber") != null)
			parseObjectForDirectoryItem.put("CustomizedOrder", request.getParameter("customizeNumber"));

		parseObjectForDirectoryItem.put("StyleId", styleObject);

		parseObjectForDirectoryItem.put("LocationId", request.getParameter("objectIdOfLocation"));

		ParseFile pf = null;
		MultipartFile multiFile = request.getFile("logo");
		String imageType = multiFile.getContentType();
		// just to show that we have actually received the file
		try {
			System.out.println("File Length:" + multiFile.getBytes().length);
			System.out.println("File Type:" + multiFile.getContentType());
			String fileName = multiFile.getOriginalFilename();
			System.out.println("File Name:" + fileName);
			if (multiFile.getBytes().length > 0) {
				pf = new ParseFile("Picture.jpg", multiFile.getBytes());

				try {
					pf.save();
					parseObjectForDirectoryItem.put("Picture", pf);
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		} catch (IOException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		}

		// parseObjectForDirectoryItem.put("Phones",parseObjectForPhones.getObjectId()
		// );

		try {
			parseObjectForDirectoryItem.save();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		String contactCount = request.getParameter("manageCount");

		int count0 = Integer.parseInt(contactCount);
		for (int i = 0; i < count0; i++) {
			System.out.println();
			ParseObject parseObjectForPhoneItem = new ParseObject("Phones");
			if (request.getParameter("manageType" + i) != null) {
				parseObjectForPhoneItem.put("Type", request.getParameter("manageType" + i));
			}
			if (request.getParameter("manageDetails" + i) != null) {
				parseObjectForPhoneItem.put("Ext", request.getParameter("manageDetails" + i));
			}
			if ((request.getParameter("manageType" + i) != null)
					|| (request.getParameter("manageDetails" + i) != null)) {
				parseObjectForPhoneItem.put("PhoneId", parseObjectForDirectoryItem.getObjectId());
				parseObjectForPhoneItem.put("LocationId", request.getParameter("objectIdOfLocation"));
			}
			try {
				parseObjectForPhoneItem.save();
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		if (request.getParameter("priceFont") != null) {
			styleObject.put("PriceFont", request.getParameter("priceFont"));
		}
		if (request.getParameter("priceColor") != null) {
			styleObject.put("PriceColor", request.getParameter("priceColor"));
		}
		if (request.getParameter("priceFamily") != null) {
			styleObject.put("PriceFamily", request.getParameter("priceFamily"));
		}
		try {
			styleObject.save();
		} catch (ParseException e1) {
			e1.printStackTrace();
		}
		String count = request.getParameter("counter");

		int count1 = Integer.parseInt(count);
		for (int i = 1; i < count1; i++) {
			ParseObject parseObjectForMenuItem = new ParseObject("Menu");
			if (request.getParameter("menuDescription" + i) != null) {
				parseObjectForMenuItem.put("Description", request.getParameter("menuDescription" + i));
			}
			if (request.getParameter("menuPrice" + i) != null) {
				parseObjectForMenuItem.put("Price", request.getParameter("menuPrice" + i));
			}
			if ((request.getParameter("menuDescription" + i) != null)
					|| (request.getParameter("menuPrice" + i) != null)) {
				parseObjectForMenuItem.put("MenuId", parseObjectForDirectoryItem.getObjectId());
				parseObjectForMenuItem.put("LocationId", request.getParameter("objectIdOfLocation"));
				parseObjectForMenuItem.put("StyleID", styleObject);
			}
			try {
				parseObjectForMenuItem.save();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		request.setAttribute("locId", request.getParameter("objectIdOfLocation"));
		try {
			select(request);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		mav.addObject("userName", request.getParameter("userName"));
		mav.addObject("user", request.getParameter("user"));
		if (request.getParameter("tempId") != null) {
			System.out.println(request.getParameter("tempId"));
			ParseQuery<ParseObject> queryForTemplateObjects = ParseQuery.getQuery("Template");
			queryForTemplateObjects.whereEqualTo("objectId", request.getParameter("tempId"));

			List<ParseObject> listOfTemplateObjects = null;

			try {
				listOfTemplateObjects = queryForTemplateObjects.find();
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			try {
				Iterator<ParseObject> iteratorForTemplateObjects = listOfTemplateObjects.listIterator();
				List<EgsdTemplateObjects> listOfEgsdTemplateObjects = new ArrayList<EgsdTemplateObjects>(20);

				while (iteratorForTemplateObjects.hasNext()) {

					ParseObject templateObjects = iteratorForTemplateObjects.next();

					listOfEgsdTemplateObjects.add(
							new EgsdTemplateObjects(templateObjects.getObjectId(), templateObjects.getString("Name"),
									templateObjects.getObjectId(), templateObjects.getBoolean("Customized")));

				}

				mav.addObject("listOfEgsdTemplateObjects", listOfEgsdTemplateObjects);

			} catch (NullPointerException npe) {

			}

			// list for selecting Templates
			ParseQuery<ParseObject> queryForSelectingTemplateObjects = ParseQuery.getQuery("Template");
			// queryForSelectingTemplateObjects.whereEqualTo("objectId",
			// request.getParameter("tempId"));
			queryForSelectingTemplateObjects.whereNotEqualTo("type", "group");

			List<ParseObject> listOfSelectingTemplateObjects = null;

			try {
				listOfSelectingTemplateObjects = queryForSelectingTemplateObjects.find();
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			try {
				Iterator<ParseObject> iteratorForSelectingTemplateObjects = listOfSelectingTemplateObjects
						.listIterator();
				List<EgsdTemplateObjects> listOfEgsdSelectedTemplateObjects = new ArrayList<EgsdTemplateObjects>(20);

				while (iteratorForSelectingTemplateObjects.hasNext()) {

					ParseObject templateObjects = iteratorForSelectingTemplateObjects.next();

					listOfEgsdSelectedTemplateObjects.add(new EgsdTemplateObjects(templateObjects.getObjectId(),
							templateObjects.getString("Name"), null, false));

				}

				mav.addObject("listOfSelectedTemplateObjects", listOfEgsdSelectedTemplateObjects);

			} catch (NullPointerException npe) {

			}
			if (request.getParameter("userName").equals("Super Admin"))
				mav.setViewName("SuperAdminTemplates");

			if (request.getParameter("userName").equals("IT Admin"))
				mav.setViewName("ITAdminTemplates");

			if (request.getParameter("userName").equals("CS Admin"))
				mav.setViewName("CSAdminTemplates");

			mav.addObject("userName", request.getParameter("userName"));
			mav.addObject("user", request.getParameter("user"));
		} else {
			if (request.getParameter("userName").equals("Super Admin"))
				// mav.setViewName("SuperAdminIndividualHotel");
				mav.setViewName("SuperAdmin");

			if (request.getParameter("userName").equals("IT Admin"))
				// mav.setViewName("SuperAdminIndividualHotel");
				mav.setViewName("ITAdmin");

			if (request.getParameter("userName").equals("Location Admin"))
				mav.setViewName("LocationDetails");

			if (request.getParameter("userName").equals("CS Admin"))
				// mav.setViewName("CSAdminIndividualHotel");
				mav.setViewName("CSAdmin");

			mav.addObject("userName", request.getParameter("userName"));
			mav.addObject("user", request.getParameter("user"));
		}

		return mav;

	}

	@RequestMapping(value = "/deleteLocationxx")
	public ModelAndView deleteLocationxx(HttpServletRequest request) {

		System.out.println("objectIdFor delete location: " + request.getParameter("objectIdForDeleteLocation"));

		HashMap<String, String> params = new HashMap<String, String>();
		params.put("objectIdForDeleteLocation", request.getParameter("objectIdForDeleteLocation"));

		try {
			ParseCloud.callFunction("deletingLocation", params);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return null;
	}

	@RequestMapping(value = "/deleteLocation")
	public ModelAndView deleteLocation(HttpServletRequest request) {

		System.out.println("objectIdFor delete location: " + request.getParameter("objectIdForDeleteLocation"));

		ParseQuery<ParseObject> queryForLocationObject = ParseQuery.getQuery("Location");
		queryForLocationObject.whereEqualTo("objectId", request.getParameter("objectIdForDeleteLocation"));

		List<ParseObject> listForLocationObject = null;

		try {
			listForLocationObject = queryForLocationObject.find();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		Iterator<ParseObject> iteratorForLocationOnject = listForLocationObject.listIterator();

		ParseObject locationObject = iteratorForLocationOnject.next();

		System.out.println("location object:" + locationObject.getObjectId());

		/*
		 * HashMap<String, String> param = new HashMap<String, String>();
		 * param.put("objectIdForDeleteLocation",
		 * request.getParameter("objectIdForDeleteLocation"));
		 * 
		 * try { ParseCloud.callFunction("deletingLocation", param); } catch
		 * (ParseException e) { // TODO Auto-generated catch block
		 * e.printStackTrace(); }
		 */

		/*
		 * //getting directoryItems
		 * 
		 * ParseQuery<ParseObject>
		 * queryForDirectoryItems=ParseQuery.getQuery("DirectoryItem");
		 * queryForDirectoryItems.whereEqualTo("LocationId",request.getParameter
		 * ("objectIdForDeleteLocation"));
		 * 
		 * List<ParseObject> listForDirectoryitems=null;
		 * 
		 * try { listForDirectoryitems=queryForDirectoryItems.find(); } catch
		 * (ParseException e) { // TODO Auto-generated catch block
		 * e.printStackTrace(); }
		 * 
		 * 
		 * try{ Iterator<ParseObject>
		 * iteratorForDirectoryItems=listForDirectoryitems.listIterator();
		 * 
		 * while(iteratorForDirectoryItems.hasNext()){
		 * 
		 * ParseObject
		 * parseObjectForDirectoryItem=iteratorForDirectoryItems.next();
		 * 
		 * System.out.println(parseObjectForDirectoryItem.getString("Title"));
		 * 
		 * deleteDirectoryObject(parseObjectForDirectoryItem.getObjectId()); }
		 * }catch(NullPointerException npe){
		 * 
		 * System.out.println("No records to be Found"); }
		 */

		HashMap<String, String> params = new HashMap<String, String>();

		// params.put("adminId", request.getParameter("adminId"));
		params.put("locationId", locationObject.getObjectId());

		String result = null;

		try {
			result = ParseCloud.callFunction("removingLocationId", params);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			result = "there is error in adding location id";
			e.printStackTrace();
		}

		System.out.println(result);

		// deleting Location object

		try {
			locationObject.delete();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		adminLoad(request);

		if (request.getParameter("userName").equals("Super Admin")) {
			mav.setViewName("SuperHotelList");
		}
		if (request.getParameter("userName").equals("IT Admin")) {
			mav.setViewName("ITHotelList");
		}
		if (request.getParameter("userName").equals("Location Admin")) {
			mav.setViewName("LocationList");
		}
		if (request.getParameter("userName").equals("CS Admin")) {
			mav.setViewName("CSHotelList");
		}

		mav.addObject("userName", request.getParameter("userName"));
		mav.addObject("user", request.getParameter("user"));

		return mav;
	}

	@RequestMapping(value = "/deleteTemplate")
	public ModelAndView deleteTemplate(HttpServletRequest request) {

		System.out.println("objectIdFor delete location: " + request.getParameter("objectIdForDeleteLocation"));

		ParseQuery<ParseObject> queryForLocationObject = ParseQuery.getQuery("Template");
		queryForLocationObject.whereEqualTo("objectId", request.getParameter("objectIdForDeleteLocation"));

		List<ParseObject> listForLocationObject = null;

		try {
			listForLocationObject = queryForLocationObject.find();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		Iterator<ParseObject> iteratorForLocationOnject = listForLocationObject.listIterator();

		ParseObject locationObject = iteratorForLocationOnject.next();

		System.out.println("location object:" + locationObject.getObjectId());

		/*
		 * HashMap<String, String> param = new HashMap<String, String>();
		 * param.put("objectIdForDeleteLocation",
		 * request.getParameter("objectIdForDeleteLocation"));
		 * 
		 * try { ParseCloud.callFunction("deletingLocation", param); } catch
		 * (ParseException e) { // TODO Auto-generated catch block
		 * e.printStackTrace(); }
		 */

		/*
		 * //getting directoryItems
		 * 
		 * ParseQuery<ParseObject>
		 * queryForDirectoryItems=ParseQuery.getQuery("DirectoryItem");
		 * queryForDirectoryItems.whereEqualTo("LocationId",request.getParameter
		 * ("objectIdForDeleteLocation"));
		 * 
		 * List<ParseObject> listForDirectoryitems=null;
		 * 
		 * try { listForDirectoryitems=queryForDirectoryItems.find(); } catch
		 * (ParseException e) { // TODO Auto-generated catch block
		 * e.printStackTrace(); }
		 * 
		 * 
		 * try{ Iterator<ParseObject>
		 * iteratorForDirectoryItems=listForDirectoryitems.listIterator();
		 * 
		 * while(iteratorForDirectoryItems.hasNext()){
		 * 
		 * ParseObject
		 * parseObjectForDirectoryItem=iteratorForDirectoryItems.next();
		 * 
		 * System.out.println(parseObjectForDirectoryItem.getString("Title"));
		 * 
		 * deleteDirectoryObject(parseObjectForDirectoryItem.getObjectId()); }
		 * }catch(NullPointerException npe){
		 * 
		 * System.out.println("No records to be Found"); }
		 */

		HashMap<String, String> params = new HashMap<String, String>();

		// params.put("adminId", request.getParameter("adminId"));
		params.put("locationId", locationObject.getObjectId());

		String result = null;

		try {
			result = ParseCloud.callFunction("removingLocationId", params);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			result = "there is error in adding location id";
			e.printStackTrace();
		}

		System.out.println(result);

		// deleting Location object

		try {
			locationObject.delete();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		adminLoad(request);

		if (request.getParameter("userName").equals("Super Admin")) {
			mav.setViewName("SuperHotelList");
		}
		if (request.getParameter("userName").equals("IT Admin")) {
			mav.setViewName("ITHotelList");
		}
		if (request.getParameter("userName").equals("Location Admin")) {
			mav.setViewName("HotelList");
		}
		if (request.getParameter("userName").equals("CS Admin")) {
			mav.setViewName("CSHotelList");
		}

		mav.addObject("userName", request.getParameter("userName"));
		mav.addObject("user", request.getParameter("user"));

		return mav;
	}

	@RequestMapping(value = "/delete")
	public ModelAndView delete(HttpServletRequest request) {

		System.out.println("objectIdFor delete: " + request.getParameter("objectIdForDelete"));
		System.out.println("locationId delete: " + request.getParameter("locationId"));
		System.out.println("directoryId delete: " + request.getParameter("directoryId"));
		System.out.println("parent directoryId delete: " + request.getParameter("parentDirectoryId"));
		System.out.println("userName : " + request.getParameter("userName"));
		System.out.println("user :" + request.getParameter("user"));
		//// ParseObject po=ParseObject.createWithoutData("DirectoryItem",
		//// request.getParameter("objectId"));
		int order = -1;
		ParseQuery<ParseObject> queryForDiretoryItem = ParseQuery.getQuery("DirectoryItem");
		queryForDiretoryItem.whereEqualTo("objectId", request.getParameter("objectIdForDelete"));
		List<ParseObject> directoryItemListObject = null;
		try {
			directoryItemListObject = queryForDiretoryItem.find();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		Iterator<ParseObject> iteratorDirectoryItemListObject = directoryItemListObject.listIterator();

		ParseObject object = iteratorDirectoryItemListObject.next();

		System.out.println("DirectoryId " + object.getString("DirectoryID"));
		System.out.println("Title " + object.getString("Title"));
		System.out.println("Caption " + object.getString("Caption"));
		System.out.println("Description " + object.getString("Description"));
		System.out.println("Timings " + object.getString("Timings"));
		System.out.println("Website " + object.getString("Website"));
		System.out.println("Email " + object.getString("Email"));
		System.out.println("Phones " + object.getString("Phones"));
		
		int itemPos = object.getInt("CustomizedOrder");

		request.setAttribute("locationId", object.getString("LocationId"));

		checkChildRoot(request.getParameter("objectIdForDelete"));

		deleteDirectoryObject(request.getParameter("objectIdForDelete"));	
		

		

		ParseQuery<ParseObject> queryForDeleteDirectoryItems = ParseQuery.getQuery("DirectoryItem");
		
		
		queryForDeleteDirectoryItems.whereEqualTo("DirectoryID", request.getParameter("directoryId"));
		queryForDeleteDirectoryItems.whereGreaterThan("CustomizedOrder", itemPos);

		List<ParseObject> listOfDeleteDirResults = null;

		try {

			listOfDeleteDirResults = queryForDeleteDirectoryItems.find();

		} catch (ParseException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		}
		
		
		try {
			Iterator<ParseObject> iteratorForDeleteDirectories = listOfDeleteDirResults.listIterator();
			
			while (iteratorForDeleteDirectories.hasNext()) {
				
				ParseObject parseObjectHavingDir = iteratorForDeleteDirectories.next();
				ParseObject updateOrder = ParseObject.createWithoutData("DirectoryItem", parseObjectHavingDir.getObjectId());
				
				order = parseObjectHavingDir.getInt("CustomizedOrder");
					updateOrder.put("CustomizedOrder", order - 1);
					try {
						updateOrder.save();
					} 
					catch (Exception ee) {
						ee.printStackTrace();
					
					}
			}

		} 
		catch (NullPointerException npe) {
			System.out.println(npe.getMessage());
		}
		
		
		request.setAttribute("locId", request.getParameter("locationId"));

		try {
			select(request);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		mav.addObject("userName", request.getParameter("userName"));
		mav.addObject("user", request.getParameter("user"));
		if (request.getParameter("tempId") != null) {
			
			request.setAttribute("tempId", request.getParameter("tempId"));
			
			viewTemplates(request);
			
			
			if (request.getParameter("userName").equals("Super Admin"))
				mav.setViewName("SuperAdminTemplates");

			if (request.getParameter("userName").equals("IT Admin"))
				mav.setViewName("ITAdminTemplates");

			if (request.getParameter("userName").equals("CS Admin"))
				mav.setViewName("CSAdminTemplates");

			mav.addObject("userName", request.getParameter("userName"));
			mav.addObject("user", request.getParameter("user"));
		} 
		
		else if (request.getParameter("groupId") != null) {
			
			request.setAttribute("tempId", request.getParameter("groupId"));
			
			viewGroups(request);
			
			
			if (request.getParameter("userName").equals("Super Admin"))
				mav.setViewName("SuperAdminGroups");

			if (request.getParameter("userName").equals("IT Admin"))
				mav.setViewName("ITAdminGroups");

			if (request.getParameter("userName").equals("CS Admin"))
				mav.setViewName("CSAdminGroups");

			mav.addObject("userName", request.getParameter("userName"));
			mav.addObject("user", request.getParameter("user"));
		}
		
		else {
			if (request.getParameter("userName").equals("Super Admin"))
				// mav.setViewName("SuperAdminIndividualHotel");
				mav.setViewName("SuperAdmin");

			if (request.getParameter("userName").equals("IT Admin"))
				// mav.setViewName("SuperAdminIndividualHotel");
				mav.setViewName("ITAdmin");

			if (request.getParameter("userName").equals("CS Admin"))
				// mav.setViewName("CSAdminIndividualHotel");
				mav.setViewName("CSAdmin");
			if (request.getParameter("userName").equals("Location Admin"))
				// mav.setViewName("CSAdminIndividualHotel");
				mav.setViewName("LocationDetails");

			mav.addObject("userName", request.getParameter("userName"));
			mav.addObject("user", request.getParameter("user"));
		}

		return mav;

	}

	@RequestMapping(value = "/deleteDirectory")
	public ModelAndView deleteDirectory(HttpServletRequest request) {

		System.out.println("objectIdFor delete: " + request.getParameter("objectIdForDelete"));
		System.out.println("locationId delete: " + request.getParameter("locationId"));
		System.out.println("directoryId delete: " + request.getParameter("directoryId"));
		System.out.println("parent directoryId delete: " + request.getParameter("parentDirectoryId"));
		System.out.println("userName : " + request.getParameter("userName"));
		System.out.println("user :" + request.getParameter("user"));
		//// ParseObject po=ParseObject.createWithoutData("DirectoryItem",
		//// request.getParameter("objectId"));

		ParseQuery<ParseObject> queryForDiretoryItem = ParseQuery.getQuery("DirectoryItem");
		queryForDiretoryItem.whereEqualTo("objectId", request.getParameter("objectIdForDelete"));
		List<ParseObject> directoryItemListObject = null;
		try {
			directoryItemListObject = queryForDiretoryItem.find();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		Iterator<ParseObject> iteratorDirectoryItemListObject = directoryItemListObject.listIterator();

		ParseObject object = iteratorDirectoryItemListObject.next();

		System.out.println("DirectoryId " + object.getString("DirectoryID"));
		System.out.println("Title " + object.getString("Title"));
		System.out.println("Caption " + object.getString("Caption"));
		System.out.println("Description " + object.getString("Description"));
		System.out.println("Timings " + object.getString("Timings"));
		System.out.println("Website " + object.getString("Website"));
		System.out.println("Email " + object.getString("Email"));
		System.out.println("Phones " + object.getString("Phones"));

		request.setAttribute("locationId", object.getString("LocationId"));

		checkChildRoot(request.getParameter("objectIdForDelete"));

		deleteDirectoryObject(request.getParameter("objectIdForDelete"));

		// EgsdController.getDataFromParse(request);
		// adminLoad(request);

		// viewLocation(request);

		request.setAttribute("locId", request.getParameter("locationId"));

		try {
			select(request);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		if (request.getParameter("userName").equals("Super Admin"))
			mav.setViewName("SuperAdminTemplates");

		if (request.getParameter("userName").equals("IT Admin"))
			mav.setViewName("SuperAdminTemplates");

		if (request.getParameter("userName").equals("Location Admin"))
			mav.setViewName("LocationList");

		if (request.getParameter("userName").equals("CS Admin"))
			mav.setViewName("CSAdminTemplates");

		mav.addObject("userName", request.getParameter("userName"));
		mav.addObject("user", request.getParameter("user"));

		return mav;

	}

	public static void checkChildRoot(String id) {

		System.out.println("checking child roots");

		ParseQuery<ParseObject> queryForChildRoot = ParseQuery.getQuery("DirectoryItem");
		queryForChildRoot.whereEqualTo("DirectoryID", id);

		List<ParseObject> listOfChildRoots = null;

		try {
			listOfChildRoots = queryForChildRoot.find();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		try {
			if (!listOfChildRoots.isEmpty())
				System.out.println(listOfChildRoots.size());

			Iterator<ParseObject> iteratorForChildRoots = listOfChildRoots.listIterator();

			while (iteratorForChildRoots.hasNext()) {

				ParseObject childObject = iteratorForChildRoots.next();

				System.out.println(childObject.getString("Title"));
				checkChildRoot(childObject.getObjectId());
				deleteDirectoryObject(childObject.getObjectId());

			}

		} catch (NullPointerException npe) {

			System.out.println("no data to be display");

		} finally {

			System.out.println("end of checkChildRoot ");
		}

	}

	public static void deleteDirectoryObject(String objectId) {

		ParseQuery<ParseObject> queryForDirectoryItem = ParseQuery.getQuery("DirectoryItem");
		queryForDirectoryItem.whereEqualTo("objectId", objectId);

		List<ParseObject> listOfParseObjectsForDeleteDirectoryItem = null;

		try {
			listOfParseObjectsForDeleteDirectoryItem = queryForDirectoryItem.find();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		try {

			if (!listOfParseObjectsForDeleteDirectoryItem.isEmpty())

				System.out.println(listOfParseObjectsForDeleteDirectoryItem.size());

			Iterator<ParseObject> iteratorForChildRoots = listOfParseObjectsForDeleteDirectoryItem.listIterator();

			while (iteratorForChildRoots.hasNext()) {

				ParseObject objectToBeDeleted = iteratorForChildRoots.next();

				// deleting phones object

				/*
				 * ParseQuery<ParseObject> parseQueryForPhones =
				 * ParseQuery.getQuery("Phones");
				 * parseQueryForPhones.whereEqualTo("PhoneId",
				 * objectToBeDeleted.getParseObject("PhoneId"));
				 * List<ParseObject> phonesParseObject = null; try {
				 * phonesParseObject = parseQueryForPhones.find(); } catch
				 * (ParseException e) { // TODO Auto-generated catch block
				 * e.printStackTrace(); }
				 * 
				 * Iterator<ParseObject> iteratorForPhones =
				 * phonesParseObject.listIterator();
				 * 
				 * ParseObject parseObjectForPhones = iteratorForPhones.next();
				 * 
				 * System.out.println("PhoneId in 'Phones':" +
				 * parseObjectForPhones.getString("PhoneId"));
				 * System.out.println("type':" +
				 * parseObjectForPhones.getString("Type"));
				 * System.out.println("ext':" +
				 * parseObjectForPhones.getString("Ext"));
				 * 
				 * try { parseObjectForPhones.delete(); } catch (ParseException
				 * e) { // TODO Auto-generated catch block e.printStackTrace();
				 * }
				 */

				// delete Menu Items
				ParseQuery<ParseObject> parseQueryForMenuItems = ParseQuery.getQuery("Menu");
				parseQueryForMenuItems.whereEqualTo("MenuId", objectToBeDeleted.getObjectId());

				List<ParseObject> listOfMenuObjects = null;

				try {
					listOfMenuObjects = parseQueryForMenuItems.find();
				} catch (ParseException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}

				try {

					Iterator<ParseObject> iteratorForMenuObjects = listOfMenuObjects.listIterator();

					while (iteratorForMenuObjects.hasNext()) {

						ParseObject menuObject = iteratorForMenuObjects.next();

						try {
							menuObject.delete();
						} catch (ParseException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}

					}

				} catch (NullPointerException npe) {

					System.out.println("No menu Items to delete");

				}

				// deleting styles

				String style_Id = null;
				ParseObject StyleId_PO = objectToBeDeleted.getParseObject("StyleId");
				if (objectToBeDeleted.getParseObject("StyleId") != null)
					style_Id = StyleId_PO.getObjectId();
				System.out.println("StyleId of sub dir:" + style_Id);

				ParseQuery<ParseObject> parseQueryForStyles = ParseQuery.getQuery("Style");
				parseQueryForStyles.whereEqualTo("objectId", style_Id);
				List<ParseObject> styleParseObject = null;

				try {
					styleParseObject = parseQueryForStyles.find();
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

				Iterator<ParseObject> iteratorForStyleObject = styleParseObject.listIterator();

				ParseObject parseObjectForStyle = iteratorForStyleObject.next();

				System.out.println("objectId in Style: " + parseObjectForStyle.getObjectId());

				try {
					parseObjectForStyle.delete();
				} catch (ParseException e) {
					e.printStackTrace();
				}

				// deleting directory items

				try {
					objectToBeDeleted.delete();
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}

		} catch (NullPointerException npe) {

			System.out.println("no data to be display");

		}

	}

	@RequestMapping(value = "/preview", headers = "content-type=multipart/*", method = RequestMethod.POST)
	public ModelAndView preview(MultipartHttpServletRequest request) {

		System.out.println("objectId:" + request.getParameter("objectId"));
		System.out.println("directoryId:" + request.getParameter("directoryId"));
		System.out.println("userName:" + request.getParameter("userName"));
		System.out.println("user:" + request.getParameter("user"));
		System.out.println("styleId:" + request.getParameter("styleId"));
		System.out.println("phones:" + request.getParameter("phones"));
		System.out.println("picture:" + request.getParameter("picture"));
		System.out.println("---------------------------------------------");

		System.out.println("Displaying Title");
		System.out.println("title:" + request.getParameter("title"));
		System.out.println("titleColor:" + request.getParameter("titleColor"));
		System.out.println("titleFont:" + request.getParameter("titleFont"));
		System.out.println("---------------------------------------------");
		System.out.println("Displaying Caption");
		System.out.println("caption:" + request.getParameter("caption"));
		System.out.println("captionColor:" + request.getParameter("captionColor"));
		System.out.println("captionFont:" + request.getParameter("captionFont"));
		System.out.println("---------------------------------------------");

		System.out.println("Displaying Timings");
		System.out.println("timings:" + request.getParameter("timings"));
		System.out.println("timingsColor:" + request.getParameter("timingsColor"));
		System.out.println("timingsFont:" + request.getParameter("timingsFont"));
		System.out.println("---------------------------------------------");

		System.out.println("Displaying Website");
		System.out.println("website:" + request.getParameter("website"));
		System.out.println("websiteColor:" + request.getParameter("websiteColor"));
		System.out.println("websiteFont:" + request.getParameter("websiteFont"));
		System.out.println("---------------------------------------------");

		System.out.println("Displaying Email");
		System.out.println("email:" + request.getParameter("email"));
		System.out.println("emailColor:" + request.getParameter("emailColor"));
		System.out.println("emailFont:" + request.getParameter("emailFont"));
		System.out.println("---------------------------------------------");

		System.out.println("description:" + request.getParameter("description"));
		System.out.println("descriptionFont:" + request.getParameter("descriptionFont"));
		System.out.println("descriptionColor:" + request.getParameter("descriptionColor"));
		System.out.println("---------------------------------------------");

		System.out.println("phonesFont:" + request.getParameter("phonesFont"));
		System.out.println("phonesColor:" + request.getParameter("phonesColor"));
		System.out.println("type:" + request.getParameter("type"));
		System.out.println("ext:" + request.getParameter("ext"));

		System.out.println("---------------------------------------------");

		System.out.println("priceFont:" + request.getParameter("priceFont"));
		System.out.println("priceColor:" + request.getParameter("priceColor"));
		System.out.println("---------------------------------------------");

		mav.addObject("objectId", request.getParameter("objectId"));
		mav.addObject("directoryId", request.getParameter("directoryId"));
		mav.addObject("userName", request.getParameter("userName"));
		mav.addObject("user", request.getParameter("user"));
		mav.addObject("styleId", request.getParameter("styleId"));
		mav.addObject("phones", request.getParameter("phones"));
		mav.addObject("picture", request.getParameter("picture"));

		mav.addObject("title", request.getParameter("title"));
		mav.addObject("titleColor", request.getParameter("titleColor"));
		mav.addObject("titleFont", request.getParameter("titleFont"));

		mav.addObject("caption", request.getParameter("caption"));
		mav.addObject("captionColor", request.getParameter("captionColor"));
		mav.addObject("captionFont", request.getParameter("captionFont"));

		mav.addObject("timings", request.getParameter("timings"));
		mav.addObject("timingsColor", request.getParameter("timingsColor"));
		mav.addObject("timingsFont", request.getParameter("timingsFont"));

		mav.addObject("website", request.getParameter("website"));
		mav.addObject("websiteColor", request.getParameter("websiteColor"));
		mav.addObject("websiteFont", request.getParameter("websiteFont"));

		mav.addObject("email", request.getParameter("email"));
		mav.addObject("emailColor", request.getParameter("emailColor"));
		mav.addObject("emailFont", request.getParameter("emailFont"));

		mav.addObject("description", request.getParameter("description"));
		mav.addObject("descriptionFont", request.getParameter("descriptionFont"));
		mav.addObject("descriptionColor", request.getParameter("descriptionColor"));

		mav.addObject("phonesFont", request.getParameter("phonesFont"));
		mav.addObject("phonesColor", request.getParameter("phonesColor"));
		mav.addObject("type", request.getParameter("type"));
		mav.addObject("ext", request.getParameter("ext"));

		mav.addObject("priceFont", request.getParameter("priceFont"));
		mav.addObject("phonesColor", request.getParameter("priceColor"));

		mav.setViewName("AdminPreview");

		return mav;

	}

	@RequestMapping(value = "/edit1", headers = "content-type=multipart/*", method = RequestMethod.POST)
	public ModelAndView edit1(MultipartHttpServletRequest request) {

		// updating menu items

		String contactCount = request.getParameter("editmenuCount");
		String menuCount = request.getParameter("editcontactCount");
		int count0 = Integer.parseInt(contactCount);
		int count1 = Integer.parseInt(menuCount);
		System.out.println("menu" + count1);
		System.out.println("contact" + count0);
		for (int i = 1; i <= count0; i++) {

			System.out.println(
					request.getParameter("editmenuDescription" + i) + " " + request.getParameter("editmenuPrice" + i));

		}
		for (int i = 0; i <= count1; i++) {
			System.out.println(
					request.getParameter("editmanageType" + i) + " " + request.getParameter("editmanageDetails" + i));
		}

		return mav;

	}

	/*
	 * @RequestMapping(value = "/edit1", headers = "content-type=multipart/*",
	 * method = RequestMethod.POST) public ModelAndView
	 * edit1(MultipartHttpServletRequest request) {
	 * 
	 * // updating menu items
	 * 
	 * 
	 * String contactCount = request.getParameter("editmenuCount"); int count0 =
	 * Integer.parseInt(contactCount); for(int i=1;i<=count0;i++) {
	 * if(request.getParameter("editmenuObject"+i) != null) { ParseObject
	 * contactObject = ParseObject.createWithoutData("Menu",
	 * request.getParameter("editmenuObject"+i));
	 * if(request.getParameter("editmenuDescription"+i) == null &&
	 * request.getParameter("editmenuPrice"+i) == null) {
	 * ParseQuery<ParseObject> parseQueryForMenu = ParseQuery.getQuery("Menu");
	 * parseQueryForMenu.whereEqualTo("objectId",
	 * request.getParameter("editmenuObject"+i)); List<ParseObject>
	 * menuParseObject = null; try { menuParseObject = parseQueryForMenu.find();
	 * } catch (ParseException e) { // TODO Auto-generated catch block
	 * e.printStackTrace(); }
	 * 
	 * Iterator<ParseObject> iteratorForMenu = menuParseObject.listIterator();
	 * 
	 * ParseObject parseObjectForMenu = iteratorForMenu.next();
	 * 
	 * 
	 * 
	 * try { parseObjectForMenu.delete(); } catch (ParseException e) { // TODO
	 * Auto-generated catch block e.printStackTrace(); }
	 * 
	 * }
	 * 
	 * 
	 * 
	 * if(request.getParameter("editmanageType"+i) != null)
	 * contactObject.put("Type", request.getParameter("editmanageType"+i));
	 * if(request.getParameter("editmanageDetails"+i) != null)
	 * contactObject.put("Ext", request.getParameter("editmanageDetails"+i));
	 * 
	 * try { contactObject.save(); } catch (ParseException e) { // TODO
	 * Auto-generated catch block e.printStackTrace(); } }
	 * 
	 * }
	 * 
	 * return mav;
	 * 
	 * }
	 */

	@RequestMapping(value = "/edit", headers = "content-type=multipart/*", method = RequestMethod.POST)
	public ModelAndView edit(MultipartHttpServletRequest request) {

		System.out.println("objectId:" + request.getParameter("objectId"));
		System.out.println("directoryId:" + request.getParameter("directoryId"));
		System.out.println("userName:" + request.getParameter("userName"));
		System.out.println("styleId:" + request.getParameter("styleId"));
		System.out.println("phones:" + request.getParameter("phones"));
		System.out.println("---------------------------------------------");

		System.out.println("Displaying Title");
		System.out.println("title:" + request.getParameter("title"));
		System.out.println("titleColor:" + request.getParameter("titleColor"));
		System.out.println("titleFont:" + request.getParameter("titleFont"));
		System.out.println("---------------------------------------------");
		System.out.println("Displaying Caption");
		System.out.println("caption:" + request.getParameter("caption"));
		System.out.println("captionColor:" + request.getParameter("captionColor"));
		System.out.println("captionFont:" + request.getParameter("captionFont"));
		System.out.println("---------------------------------------------");

		System.out.println("Displaying Timings");
		System.out.println("timings:" + request.getParameter("timings"));
		System.out.println("timingsColor:" + request.getParameter("timingsColor"));
		System.out.println("timingsFont:" + request.getParameter("timingsFont"));
		System.out.println("---------------------------------------------");

		System.out.println("description:" + request.getParameter("description"));
		System.out.println("descriptionFont:" + request.getParameter("descriptionFont"));
		System.out.println("descriptionColor:" + request.getParameter("descriptionColor"));
		System.out.println("---------------------------------------------");

		System.out.println("---------------------------------------------");

		System.out.println("priceFont:" + request.getParameter("priceFont"));
		System.out.println("priceColor:" + request.getParameter("priceColor"));
		System.out.println("---------------------------------------------");

		// Updating Directory Items

		ParseObject diretoryItemObject = ParseObject.createWithoutData("DirectoryItem",
				request.getParameter("objectId"));
		if (request.getParameter("title") != null)
			diretoryItemObject.put("Title", request.getParameter("title"));
		if (request.getParameter("caption") != null)
			diretoryItemObject.put("Caption", request.getParameter("caption"));
		if (request.getParameter("description") != null)
			diretoryItemObject.put("Description", request.getParameter("description"));
		if (request.getParameter("timings") != null)
			diretoryItemObject.put("Timings", request.getParameter("timings"));
		if (request.getParameter("editCustomizeNumber") != null)
			diretoryItemObject.put("CustomizedOrder", request.getParameter("editCustomizeNumber"));

		ParseFile pf = null;

		MultipartFile multiFile = request.getFile("logo");
		String imageType = multiFile.getContentType();
		// just to show that we have actually received the file

		try {
			System.out.println("File Length:" + multiFile.getBytes().length);
			System.out.println("File Type:" + multiFile.getContentType());
			String fileName = multiFile.getOriginalFilename();
			System.out.println("File Name:" + fileName);
			if (multiFile.getBytes().length > 0) {
				pf = new ParseFile("Picture.jpg", multiFile.getBytes());

				try {
					pf.save();
					diretoryItemObject.put("Picture", pf);

				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}else if (multiFile.getBytes().length <= 0) {
				pf = new ParseFile("Empty.jpg", multiFile.getBytes());
				
				try {
					pf.save();
					diretoryItemObject.put("Picture", pf);

				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			/*else
			{
				String imgUrl = request.getParameter("dirImgUrl");
				HashMap<String, String> params = new HashMap<String, String>();
				params.put("imgUrl", imgUrl);
				
				String result = "";
				try {
					result = ParseCloud.callFunction("deleteImage", params);

					System.out.println("admin update :" + result);
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}*/
		} catch (IOException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		}

		try {
			diretoryItemObject.save();
		} catch (ParseException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		}

		// diretoryItemObject.put("DirectoryID",
		// request.getParameter("directoryId"));

		// System.out.println(diretoryItemObject.getString("StyleID"));

		// Updating Style
		ParseObject styleObject = ParseObject.createWithoutData("Style", request.getParameter("styleId"));
		if (request.getParameter("titleFont") != null)
			styleObject.put("TitleFont", request.getParameter("titleFont"));

		if (request.getParameter("titleColor") != null)
			styleObject.put("TitleColor", request.getParameter("titleColor"));

		if (request.getParameter("titleFamily") != null)
			styleObject.put("TitleFamily", request.getParameter("titleFamily"));

		if (request.getParameter("captionFont") != null)
			styleObject.put("CaptionFont", request.getParameter("captionFont"));

		if (request.getParameter("captionColor") != null)
			styleObject.put("CaptionColor", request.getParameter("captionColor"));

		if (request.getParameter("captionFamily") != null)
			styleObject.put("CaptionFamily", request.getParameter("captionFamily"));

		if (request.getParameter("descriptionFont") != null)
			styleObject.put("DescriptionFont", request.getParameter("descriptionFont"));

		if (request.getParameter("descriptionColor") != null)
			styleObject.put("DescriptionColor", request.getParameter("descriptionColor"));

		if (request.getParameter("descriptionFamily") != null)
			styleObject.put("DescriptionFamily", request.getParameter("descriptionFamily"));

		if (request.getParameter("timingsFont") != null)
			styleObject.put("TimingsFont", request.getParameter("timingsFont"));

		if (request.getParameter("timingsColor") != null)
			styleObject.put("TimingsColor", request.getParameter("timingsColor"));

		if (request.getParameter("timingsFamily") != null)
			styleObject.put("TimingsFamily", request.getParameter("timingsFamily"));

		// styleObject.put("PriceFont", request.getParameter("priceFont"));
		// styleObject.put("PriceColor", request.getParameter("priceColor"));
		System.out.println(styleObject);
		try {
			styleObject.save();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		// updating phone items
		String contactCount = request.getParameter("manageCount");
		int count0 = Integer.parseInt(contactCount);
		for (int i = 0; i < count0; i++) {
			if (request.getParameter("editphoneObjectId" + i) != null) {
				ParseObject contactObject = ParseObject.createWithoutData("Phones",
						request.getParameter("editphoneObjectId" + i));
				if (request.getParameter("manageType" + i) == null
						&& request.getParameter("manageDetails" + i) == null) {
					ParseQuery<ParseObject> parseQueryForPhones = ParseQuery.getQuery("Phones");
					parseQueryForPhones.whereEqualTo("objectId", request.getParameter("editphoneObjectId" + i));
					List<ParseObject> phonesParseObject = null;
					try {
						phonesParseObject = parseQueryForPhones.find();
					} catch (ParseException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}

					Iterator<ParseObject> iteratorForPhones = phonesParseObject.listIterator();

					ParseObject parseObjectForPhones = iteratorForPhones.next();

					System.out.println("PhoneId in 'Phones':" + parseObjectForPhones.getString("PhoneId"));
					System.out.println("type':" + parseObjectForPhones.getString("Type"));
					System.out.println("ext':" + parseObjectForPhones.getString("Ext"));

					try {
						parseObjectForPhones.delete();
					} catch (ParseException e) { // TODO Auto-generated catch
													// block
						e.printStackTrace();
					}

				}
				if (request.getParameter("manageType" + i) != null)
					contactObject.put("Type", request.getParameter("manageType" + i));
				if (request.getParameter("manageDetails" + i) != null)
					contactObject.put("Ext", request.getParameter("manageDetails" + i));

				try {
					contactObject.save();
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			} else {
				ParseObject parseObjectForPhoneItem = new ParseObject("Phones");
				if (request.getParameter("manageType" + i) != null)
					parseObjectForPhoneItem.put("Type", request.getParameter("manageType" + i));
				if (request.getParameter("manageDetails" + i) != null)
					parseObjectForPhoneItem.put("Ext", request.getParameter("manageDetails" + i));
				if (request.getParameter("manageType" + i) != null
						|| request.getParameter("manageDetails" + i) != null) {
					parseObjectForPhoneItem.put("PhoneId", diretoryItemObject.getObjectId());
					parseObjectForPhoneItem.put("LocationId", request.getParameter("locationId"));
				}

				try {
					parseObjectForPhoneItem.save();
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}

		}

		// updating menu items
		if (request.getParameter("priceFont") != null)
			styleObject.put("PriceFont", request.getParameter("priceFont"));

		if (request.getParameter("priceColor") != null)
			styleObject.put("PriceColor", request.getParameter("priceColor"));

		if (request.getParameter("priceFamily") != null)
			styleObject.put("PriceFamily", request.getParameter("priceFamily"));
		try {
			styleObject.save();
		} catch (ParseException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

		String menuCount = request.getParameter("counter");
		int count = Integer.parseInt(menuCount);

		for (int i = 0; i < count; i++) {
			if (request.getParameter("editmenuObject" + i) != null) {
				ParseObject menuObject = ParseObject.createWithoutData("Menu",
						request.getParameter("editmenuObject" + i));
				
				
				if (request.getParameter("menuDescription" + i) == null
						&& request.getParameter("menuPrice" + i) == null) {
					ParseQuery<ParseObject> parseQueryForMenu = ParseQuery.getQuery("Menu");
					parseQueryForMenu.whereEqualTo("objectId", request.getParameter("editmenuObject" + i));
					List<ParseObject> menuParseObject = null;
					try {
						menuParseObject = parseQueryForMenu.find();
					} catch (ParseException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}

					Iterator<ParseObject> iteratorForMenu = menuParseObject.listIterator();

					ParseObject parseObjectForMenu = iteratorForMenu.next();

					try {
						parseObjectForMenu.delete();
					} catch (ParseException e) { // TODO Auto-generated catch
													// block
						e.printStackTrace();
					}

				}
				menuObject.put("LocationId", request.getParameter("locationId"));
				System.out.println(request.getParameter("menuDescription" + i));
				System.out.println(request.getParameter("menuPrice" + i));
				if (request.getParameter("menuDescription" + i) != null)
					menuObject.put("Description", request.getParameter("menuDescription" + i));
				if (request.getParameter("menuPrice" + i) != null)
					menuObject.put("Price", request.getParameter("menuPrice" + i));
				if (request.getParameter("menuSequence" + i) != null)
				{
					int mSequence = Integer.parseInt(request.getParameter("menuSequence" + i));
					menuObject.put("Sequence", mSequence);
				}
					

				try {
					menuObject.save();
				} catch (Exception e) {
					e.printStackTrace();
				}
			} else {
				ParseObject parseObjectForMenuItem = new ParseObject("Menu");				
				
				if (request.getParameter("menuDescription" + i) != null && !request.getParameter("menuPrice" + i).equals(""))
					parseObjectForMenuItem.put("Description", request.getParameter("menuDescription" + i));

				if (request.getParameter("menuPrice" + i) != null && !request.getParameter("menuPrice" + i).equals(""))
					parseObjectForMenuItem.put("Price", request.getParameter("menuPrice" + i));
				
				if (request.getParameter("menuSequence" + i) != null && !request.getParameter("menuSequence" + i).equals("0"))
				{
					int mSequence = Integer.parseInt(request.getParameter("menuSequence" + i));
					parseObjectForMenuItem.put("Sequence", mSequence);
				}
					

				if (request.getParameter("menuDescription" + i) != null && !request.getParameter("menuPrice" + i).equals("")  || request.getParameter("menuPrice" + i) != null && !request.getParameter("menuPrice" + i).equals("")) {
					parseObjectForMenuItem.put("MenuId", diretoryItemObject.getObjectId());
					parseObjectForMenuItem.put("LocationId", request.getParameter("locationId"));
					parseObjectForMenuItem.put("StyleID", styleObject);
				}

				try {

					parseObjectForMenuItem.save();

				} catch (Exception e) {
					e.printStackTrace();
				}
			}

		}

		System.out.println("userName:" + request.getParameter("userName"));
		System.out.println("user:" + request.getParameter("user"));

		System.out.println("edit is redireting to getDataFromParse()");
		request.setAttribute("locId", request.getParameter("locationId"));

		// EgsdController.getDataFromParse(request);
		// adminLoad(request);
		// viewLocation(request);

		try {
			select(request);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		mav.addObject("userName", request.getParameter("userName"));
		mav.addObject("user", request.getParameter("user"));
		if (request.getParameter("tempId") != null) {
			
			request.setAttribute("tempId",request.getParameter("tempId"));
			
			viewTemplates(request);
			
			mav.addObject("userName", request.getParameter("userName"));
			mav.addObject("user", request.getParameter("user"));
			
			if (request.getParameter("userName").equals("Super Admin"))
				mav.setViewName("SuperAdminTemplates");

			if (request.getParameter("userName").equals("IT Admin"))
				mav.setViewName("ITAdminTemplates");

			if (request.getParameter("userName").equals("CS Admin"))
				mav.setViewName("CSAdminTemplates");

			
		}
		
		else if (request.getParameter("groupId") != null) {
			
			request.setAttribute("tempId",request.getParameter("groupId"));
			
			viewGroups(request);
			
			mav.addObject("userName", request.getParameter("userName"));
			mav.addObject("user", request.getParameter("user"));
			
			if (request.getParameter("userName").equals("Super Admin"))
				mav.setViewName("SuperAdminGroups");

			if (request.getParameter("userName").equals("IT Admin"))
				mav.setViewName("ITAdminGroups");

			if (request.getParameter("userName").equals("CS Admin"))
				mav.setViewName("CSAdminGroups");

			
		}
		else {
			if (request.getParameter("userName").equals("Super Admin"))
				// mav.setViewName("SuperAdminIndividualHotel");
				mav.setViewName("SuperAdmin");

			if (request.getParameter("userName").equals("IT Admin"))
				// mav.setViewName("SuperAdminIndividualHotel");
				mav.setViewName("ITAdmin");

			if (request.getParameter("userName").equals("CS Admin"))
				// mav.setViewName("CSAdminIndividualHotel");
				mav.setViewName("CSAdmin");

			mav.addObject("userName", request.getParameter("userName"));
			mav.addObject("user", request.getParameter("user"));
		}
		return mav;

	}

	@RequestMapping(value = "/addDirectoryItems", headers = "content-type=multipart/*", method = RequestMethod.POST)
	public ModelAndView addDirectoryItems(MultipartHttpServletRequest request) {

		System.out.println("Entered into Add Directories");

		System.out.println("objectId:" + request.getParameter("objectId"));
		System.out.println("directoryId:" + request.getParameter("directoryId"));
		System.out.println("directoryId:" + request.getParameter("tempId"));
		System.out.println("userName:" + request.getParameter("userName"));
		System.out.println("styleId:" + request.getParameter("styleId"));
		System.out.println("phones:" + request.getParameter("phones"));
		System.out.println("---------------------------------------------");

		System.out.println("Displaying Title");
		System.out.println("title:" + request.getParameter("title"));
		System.out.println("titleColor:" + request.getParameter("titleColor"));
		System.out.println("titleFont:" + request.getParameter("titleFont"));
		System.out.println("---------------------------------------------");
		System.out.println("Displaying Caption");
		System.out.println("caption:" + request.getParameter("caption"));
		System.out.println("captionColor:" + request.getParameter("captionColor"));
		System.out.println("captionFont:" + request.getParameter("captionFont"));
		System.out.println("---------------------------------------------");

		System.out.println("Displaying Timings");
		System.out.println("timings:" + request.getParameter("timings"));
		System.out.println("timingsColor:" + request.getParameter("timingsColor"));
		System.out.println("timingsFont:" + request.getParameter("timingsFont"));
		System.out.println("---------------------------------------------");

		System.out.println("Displaying Website");
		System.out.println("website:" + request.getParameter("website"));
		System.out.println("websiteColor:" + request.getParameter("websiteColor"));
		System.out.println("websiteFont:" + request.getParameter("websiteFont"));
		System.out.println("---------------------------------------------");

		System.out.println("Displaying Email");
		System.out.println("email:" + request.getParameter("email"));
		System.out.println("emailColor:" + request.getParameter("emailColor"));
		System.out.println("emailFont:" + request.getParameter("emailFont"));
		System.out.println("---------------------------------------------");

		System.out.println("description:" + request.getParameter("description"));
		System.out.println("descriptionFont:" + request.getParameter("descriptionFont"));
		System.out.println("descriptionColor:" + request.getParameter("descriptionColor"));
		System.out.println("---------------------------------------------");

		System.out.println("phonesFont:" + request.getParameter("phonesFont"));
		System.out.println("phonesColor:" + request.getParameter("phonesColor"));
		System.out.println("phonesType:" + request.getParameter("type"));
		System.out.println("phonesext:" + request.getParameter("ext"));

		System.out.println("---------------------------------------------");

		System.out.println("priceFont:" + request.getParameter("priceFont"));
		System.out.println("priceFont:" + request.getParameter("priceFamily"));
		System.out.println("priceColor:" + request.getParameter("priceColor"));
		System.out.println("---------------------------------------------");
		System.out.println("object Id: "+request.getParameter("objectIdOfLocation"));

		if(request.getParameter("objectIdOfLocation").equals("") || request.getParameter("objectIdOfLocation").equals("null"))
		{
			// Adding Style object
			ParseObject styleObject = new ParseObject("Style");
			if (request.getParameter("titleFont") != null)
				styleObject.put("TitleFont", request.getParameter("titleFont"));

			if (request.getParameter("titleColor") != null)
				styleObject.put("TitleColor", request.getParameter("titleColor"));
			
			if (request.getParameter("titleFamily") != null)
				styleObject.put("TitleFamily", request.getParameter("titleFamily"));

			if (request.getParameter("captionFont") != null)
				styleObject.put("CaptionFont", request.getParameter("captionFont"));

			if (request.getParameter("captionColor") != null)
				styleObject.put("CaptionColor", request.getParameter("captionColor"));
			
			if (request.getParameter("captionFamily") != null)
				styleObject.put("CaptionFamily", request.getParameter("captionFamily"));

			if (request.getParameter("descriptionFont") != null)
				styleObject.put("DescriptionFont", request.getParameter("descriptionFont"));

			if (request.getParameter("descriptionColor") != null)
				styleObject.put("DescriptionColor", request.getParameter("descriptionColor"));
			
			if (request.getParameter("descriptionFamily") != null)
				styleObject.put("DescriptionFamily", request.getParameter("descriptionFamily"));
			
			if (request.getParameter("timingsFont") != null)
				styleObject.put("TimingsFont", request.getParameter("timingsFont"));

			if (request.getParameter("timingsColor") != null)
				styleObject.put("TimingsColor", request.getParameter("timingsColor"));
			
			if (request.getParameter("timingsFamily") != null)
				styleObject.put("TimingsFamily", request.getParameter("timingsFamily"));
			
			
			
			

			

			
			
			styleObject.put("LocationId", request.getParameter("locationId"));
			
			// styleObject.put("PriceFont", request.getParameter("priceFont"));
			// styleObject.put("PriceColor", request.getParameter("priceColor"));
			System.out.println(styleObject);
			try {
				styleObject.save();
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			System.out.println(styleObject.getObjectId());
			
			
			
			ParseQuery<ParseObject> queryForDirectoryItems;
			List<ParseObject> listOfDirResults;
			Iterator<ParseObject> iteratorForDirectories;
			listOfDirResults = null;
			int listSize = 0;
			try {
				queryForDirectoryItems = ParseQuery.getQuery("DirectoryItem");		
				queryForDirectoryItems.whereEqualTo("DirectoryID", request.getParameter("objectId"));
				//queryForDirectoryItems.whereEqualTo("objectId", source);

				try {
					listOfDirResults = queryForDirectoryItems.find();
				} catch (ParseException e2) {
					// TODO Auto-generated catch block
					e2.printStackTrace();
				}
				if(listOfDirResults == null )
				{
					listSize = 0;
				}
				else
				{
					listSize = listOfDirResults.size();
				}
				
				
				
				
			} catch (NullPointerException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			

			ParseObject parseObjectForDirectoryItem = new ParseObject("DirectoryItem");

			//parseObjectForDirectoryItem.put("ParentDirectoryId", request.getParameter("objectId"));
			parseObjectForDirectoryItem.put("ParentReferrence", request.getParameter("locationId"));
			parseObjectForDirectoryItem.put("LocationId", request.getParameter("locationId"));
			parseObjectForDirectoryItem.put("DirectoryID", request.getParameter("objectId"));
			if (request.getParameter("title") != null)
				parseObjectForDirectoryItem.put("Title", request.getParameter("title"));
			if (request.getParameter("caption") != null)
				parseObjectForDirectoryItem.put("Caption", request.getParameter("caption"));
			if (request.getParameter("description") != null)
				parseObjectForDirectoryItem.put("Description", request.getParameter("description"));
			if (request.getParameter("timings") != null)
				parseObjectForDirectoryItem.put("Timings", request.getParameter("timings"));
			if (request.getParameter("website") != null)
				parseObjectForDirectoryItem.put("Website", request.getParameter("website"));
			if (request.getParameter("email") != null)
				parseObjectForDirectoryItem.put("Email", request.getParameter("email"));
			
				parseObjectForDirectoryItem.put("CustomizedOrder", listSize);
			
			ParseFile pf = null;
			MultipartFile multiFile = request.getFile("logo");
			String imageType = multiFile.getContentType();
			// just to show that we have actually received the file
			try {
				System.out.println("File Length:" + multiFile.getBytes().length);
				System.out.println("File Type:" + multiFile.getContentType());
				String fileName = multiFile.getOriginalFilename();
				System.out.println("File Name:" + fileName);
				if (multiFile.getBytes().length > 0) {
					pf = new ParseFile("Picture.jpg", multiFile.getBytes());

					try {
						pf.save();
						parseObjectForDirectoryItem.put("Picture", pf);
					} catch (ParseException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
			} catch (IOException e2) {
				// TODO Auto-generated catch block
				e2.printStackTrace();
			}

			parseObjectForDirectoryItem.put("StyleId", styleObject);
			// parseObjectForDirectoryItem.put("Phones",parseObjectForPhones.getObjectId()
			// );
			

			try {
				parseObjectForDirectoryItem.save();
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			
			// Adding contact details
			
			String contactCount = request.getParameter("manageCount");
			  
			int count0 = Integer.parseInt(contactCount);
			  
			for(int i=0;i<count0;i++)
			{
				
				System.out.println();
				ParseObject parseObjectForPhoneItem = new ParseObject("Phones");
				if(request.getParameter("manageType"+i) != null)
					parseObjectForPhoneItem.put("Type", request.getParameter("manageType"+i));
				if(request.getParameter("manageDetails"+i) != null)
					parseObjectForPhoneItem.put("Ext", request.getParameter("manageDetails"+i));
				if(request.getParameter("manageType"+i) != null || request.getParameter("manageDetails"+i) != null)
				{
					parseObjectForPhoneItem.put("PhoneId", parseObjectForDirectoryItem.getObjectId() );
					parseObjectForPhoneItem.put("LocationId", request.getParameter("locationId") );
				}
				
				try {
					parseObjectForPhoneItem.save();
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
					
			}

			
			
			// Adding Menu Objects 
			
			
			if (request.getParameter("priceFont") != null)
				styleObject.put("PriceFont", request.getParameter("priceFont"));

			if (request.getParameter("priceColor") != null)
				styleObject.put("PriceColor", request.getParameter("priceColor"));
			
			if (request.getParameter("priceFamily") != null)
				styleObject.put("PriceFamily", request.getParameter("priceFamily"));
			try {
				styleObject.save();
			} catch (ParseException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			
			String count = request.getParameter("counter");
			  
			  int count1 = Integer.parseInt(count);
			  
			  
			  for(int i=0;i<count1;i++)
			  {
				  ParseObject parseObjectForMenuItem = new ParseObject("Menu");
				  
				  if(request.getParameter("menuDescription"+i) != null  && !request.getParameter("menuDescription" + i).equals(""))
				  parseObjectForMenuItem.put("Description", request.getParameter("menuDescription"+i));
				  
				  if(request.getParameter("menuPrice"+i) != null && !request.getParameter("menuPrice" + i).equals(""))
				  parseObjectForMenuItem.put("Price", request.getParameter("menuPrice"+i));
				  
				  if(request.getParameter("menuSequence"+i) != null )
				  {
					  int mSequence = Integer.parseInt(request.getParameter("menuSequence"+i));
					  parseObjectForMenuItem.put("Sequence", mSequence);
				  }
					  
				  
				  if(request.getParameter("menuDescription"+i) != null && !request.getParameter("menuDescription" + i).equals("") || request.getParameter("menuPrice"+i) != null && !request.getParameter("menuPrice" + i).equals(""))
				  {
					  parseObjectForMenuItem.put("MenuId", parseObjectForDirectoryItem.getObjectId());			  
					  parseObjectForMenuItem.put("LocationId", request.getParameter("locationId"));			  
					  parseObjectForMenuItem.put("StyleID", styleObject);
				  }
				  
				  
				  try {
					
					  parseObjectForMenuItem.save();
					  
				} catch (Exception e) {
					e.printStackTrace();
				}
				  
				  
				  
			  }

			// redirecting to CSAdmin with the required models
			  
			  System.out.println();

			request.setAttribute("locId",request.getParameter("locationId"));
			
			//EgsdController.getDataFromParse(request);
		//	adminLoad(request);
			//viewLocation(request);
			
			System.out.println(request.getParameter("locId"));
			System.out.println(request.getAttribute("locId"));
			
			try {
				select(request);
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			mav.addObject("userName", request.getParameter("userName"));
			mav.addObject("user", request.getParameter("user"));
			if( request.getParameter("tempId") != null)
			{	
				
				request.setAttribute("tempId",request.getParameter("tempId"));
				
				viewTemplates(request);
				
				mav.addObject("userName", request.getParameter("userName"));
				mav.addObject("user", request.getParameter("user"));
				
				if (request.getParameter("userName").equals("Super Admin"))				
					mav.setViewName("SuperAdminTemplates");
				
				if (request.getParameter("userName").equals("IT Admin"))				
					mav.setViewName("ITAdminTemplates");			
				

				if (request.getParameter("userName").equals("CS Admin"))				
					mav.setViewName("CSAdminTemplates");

				
			}
			
			else if( request.getParameter("groupId") != null)
			{	
				
				request.setAttribute("tempId",request.getParameter("groupId"));
				
				viewGroups(request);
				
				mav.addObject("userName", request.getParameter("userName"));
				mav.addObject("user", request.getParameter("user"));
				
				if (request.getParameter("userName").equals("Super Admin"))				
					mav.setViewName("SuperAdminGroups");
				
				if (request.getParameter("userName").equals("IT Admin"))				
					mav.setViewName("ITAdminGroups");			
				

				if (request.getParameter("userName").equals("CS Admin"))				
					mav.setViewName("CSAdminGroups");

				
			}
			else
			{
				if (request.getParameter("userName").equals("Super Admin"))
					//mav.setViewName("SuperAdminIndividualHotel");
					mav.setViewName("SuperAdmin");
				
				if (request.getParameter("userName").equals("IT Admin"))
					//mav.setViewName("SuperAdminIndividualHotel");
					mav.setViewName("ITAdmin");
							

				if (request.getParameter("userName").equals("CS Admin"))
					//mav.setViewName("CSAdminIndividualHotel");
					mav.setViewName("CSAdmin");
				
				if (request.getParameter("userName").equals("Location Admin"))
					//mav.setViewName("CSAdminIndividualHotel");
					mav.setViewName("LocationDetails");

				mav.addObject("userName", request.getParameter("userName"));
				mav.addObject("user", request.getParameter("user"));
			}
		}
		else
		{
			ParseQuery<ParseObject> queryForDirectoryItems;
			List<ParseObject> listOfDirResults;
			Iterator<ParseObject> iteratorForDirectories;
			listOfDirResults = null;
			int listSize = 0;
			try {
				queryForDirectoryItems = ParseQuery.getQuery("DirectoryItem");		
				queryForDirectoryItems.whereEqualTo("DirectoryID", request.getParameter("objectIdOfLocation"));
				//queryForDirectoryItems.whereEqualTo("objectId", source);

				try {
					listOfDirResults = queryForDirectoryItems.find();
				} catch (ParseException e2) {
					// TODO Auto-generated catch block
					e2.printStackTrace();
				}
				if(listOfDirResults == null)
				{
					listSize = 0;
				}
				else
				{
					listSize = listOfDirResults.size();
				}
				
				
				
				
			} catch (NullPointerException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			// Adding Style object
			ParseObject styleObject = new ParseObject("Style");
			if (request.getParameter("titleFont") != null)
				styleObject.put("TitleFont", request.getParameter("titleFont"));

			if (request.getParameter("titleColor") != null)
				styleObject.put("TitleColor", request.getParameter("titleColor"));
			
			if (request.getParameter("titleFamily") != null)
				styleObject.put("TitleFamily", request.getParameter("titleFamily"));

			if (request.getParameter("captionFont") != null)
				styleObject.put("CaptionFont", request.getParameter("captionFont"));
			
			if (request.getParameter("captionFamily") != null)
				styleObject.put("CaptionFamily", request.getParameter("captionFamily"));

			if (request.getParameter("captionColor") != null)
				styleObject.put("CaptionColor", request.getParameter("captionColor"));

			if (request.getParameter("descriptionFont") != null)
				styleObject.put("DescriptionFont", request.getParameter("descriptionFont"));

			if (request.getParameter("descriptionColor") != null)
				styleObject.put("DescriptionColor", request.getParameter("descriptionColor"));
			
			if (request.getParameter("descriptionFamily") != null)
				styleObject.put("DescriptionFamily", request.getParameter("descriptionFamily"));

			if (request.getParameter("phonesFont") != null)
				styleObject.put("PhonesFont", request.getParameter("phonesFont"));

			if (request.getParameter("phonesColor") != null)
				styleObject.put("PhonesColor", request.getParameter("phonesColor"));
			
			if (request.getParameter("phonesFamily") != null)
				styleObject.put("PhonesFamily", request.getParameter("phonesFamily"));

			if (request.getParameter("timingsFont") != null)
				styleObject.put("TimingsFont", request.getParameter("timingsFont"));

			if (request.getParameter("timingsColor") != null)
				styleObject.put("TimingsColor", request.getParameter("timingsColor"));
			
			if (request.getParameter("timingsFamily") != null)
				styleObject.put("TimingsFamily", request.getParameter("timingsFamily"));

			if (request.getParameter("websiteFont") != null)
				styleObject.put("WebsiteFont", request.getParameter("websiteFont"));

			if (request.getParameter("websiteColor") != null)
				styleObject.put("WebsiteColor", request.getParameter("websiteColor"));
			
			if (request.getParameter("websiteFamily") != null)
				styleObject.put("WebsiteFamily", request.getParameter("websiteFamily"));

			if (request.getParameter("emailFont") != null)
				styleObject.put("EmailFont", request.getParameter("emailFont"));

			if (request.getParameter("emailColor") != null)
				styleObject.put("EmailColor", request.getParameter("emailColor"));
			
			if (request.getParameter("emailFamily") != null)
				styleObject.put("EmailFamily", request.getParameter("emailFamily"));
			
			styleObject.put("LocationId", request.getParameter("objectIdOfLocation"));
			
			// styleObject.put("PriceFont", request.getParameter("priceFont"));
			// styleObject.put("PriceColor", request.getParameter("priceColor"));
			System.out.println(styleObject);

			try {
				styleObject.save();
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			System.out.println(styleObject.getObjectId());

					ParseObject parseObjectForDirectoryItem = new ParseObject("DirectoryItem");

			if (request.getParameter("objectIdOfLocation") != null)
				parseObjectForDirectoryItem.put("DirectoryID", request.getParameter("objectIdOfLocation"));
				parseObjectForDirectoryItem.put("ParentReferrence", request.getParameter("objectIdOfLocation"));
			if (request.getParameter("title") != null)
				parseObjectForDirectoryItem.put("Title", request.getParameter("title"));
			if (request.getParameter("caption") != null)
				parseObjectForDirectoryItem.put("Caption", request.getParameter("caption"));
			if (request.getParameter("description") != null)
				parseObjectForDirectoryItem.put("Description", request.getParameter("description"));
			if (request.getParameter("timings") != null)
				parseObjectForDirectoryItem.put("Timings", request.getParameter("timings"));
			if (request.getParameter("website") != null)
				parseObjectForDirectoryItem.put("Website", request.getParameter("website"));
			if (request.getParameter("email") != null)
				parseObjectForDirectoryItem.put("Email", request.getParameter("email"));
			
				parseObjectForDirectoryItem.put("CustomizedOrder", listSize);
			

			parseObjectForDirectoryItem.put("StyleId", styleObject);
			
			parseObjectForDirectoryItem.put("LocationId", request.getParameter("objectIdOfLocation"));
			
			ParseFile pf = null;
			MultipartFile multiFile = request.getFile("logo");
			String imageType = multiFile.getContentType();
			// just to show that we have actually received the file
			try {
				System.out.println("File Length:" + multiFile.getBytes().length);
				System.out.println("File Type:" + multiFile.getContentType());
				String fileName = multiFile.getOriginalFilename();
				System.out.println("File Name:" + fileName);
				if(multiFile.getBytes().length>0){
				pf = new ParseFile("Picture.jpg", multiFile.getBytes());

				try {
					pf.save();
					parseObjectForDirectoryItem.put("Picture", pf);
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				}
			} catch (IOException e2) {
				// TODO Auto-generated catch block
				e2.printStackTrace();
			}


			
			// parseObjectForDirectoryItem.put("Phones",parseObjectForPhones.getObjectId()
			// );

			try {
				parseObjectForDirectoryItem.save();
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			String contactCount = request.getParameter("manageCount");
		    
		    int count0 = Integer.parseInt(contactCount);
		    for (int i = 0; i < count0; i++)
		    {
		      System.out.println();
		      ParseObject parseObjectForPhoneItem = new ParseObject("Phones");
		      if (request.getParameter("manageType" + i) != null) {
		        parseObjectForPhoneItem.put("Type", request.getParameter("manageType" + i));
		      }
		      if (request.getParameter("manageDetails" + i) != null) {
		        parseObjectForPhoneItem.put("Ext", request.getParameter("manageDetails" + i));
		      }
		      if ((request.getParameter("manageType" + i) != null) || (request.getParameter("manageDetails" + i) != null))
		      {
		        parseObjectForPhoneItem.put("PhoneId", parseObjectForDirectoryItem.getObjectId());
		        parseObjectForPhoneItem.put("LocationId", request.getParameter("objectIdOfLocation"));
		      }
		      try
		      {
		        parseObjectForPhoneItem.save();
		      }
		      catch (ParseException e)
		      {
		        e.printStackTrace();
		      }
		    }
		    if (request.getParameter("priceFont") != null) {
		      styleObject.put("PriceFont", request.getParameter("priceFont"));
		    }
		    if (request.getParameter("priceColor") != null) {
		      styleObject.put("PriceColor", request.getParameter("priceColor"));
		    }
		    if (request.getParameter("priceFamily") != null) {
		      styleObject.put("PriceFamily", request.getParameter("priceFamily"));
		    }
		    try
		    {
		      styleObject.save();
		    }
		    catch (ParseException e1)
		    {
		      e1.printStackTrace();
		    }
		    String count = request.getParameter("counter");
		    
		    int count1 = Integer.parseInt(count);
		    for (int i = 0; i < count1; i++)
		    {
		      ParseObject parseObjectForMenuItem = new ParseObject("Menu");
		      if (request.getParameter("menuDescription" + i) != null) {
		        parseObjectForMenuItem.put("Description", request.getParameter("menuDescription" + i));
		      }
		      if (request.getParameter("menuPrice" + i) != null) {
		        parseObjectForMenuItem.put("Price", request.getParameter("menuPrice" + i));
		      }
		      if ((request.getParameter("menuDescription" + i) != null) || (request.getParameter("menuPrice" + i) != null))
		      {
		        parseObjectForMenuItem.put("MenuId", parseObjectForDirectoryItem.getObjectId());
		        parseObjectForMenuItem.put("LocationId", request.getParameter("objectIdOfLocation"));
		        parseObjectForMenuItem.put("StyleID", styleObject);
		      }
		      try
		      {
		        parseObjectForMenuItem.save();
		      }
		      catch (Exception e)
		      {
		        e.printStackTrace();
		      }
		    }
		    request.setAttribute("locId", request.getParameter("objectIdOfLocation"));
		    try {
				select(request);
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			mav.addObject("userName", request.getParameter("userName"));
			mav.addObject("user", request.getParameter("user"));
			if( request.getParameter("tempId") != null)
			{			
				
				request.setAttribute("tempId", request.getParameter("tempId"));
				
				viewTemplates(request);
				
				mav.addObject("userName", request.getParameter("userName"));
				mav.addObject("user", request.getParameter("user"));
				
				if (request.getParameter("userName").equals("Super Admin"))				
					mav.setViewName("SuperAdminTemplates");
				
				if (request.getParameter("userName").equals("IT Admin"))				
					mav.setViewName("ITAdminTemplates");			
				

				if (request.getParameter("userName").equals("CS Admin"))				
					mav.setViewName("CSAdminTemplates");

				
			}
			else if( request.getParameter("groupId") != null)
			{			
				
				request.setAttribute("tempId", request.getParameter("groupId"));
				
				viewGroups(request);
				
				mav.addObject("userName", request.getParameter("userName"));
				mav.addObject("user", request.getParameter("user"));
				
				if (request.getParameter("userName").equals("Super Admin"))				
					mav.setViewName("SuperAdminGroups");
				
				if (request.getParameter("userName").equals("IT Admin"))				
					mav.setViewName("ITAdminGroups");			
				

				if (request.getParameter("userName").equals("CS Admin"))				
					mav.setViewName("CSAdminGroups");

				
			}
			else
			{
				if (request.getParameter("userName").equals("Super Admin"))
					//mav.setViewName("SuperAdminIndividualHotel");
					mav.setViewName("SuperAdmin");
				
				if (request.getParameter("userName").equals("IT Admin"))
					//mav.setViewName("SuperAdminIndividualHotel");
					mav.setViewName("ITAdmin");
				
				if (request.getParameter("userName").equals("Location Admin"))
					mav.setViewName("LocationDetails");
							

				if (request.getParameter("userName").equals("CS Admin"))
					//mav.setViewName("CSAdminIndividualHotel");
					mav.setViewName("CSAdmin");

				mav.addObject("userName", request.getParameter("userName"));
				mav.addObject("user", request.getParameter("user"));
			}
		}
		
		
		


		
		return mav;

	}

	/*
	 * @RequestMapping(value = "/registerCSAdminForm") public ModelAndView
	 * registerCSAdminForm(HttpServletRequest request) {
	 * 
	 * 
	 * System.out.println(request.getParameter("user"));
	 * System.out.println(request.getParameter("userName"));
	 * 
	 * 
	 * mav.setViewName("RegisterCSAdminForm");
	 * mav.addObject("user",request.getParameter("user") );
	 * mav.addObject("userName",request.getParameter("userName") );
	 * 
	 * return mav; }
	 */

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/searchHotels", method = RequestMethod.POST)
	public @ResponseBody List searchHotel(HttpServletRequest request) {

		System.out.println(request.getParameter("searchId"));
		System.out.println(request.getParameter("username"));
		String pattern = "^.*" + request.getParameter("searchId") + ".*$";
		String searchId = request.getParameter("searchId");
		System.out.println("searchId is " + searchId);
		ParseQuery<ParseObject> queryForSearchName = ParseQuery.getQuery("Location");
		List<ParseObject> listOfSearchNames = null;
		List<EgsdHotelObjects> listOfEgsdHotelObjects = null;
		String userObjectId = null;
		listOfEgsdHotelObjects = new ArrayList<EgsdHotelObjects>(100);
		List<EgsdHotelObjects> listOfEgsdHotelObjects2 = new ArrayList<EgsdHotelObjects>(100);
		List<EgsdHotelObjects> listOfEgsdHotelObjects3 = new ArrayList<EgsdHotelObjects>(100);
		List<EgsdHotelObjects> listOfEgsdHotelObjects4 = new ArrayList<EgsdHotelObjects>(100);
		List<EgsdHotelObjects> listOfEgsdHotelObjects5 = new ArrayList<EgsdHotelObjects>(100);
		List<EgsdHotelObjects> listOfEgsdHotelObjects6 = new ArrayList<EgsdHotelObjects>(100);
		List<EgsdHotelObjects> listOfEgsdHotelObjects7 = new ArrayList<EgsdHotelObjects>(100);
		List<EgsdHotelObjects> listOfEgsdHotelObjects8 = new ArrayList<EgsdHotelObjects>(100);
		List<EgsdHotelObjects> listOfEgsdHotelObjectsMain = new ArrayList<EgsdHotelObjects>(100);
		HashSet<EgsdHotelObjects> set = new HashSet<EgsdHotelObjects>();
		if (!request.getParameter("username").equals("null") || request.getParameter("username") == "") {

			ParseQuery<ParseObject> queryForLocationAdmin = ParseQuery.getQuery("_User");
			queryForLocationAdmin.whereEqualTo("username", request.getParameter("username"));

			List<ParseObject> listOfEmptyAdmins = null;

			try {

				listOfEmptyAdmins = queryForLocationAdmin.find();
				try {
					Iterator<ParseObject> iteratorForEmptyAdmins = listOfEmptyAdmins.listIterator();

					while (iteratorForEmptyAdmins.hasNext()) {

						ParseObject parseObjectAdmins = iteratorForEmptyAdmins.next();
						System.out.println(parseObjectAdmins.getObjectId());
						userObjectId = parseObjectAdmins.getObjectId();
						System.out.println("userObjectId is " + userObjectId);
					}

					queryForSearchName.whereMatches("GroupSiteId", pattern, "i");
					queryForSearchName.whereEqualTo("GroupId", userObjectId);

					List<ParseObject> listOfLocationsFromParse = null;

					try {
						listOfSearchNames = queryForSearchName.find();
					} catch (ParseException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}

				} catch (Exception npe) {
					System.out.println(npe);
				}

				try {
					Iterator<ParseObject> iteratorForSearchObjects = listOfSearchNames.listIterator();

					while (iteratorForSearchObjects.hasNext()) {

						ParseObject hotelObjects = iteratorForSearchObjects.next();

						listOfEgsdHotelObjects.add(new EgsdHotelObjects(hotelObjects.getString("Name"),
								hotelObjects.getObjectId(), hotelObjects.getString("GroupSiteId"),
								hotelObjects.getString("zipcode"), hotelObjects.getString("GroupName")));

					}

				} catch (NullPointerException npe) {
					listOfEgsdHotelObjects.clear();

				}
			} catch (ParseException e2) {
				// TODO Auto-generated catch block
				e2.printStackTrace();
			}
			return listOfEgsdHotelObjects;
		} else

		{

			queryForSearchName.whereEqualTo("GroupSiteId", request.getParameter("searchId"));

			queryForSearchName.addAscendingOrder("Name");

			try {
				listOfSearchNames = queryForSearchName.find();
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		try {
			Iterator<ParseObject> iteratorForSearchObjects = listOfSearchNames.listIterator();

			while (iteratorForSearchObjects.hasNext()) {

				ParseObject hotelObjects = iteratorForSearchObjects.next();
				
				
				
				EgsdHotelObjects egsdhObjects = new EgsdHotelObjects();				
				
				egsdhObjects.setHotelId(hotelObjects.getObjectId());
				egsdhObjects.setName(hotelObjects.getString("Name"));
				egsdhObjects.setGroupId(hotelObjects.getString("GroupSiteId"));
				egsdhObjects.setZipcode(hotelObjects.getString("zipcode"));
				egsdhObjects.setGroupName(hotelObjects.getString("GroupName"));
				egsdhObjects.setEmail(hotelObjects.getString("email"));
				egsdhObjects.setAdminName(hotelObjects.getString("adminName"));
				
				listOfEgsdHotelObjects.add(egsdhObjects);

			}

		} catch (NullPointerException npe) {
			listOfEgsdHotelObjects.clear();

		}

		finally {

			listOfEgsdHotelObjects2 = searchingNames(pattern);
			listOfEgsdHotelObjects3 = searchingObjects(searchId);
			listOfEgsdHotelObjects4 = searchingZipcode(searchId);
			listOfEgsdHotelObjects6 = searchingGroupname(pattern);
			listOfEgsdHotelObjects7 = searchingAdminname(pattern);
			listOfEgsdHotelObjects8 = searchingEmail(searchId);
			listOfEgsdHotelObjects5.clear();
			System.out.println("listOfEgsdHotelObjects size is " + listOfEgsdHotelObjects.size());
			System.out.println("listOfEgsdHotelObjects2 size is " + listOfEgsdHotelObjects2.size());
			System.out.println("listOfEgsdHotelObjects3 size is " + listOfEgsdHotelObjects3.size());
			System.out.println("listOfEgsdHotelObjects4 size is " + listOfEgsdHotelObjects4.size());
			System.out.println("listOfEgsdHotelObjects6 size is " + listOfEgsdHotelObjects6.size());

			if (listOfEgsdHotelObjects.size() != 0) {
				listOfEgsdHotelObjects5.addAll(listOfEgsdHotelObjects);
			}
			if (listOfEgsdHotelObjects2.size() != 0) {
				listOfEgsdHotelObjects5.addAll(listOfEgsdHotelObjects2);
			}
			if (listOfEgsdHotelObjects3.size() != 0) {
				listOfEgsdHotelObjects5.addAll(listOfEgsdHotelObjects3);
			}

			if (listOfEgsdHotelObjects4.size() != 0) {
				listOfEgsdHotelObjects5.addAll(listOfEgsdHotelObjects4);
			}
			if (listOfEgsdHotelObjects6.size() != 0) {
				listOfEgsdHotelObjects5.addAll(listOfEgsdHotelObjects6);
			}
			if (listOfEgsdHotelObjects7.size() != 0) {
				listOfEgsdHotelObjects5.addAll(listOfEgsdHotelObjects7);
			}
			if (listOfEgsdHotelObjects8.size() != 0) {
				listOfEgsdHotelObjects5.addAll(listOfEgsdHotelObjects8);
			}
			System.out.println("listOfEgsdHotelObjects5 size is " + listOfEgsdHotelObjects5.size());
			for (int i = 0; i < listOfEgsdHotelObjects5.size() - 1; i++) {
				for (int j = 1 + i; j < listOfEgsdHotelObjects5.size(); j++) {
					System.out.println("in i for loop " + listOfEgsdHotelObjects5.get(i).getName().toString());
					System.out.println("in j for loop " + listOfEgsdHotelObjects5.get(j).getName().toString());
					System.out.println("listOfEgsdHotelObjects5 size is " + listOfEgsdHotelObjects5.size());
					if (listOfEgsdHotelObjects5.get(i).getName().toString()
							.equals(listOfEgsdHotelObjects5.get(j).getName().toString())) {
						listOfEgsdHotelObjects5.remove(j);
						j--;
					}
				}
			}
			Collections.sort(listOfEgsdHotelObjects5, new GenericComparator("name", true));
		}

		System.out.println(listOfEgsdHotelObjects5.size());

		return listOfEgsdHotelObjects5;
	}

	public List searchingNames(String pattern) {
		ParseQuery<ParseObject> queryForSearchObjectId = ParseQuery.getQuery("Location");

		System.out.println("pattern is " + pattern);
		queryForSearchObjectId.whereMatches("Name", pattern, "i");
		queryForSearchObjectId.addAscendingOrder("Name");

		List<ParseObject> listOfSearchObjectId = null;
		List<EgsdHotelObjects> listOfEgsdHotelObjects = new ArrayList<EgsdHotelObjects>(100);

		try {
			listOfSearchObjectId = queryForSearchObjectId.find();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();

		}

		try {
			Iterator<ParseObject> iteratorForSearchObjects = listOfSearchObjectId.listIterator();

			while (iteratorForSearchObjects.hasNext()) {

				ParseObject hotelObjects = iteratorForSearchObjects.next();

				EgsdHotelObjects egsdhObjects = new EgsdHotelObjects();				
				
				egsdhObjects.setHotelId(hotelObjects.getObjectId());
				egsdhObjects.setName(hotelObjects.getString("Name"));
				egsdhObjects.setGroupId(hotelObjects.getString("GroupSiteId"));
				egsdhObjects.setZipcode(hotelObjects.getString("zipcode"));
				egsdhObjects.setGroupName(hotelObjects.getString("GroupName"));
				egsdhObjects.setEmail(hotelObjects.getString("email"));
				egsdhObjects.setAdminName(hotelObjects.getString("adminName"));
				
				listOfEgsdHotelObjects.add(egsdhObjects);

			}

		} catch (NullPointerException npe) {
			listOfEgsdHotelObjects.clear();
			return listOfEgsdHotelObjects;

		}

		return listOfEgsdHotelObjects;

	}

	public List searchingGroupname(String pattern) {
		ParseQuery<ParseObject> queryForSearchObjectId = ParseQuery.getQuery("Location");

		System.out.println("pattern is " + pattern);
		queryForSearchObjectId.whereMatches("GroupName", pattern, "i");
		queryForSearchObjectId.addAscendingOrder("Name");

		List<ParseObject> listOfSearchObjectId = null;
		List<EgsdHotelObjects> listOfEgsdHotelObjects = new ArrayList<EgsdHotelObjects>(100);

		try {
			listOfSearchObjectId = queryForSearchObjectId.find();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();

		}

		try {
			Iterator<ParseObject> iteratorForSearchObjects = listOfSearchObjectId.listIterator();

			while (iteratorForSearchObjects.hasNext()) {

				ParseObject hotelObjects = iteratorForSearchObjects.next();

				EgsdHotelObjects egsdhObjects = new EgsdHotelObjects();				
				
				egsdhObjects.setHotelId(hotelObjects.getObjectId());
				egsdhObjects.setName(hotelObjects.getString("Name"));
				egsdhObjects.setGroupId(hotelObjects.getString("GroupSiteId"));
				egsdhObjects.setZipcode(hotelObjects.getString("zipcode"));
				egsdhObjects.setGroupName(hotelObjects.getString("GroupName"));
				egsdhObjects.setEmail(hotelObjects.getString("email"));
				egsdhObjects.setAdminName(hotelObjects.getString("adminName"));
				
				listOfEgsdHotelObjects.add(egsdhObjects);

			}

		} catch (NullPointerException npe) {
			listOfEgsdHotelObjects.clear();
			return listOfEgsdHotelObjects;

		}

		return listOfEgsdHotelObjects;

	}

	public List searchingObjects(String searchId) {
		ParseQuery<ParseObject> queryForSearchObjectId = ParseQuery.getQuery("Location");
		System.out.println("searchId is " + searchId);
		queryForSearchObjectId.addAscendingOrder("Name");
		// queryForSearchObjectId.whereMatches("GroupSiteId",pattern,"i");
		queryForSearchObjectId.whereEqualTo("objectId", searchId);

		List<ParseObject> listOfSearchObjectId = null;
		List<EgsdHotelObjects> listOfEgsdHotelObjects = new ArrayList<EgsdHotelObjects>(100);

		try {
			listOfSearchObjectId = queryForSearchObjectId.find();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();

		}

		try {
			Iterator<ParseObject> iteratorForSearchObjects = listOfSearchObjectId.listIterator();

			while (iteratorForSearchObjects.hasNext()) {

				ParseObject hotelObjects = iteratorForSearchObjects.next();

				EgsdHotelObjects egsdhObjects = new EgsdHotelObjects();				
				
				egsdhObjects.setHotelId(hotelObjects.getObjectId());
				egsdhObjects.setName(hotelObjects.getString("Name"));
				egsdhObjects.setGroupId(hotelObjects.getString("GroupSiteId"));
				egsdhObjects.setZipcode(hotelObjects.getString("zipcode"));
				egsdhObjects.setGroupName(hotelObjects.getString("GroupName"));
				egsdhObjects.setEmail(hotelObjects.getString("email"));
				egsdhObjects.setAdminName(hotelObjects.getString("adminName"));
				
				listOfEgsdHotelObjects.add(egsdhObjects);

			}

		} catch (NullPointerException npe) {
			listOfEgsdHotelObjects.clear();
			return listOfEgsdHotelObjects;
		}

		return listOfEgsdHotelObjects;
	}

	public List searchingZipcode(String searchId) {
		ParseQuery<ParseObject> queryForSearchObjectId = ParseQuery.getQuery("Location");

		queryForSearchObjectId.addAscendingOrder("Name");
		queryForSearchObjectId.whereEqualTo("zipcode", searchId);

		List<ParseObject> listOfSearchObjectId = null;
		List<EgsdHotelObjects> listOfEgsdHotelObjects = new ArrayList<EgsdHotelObjects>(100);

		try {
			listOfSearchObjectId = queryForSearchObjectId.find();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();

		}

		try {
			Iterator<ParseObject> iteratorForSearchObjects = listOfSearchObjectId.listIterator();

			while (iteratorForSearchObjects.hasNext()) {

				ParseObject hotelObjects = iteratorForSearchObjects.next();

				EgsdHotelObjects egsdhObjects = new EgsdHotelObjects();				
				
				egsdhObjects.setHotelId(hotelObjects.getObjectId());
				egsdhObjects.setName(hotelObjects.getString("Name"));
				egsdhObjects.setGroupId(hotelObjects.getString("GroupSiteId"));
				egsdhObjects.setZipcode(hotelObjects.getString("zipcode"));
				egsdhObjects.setGroupName(hotelObjects.getString("GroupName"));
				egsdhObjects.setEmail(hotelObjects.getString("email"));
				egsdhObjects.setAdminName(hotelObjects.getString("adminName"));
				
				listOfEgsdHotelObjects.add(egsdhObjects);

			}

		} catch (NullPointerException npe) {
			listOfEgsdHotelObjects.clear();
			return listOfEgsdHotelObjects;

		}

		return listOfEgsdHotelObjects;

	}
	
	
	public List searchingAdminname(String pattern) {
		ParseQuery<ParseObject> queryForSearchObjectId = ParseQuery.getQuery("Location");

		System.out.println("pattern is " + pattern);
		queryForSearchObjectId.whereMatches("adminName", pattern, "i");
		queryForSearchObjectId.addAscendingOrder("Name");

		List<ParseObject> listOfSearchObjectId = null;
		List<EgsdHotelObjects> listOfEgsdHotelObjects = new ArrayList<EgsdHotelObjects>(100);

		try {
			listOfSearchObjectId = queryForSearchObjectId.find();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();

		}

		try {
			Iterator<ParseObject> iteratorForSearchObjects = listOfSearchObjectId.listIterator();

			while (iteratorForSearchObjects.hasNext()) {

				ParseObject hotelObjects = iteratorForSearchObjects.next();

				EgsdHotelObjects egsdhObjects = new EgsdHotelObjects();				
				
				egsdhObjects.setHotelId(hotelObjects.getObjectId());
				egsdhObjects.setName(hotelObjects.getString("Name"));
				egsdhObjects.setGroupId(hotelObjects.getString("GroupSiteId"));
				egsdhObjects.setZipcode(hotelObjects.getString("zipcode"));
				egsdhObjects.setGroupName(hotelObjects.getString("GroupName"));
				egsdhObjects.setEmail(hotelObjects.getString("email"));
				egsdhObjects.setAdminName(hotelObjects.getString("adminName"));
				
				listOfEgsdHotelObjects.add(egsdhObjects);

			}

		} catch (NullPointerException npe) {
			listOfEgsdHotelObjects.clear();
			return listOfEgsdHotelObjects;

		}

		return listOfEgsdHotelObjects;

	}
	
	
	public List searchingEmail(String searchId) {
		ParseQuery<ParseObject> queryForSearchObjectId = ParseQuery.getQuery("Location");

		queryForSearchObjectId.addAscendingOrder("Name");
		queryForSearchObjectId.whereEqualTo("email", searchId);

		List<ParseObject> listOfSearchObjectId = null;
		List<EgsdHotelObjects> listOfEgsdHotelObjects = new ArrayList<EgsdHotelObjects>(100);

		try {
			listOfSearchObjectId = queryForSearchObjectId.find();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();

		}

		try {
			Iterator<ParseObject> iteratorForSearchObjects = listOfSearchObjectId.listIterator();

			while (iteratorForSearchObjects.hasNext()) {

				ParseObject hotelObjects = iteratorForSearchObjects.next();

				EgsdHotelObjects egsdhObjects = new EgsdHotelObjects();				
				
				egsdhObjects.setHotelId(hotelObjects.getObjectId());
				egsdhObjects.setName(hotelObjects.getString("Name"));
				egsdhObjects.setGroupId(hotelObjects.getString("GroupSiteId"));
				egsdhObjects.setZipcode(hotelObjects.getString("zipcode"));
				egsdhObjects.setGroupName(hotelObjects.getString("GroupName"));
				egsdhObjects.setEmail(hotelObjects.getString("email"));
				egsdhObjects.setAdminName(hotelObjects.getString("adminName"));
				
				listOfEgsdHotelObjects.add(egsdhObjects);

			}

		} catch (NullPointerException npe) {
			listOfEgsdHotelObjects.clear();
			return listOfEgsdHotelObjects;

		}

		return listOfEgsdHotelObjects;

	}
	

	@RequestMapping(value = "/deleteUser", method = RequestMethod.POST)
	public @ResponseBody String deleteUser(HttpServletRequest request) {

		String userId = request.getParameter("searchId");
		String status = "nolocations";
		
		ParseQuery<ParseObject> queryForAdmin = ParseQuery.getQuery("Location");
		
		
		queryForAdmin.whereEqualTo("GroupId", userId);
		List<ParseObject> listOfAdmins = null;

		try {

			listOfAdmins = queryForAdmin.find();

		} catch (ParseException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		}
		
		if(listOfAdmins != null)
		{
			status = "islocations";
		}		

		return status;

	}
	
	@RequestMapping(value = "/confirmDeleteUser", method = RequestMethod.POST)
	public @ResponseBody String deleteConfirmUser(HttpServletRequest request) {

		String userId = request.getParameter("searchId");
		String status = "";
		
		
		
		HashMap<String, String> params = new HashMap<String, String>();
		params.put("objectId", userId);
		String result = "";
		try {
			result = ParseCloud.callFunction("deleteAdminInformation", params);
			status = "deleted";
			System.out.println("admin update :" + result);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			status = "notdeleted";
			e.printStackTrace();

		}

		return status;

	}
	
	
	@RequestMapping(value = "/updateUserPassword", method = RequestMethod.POST)
	public @ResponseBody String updateUserPassword(HttpServletRequest request) {

		String username = request.getParameter("username");
		String password = request.getParameter("password");

		String status = "";
		
		HashMap<String, String> params = new HashMap<String, String>();
		params.put("username", username);
		params.put("password", password);
		try {
			status = ParseCloud.callFunction("updatePasswordToUser", params);
			status = "success";
		} catch (ParseException e) {
			status = "error";
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return status;

	}

	@RequestMapping(value = "/searchUsers", method = RequestMethod.POST)
	public @ResponseBody List searchUsers(HttpServletRequest request) {

		String userName = request.getParameter("userName");
		System.out.println(userName);
		String admin = "^.*" + request.getParameter("searchId") + ".*$";
		ParseQuery<ParseObject> queryForAdmin = ParseQuery.getQuery("_User");
		queryForAdmin.orderByAscending("username");
		queryForAdmin.whereMatches("email", admin, "i");
		queryForAdmin.whereEqualTo("Status", true);
		List<ParseObject> listOfAdmins = null;

		try {

			listOfAdmins = queryForAdmin.find();

		} catch (ParseException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		}
		List<EgsdUserObjects> listOfUserObjects = new ArrayList<EgsdUserObjects>(100);
		List<EgsdUserObjects> listOfUserObjects2 = new ArrayList<EgsdUserObjects>(100);
		List<EgsdUserObjects> listOfUserObjects3 = new ArrayList<EgsdUserObjects>(100);
		List<EgsdUserObjects> listOfUserObjects4 = new ArrayList<EgsdUserObjects>(100);
		List<EgsdUserObjects> listOfUserObjects5 = new ArrayList<EgsdUserObjects>(100);
		List<EgsdUserObjects> listOfUserObjects6 = new ArrayList<EgsdUserObjects>(100);
		List<EgsdUserObjects> listOfUserObjects7 = new ArrayList<EgsdUserObjects>(100);
		
		Set<EgsdUserObjects> set = new HashSet<EgsdUserObjects>();
		try {
			Iterator<ParseObject> iteratorForEmptyAdmins = listOfAdmins.listIterator();

			while (iteratorForEmptyAdmins.hasNext()) {

				ParseObject parseObjectHavingEmptyAdmins = iteratorForEmptyAdmins.next();

				listOfUserObjects.add(new EgsdUserObjects(parseObjectHavingEmptyAdmins.getObjectId(),
						parseObjectHavingEmptyAdmins.getString("username"), null,
						parseObjectHavingEmptyAdmins.getString("email"), parseObjectHavingEmptyAdmins.getString("user"),
						parseObjectHavingEmptyAdmins.getString("locationId"),
						parseObjectHavingEmptyAdmins.getString("firstname"),
						parseObjectHavingEmptyAdmins.getString("lastname"),
						parseObjectHavingEmptyAdmins.getString("phone")));

			}

		} catch (NullPointerException npe) {

			listOfUserObjects.clear();

		} finally {

			listOfUserObjects2 = searchingFirstName(admin);
			listOfUserObjects3 = searchingLastName(admin);
			listOfUserObjects7 = searchingPhone(admin);
			listOfUserObjects4.clear();
			System.out.println("listOfUserObjects size is " + listOfUserObjects.size());
			System.out.println("listOfUserObjects2 size is " + listOfUserObjects2.size());
			System.out.println("listOfUserObjects3 size is " + listOfUserObjects3.size());
			if (listOfUserObjects.size() != 0) {
				listOfUserObjects4.addAll(listOfUserObjects);
			}
			if (listOfUserObjects2.size() != 0) {
				listOfUserObjects4.addAll(listOfUserObjects2);
			}
			if (listOfUserObjects3.size() != 0) {
				listOfUserObjects4.addAll(listOfUserObjects3);
			}
			if (listOfUserObjects7.size() != 0) {
				listOfUserObjects4.addAll(listOfUserObjects7);
			}
			System.out.println(listOfUserObjects4.size());
			for (int i = 0; i < listOfUserObjects4.size() - 1; i++) {
				for (int j = 1 + i; j < listOfUserObjects4.size(); j++) {
					// System.out.println("in i loop
					// "+i+""+listOfUserObjects4.get(i).getUsername().toString());
					// System.out.println(listOfUserObjects4.get(i).getFirstname().toString().equals(listOfUserObjects4.get(j).getFirstname().toString()));
					// System.out.println("in i loop
					// "+i+""+listOfUserObjects4.get(i).getUsername().toString());
					if (listOfUserObjects4.get(i).getUsername().toString()
							.equals(listOfUserObjects4.get(j).getUsername().toString())
							&& (listOfUserObjects4.get(i).getObjectId().toString()
									.equals(listOfUserObjects4.get(j).getObjectId().toString()))) {
						System.out.println("in i loop " + i + "" + listOfUserObjects4.get(i).getUsername().toString());
						System.out.println("in i loop " + j + "" + listOfUserObjects4.get(j).getUsername().toString());
						System.out.println("removed " + listOfUserObjects4.get(j).getUsername());
						listOfUserObjects4.remove(j);
						System.out.println(listOfUserObjects4.size());

					}
				}
			}
			System.out.println(listOfUserObjects4.size());
			set.addAll(listOfUserObjects4);
			listOfUserObjects4.clear();
			listOfUserObjects4.addAll(set);
			System.out.println(listOfUserObjects4.size());

			Iterator<EgsdUserObjects> iterator = listOfUserObjects4.iterator();
			while (iterator.hasNext()) {
				EgsdUserObjects egsdUserObjects = iterator.next();
				egsdUserObjects.setUsername(egsdUserObjects.getUsername().toString());
				egsdUserObjects.setFirstname(egsdUserObjects.getFirstname().toString());
				egsdUserObjects.setLastname(egsdUserObjects.getLastname().toString());
				egsdUserObjects.setUser(egsdUserObjects.getUser().toString().toLowerCase());
				egsdUserObjects.setEmail(egsdUserObjects.getEmail().toString());
				
				egsdUserObjects.setPhone(egsdUserObjects.getPhone());
				
				
				egsdUserObjects.setObjectId(egsdUserObjects.getObjectId().toString());
				listOfUserObjects5.add(egsdUserObjects);
			}

			listOfUserObjects6.clear();
			if (userName.equals("IT Admin")) {

				for (int k = 0; k < listOfUserObjects5.size(); k++) {
					if (listOfUserObjects5.get(k).getUser().toString().equals("it admin")) {
						listOfUserObjects6.add(listOfUserObjects5.get(k));
					}
				}
				for (int k = 0; k < listOfUserObjects5.size(); k++) {
					if (listOfUserObjects5.get(k).getUser().toString().equals("super admin")) {
						listOfUserObjects6.add(listOfUserObjects5.get(k));
					}
				}

				for (int k = 0; k < listOfUserObjects5.size(); k++) {
					if (listOfUserObjects5.get(k).getUser().toString().equals("cs admin")) {
						listOfUserObjects6.add(listOfUserObjects5.get(k));
					}
				}
				for (int k = 0; k < listOfUserObjects5.size(); k++) {
					if (listOfUserObjects5.get(k).getUser().toString().equals("location admin")) {
						listOfUserObjects6.add(listOfUserObjects5.get(k));
					}
				}
			}
			System.out.println("userName is " + userName);
			if (userName.equals("Super Admin")) {

				for (int k = 0; k < listOfUserObjects5.size(); k++) {
					if (listOfUserObjects5.get(k).getUser().toString().equals("cs admin")) {
						listOfUserObjects6.add(listOfUserObjects5.get(k));
					}
				}
				for (int k = 0; k < listOfUserObjects5.size(); k++) {
					if (listOfUserObjects5.get(k).getUser().toString().equals("location admin")) {
						listOfUserObjects6.add(listOfUserObjects5.get(k));
					}
				}
			}
			if (userName.equals("CS Admin")) {
				for (int k = 0; k < listOfUserObjects5.size(); k++) {
					if (listOfUserObjects5.get(k).getUser().toString().equals("location admin")) {
						listOfUserObjects6.add(listOfUserObjects5.get(k));
					}
				}
			}
			for (EgsdUserObjects e : listOfUserObjects6) {
				System.out.println(e.getUser() + "-->" + e.getUsername());

			}

		}
		return listOfUserObjects6;
	}

	public List searchingFirstName(String admin) {

		ParseQuery<ParseObject> queryForAdmin = ParseQuery.getQuery("_User");
		queryForAdmin.orderByAscending("username");
		queryForAdmin.whereMatches("firstname", admin, "i");
		queryForAdmin.whereEqualTo("Status", true);
		List<ParseObject> listOfAdmins = null;

		try {

			listOfAdmins = queryForAdmin.find();

		} catch (ParseException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		}
		List<EgsdUserObjects> listOfUserObjects = new ArrayList<EgsdUserObjects>(100);

		try {
			Iterator<ParseObject> iteratorForEmptyAdmins = listOfAdmins.listIterator();

			while (iteratorForEmptyAdmins.hasNext()) {

				ParseObject parseObjectHavingEmptyAdmins = iteratorForEmptyAdmins.next();

				listOfUserObjects.add(new EgsdUserObjects(parseObjectHavingEmptyAdmins.getObjectId(),
						parseObjectHavingEmptyAdmins.getString("username"), null,
						parseObjectHavingEmptyAdmins.getString("email"), parseObjectHavingEmptyAdmins.getString("user"),
						parseObjectHavingEmptyAdmins.getString("locationId"),
						parseObjectHavingEmptyAdmins.getString("firstname"),
						parseObjectHavingEmptyAdmins.getString("lastname"),
						parseObjectHavingEmptyAdmins.getString("phone")));

			}

		} catch (NullPointerException npe) {
			listOfUserObjects.clear();
			// listOfUserObjects = searchingLastName(admin);
			return listOfUserObjects;
		}
		return listOfUserObjects;

	}

	public List searchingLastName(String admin) {

		ParseQuery<ParseObject> queryForAdmin = ParseQuery.getQuery("_User");
		queryForAdmin.orderByAscending("username");
		queryForAdmin.whereMatches("lastname", admin, "i");
		queryForAdmin.whereEqualTo("Status", true);
		List<ParseObject> listOfAdmins = null;
		List<EgsdUserObjects> listOfUserObjects = new ArrayList<EgsdUserObjects>(100);
		try {

			listOfAdmins = queryForAdmin.find();

		} catch (ParseException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		}

		try {
			Iterator<ParseObject> iteratorForEmptyAdmins = listOfAdmins.listIterator();

			while (iteratorForEmptyAdmins.hasNext()) {

				ParseObject parseObjectHavingEmptyAdmins = iteratorForEmptyAdmins.next();

				listOfUserObjects.add(new EgsdUserObjects(parseObjectHavingEmptyAdmins.getObjectId(),
						parseObjectHavingEmptyAdmins.getString("username"), null,
						parseObjectHavingEmptyAdmins.getString("email"), parseObjectHavingEmptyAdmins.getString("user"),
						parseObjectHavingEmptyAdmins.getString("locationId"),
						parseObjectHavingEmptyAdmins.getString("firstname"),
						parseObjectHavingEmptyAdmins.getString("lastname"),
						parseObjectHavingEmptyAdmins.getString("phone")));

			}

		} catch (NullPointerException npe) {
			listOfUserObjects.clear();
			// listOfUserObjects = searchingUsername(admin);
			return listOfUserObjects;
		}
		return listOfUserObjects;

	}
	
	public List searchingPhone(String admin) {

		ParseQuery<ParseObject> queryForAdmin = ParseQuery.getQuery("_User");
		queryForAdmin.orderByAscending("username");
		queryForAdmin.whereMatches("phone", admin, "i");
		queryForAdmin.whereEqualTo("Status", true);
		List<ParseObject> listOfAdmins = null;
		List<EgsdUserObjects> listOfUserObjects = new ArrayList<EgsdUserObjects>(100);
		try {

			listOfAdmins = queryForAdmin.find();

		} catch (ParseException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		}

		try {
			Iterator<ParseObject> iteratorForEmptyAdmins = listOfAdmins.listIterator();

			while (iteratorForEmptyAdmins.hasNext()) {

				ParseObject parseObjectHavingEmptyAdmins = iteratorForEmptyAdmins.next();

				listOfUserObjects.add(new EgsdUserObjects(parseObjectHavingEmptyAdmins.getObjectId(),
						parseObjectHavingEmptyAdmins.getString("username"), null,
						parseObjectHavingEmptyAdmins.getString("email"), parseObjectHavingEmptyAdmins.getString("user"),
						parseObjectHavingEmptyAdmins.getString("locationId"),
						parseObjectHavingEmptyAdmins.getString("firstname"),
						parseObjectHavingEmptyAdmins.getString("lastname"),
						parseObjectHavingEmptyAdmins.getString("phone")));

			}

		} catch (NullPointerException npe) {
			listOfUserObjects.clear();
			// listOfUserObjects = searchingUsername(admin);
			return listOfUserObjects;
		}
		return listOfUserObjects;

	}

	@RequestMapping(value = "/searchTemplates", method = RequestMethod.POST)
	public @ResponseBody List searchTemplates(HttpServletRequest request) {

		System.out.println(request.getParameter("username"));
		String pattern = "^.*" + request.getParameter("searchId") + ".*$";
		ParseQuery<ParseObject> queryForSearchName = ParseQuery.getQuery("Template");
		List<ParseObject> listOfSearchNames = null;
		List<EgsdSearchTemplateObjects> listOfEgsdHotelObjects = null;
		// queryForSearchName.addAscendingOrder("Name");
		queryForSearchName.whereNotEqualTo("type", "group");
		queryForSearchName.addAscendingOrder("Name");
		queryForSearchName.whereMatches("Name", pattern, "i");

		try {
			listOfSearchNames = queryForSearchName.find();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		try {
			Iterator<ParseObject> iteratorForSearchObjects = listOfSearchNames.listIterator();
			listOfEgsdHotelObjects = new ArrayList<EgsdSearchTemplateObjects>(100);

			while (iteratorForSearchObjects.hasNext()) {

				ParseObject hotelObjects = iteratorForSearchObjects.next();

				listOfEgsdHotelObjects
						.add(new EgsdSearchTemplateObjects(hotelObjects.getString("Name"), hotelObjects.getObjectId()));

			}

		} catch (NullPointerException npe) {

			System.out.println(npe);
			listOfEgsdHotelObjects = searchingTemplateId(pattern);

		}

		return listOfEgsdHotelObjects;

	}

	public List searchingTemplateId(String pattern) {
		ParseQuery<ParseObject> queryForSearchObjectId = ParseQuery.getQuery("Template");

		queryForSearchObjectId.whereMatches("objectId", pattern, "i");
		queryForSearchObjectId.addAscendingOrder("Name");
		List<ParseObject> listOfSearchObjectId = null;
		List<EgsdSearchTemplateObjects> listOfEgsdHotelObjects = null;

		try {
			listOfSearchObjectId = queryForSearchObjectId.find();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();

		}

		try {
			Iterator<ParseObject> iteratorForSearchObjects = listOfSearchObjectId.listIterator();
			listOfEgsdHotelObjects = new ArrayList<EgsdSearchTemplateObjects>(100);

			while (iteratorForSearchObjects.hasNext()) {

				ParseObject hotelObjects = iteratorForSearchObjects.next();

				listOfEgsdHotelObjects
						.add(new EgsdSearchTemplateObjects(hotelObjects.getString("Name"), hotelObjects.getObjectId()));

			}

		} catch (NullPointerException npe) {

			System.out.println(npe);
			listOfEgsdHotelObjects = searchingObjects(pattern);

		}
		return listOfEgsdHotelObjects;

	}
	
	@RequestMapping(value = "/hotelMenuItems", method = RequestMethod.POST,produces="application/json")
	public @ResponseBody 
	String hotelMenuItems(@RequestBody Object[] resp) {
		
		ObjectMapper mapper = new ObjectMapper();
		String str="";
		try{
		 str = mapper.writeValueAsString(resp);
		}catch(Exception e){
			e.printStackTrace();
		}
		
		System.out.println(str);
		
		JSONArray array = new JSONArray(str);
		JSONObject jsonObj;
		JSONObject jsonObj1=array.getJSONObject(0);
		String hotelMenuId = jsonObj1.getString("HotelId");
		
		ParseQuery<ParseObject> parseQueryForMenuItems = ParseQuery.getQuery("HotelMenuList");
	    parseQueryForMenuItems.whereEqualTo("HotelId", hotelMenuId);
        
        List<ParseObject> listOfMenuObjects = null;

		try {
			listOfMenuObjects = parseQueryForMenuItems.find();
		} catch (ParseException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		try {

			Iterator<ParseObject> iteratorForMenuObjects = listOfMenuObjects.listIterator();

			while (iteratorForMenuObjects.hasNext()) {

				ParseObject menuObject = iteratorForMenuObjects.next();

				try {
					menuObject.delete();
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

			}

		} catch (NullPointerException npe) {

			System.out.println("No menu Items to delete");

		}
		
		
		
		
		ParseFile pf = null;
		
		
		
		for(int i=0; i<array.length(); i++){
			jsonObj  = array.getJSONObject(i);	        
	        
	        
			ParseObject parseObjectForMenuItem = new ParseObject("HotelMenuList");
				
				if( !jsonObj.getString("MenuDesc").equals("") || !jsonObj.getString("ActionType").equals("Select Action Type") || !jsonObj.getString("MenuQuan").equals("") || !jsonObj.getString("ItemAction").equals("") || !jsonObj.getString("ItemQuan").equals("") )
				{
					parseObjectForMenuItem.put("HotelId", jsonObj.getString("HotelId"));
					ParseQuery<ParseObject> parseQueryForIcons = ParseQuery.getQuery("HotelMenuIcons");
					List<ParseObject> listOfIconsObjects = null;
					
					try {
						listOfIconsObjects = parseQueryForIcons.find();
					} catch (ParseException e1) {
						// TODO Auto-generated catch block
						e1.printStackTrace();
					}				
					
					byte[] taxi = null;
					String name = listOfIconsObjects.get(i).getParseFile("MenuIcon").getName();
					System.out.println(name);
					try {
						taxi = listOfIconsObjects.get(i).getParseFile("MenuIcon").getData();
					} catch (ParseException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					String nameImg = i+".png";
					nameImg = nameImg.replaceAll("\\s+","");
					pf = new ParseFile(nameImg, taxi);
					try {
						pf.save();
					} catch (ParseException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					parseObjectForMenuItem.put("Icon", pf);
					
					
					
				}
				
				
				if(jsonObj.getString("MenuDesc").equals(""))
				{
					System.out.println("empty");
				}
				else
				{
					parseObjectForMenuItem.put("MenuDescription", jsonObj.getString("MenuDesc"));
				}
				
				if(jsonObj.getString("ActionType").equals("Select Action Type"))
				{
					System.out.println("empty");
				}
				else
				{
					parseObjectForMenuItem.put("ActionType", jsonObj.getString("ActionType"));
				}
				
				if(jsonObj.getString("MenuQuan").equals(""))
				{
					System.out.println("empty");
				}
				else
				{
					parseObjectForMenuItem.put("MenuSequence", Integer.parseInt(jsonObj.getString("MenuQuan")));
				}
				
				if(jsonObj.getString("ItemAction").equals(""))
				{
					System.out.println("empty");
				}
				else
				{
					parseObjectForMenuItem.put("IconAction", jsonObj.getString("ItemAction"));
				}				
				
				if(jsonObj.getString("ItemQuan").equals(""))
				{
					System.out.println("empty");
				}
				else
				{
					parseObjectForMenuItem.put("IconSequence", Integer.parseInt(jsonObj.getString("ItemQuan")));
				}	
				
				
				
				
				
				
				
				
				
				
				
				try {
					parseObjectForMenuItem.save();
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} 
	        
	        
	    }		
		
		return "success";
		
	}
	
	@RequestMapping(value = "/getLocationAdmins", method = RequestMethod.POST)
	public @ResponseBody List getLocationAdmins() {
ParseQuery<ParseObject> queryForLocationAdminWasEmpty = ParseQuery.getQuery("_User");
		
		queryForLocationAdminWasEmpty.orderByAscending("username");
		queryForLocationAdminWasEmpty.whereEqualTo("user", "Location Admin");
		

		List<ParseObject> listOfEmptyAdmins = null;

		try {

			listOfEmptyAdmins = queryForLocationAdminWasEmpty.find();

		} catch (ParseException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		}
		List<EgsdUserObjects> listOfUserObjects = new ArrayList<EgsdUserObjects>(100);

		try {
			Iterator<ParseObject> iteratorForEmptyAdmins = listOfEmptyAdmins.listIterator();

			while (iteratorForEmptyAdmins.hasNext()) {

				ParseObject parseObjectHavingEmptyAdmins = iteratorForEmptyAdmins.next();

				listOfUserObjects.add(new EgsdUserObjects(parseObjectHavingEmptyAdmins.getObjectId(),
						parseObjectHavingEmptyAdmins.getString("username"), null,
						parseObjectHavingEmptyAdmins.getString("email"), parseObjectHavingEmptyAdmins.getString("user"),
						parseObjectHavingEmptyAdmins.getString("locationId"),
						parseObjectHavingEmptyAdmins.getString("firstname"),
						parseObjectHavingEmptyAdmins.getString("lastname"),
						parseObjectHavingEmptyAdmins.getString("phone")));

			}

		} catch (NullPointerException npe) {

			listOfUserObjects
					.add(new EgsdUserObjects("empty", "Please Add Location Admin", null, null, null, null, "", "",null));

		}
		
		return listOfUserObjects;

	}
	
	
	@RequestMapping(value = "/getTemplates", method = RequestMethod.POST)
	public @ResponseBody List getTemplates() {
		

		ParseQuery<ParseObject> queryForTemplateObjects = ParseQuery.getQuery("Template");
		queryForTemplateObjects.orderByAscending("Name");
		queryForTemplateObjects.whereNotEqualTo("type", "group");

		List<ParseObject> listOfTemplateObjects = null;

		try {
			listOfTemplateObjects = queryForTemplateObjects.find();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		List<EgsdTemplateObjects> listOfEgsdTemplateObjects = new ArrayList<EgsdTemplateObjects>(100);
		try {
			Iterator<ParseObject> iteratorForTemplateObjects = listOfTemplateObjects.listIterator();
			

			while (iteratorForTemplateObjects.hasNext()) {

				ParseObject templateObjects = iteratorForTemplateObjects.next();

				listOfEgsdTemplateObjects
						.add(new EgsdTemplateObjects(templateObjects.getObjectId(), templateObjects.getString("Name"),
								templateObjects.getObjectId(), templateObjects.getBoolean("Customized")));

			}

			

		} catch (NullPointerException npe) {
			
			System.out.println(npe);

		}
		
		return listOfEgsdTemplateObjects;
	}
	
	
	
	@RequestMapping(value = "/getGroups", method = RequestMethod.POST)
	public @ResponseBody List getGroups() {
		

		ParseQuery<ParseObject> queryForGroupObjects = ParseQuery.getQuery("Template");
		queryForGroupObjects.orderByAscending("Name");

		queryForGroupObjects.whereEqualTo("type", "group");

		List<ParseObject> listOfGroupObjects = null;

		try {
			listOfGroupObjects = queryForGroupObjects.find();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		List<EgsdTemplateObjects> listOfEgsdGroupObjects = new ArrayList<EgsdTemplateObjects>(100);
		try {
			Iterator<ParseObject> iteratorForGroupObjects = listOfGroupObjects.listIterator();
			

			while (iteratorForGroupObjects.hasNext()) {

				ParseObject templateObjects = iteratorForGroupObjects.next();

				listOfEgsdGroupObjects
						.add(new EgsdTemplateObjects(templateObjects.getObjectId(), templateObjects.getString("Name"),
								templateObjects.getObjectId(), templateObjects.getBoolean("Customized")));

			}

			

		} catch (NullPointerException npe) {
			System.out.println(npe);
		}
		return listOfEgsdGroupObjects;
	}
	
	
	
	@RequestMapping(value = "/findHotelMenuList", method = RequestMethod.POST)
	public @ResponseBody List searchHotelMenuList(HttpServletRequest request) {
		
		System.out.println(request.getParameter("id"));
		String dirId = request.getParameter("id");
		ParseQuery<ParseObject> queryForSearchName = ParseQuery.getQuery("HotelMenuList");
		List<ParseObject> listOfSearchNames = null;
		List<HotelMenuListModel> listOfEgsdHotelMenuObjects = null;

		queryForSearchName.whereEqualTo("HotelId", dirId);

		try {
			listOfSearchNames = queryForSearchName.find();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		try {
			Iterator<ParseObject> iteratorForSearchObjects = listOfSearchNames.listIterator();
			listOfEgsdHotelMenuObjects = new ArrayList<HotelMenuListModel>(100);

			while (iteratorForSearchObjects.hasNext()) {

				ParseObject hotelObjects = iteratorForSearchObjects.next();				

				listOfEgsdHotelMenuObjects.add(new HotelMenuListModel(hotelObjects.getString("MenuDescription"),hotelObjects.getInt("MenuSequence") , hotelObjects.getString("IconAction"),hotelObjects.getInt("IconSequence"),hotelObjects.getString("ActionType")));

			}
			
			

		} catch (NullPointerException npe) {

			
			System.out.println(npe);

		}

		return listOfEgsdHotelMenuObjects;

	}
	

	@RequestMapping(value = "/getDirectoryDetails", method = RequestMethod.POST)
	public @ResponseBody List searchDirectory(HttpServletRequest request) {

		System.out.println(request.getParameter("username"));
		String dirId = request.getParameter("searchId");
		ParseQuery<ParseObject> queryForSearchName = ParseQuery.getQuery("DirectoryItem");
		List<ParseObject> listOfSearchNames = null;
		List<DirectoryDetails> listOfEgsdHotelObjects = null;

		queryForSearchName.whereEqualTo("objectId", dirId);

		try {
			listOfSearchNames = queryForSearchName.find();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		try {
			Iterator<ParseObject> iteratorForSearchObjects = listOfSearchNames.listIterator();
			listOfEgsdHotelObjects = new ArrayList<DirectoryDetails>(100);

			while (iteratorForSearchObjects.hasNext()) {

				ParseObject hotelObjects = iteratorForSearchObjects.next();
				ParseObject StyleIdPO = hotelObjects.getParseObject("StyleId");
				String styleId = null;
				if (hotelObjects.getParseObject("StyleId") != null)
					styleId = StyleIdPO.getObjectId();

				listOfEgsdHotelObjects.add(new DirectoryDetails(hotelObjects.getObjectId(),
						hotelObjects.getString("DirectoryID"), styleId, hotelObjects.getString("LocationId")));

			}

		} catch (NullPointerException npe) {

			System.out.println(npe);

		}

		return listOfEgsdHotelObjects;

	}

	@RequestMapping(value = "/editDirectoryDetails", method = RequestMethod.POST)
	public @ResponseBody DirectoryDetailsModel searchDirectoryDetails(HttpServletRequest request) {
		String styleId = null;
		System.out.println(request.getParameter("username"));
		String dirId = request.getParameter("searchId");
		DirectoryDetailsModel dModel = new DirectoryDetailsModel();
		ParseQuery<EgsdDirectoryItemParseObject> queryForDirectoryItem = ParseQuery.getQuery("DirectoryItem");
		Map<String, List> myMap = new HashMap<String, List>();
		queryForDirectoryItem.whereEqualTo("objectId", dirId);

		queryForDirectoryItem.orderByAscending("Title");
		queryForDirectoryItem.limit(1000);
		List<EgsdDirectoryItemParseObject> directoryItemParseObjectsList = null;
		List listAll = new ArrayList();
		listAll.clear();
		try {
			directoryItemParseObjectsList = queryForDirectoryItem.find();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		List<EgsdDirectoryItemObjects> directoryItemObjectsList = new ArrayList<EgsdDirectoryItemObjects>(1000);
		System.out.println("Directory items are loaded:");
		try {
			Iterator<EgsdDirectoryItemParseObject> iterator = directoryItemParseObjectsList.listIterator();
			System.out.println("objectId" + "---> " + "DirectoryId" + "--->" + "getParentDirectoryId" + "--->"
					+ "getTitle" + "--->" + "getCaption" + "--->" + "getTimings" + "--->" + "getWebsite" + "--->"
					+ "getEmail" + "--->" + "getPhones");
			int count = 1;
			while (iterator.hasNext()) {

				EgsdDirectoryItemParseObject egsd = iterator.next();
				String img = "No Image To Display";
				if (egsd.getParseFile("Picture") != null)
				{
					int imgLength;
					try {
						imgLength = egsd.getParseFile("Picture").getData().length;
						
						if(imgLength > 0)
						{
							img = egsd.getParseFile("Picture").getUrl();
						}
					} catch (ParseException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					
				}
					
				// System.out.print(img);
				styleId = null;
				ParseObject StyleIdPO = egsd.getParseObject("StyleId");
				if (egsd.getParseObject("StyleId") != null)
					styleId = StyleIdPO.getObjectId();
				// System.out.println(styleId);

				/*
				 * if(StyleIdPO.getObjectId()!=null) System.out.println(
				 * "StyleID AT Directory Items"+StyleIdPO.getObjectId());
				 */

				directoryItemObjectsList.add(new EgsdDirectoryItemObjects(egsd.getObjectId(), egsd.getDirectoryId(),
						egsd.getTitle(), egsd.getCaption(), egsd.getDescription(), egsd.getTimings(), egsd.getWebsite(),
						egsd.getEmail(), egsd.getParentDirectoryId(), img, styleId, egsd.getPhones(),
						egsd.getParentDirectoryId(), egsd.getLocationId(), egsd.getCustomizedOrder()));

			}
		} catch (NullPointerException npe) {

		}
		dModel.setDirectoryList(directoryItemObjectsList);

		ParseQuery<ParseObject> queryForStyleID = ParseQuery.getQuery("Style");
		queryForStyleID.limit(1000);
		queryForStyleID.whereEqualTo("objectId", styleId);

		List<ParseObject> styleIdObjParseObj = null;
		try {
			styleIdObjParseObj = queryForStyleID.find();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		List<EgsdStyleObjects> styleObjects = new ArrayList<EgsdStyleObjects>(200);
		try {
			Iterator<ParseObject> styleIterator = styleIdObjParseObj.listIterator();
			// System.out.println(styleIdObjParseObj);

			while (styleIterator.hasNext()) {
				ParseObject sp = styleIterator.next();

				styleObjects.add(new EgsdStyleObjects(sp.getObjectId(), sp.getString("TitleFont"),
						sp.getString("TitleColor"), sp.getString("TitleFamily"), sp.getString("CaptionFont"),
						sp.getString("CaptionColor"), sp.getString("CaptionFamily"), sp.getString("DescriptionFont"),
						sp.getString("DescriptionColor"), sp.getString("DescriptionFamily"), sp.getString("PhonesFont"),
						sp.getString("PhonesColor"), sp.getString("PhonesFamily"), sp.getString("TimingsFont"),
						sp.getString("TimingsColor"), sp.getString("TimingsFamily"), sp.getString("WebsiteFont"),
						sp.getString("WebsiteColor"), sp.getString("WebsiteFamily"), sp.getString("EmailFont"),
						sp.getString("EmailColor"), sp.getString("EmailFamily"), sp.getString("StyleID"),
						sp.getString("PriceFont"), sp.getString("PriceColor"), sp.getString("PriceFamily")));

			}
		} catch (NullPointerException npe) {

		}

		dModel.setStyleList(styleObjects);

		ParseQuery<ParseObject> queryForPhones = ParseQuery.getQuery("Phones");
		queryForPhones.limit(1000);
		queryForPhones.whereEqualTo("PhoneId", dirId);

		List<ParseObject> phonesParseObjectsList = null;
		try {
			phonesParseObjectsList = queryForPhones.find();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		List<EgsdPhonesObjects> phonesObjectsList = new ArrayList<EgsdPhonesObjects>(1000);
		System.out.println("Phone Objects  are loaded:");
		// System.out.println(phonesParseObjectsList);
		try {
			Iterator<ParseObject> phoneIterator = phonesParseObjectsList.listIterator();
			int i = 0;
			while (phoneIterator.hasNext()) {

				ParseObject egsdPhonePO = phoneIterator.next();

				// System.out.println(egsdPhonePO.getObjectId()
				// +"-->"+egsdPhonePO.getString("PhoneId")
				// +"-->"+egsdPhonePO.getString("Type")
				// +"-->"+egsdPhonePO.getString("Ext"));
				phonesObjectsList.add(new EgsdPhonesObjects(egsdPhonePO.getObjectId(), egsdPhonePO.getString("PhoneId"),
						egsdPhonePO.getString("Type"), egsdPhonePO.getString("Ext")));

			}
		} catch (NullPointerException npe) {
			System.out.println(npe);
		}

		dModel.setPhoneList(phonesObjectsList);

		ParseQuery<ParseObject> queryForMenu = ParseQuery.getQuery("Menu");
		queryForMenu.whereEqualTo("MenuId", dirId);
		queryForMenu.orderByAscending("Sequence");
		List<ParseObject> menuParseObjectsList = null;
		try {
			menuParseObjectsList = queryForMenu.find();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		List<EgsdMenuObjects> menuObjectsList = new ArrayList<EgsdMenuObjects>(1000);
		System.out.println("Menu Items are loaded:");
		// System.out.println(menuParseObjectsList);
		try {
			Iterator<ParseObject> menuIterator = menuParseObjectsList.listIterator();
			while (menuIterator.hasNext()) {

				ParseObject egsdMenuPO = menuIterator.next();
				// System.out.println(egsdMenuPO.getObjectId() + "---> " +
				// egsdMenuPO.getString("MenuId") + "--->"
				// + egsdMenuPO.getString("Description") + "--->" +
				// egsdMenuPO.getString("Price"));
				// System.out.println(egsdMenuPO.getParseObject("StyleID"));
				// ParseObject styleIdObj=egsdMenuPO.getParseObject("StyleID");

				ParseObject ppp = egsdMenuPO.getParseObject("StyleID");
				// System.out.println("menu o.i:
				// "+egsdMenuPO.getObjectId()+"::styleId o.i:
				// "+ppp.getObjectId());

				menuObjectsList.add(new EgsdMenuObjects(egsdMenuPO.getObjectId(), egsdMenuPO.getString("MenuId"),
						egsdMenuPO.getString("Description"), egsdMenuPO.getString("Price"), ppp.getObjectId(), egsdMenuPO.getInt("Sequence")));
			}
		} catch (NullPointerException npe) {

		}
		dModel.setMenuList(menuObjectsList);

		return dModel;

	}

	@RequestMapping(value = "/searchGroups", method = RequestMethod.POST)
	public @ResponseBody List searchGroups(HttpServletRequest request) {

		System.out.println(request.getParameter("username"));
		String pattern = "^.*" + request.getParameter("searchId") + ".*$";
		ParseQuery<ParseObject> queryForSearchName = ParseQuery.getQuery("Template");
		List<ParseObject> listOfSearchNames = null;
		List<EgsdSearchTemplateObjects> listOfEgsdHotelObjects = null;
		queryForSearchName.addAscendingOrder("Name");
		queryForSearchName.whereEqualTo("type", "group");

		queryForSearchName.whereMatches("Name", pattern, "i");

		try {
			listOfSearchNames = queryForSearchName.find();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		try {
			Iterator<ParseObject> iteratorForSearchObjects = listOfSearchNames.listIterator();
			listOfEgsdHotelObjects = new ArrayList<EgsdSearchTemplateObjects>(100);

			while (iteratorForSearchObjects.hasNext()) {

				ParseObject hotelObjects = iteratorForSearchObjects.next();

				listOfEgsdHotelObjects
						.add(new EgsdSearchTemplateObjects(hotelObjects.getString("Name"), hotelObjects.getObjectId()));

			}

		} catch (NullPointerException npe) {

			System.out.println(npe);
			listOfEgsdHotelObjects = searchingGroupId(request.getParameter("searchId"));

		}

		return listOfEgsdHotelObjects;

	}

	public List searchingGroupId(String pattern) {
		ParseQuery<ParseObject> queryForSearchObjectId = ParseQuery.getQuery("Template");

		queryForSearchObjectId.whereEqualTo("objectId", pattern);

		List<ParseObject> listOfSearchObjectId = null;
		List<EgsdSearchTemplateObjects> listOfEgsdHotelObjects = null;

		try {
			listOfSearchObjectId = queryForSearchObjectId.find();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();

		}

		try {
			Iterator<ParseObject> iteratorForSearchObjects = listOfSearchObjectId.listIterator();
			listOfEgsdHotelObjects = new ArrayList<EgsdSearchTemplateObjects>(100);

			while (iteratorForSearchObjects.hasNext()) {

				ParseObject hotelObjects = iteratorForSearchObjects.next();

				listOfEgsdHotelObjects
						.add(new EgsdSearchTemplateObjects(hotelObjects.getString("Name"), hotelObjects.getObjectId()));

			}

		} catch (NullPointerException npe) {

			System.out.println(npe);
			listOfEgsdHotelObjects = searchingObjects(pattern);

		}
		return listOfEgsdHotelObjects;

	}

	@RequestMapping(value = "/registerSuperAdmin", method = RequestMethod.POST)
	public @ResponseBody String registerSuperAdmin(HttpServletRequest request) throws ParseException {

		System.out.println(request.getParameter("user"));
		System.out.println(request.getParameter("userName"));
		System.out.println(request.getParameter("locId"));
		String locAdminId = "";
		ParseQuery<ParseObject> queryForLocationAdmin = ParseQuery.getQuery("_User");
		System.out.println();
		if (request.getParameter("sEmail") == "" || request.getParameter("sEmail") == null) {

			queryForLocationAdmin.whereEqualTo("username", request.getParameter("username"));

			List<ParseObject> listOfEmptyAdmins = null;
			try {
				listOfEmptyAdmins = queryForLocationAdmin.find();

			} catch (NullPointerException e) {
				// TODO: handle exception
				System.out.println(e);
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			if (listOfEmptyAdmins == null) {
				ParseQuery<ParseObject> queryForEmail = ParseQuery.getQuery("_User");
				queryForEmail.whereEqualTo("email", request.getParameter("email"));
				List<ParseObject> listOfEmptyEmail = null;
				try {
					listOfEmptyEmail = queryForEmail.find();

				} catch (NullPointerException e) {
					// TODO: handle exception
					System.out.println(e);
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				String password = UUID.randomUUID().toString().replaceAll("-","");
				password.trim();
				password = password.substring(0, 10);
				
				String user = "";
				String adminUsername = request.getParameter("userType");
				if (listOfEmptyEmail == null) {
					
					
					if(adminUsername.equals("Super Admin"))
					{						
						user = "Super Admin";
					}
					else
					{						
						user = "IT Admin";
					}
					
					
					HashMap<String, String> params = new HashMap<String, String>();
					params.put("username", request.getParameter("username"));
					params.put("firstname", request.getParameter("firstname"));
					params.put("lastname", request.getParameter("lastname"));
					params.put("password", password);
					params.put("email", request.getParameter("email"));
					params.put("phone", request.getParameter("phone"));
					params.put("user", user);
					params.put("locationId", "");

					String result = null;
					try {
						result = ParseCloud.callFunction("signUpForLocationAdmin", params);

						SendEmail email = new SendEmail();
						String res = email.sendEmail(request.getParameter("firstname"), request.getParameter("email"),
								request.getParameter("username"), password, user);
						System.out.println(res);
					} catch (ParseException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				} else {
					locAdminId = "emailExisted";
				}

			} else {
				locAdminId = "userExisted";
			}

		} else {
			HashMap<String, String> params = new HashMap<String, String>();
			params.put("username", request.getParameter("username"));
			params.put("firstname", request.getParameter("firstname"));
			params.put("lastname", request.getParameter("lastname"));
			params.put("email", request.getParameter("email"));
			params.put("phone", request.getParameter("phone"));
			params.put("objectId", request.getParameter("sEmail"));
			String result = "";
			try {
				result = ParseCloud.callFunction("updateAdminInformation", params);

				System.out.println("admin update :" + result);
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			locAdminId = "userUpdated";
		}

		// EgsdController.getDataFromParse(request);
		/*
		 * try { select(request); } catch (ParseException e) { // TODO
		 * Auto-generated catch block e.printStackTrace(); }
		 */

		/*
		 * mav.addObject("userName", request.getParameter("userName"));
		 * mav.addObject("user", request.getParameter("user"));
		 * 
		 * if (request.getParameter("userName").equals("IT Admin"))
		 * mav.setViewName("ITAdmin");
		 * 
		 * if (request.getParameter("userName").equals("Super Admin"))
		 * mav.setViewName("SuperAdmin");
		 * 
		 * if (request.getParameter("userName").equals("CS Admin"))
		 * mav.setViewName("CSAdmin"); return mav;
		 */

		return locAdminId;

	}
	
	
	@RequestMapping(value = "/updateHotelAdmin", method = RequestMethod.POST)
	 public @ResponseBody String updateHotelAdmin(HttpServletRequest request) {
	  
	  String status = "success";

	  ParseObject parseObjectForLocation = ParseObject.createWithoutData("Location", request.getParameter("hotelId"));
	  
	  parseObjectForLocation.put("GroupId", request.getParameter("adminId"));
	  
	  
	  try {
		parseObjectForLocation.save();
	} catch (ParseException e) {
		status  = "error";
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	  
	  return status;

	 }
	
	
	@RequestMapping(value = "/getAdminDetails", method = RequestMethod.POST)
	 public @ResponseBody List getAdminDetails(HttpServletRequest request) {
	  ParseQuery<ParseObject> queryForLocationAdminWasEmpty = ParseQuery.getQuery("_User");
	  System.out.println(request.getParameter("user"));
	  queryForLocationAdminWasEmpty.orderByAscending("username");
	  queryForLocationAdminWasEmpty.whereEqualTo("username", request.getParameter("user"));
	  

	  List<ParseObject> listOfEmptyAdmins = null;

	  try {

	   listOfEmptyAdmins = queryForLocationAdminWasEmpty.find();

	  } catch (ParseException e2) {
	   // TODO Auto-generated catch block
	   e2.printStackTrace();
	  }
	  List<EgsdUserObjects> listOfUserObjects = new ArrayList<EgsdUserObjects>(100);

	  try {
	   Iterator<ParseObject> iteratorForEmptyAdmins = listOfEmptyAdmins.listIterator();

	   while (iteratorForEmptyAdmins.hasNext()) {

	    ParseObject parseObjectHavingEmptyAdmins = iteratorForEmptyAdmins.next();

	    listOfUserObjects.add(new EgsdUserObjects(parseObjectHavingEmptyAdmins.getObjectId(),
	      parseObjectHavingEmptyAdmins.getString("username"), null,
	      parseObjectHavingEmptyAdmins.getString("email"), parseObjectHavingEmptyAdmins.getString("user"),
	      parseObjectHavingEmptyAdmins.getString("locationId"),
	      parseObjectHavingEmptyAdmins.getString("firstname"),
	      parseObjectHavingEmptyAdmins.getString("lastname"),
	      parseObjectHavingEmptyAdmins.getString("phone")));

	   }

	  } catch (NullPointerException npe) {

	   listOfUserObjects
	     .add(new EgsdUserObjects(null,null, null, null, null, null, null, null,null));

	  }
	  
	  return listOfUserObjects;

	 }
	
	@RequestMapping(value = "/updateAdminUser", method = RequestMethod.POST)
	  public @ResponseBody String editProfile(HttpServletRequest request) {
	  
	  String locAdminId="";
	  
	  System.out.println(request.getParameter("editUsername"));
	  System.out.println(request.getParameter("editFirstname"));
	  System.out.println(request.getParameter("editLastname"));
	  System.out.println(request.getParameter("editEmail"));
	  System.out.println(request.getParameter("oldEmail"));
	  
	  //ParseQuery<ParseObject> queryForLocationAdmin = ParseQuery.getQuery("_User");

	  HashMap<String, String> params = new HashMap<String, String>();
	     params.put("username", request.getParameter("username"));
	     params.put("firstname", request.getParameter("firstname"));
	     params.put("lastname", request.getParameter("lastname"));
	     params.put("email", request.getParameter("email"));
	     params.put("phone", request.getParameter("phone"));	     
	     params.put("objectId", request.getParameter("sEmail"));
	     String result = "";

	  try {
	      result = ParseCloud.callFunction("updateAdminInformation", params);

	      System.out.println("admin update :" + result);
	     } catch (ParseException e) {
	      // TODO Auto-generated catch block
	      e.printStackTrace();
	     }
	  
	  
	  locAdminId = "userUpdated";
	  
	  
	  return locAdminId;
	  }

	@RequestMapping(value = "/registerCSAdmin", method = RequestMethod.POST)
	public @ResponseBody String registerCSAdmin(HttpServletRequest request) {

		System.out.println(request.getParameter("user"));
		System.out.println(request.getParameter("userName"));
		System.out.println(request.getParameter("locId"));

		ParseQuery<ParseObject> queryForLocationAdmin = ParseQuery.getQuery("_User");
		queryForLocationAdmin.whereEqualTo("username", request.getParameter("username"));
		String locAdminId = "";
		if (request.getParameter("sEmail") == "" || request.getParameter("sEmail") == null) {
			List<ParseObject> listOfEmptyAdmins = null;
			try {
				listOfEmptyAdmins = queryForLocationAdmin.find();

			} catch (NullPointerException e) {
				// TODO: handle exception
				System.out.println(e);
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			if (listOfEmptyAdmins == null) {
				ParseQuery<ParseObject> queryForEmail = ParseQuery.getQuery("_User");
				queryForEmail.whereEqualTo("email", request.getParameter("email"));
				List<ParseObject> listOfEmptyEmail = null;
				try {
					listOfEmptyEmail = queryForEmail.find();

				} catch (NullPointerException e) {
					// TODO: handle exception
					System.out.println(e);
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

				if (listOfEmptyEmail == null) {
					String password = UUID.randomUUID().toString().replaceAll("-","");
					password.trim();
					password = password.substring(0, 10);
					HashMap<String, String> params = new HashMap<String, String>();
					params.put("username", request.getParameter("username"));
					params.put("firstname", request.getParameter("firstname"));
					params.put("lastname", request.getParameter("lastname"));
					params.put("password", password);
					params.put("email", request.getParameter("email"));
					params.put("phone", request.getParameter("phone"));
					params.put("user", "CS Admin");
					params.put("locationId", "");

					String result = null;
					try {
						result = ParseCloud.callFunction("signUpForLocationAdmin", params);
						SendEmail email = new SendEmail();
						String res = email.sendEmail(request.getParameter("firstname"), request.getParameter("email"),
								request.getParameter("username"), password, "CS Admin");
						System.out.println(res);
					} catch (ParseException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				} else {
					locAdminId = "emailExisted";
				}

			} else {
				locAdminId = "userExisted";
			}
		} else {
			HashMap<String, String> params = new HashMap<String, String>();
			params.put("username", request.getParameter("username"));
			params.put("firstname", request.getParameter("firstname"));
			params.put("lastname", request.getParameter("lastname"));
			params.put("email", request.getParameter("email"));
			params.put("phone", request.getParameter("phone"));
			params.put("objectId", request.getParameter("sEmail"));
			String result = "";
			try {
				result = ParseCloud.callFunction("updateAdminInformation", params);

				System.out.println("admin update :" + result);
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			locAdminId = "userUpdated";
		}

		// EgsdController.getDataFromParse(request);
		/*
		 * try { select(request); } catch (ParseException e) { // TODO
		 * Auto-generated catch block e.printStackTrace(); }
		 */

		return locAdminId;

		/*
		 * mav.addObject("userName", request.getParameter("userName"));
		 * mav.addObject("user", request.getParameter("user"));
		 * 
		 * if (request.getParameter("userName").equals("Super Admin"))
		 * mav.setViewName("SuperAdmin");
		 * 
		 * if (request.getParameter("userName").equals("CS Admin"))
		 * mav.setViewName("CSAdmin"); return mav;
		 */
	}

	@RequestMapping(value = "/verifyHotel", method = RequestMethod.POST)
	public @ResponseBody String verifyHotel(HttpServletRequest request) {
		String result = "";
		String name = request.getParameter("hotelName");
		System.out.println(name);

		ParseQuery<ParseObject> queryForHotels = ParseQuery.getQuery("Location");
		queryForHotels.whereEqualTo("Name", name);

		List<ParseObject> listOfLocationsFromParse = null;

		try {
			listOfLocationsFromParse = queryForHotels.find();

		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if (listOfLocationsFromParse == null) {
			result = "noduplicate";
		} else {
			result = "duplicate";
		}

		return result;

	}

	@RequestMapping(value = "/verifyTemplate", method = RequestMethod.POST)
	public @ResponseBody String verifyTemplate(HttpServletRequest request) {
		String result = "";
		String name = request.getParameter("templateName");
		System.out.println(name);

		ParseQuery<ParseObject> queryForTemplates = ParseQuery.getQuery("Template");
		queryForTemplates.whereEqualTo("Name", name);

		List<ParseObject> listOfLocationsFromParse = null;

		try {
			listOfLocationsFromParse = queryForTemplates.find();

		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if (listOfLocationsFromParse == null) {
			result = "noduplicate";
		} else {
			result = "duplicate";
		}
		System.out.println(result);
		return result;

	}

	@RequestMapping(value = "/verifyGroup", method = RequestMethod.POST)
	public @ResponseBody String verifyGroup(HttpServletRequest request) {
		String result = "";
		String name = request.getParameter("groupName");
		System.out.println(name);

		ParseQuery<ParseObject> queryForGroups = ParseQuery.getQuery("Template");
		queryForGroups.whereEqualTo("type", "group");
		queryForGroups.whereEqualTo("Name", name);

		List<ParseObject> listOfLocationsFromParse = null;

		try {
			listOfLocationsFromParse = queryForGroups.find();

		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if (listOfLocationsFromParse == null) {
			result = "noduplicate";
		} else {
			result = "duplicate";
		}
		System.out.println(result);
		return result;

	}

	@RequestMapping(value = "/registerLocationAdmin", method = RequestMethod.POST)
	public @ResponseBody String registerLocationAdmin(HttpServletRequest request) {

		String locAdminId = "";
		System.out.println("Fields dat got from Form");
		System.out.println(request.getParameter("user"));
		System.out.println(request.getParameter("userName"));

		ParseQuery<ParseObject> queryForLocationAdmin = ParseQuery.getQuery("_User");
		queryForLocationAdmin.whereEqualTo("username", request.getParameter("username"));
		if (request.getParameter("sEmail") == "" || request.getParameter("sEmail") == null) {
			List<ParseObject> listOfEmptyAdmins = null;
			try {
				listOfEmptyAdmins = queryForLocationAdmin.find();

			} catch (NullPointerException e) {
				// TODO: handle exception
				System.out.println(e);
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			if (listOfEmptyAdmins == null) {
				ParseQuery<ParseObject> queryForEmail = ParseQuery.getQuery("_User");
				queryForEmail.whereEqualTo("email", request.getParameter("email"));
				List<ParseObject> listOfEmptyEmail = null;
				try {
					listOfEmptyEmail = queryForEmail.find();

				} catch (NullPointerException e) {
					// TODO: handle exception
					System.out.println(e);
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

				if (listOfEmptyEmail == null) {
					String password = UUID.randomUUID().toString().replaceAll("-","");
					password.trim();
					password = password.substring(0, 10);
					ParseObject locationObject = new ParseObject("_User");
					locationObject.put("username", request.getParameter("username"));
					locationObject.put("firstname", request.getParameter("firstname"));
					locationObject.put("lastname", request.getParameter("lastname"));
					locationObject.put("password", password);
					locationObject.put("Status", true);
					locationObject.put("email", request.getParameter("email"));
					locationObject.put("phone", request.getParameter("phone"));
					locationObject.put("user", "Location Admin");
					locationObject.put("locationId", "empty");

					try {
						locationObject.save();
						SendEmail email = new SendEmail();
						String res = email.sendEmail(request.getParameter("firstname"), request.getParameter("email"),
								request.getParameter("username"), password, "Location Admin");
						System.out.println(res);
						locAdminId = locationObject.getObjectId();
						System.out.println(locAdminId);

					} catch (ParseException e1) {
						// TODO Auto-generated catch block
						e1.printStackTrace();
					}
				} else {
					locAdminId = "emailExisted";
				}

			} else {
				locAdminId = "userExisted";
			}
		} else {
			HashMap<String, String> params = new HashMap<String, String>();
			params.put("username", request.getParameter("username"));
			params.put("firstname", request.getParameter("firstname"));
			params.put("lastname", request.getParameter("lastname"));
			params.put("email", request.getParameter("email"));
			params.put("phone", request.getParameter("phone"));
			params.put("objectId", request.getParameter("sEmail"));
			String result = "";
			try {
				result = ParseCloud.callFunction("updateAdminInformation", params);

				System.out.println("admin update :" + result);
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			locAdminId = "userUpdated";
		}

		/*
		 * HashMap<String, String> params = new HashMap<String, String>();
		 * params.put("username", request.getParameter("username"));
		 * params.put("firstname", request.getParameter("firstname"));
		 * params.put("lastname", request.getParameter("lastname"));
		 * params.put("password", "locationadmin"); params.put("email",
		 * request.getParameter("email")); params.put("user", "Location Admin");
		 * params.put("locationId","empty" );
		 * 
		 * 
		 * String result=null; try { result =
		 * ParseCloud.callFunction("signUpForLocationAdmin", params); SendEmail
		 * email = new SendEmail(); String res =
		 * email.sendEmail(request.getParameter("email"),
		 * request.getParameter("username"), "locationadmin", "Location Admin");
		 * System.out.println(res); } catch (ParseException e) { // TODO
		 * Auto-generated catch block e.printStackTrace(); }
		 */

		// EgsdController.getDataFromParse(request);

		// adminLoad(request);

		/*
		 * try { select(request); } catch (ParseException e) { // TODO
		 * Auto-generated catch block e.printStackTrace(); }
		 */

		return locAdminId;

		/*
		 * if (request.getParameter("userName").equals("Super Admin"))
		 * mav.setViewName("SuperAdmin");
		 * 
		 * 
		 * if (request.getParameter("userName").equals("CS Admin"))
		 * mav.setViewName("CSAdmin");
		 * 
		 * mav.addObject("userName", request.getParameter("userName"));
		 * mav.addObject("user", request.getParameter("user"));
		 * 
		 * 
		 * 
		 * mav.setViewName("RegisterLocationAdmin");
		 * mav.addObject("user",request.getParameter("user") );
		 * mav.addObject("userName",request.getParameter("userName") );
		 * 
		 * return mav;
		 */
	}

	@RequestMapping(value = "/newedit", method = RequestMethod.POST)
	public ModelAndView demo(HttpServletRequest request) {

		System.out.println("Entered into Add Directories");

		System.out.println("objectId:" + request.getParameter("objectId"));
		System.out.println("directoryId:" + request.getParameter("directoryId"));
		System.out.println("userName:" + request.getParameter("userName"));
		System.out.println("styleId:" + request.getParameter("styleId"));
		System.out.println("phones:" + request.getParameter("phones"));
		System.out.println("---------------------------------------------");

		System.out.println("Displaying Title");
		System.out.println("title:" + request.getParameter("title"));
		System.out.println("titleColor:" + request.getParameter("titleColor"));
		System.out.println("titleFont:" + request.getParameter("titleFont"));
		System.out.println("---------------------------------------------");
		System.out.println("Displaying Caption");
		System.out.println("caption:" + request.getParameter("caption"));
		System.out.println("captionColor:" + request.getParameter("captionColor"));
		System.out.println("captionFont:" + request.getParameter("captionFont"));
		System.out.println("---------------------------------------------");

		System.out.println("Displaying Timings");
		System.out.println("timings:" + request.getParameter("timings"));
		System.out.println("timingsColor:" + request.getParameter("timingsColor"));
		System.out.println("timingsFont:" + request.getParameter("timingsFont"));
		System.out.println("---------------------------------------------");

		System.out.println("Displaying Website");
		System.out.println("website:" + request.getParameter("website"));
		System.out.println("websiteColor:" + request.getParameter("websiteColor"));
		System.out.println("websiteFont:" + request.getParameter("websiteFont"));
		System.out.println("---------------------------------------------");

		System.out.println("Displaying Email");
		System.out.println("email:" + request.getParameter("email"));
		System.out.println("emailColor:" + request.getParameter("emailColor"));
		System.out.println("emailFont:" + request.getParameter("emailFont"));
		System.out.println("---------------------------------------------");

		System.out.println("description:" + request.getParameter("description"));
		System.out.println("descriptionFont:" + request.getParameter("descriptionFont"));
		System.out.println("descriptionColor:" + request.getParameter("descriptionColor"));
		System.out.println("---------------------------------------------");

		System.out.println("phonesFont:" + request.getParameter("phonesFont"));
		System.out.println("phonesColor:" + request.getParameter("phonesColor"));
		System.out.println("phonesType:" + request.getParameter("type"));
		System.out.println("phonesext:" + request.getParameter("ext"));

		System.out.println("---------------------------------------------");

		System.out.println("priceFont:" + request.getParameter("priceFont"));
		System.out.println("priceColor:" + request.getParameter("priceColor"));
		System.out.println("---------------------------------------------");

		String values[] = request.getParameterValues("menuValues");

		return new ModelAndView("Sample");
	}

	@RequestMapping(value = "/logout")
	public synchronized ModelAndView logout() throws ParseException {

		System.out.println("b4 logout");

		ParseUser ps = new ParseUser();
		ps.logout();
		System.out.println("aftr logout");
		return new ModelAndView("Error");
	}

	@RequestMapping(value = "/menu/{objId}")
	public synchronized ModelAndView menu(HttpServletRequest req) throws ParseException {

		System.out.println("b4 insert");

		System.out.println("aftr insert");
		return new ModelAndView("Sample");
	}

	@RequestMapping(value = "/forgotPassword", method = RequestMethod.POST)
	public synchronized ModelAndView forgotPassword(HttpServletRequest req) throws ParseException {

		// ModelAndView mav=new ModelAndView();

		ParseQuery<ParseObject> queryForEmail = ParseQuery.getQuery("_User");
		// queryForEmail.whereEqualTo("email",req.getParameter("email"));
		List<ParseObject> listOfEmails = queryForEmail.find();

		Iterator<ParseObject> listIterator = listOfEmails.listIterator();
		while (listIterator.hasNext()) {
			ParseObject po = listIterator.next();
			if (po.getString("email") != null) {
				if (po.getString("email").equals(req.getParameter("email"))) {
					ParseUser.requestPasswordReset(req.getParameter("email"));
					return new ModelAndView("login", "mailId", req.getParameter("email"));
				}
			}
		}

		System.out.println(req.getParameter("email"));
		System.out.println("aftr insert");
		return new ModelAndView("WrongPassword", "mailId", req.getParameter("email"));
	}

	@RequestMapping(value = "/addTemplateg", method = RequestMethod.POST)
	public ModelAndView createTemplateg(HttpServletRequest request) {

		System.out.println(request.getParameter("templateName"));
		System.out.println(request.getParameter("user"));
		System.out.println(request.getParameter("userName"));
		System.out.println(request.getParameter("templateId"));

		return null;
	}

	@RequestMapping(value = "/addTemplate", method = RequestMethod.POST)
	public ModelAndView createTemplate(HttpServletRequest request) throws ParseException {

		System.out.println(request.getParameter("templateName"));
		System.out.println(request.getParameter("user"));
		System.out.println(request.getParameter("userName"));
		System.out.println(request.getParameter("templateId"));
		
		String templateCaption = "";
		String templateDesc = "";
		String templateFooterText = "";
		String style = "";
		String style1 = "";
		ParseFile templateLogo = null;
		ParseFile templateImage = null;
		ParseFile templateFooter = null;
		
		ParseQuery<ParseObject> queryForGroupName = ParseQuery.getQuery("Template");
		queryForGroupName.orderByAscending("Name");

		queryForGroupName.whereEqualTo("objectId", request.getParameter("templateId"));

		List<ParseObject> listOfGroupName = null;
		ParseObject styleObject1 = new ParseObject("Style");	
		ParseObject templateObjects = null;
		try {
			listOfGroupName = queryForGroupName.find();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		try {
			Iterator<ParseObject> iteratorForGroupObjects = listOfGroupName.listIterator();
			List<EgsdTemplateObjects> listOfEgsdGroupObjects = new ArrayList<EgsdTemplateObjects>(100);

			while (iteratorForGroupObjects.hasNext()) {

				templateObjects = iteratorForGroupObjects.next();
				
				System.out.println(templateObjects.getString("hotelCaption"));
				System.out.println(templateObjects.getString("description"));
				System.out.println(templateObjects.getString("footerText"));
				
				if (templateObjects.getString("hotelCaption") != null) {
					templateCaption = templateObjects.getString("hotelCaption");
				} else {
					templateCaption = "";
				}
				
				if (templateObjects.getString("description") != null) {
					templateDesc = templateObjects.getString("description");
				} else {
					templateDesc = "";
				}
				
				if (templateObjects.getString("footerText") != null) {
					templateFooterText = templateObjects.getString("footerText");
				} else {
					templateFooterText = "";
				}
				
				if (templateObjects.getParseFile("templateLogo") != null) {
					templateLogo = templateObjects.getParseFile("templateLogo");
				}
				
				if (templateObjects.getParseFile("templateImage") != null) {
					templateImage = templateObjects.getParseFile("templateImage");
				}
				
				if (templateObjects.getParseFile("templateFooter") != null) {
					templateFooter = templateObjects.getParseFile("templateFooter");
				} 
				
				
				ParseObject StyleIdPO = templateObjects.getParseObject("StyleId");
				
				if (templateObjects.getParseObject("StyleId") != null){
					style = StyleIdPO.getObjectId();
				}
				else
				{
					style = "";
				}
				
			}

		} catch (NullPointerException npe) {
			
		}
		
		
		if(style!=null&&!style.equals("")){
			ParseQuery<ParseObject> styleIdQuery = ParseQuery.getQuery("Style");
			styleIdQuery.whereEqualTo("objectId", style);
			List<ParseObject> StyleResults = new ArrayList<ParseObject>();
			
			try {
				StyleResults = styleIdQuery.find();
			} catch (ParseException ee) {
				// TODO Auto-generated catch block
				ee.printStackTrace();
			}
			try {
				Iterator<ParseObject> StyleList = StyleResults.listIterator();
				ParseObject styleObject = null;
				ParseObject pp = null;
				while (StyleList.hasNext()) {
					pp = StyleList.next();
								
								
					
					if(pp.getString("hotelTitleColor")!=null&&!pp.getString("hotelTitleColor").equals("")){
						styleObject1.put("hotelTitleColor", pp.getString("hotelTitleColor"));
						 }
					 if(pp.getString("hotelTitleFont")!=null&&!pp.getString("hotelTitleFont").equals("")){
						 styleObject1.put("hotelTitleFont", pp.getString("hotelTitleFont"));
				     }
				     if(pp.getString("hotelTitleFontFamily")!=null&&!pp.getString("hotelTitleFontFamily").equals("")){
				    	 styleObject1.put("hotelTitleFontFamily", pp.getString("hotelTitleFontFamily"));
				     }
				     if(pp.getString("hotelCaptionColor")!=null&&!pp.getString("hotelCaptionColor").equals("")){
				    	 styleObject1.put("hotelCaptionColor", pp.getString("hotelCaptionColor"));
						 }
					 if(pp.getString("hotelCaptionFont")!=null&&!pp.getString("hotelCaptionFont").equals("")){
						 styleObject1.put("hotelCaptionFont", pp.getString("hotelCaptionFont"));
				     }
				     if(pp.getString("hotelCaptionFontFamily")!=null&&!pp.getString("hotelCaptionFontFamily").equals("")){
				    	 styleObject1.put("hotelCaptionFontFamily", pp.getString("hotelCaptionFontFamily"));
				     }
				     
				     if(pp.getString("LocationAddressFont")!=null&&!pp.getString("LocationAddressFont").equals("")){
				    	 styleObject1.put("LocationAddressFont", pp.getString("LocationAddressFont"));
						 }
					 if(pp.getString("LocationAddressFontColor")!=null&&!pp.getString("LocationAddressFontColor").equals("")){
						 styleObject1.put("LocationAddressFontColor", pp.getString("LocationAddressFontColor"));
				     }
				     if(pp.getString("LocationAddressFontFamily")!=null&&!pp.getString("LocationAddressFontFamily").equals("")){
				    	 styleObject1.put("LocationAddressFontFamily", pp.getString("LocationAddressFontFamily"));
				     }     
				     
					
					 if(pp.getString("LocationBackground")!=null&&!pp.getString("LocationBackground").equals("")){
						 styleObject1.put("LocationBackground", pp.getString("LocationBackground"));
						 }
					 if(pp.getString("BrandButtonColor")!=null&&!pp.getString("BrandButtonColor").equals("")){
						 styleObject1.put("BrandButtonColor", pp.getString("BrandButtonColor"));
				     }
				     if(pp.getString("BrandFontColor")!=null&&!pp.getString("BrandFontColor").equals("")){
				    	 styleObject1.put("BrandFontColor", pp.getString("BrandFontColor"));
				     }
				     if(pp.getString("BrandFontFamily")!=null&&!pp.getString("BrandFontFamily").equals("")){
				    	 styleObject1.put("BrandFontFamily", pp.getString("BrandFontFamily"));
				     }
						 
						 if(pp.getString("LocationFooterBackground")!=null&&!pp.getString("LocationFooterBackground").equals("")){
							 styleObject1.put("LocationFooterBackground", pp.getString("LocationFooterBackground"));
						 }
						 if(pp.getString("FooterTextColor")!=null&&!pp.getString("FooterTextColor").equals("")){
							 styleObject1.put("FooterTextColor", pp.getString("FooterTextColor"));
						 }
						 if(pp.getString("footerFont")!=null){
							 styleObject1.put("footerFont", pp.getString("footerFont"));
						 }
						 if(pp.getString("footerCaptionFamily")!=null){
							 styleObject1.put("footerCaptionFamily", pp.getString("footerCaptionFamily"));
						 }
						 
						 try{
							 styleObject1.save();	
							 style1=styleObject1.getObjectId();
						 }
						 catch(Exception ee){
							 style1 = "";
							 ee.printStackTrace();
						 }
				}
				
			}
			catch(Exception estyle){
				estyle.printStackTrace();
			}
			}
		
		

		ParseObject templateObject = new ParseObject("Template");

		templateObject.put("Name", request.getParameter("templateName"));
		templateObject.put("description", templateDesc);
		templateObject.put("hotelCaption", templateCaption);
		templateObject.put("footerText", templateFooterText);
		
		templateObject.put("Customized", true);
		
		if(style != "")			
		templateObject.put("StyleId", styleObject1);
		
		try {
			templateObject.save();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		templateObject.put("LocationId", templateObject.getObjectId());
		
		
		if (templateLogo != null)
		{
			byte[] taxi = null;
			
			
			try {
				taxi = templateLogo.getData();
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			templateLogo = new ParseFile("logo.jpg", taxi);
			try {
				templateLogo.save();
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			templateObject.put("templateLogo", templateLogo);
		}
		
		if (templateImage != null)
	{
		byte[] taxi = null;
		
		
		try {
			taxi = templateImage.getData();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		templateImage = new ParseFile("logo.jpg", taxi);
		try {
			templateImage.save();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		templateObject.put("templateImage", templateImage);
	}
	
	if (templateFooter != null)
	{
		byte[] taxi = null;
		
		
		try {
			taxi = templateFooter.getData();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		templateFooter = new ParseFile("logo.jpg", taxi);
		try {
			templateFooter.save();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		templateObject.put("templateFooter", templateFooter);
	}
		
		

		try {
			templateObject.save();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		ParseQuery<ParseObject> queryDefaultDirectoryItemObjects = ParseQuery.getQuery("DirectoryItem");
		queryDefaultDirectoryItemObjects.whereEqualTo("DirectoryID", request.getParameter("templateId"));

		List<ParseObject> listOfDefaultDirectoryItems = null;

		try {
			listOfDefaultDirectoryItems = queryDefaultDirectoryItemObjects.find();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		try {

			Iterator<ParseObject> iteratorForDefaultDirectoryItems = listOfDefaultDirectoryItems.listIterator();

			while (iteratorForDefaultDirectoryItems.hasNext()) {

				ParseObject parseObjectOfParentDirectoryItem = iteratorForDefaultDirectoryItems.next();

				System.out.println(parseObjectOfParentDirectoryItem.getString("Title"));
				System.out.println(parseObjectOfParentDirectoryItem.getString("Caption"));
				System.out.println(parseObjectOfParentDirectoryItem.getString("Description"));
				System.out.println(parseObjectOfParentDirectoryItem.getString("Email"));
				System.out.println(parseObjectOfParentDirectoryItem.getInt("CustomizedOrder"));

				ParseObject directoryItemObject = new ParseObject("DirectoryItem");

				if (parseObjectOfParentDirectoryItem.getString("Title") != null)
					directoryItemObject.put("Title", parseObjectOfParentDirectoryItem.getString("Title"));
				if (parseObjectOfParentDirectoryItem.getString("Caption") != null)
					directoryItemObject.put("Caption", parseObjectOfParentDirectoryItem.getString("Caption"));
				if (parseObjectOfParentDirectoryItem.getString("Description") != null)
					directoryItemObject.put("Description", parseObjectOfParentDirectoryItem.getString("Description"));
				
				directoryItemObject.put("CustomizedOrder", parseObjectOfParentDirectoryItem.getInt("CustomizedOrder"));
				
				if (parseObjectOfParentDirectoryItem.getString("Timings") != null)
					directoryItemObject.put("Timings", parseObjectOfParentDirectoryItem.getString("Timings"));
				
				
				ParseFile pf = null;
				if (parseObjectOfParentDirectoryItem.getParseFile("Picture") != null)
				{
					byte[] taxi = null;
					
					
					try {
						taxi = parseObjectOfParentDirectoryItem.getParseFile("Picture").getData();
					} catch (ParseException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					
					pf = new ParseFile("Picture.png", taxi);
					try {
						pf.save();
					} catch (ParseException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					directoryItemObject.put("Picture", pf);
				}

				directoryItemObject.put("LocationId", templateObject.getObjectId());
				directoryItemObject.put("DirectoryID", templateObject.getObjectId());

				try {
					directoryItemObject.save();
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

				// adding styles to chain directory Items

				ParseQuery<ParseObject> queryForStyleObjects = ParseQuery.getQuery("Style");
				queryForStyleObjects.whereEqualTo("objectId",
						parseObjectOfParentDirectoryItem.getParseObject("StyleId").getObjectId());

				List<ParseObject> listOfDirectoryItemStyleObject = null;

				try {
					listOfDirectoryItemStyleObject = queryForStyleObjects.find();
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

				Iterator<ParseObject> iteratorForDirectoryItemStyleObject = listOfDirectoryItemStyleObject
						.listIterator();

				ParseObject directoryItemStyleObject = iteratorForDirectoryItemStyleObject.next();

				ParseObject directoryItemChainStyleObj = new ParseObject("Style");

				if (directoryItemStyleObject.getString("TitleFont") != null)
					directoryItemChainStyleObj.put("TitleFont", directoryItemStyleObject.getString("TitleFont"));

				if (directoryItemStyleObject.getString("TitleColor") != null)
					directoryItemChainStyleObj.put("TitleColor", directoryItemStyleObject.getString("TitleColor"));

				if (directoryItemStyleObject.getString("TitleFamily") != null)
					directoryItemChainStyleObj.put("TitleFamily", directoryItemStyleObject.getString("TitleFamily"));

				if (directoryItemStyleObject.getString("CaptionFont") != null)
					directoryItemChainStyleObj.put("CaptionFont", directoryItemStyleObject.getString("CaptionFont"));

				if (directoryItemStyleObject.getString("CaptionColor") != null)
					directoryItemChainStyleObj.put("CaptionColor", directoryItemStyleObject.getString("CaptionColor"));

				if (directoryItemStyleObject.getString("CaptionFamily") != null)
					directoryItemChainStyleObj.put("CaptionFamily",
							directoryItemStyleObject.getString("CaptionFamily"));

				if (directoryItemStyleObject.getString("DescriptionFont") != null)
					directoryItemChainStyleObj.put("DescriptionFont",
							directoryItemStyleObject.getString("DescriptionFont"));

				if (directoryItemStyleObject.getString("DescriptionColor") != null)
					directoryItemChainStyleObj.put("DescriptionColor",
							directoryItemStyleObject.getString("DescriptionColor"));

				if (directoryItemStyleObject.getString("DescriptionFamily") != null)
					directoryItemChainStyleObj.put("DescriptionFamily",
							directoryItemStyleObject.getString("DescriptionFamily"));

				if (directoryItemStyleObject.getString("TimingsFont") != null)
					directoryItemChainStyleObj.put("TimingsFont", directoryItemStyleObject.getString("TimingsFont"));

				if (directoryItemStyleObject.getString("TimingsColor") != null)
					directoryItemChainStyleObj.put("TimingsColor", directoryItemStyleObject.getString("TimingsColor"));

				if (directoryItemStyleObject.getString("TimingsFamily") != null)
					directoryItemChainStyleObj.put("TimingsFamily",
							directoryItemStyleObject.getString("TimingsFamily"));
				
				if (directoryItemStyleObject.getString("PriceFont") != null)
					directoryItemChainStyleObj.put("PriceFont",
							directoryItemStyleObject.getString("PriceFont"));
				
				if (directoryItemStyleObject.getString("PriceColor") != null)
					directoryItemChainStyleObj.put("PriceColor",
							directoryItemStyleObject.getString("PriceColor"));
				
				if (directoryItemStyleObject.getString("PriceFamily") != null)
					directoryItemChainStyleObj.put("PriceFamily",
							directoryItemStyleObject.getString("PriceFamily"));

				directoryItemChainStyleObj.put("LocationId", templateObject.getObjectId());

				try {
					directoryItemChainStyleObj.save();
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

				directoryItemObject.put("StyleId", directoryItemChainStyleObj);

				try {
					directoryItemObject.save();
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

				// adding phone Items

				ParseQuery<ParseObject> queryForPhoneObjects = ParseQuery.getQuery("Phones");
				queryForPhoneObjects.whereEqualTo("PhoneId", parseObjectOfParentDirectoryItem.getObjectId());

				List<ParseObject> listOfPhoneObjects = null;

				try {
					listOfPhoneObjects = queryForPhoneObjects.find();
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

				try {

					Iterator<ParseObject> iteratorForPhoneObjects = listOfPhoneObjects.listIterator();

					while (iteratorForPhoneObjects.hasNext()) {

						ParseObject phoneObject = iteratorForPhoneObjects.next();

						ParseObject newPhoneObject = new ParseObject("Phones");

						if (phoneObject.getString("Ext") != null)
							newPhoneObject.put("Ext", phoneObject.getString("Ext"));
						if (phoneObject.getString("Type") != null)
							newPhoneObject.put("Type", phoneObject.getString("Type"));

						newPhoneObject.put("PhoneId", directoryItemObject.getObjectId());
						newPhoneObject.put("LocationId", templateObject.getObjectId());

						try {
							newPhoneObject.save();
						} catch (ParseException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}

					}

				} catch (NullPointerException npe) {
					npe.printStackTrace();
				}

				// adding menu Items

				System.out.println(parseObjectOfParentDirectoryItem.getObjectId());
				  ParseQuery<ParseObject>  queryForMenuObjects=ParseQuery.getQuery("Menu");
				  queryForMenuObjects.whereEqualTo("MenuId", parseObjectOfParentDirectoryItem.getObjectId());
				  
				  List<ParseObject> listOfMenuObjects=null;
				  
				  try { 
					  listOfMenuObjects=queryForMenuObjects.find(); 
				  } 
				  catch(ParseException e) { 
					  // TODO Auto-generated catch block
					  e.printStackTrace(); 
					  }
				  
				  
				  try{
				  
				  Iterator<ParseObject> iteratorForMenuObjects=listOfMenuObjects.listIterator();
				  
				  while(iteratorForMenuObjects.hasNext()){
				  
				  ParseObject menuObject=iteratorForMenuObjects.next();
				  
				  ParseObject newMenuObject=new ParseObject("Menu");
				  
				  if(menuObject.getString("Description")!=null || menuObject.getString("Description")!= "")
				  newMenuObject.put("Description", menuObject.getString("Description"));
				  if(menuObject.getString("Price")!=null || menuObject.getString("Description")!= "")
				  newMenuObject.put("Price", menuObject.getString("Price"));
				  
				  newMenuObject.put("StyleID",directoryItemChainStyleObj);
				  newMenuObject.put("MenuId",directoryItemObject.getObjectId());
				  newMenuObject.put("LocationId",templateObject.getObjectId());
				  
				  try { 
					  newMenuObject.save(); 
					} catch (ParseException e) { 
				  //TODO Auto-generated catch block e.printStackTrace(); 
					  }
				  
				  }
				  
				  
				  }catch(NullPointerException npe){
				  
				  
				  }
				 

				checkChain(parseObjectOfParentDirectoryItem.getObjectId(), directoryItemObject,
						directoryItemObject.getObjectId(), templateObject.getObjectId());

			}

		} catch (NullPointerException npe) {
			npe.printStackTrace();
		}
		
		
		

		request.setAttribute("tempId", templateObject.getObjectId());
		
		viewTemplates(request);	
		
		mav.addObject("userName", request.getParameter("userName"));
		mav.addObject("user", request.getParameter("user"));
			
		
		if (request.getParameter("userName").equals("Super Admin"))
			mav.setViewName("SuperAdminTemplates");

		if (request.getParameter("userName").equals("IT Admin"))
			mav.setViewName("ITAdminTemplates");

		if (request.getParameter("userName").equals("CS Admin"))
			mav.setViewName("CSAdminTemplates");
		
		
		/*if (request.getParameter("locId") != null) {		
			
			request.setAttribute("locId", request.getParameter("locId"));
			
			try {
				select(request);
			} catch (ParseException e) {
				e.printStackTrace();
			}
			mav.addObject("userName", request.getParameter("userName"));
			mav.addObject("user", request.getParameter("user"));
			if (request.getParameter("userName").equals("Location Admin")) {
				mav.setViewName("LocationAdmin");
			}
			if (request.getParameter("userName").equals("CS Admin")) {
				mav.setViewName("CSAdmin");
			}
			if (request.getParameter("userName").equals("Super Admin")) {
				mav.setViewName("SuperAdmin");
			}
			if (request.getParameter("userName").equals("IT Admin")) {
				mav.setViewName("ITAdmin");
			}
		}
		else {				
			
			if (request.getParameter("tempId") != null) {
				
				request.setAttribute("tempId", request.getParameter("tempId"));
				
				viewTemplates(request);	
				
				mav.addObject("userName", request.getParameter("userName"));
				mav.addObject("user", request.getParameter("user"));
					
				
				if (request.getParameter("userName").equals("Super Admin"))
					mav.setViewName("SuperAdminTemplates");
	
				if (request.getParameter("userName").equals("IT Admin"))
					mav.setViewName("ITAdminTemplates");
	
				if (request.getParameter("userName").equals("CS Admin"))
					mav.setViewName("CSAdminTemplates");
	
				
			} else {
				
				adminLoad(request);
				mav.addObject("userName", request.getParameter("userName"));
				mav.addObject("user", request.getParameter("user"));
				if (request.getParameter("userName").equals("CS Admin")) {
					mav.setViewName("CSHotelList");
				}
				if (request.getParameter("userName").equals("Super Admin")) {
					mav.setViewName("SuperHotelList");
				}
				if (request.getParameter("userName").equals("IT Admin")) {
					mav.setViewName("ITHotelList");
				}
	
			}
		}	*/
		return mav;
	}

	@RequestMapping(value = "/addTemplateHotelList1", method = RequestMethod.POST)
	public ModelAndView createTemplateHotelList1(HttpServletRequest request) {

		adminLoad(request);

		mav.addObject("userName", request.getParameter("userName"));
		mav.addObject("user", request.getParameter("user"));

		if (request.getParameter("userName").equals("Location Admin"))
			mav.setViewName("LocationAdmin");

		if (request.getParameter("userName").equals("CS Admin"))
			mav.setViewName("CSAdmin");

		if (request.getParameter("userName").equals("Super Admin"))
			mav.setViewName("HotelList");

		return mav;

	}

	@RequestMapping(value = "/addTemplateHotelList", method = RequestMethod.POST)
	public ModelAndView createTemplateHotelList(HttpServletRequest request) {

		System.out.println(request.getParameter("templateName"));
		System.out.println(request.getParameter("user"));
		System.out.println(request.getParameter("userName"));
		System.out.println(request.getParameter("templateId"));

		ParseObject templateObject = new ParseObject("Template");

		templateObject.put("Name", request.getParameter("templateName"));
		templateObject.put("Customized", true);

		try {
			templateObject.save();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		templateObject.put("LocationId", templateObject.getObjectId());

		try {
			templateObject.save();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		ParseQuery<ParseObject> queryDefaultDirectoryItemObjects = ParseQuery.getQuery("DirectoryItem");
		queryDefaultDirectoryItemObjects.whereEqualTo("DirectoryID", request.getParameter("templateId"));

		List<ParseObject> listOfDefaultDirectoryItems = null;

		try {
			listOfDefaultDirectoryItems = queryDefaultDirectoryItemObjects.find();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		try {

			Iterator<ParseObject> iteratorForDefaultDirectoryItems = listOfDefaultDirectoryItems.listIterator();

			while (iteratorForDefaultDirectoryItems.hasNext()) {

				ParseObject parseObjectOfParentDirectoryItem = iteratorForDefaultDirectoryItems.next();

				System.out.println(parseObjectOfParentDirectoryItem.getString("Title"));

				ParseObject directoryItemObject = new ParseObject("DirectoryItem");

				if (parseObjectOfParentDirectoryItem.getString("Title") != null)
					directoryItemObject.put("Title", parseObjectOfParentDirectoryItem.getString("Title"));
				if (parseObjectOfParentDirectoryItem.getString("Caption") != null)
					directoryItemObject.put("Caption", parseObjectOfParentDirectoryItem.getString("Caption"));
				if (parseObjectOfParentDirectoryItem.getString("Description") != null)
					directoryItemObject.put("Description", parseObjectOfParentDirectoryItem.getString("Description"));
				if (parseObjectOfParentDirectoryItem.getString("Timings") != null)
					directoryItemObject.put("Timings", parseObjectOfParentDirectoryItem.getString("Timings"));
				if (parseObjectOfParentDirectoryItem.getString("Website") != null)
					directoryItemObject.put("Website", parseObjectOfParentDirectoryItem.getString("Website"));
				if (parseObjectOfParentDirectoryItem.getString("Email") != null)
					directoryItemObject.put("Email", parseObjectOfParentDirectoryItem.getString("Email"));

				if (parseObjectOfParentDirectoryItem.getParseObject("Picture") != null)
					directoryItemObject.put("Picture", parseObjectOfParentDirectoryItem.getParseObject("Picture"));

				directoryItemObject.put("LocationId", templateObject.getObjectId());
				directoryItemObject.put("DirectoryID", templateObject.getObjectId());

				try {
					directoryItemObject.save();
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

				// adding styles to chain directory Items

				ParseQuery<ParseObject> queryForStyleObjects = ParseQuery.getQuery("Style");
				queryForStyleObjects.whereEqualTo("objectId",
						parseObjectOfParentDirectoryItem.getParseObject("StyleId").getObjectId());

				List<ParseObject> listOfDirectoryItemStyleObject = null;

				try {
					listOfDirectoryItemStyleObject = queryForStyleObjects.find();
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

				Iterator<ParseObject> iteratorForDirectoryItemStyleObject = listOfDirectoryItemStyleObject
						.listIterator();

				ParseObject directoryItemStyleObject = iteratorForDirectoryItemStyleObject.next();

				ParseObject directoryItemChainStyleObj = new ParseObject("Style");

				if (directoryItemStyleObject.getString("TitleFont") != null)
					directoryItemChainStyleObj.put("TitleFont", directoryItemStyleObject.getString("TitleFont"));

				if (directoryItemStyleObject.getString("TitleColor") != null)
					directoryItemChainStyleObj.put("TitleColor", directoryItemStyleObject.getString("TitleColor"));

				if (directoryItemStyleObject.getString("TitleFamily") != null)
					directoryItemChainStyleObj.put("TitleFamily", directoryItemStyleObject.getString("TitleFamily"));

				if (directoryItemStyleObject.getString("CaptionFont") != null)
					directoryItemChainStyleObj.put("CaptionFont", directoryItemStyleObject.getString("CaptionFont"));

				if (directoryItemStyleObject.getString("CaptionColor") != null)
					directoryItemChainStyleObj.put("CaptionColor", directoryItemStyleObject.getString("CaptionColor"));

				if (directoryItemStyleObject.getString("CaptionFamily") != null)
					directoryItemChainStyleObj.put("CaptionFamily",
							directoryItemStyleObject.getString("CaptionFamily"));

				if (directoryItemStyleObject.getString("DescriptionFont") != null)
					directoryItemChainStyleObj.put("DescriptionFont",
							directoryItemStyleObject.getString("DescriptionFont"));

				if (directoryItemStyleObject.getString("DescriptionColor") != null)
					directoryItemChainStyleObj.put("DescriptionColor",
							directoryItemStyleObject.getString("DescriptionColor"));

				if (directoryItemStyleObject.getString("DescriptionFamily") != null)
					directoryItemChainStyleObj.put("DescriptionFamily",
							directoryItemStyleObject.getString("DescriptionFamily"));

				if (directoryItemStyleObject.getString("PhonesFont") != null)
					directoryItemChainStyleObj.put("PhonesFont", directoryItemStyleObject.getString("PhonesFont"));

				if (directoryItemStyleObject.getString("PhonesColor") != null)
					directoryItemChainStyleObj.put("PhonesColor", directoryItemStyleObject.getString("PhonesColor"));

				if (directoryItemStyleObject.getString("PhonesFamily") != null)
					directoryItemChainStyleObj.put("PhonesFamily", directoryItemStyleObject.getString("PhonesFamily"));

				if (directoryItemStyleObject.getString("TimingsFont") != null)
					directoryItemChainStyleObj.put("TimingsFont", directoryItemStyleObject.getString("TimingsFont"));

				if (directoryItemStyleObject.getString("TimingsColor") != null)
					directoryItemChainStyleObj.put("TimingsColor", directoryItemStyleObject.getString("TimingsColor"));

				if (directoryItemStyleObject.getString("TimingsFamily") != null)
					directoryItemChainStyleObj.put("TimingsFamily",
							directoryItemStyleObject.getString("TimingsFamily"));

				if (directoryItemStyleObject.getString("WebsiteFont") != null)
					directoryItemChainStyleObj.put("WebsiteFont", directoryItemStyleObject.getString("WebsiteFont"));

				if (directoryItemStyleObject.getString("WebsiteColor") != null)
					directoryItemChainStyleObj.put("WebsiteColor", directoryItemStyleObject.getString("WebsiteColor"));

				if (directoryItemStyleObject.getString("WebsiteFamily") != null)
					directoryItemChainStyleObj.put("WebsiteFamily",
							directoryItemStyleObject.getString("WebsiteFamily"));

				if (directoryItemStyleObject.getString("EmailFont") != null)
					directoryItemChainStyleObj.put("EmailFont", directoryItemStyleObject.getString("EmailFont"));

				if (directoryItemStyleObject.getString("EmailColor") != null)
					directoryItemChainStyleObj.put("EmailColor", directoryItemStyleObject.getString("EmailColor"));

				if (directoryItemStyleObject.getString("EmailFamily") != null)
					directoryItemChainStyleObj.put("EmailFamily", directoryItemStyleObject.getString("EmailFamily"));

				directoryItemChainStyleObj.put("LocationId", templateObject.getObjectId());

				try {
					directoryItemChainStyleObj.save();
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

				directoryItemObject.put("StyleId", directoryItemChainStyleObj);

				try {
					directoryItemObject.save();
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

				// adding phone Items

				ParseQuery<ParseObject> queryForPhoneObjects = ParseQuery.getQuery("Phones");
				queryForPhoneObjects.whereEqualTo("PhoneId", parseObjectOfParentDirectoryItem.getObjectId());

				List<ParseObject> listOfPhoneObjects = null;

				try {
					listOfPhoneObjects = queryForPhoneObjects.find();
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

				try {

					Iterator<ParseObject> iteratorForPhoneObjects = listOfPhoneObjects.listIterator();

					while (iteratorForPhoneObjects.hasNext()) {

						ParseObject phoneObject = iteratorForPhoneObjects.next();

						ParseObject newPhoneObject = new ParseObject("Phones");

						if (phoneObject.getString("Ext") != null)
							newPhoneObject.put("Ext", phoneObject.getString("Ext"));
						if (phoneObject.getString("Type") != null)
							newPhoneObject.put("Type", phoneObject.getString("Type"));

						newPhoneObject.put("PhoneId", directoryItemObject.getObjectId());
						newPhoneObject.put("LocationId", templateObject.getObjectId());

						try {
							newPhoneObject.save();
						} catch (ParseException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}

					}

				} catch (NullPointerException npe) {

				}

				checkChain(parseObjectOfParentDirectoryItem.getObjectId(), directoryItemObject,
						directoryItemObject.getObjectId(), templateObject.getObjectId());

			}

		} catch (NullPointerException npe) {

		}

		// getDataFromParse(request);

		// adminLoad(request);

		mav.addObject("userName", request.getParameter("userName"));
		mav.addObject("user", request.getParameter("user"));

		if (request.getParameter("userName").equals("Location Admin"))
			mav.setViewName("LocationAdmin");
		if (request.getParameter("userName").equals("CS Admin"))
			mav.setViewName("HotelList");
		if (request.getParameter("userName").equals("Super Admin"))
			mav.setViewName("HotelList");
		if (request.getParameter("userName").equals("IT Admin"))
			mav.setViewName("HotelList");

		return mav;
	}

	@RequestMapping(value = "/viewTemplates")
	public ModelAndView viewTemplates(HttpServletRequest request) {
		final DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");

		System.out.println("User:" + request.getParameter("user"));
		System.out.println("UserName:" + request.getParameter("userName"));
		System.out.println("Temp Id:" + request.getParameter("tempId"));

		mav.clear();

		

		// list of Templates based on temp Id
		ParseQuery<ParseObject> queryForTemplateObjects = ParseQuery.getQuery("Template");
		if( request.getParameter("tempId") !=null )
		queryForTemplateObjects.whereEqualTo("objectId", request.getParameter("tempId"));
		if( request.getAttribute("tempId") !=null )
		queryForTemplateObjects.whereEqualTo("objectId", request.getAttribute("tempId"));

		List<ParseObject> listOfTemplateObjects = null;

		try {
			listOfTemplateObjects = queryForTemplateObjects.find();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
			
		EgsdTemplateObjects tObjects = new EgsdTemplateObjects();
		
		try {
			Iterator<ParseObject> iteratorForTemplateObjects = listOfTemplateObjects.listIterator();
			List<EgsdTemplateObjects> listOfEgsdTemplateObjects = new ArrayList<EgsdTemplateObjects>();
			
			
			String templateStyleid = "";

			while (iteratorForTemplateObjects.hasNext()) {

				ParseObject templateObjects = iteratorForTemplateObjects.next();
				
				String templateLogo = "No Image To Display";
				if (templateObjects.getParseFile("templateLogo") != null)
					templateLogo = templateObjects.getParseFile("templateLogo").getUrl();
				

				String templateImage = "No Image To Display";
				if (templateObjects.getParseFile("templateImage") != null)
					templateImage = templateObjects.getParseFile("templateImage").getUrl();

				String templateFooter = "No Image To Display";
				if (templateObjects.getParseFile("templateFooter") != null)
					templateFooter = templateObjects.getParseFile("templateFooter").getUrl();
				
				tObjects.setCustomized(templateObjects.getBoolean("Customized"));
				tObjects.setName(templateObjects.getString("Name"));
				tObjects.setObjectId(templateObjects.getObjectId());
				tObjects.setTemplateCaption(templateObjects.getString("hotelCaption"));
				tObjects.setTemplateFooterText(templateObjects.getString("footerText"));
				tObjects.setTemplateDescription(templateObjects.getString("description"));
				tObjects.setTemplateLogo(templateLogo);
				tObjects.setTemplateImage(templateImage);
				tObjects.setTemplateFooter(templateFooter);
				
				/*listOfEgsdTemplateObjects
						.add(new EgsdTemplateObjects(templateObjects.getObjectId(), templateObjects.getString("Name"),
								templateObjects.getObjectId(), templateObjects.getBoolean("Customized")));
				*/
				
				if (templateObjects.getParseObject("StyleId") != null){
					templateStyleid = templateObjects.getParseObject("StyleId").getObjectId();
				}

			}
			
			
			
			
			
			
			if(templateStyleid!=null&&!templateStyleid.equals("")){
				ParseQuery<ParseObject> styleIdQuery = ParseQuery.getQuery("Style");
				styleIdQuery.whereEqualTo("objectId", templateStyleid);
				List<ParseObject> StyleResults = new ArrayList<ParseObject>();
				try {
					StyleResults = styleIdQuery.find();
				} catch (ParseException ee) {
					// TODO Auto-generated catch block
					ee.printStackTrace();
				}
				try {
					Iterator<ParseObject> StyleList = StyleResults.listIterator();
					ParseObject styleObject = null;
					ParseObject pp = null;
					while (StyleList.hasNext()) {
						pp = StyleList.next();
						
						tObjects.setTemplateBrandBackgroundColor(pp.getString("LocationBackground"));
						tObjects.setTemplateBrandButtonColor(pp.getString("BrandButtonColor"));
						tObjects.setTemplateBrandFontColor(pp.getString("BrandFontColor"));
						tObjects.setTemplateBrandFontFamily(pp.getString("BrandFontFamily"));
						
						tObjects.setTemplateFooterFont(pp.getString("footerFont"));
						tObjects.setTemplateFooterFontFamily(pp.getString("footerCaptionFamily"));
						tObjects.setTemplateFooterImageBackgroundColor(pp.getString("LocationFooterBackground"));
						//tObjects.setTemplateFooterText(pp.getString(""));
						tObjects.setTemplateFooterTextColor(pp.getString("FooterTextColor"));
						
						tObjects.setAddressColor(pp.getString("LocationAddressFontColor"));
						tObjects.setAddressFont(pp.getString("LocationAddressFont"));
						tObjects.setAddressFontFamily(pp.getString("LocationAddressFontFamily"));
						
						//tObjects.setTemplateCaption(pp.getString(""));
						tObjects.setTemplateCaptionColor(pp.getString("hotelCaptionColor"));
						tObjects.setTemplateCaptionFont(pp.getString("hotelCaptionFont"));
						tObjects.setTemplateCaptionFontFamily(pp.getString("hotelCaptionFontFamily"));
						
						tObjects.setTemplateTitleColor(pp.getString("hotelTitleColor"));
						tObjects.setTemplateTitleFont(pp.getString("hotelTitleFont"));
						tObjects.setTemplateTitleFamily(pp.getString("hotelTitleFontFamily"));
						
					}
					
				}
				catch(Exception estyle){
					estyle.printStackTrace();
				}
				}
			listOfEgsdTemplateObjects.add(tObjects);

			mav.addObject("listOfEgsdTemplateObjects", listOfEgsdTemplateObjects);
			System.out.println(listOfEgsdTemplateObjects.toString());

		} catch (NullPointerException npe) {

		}

		

		// list of Groups
		Calendar now = Calendar.getInstance();
		System.out.println("start" + dateFormat.format(now.getTime()));
		

		// this is for directory items objects

		ParseQuery<EgsdDirectoryItemParseObject> queryForDirectoryItem = ParseQuery.getQuery("DirectoryItem");
		if (request.getParameter("tempId") != null)
			queryForDirectoryItem.whereEqualTo("LocationId", request.getParameter("tempId"));
		if (request.getAttribute("tempId") != null)
			queryForDirectoryItem.whereEqualTo("LocationId", request.getAttribute("tempId"));

		// queryForDirectoryItem.whereEqualTo("DirectoryID",p.getString("Directories"));
		queryForDirectoryItem.orderByAscending("CustomizedOrder");
			
		
		queryForDirectoryItem.limit(1000);
		List<EgsdDirectoryItemParseObject> directoryItemParseObjectsList = null;
		try {
			directoryItemParseObjectsList = queryForDirectoryItem.find();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		List<EgsdDirectoryItemObjects> directoryItemObjectsList = new ArrayList<EgsdDirectoryItemObjects>(300);
		System.out.println("Directory items are loaded:");
		try {
			Iterator<EgsdDirectoryItemParseObject> iterator = directoryItemParseObjectsList.listIterator();
			System.out.println("objectId" + "---> " + "DirectoryId" + "--->" + "getParentDirectoryId" + "--->"
					+ "getTitle" + "--->" + "getCaption" + "--->" + "getTimings" + "--->" + "getWebsite" + "--->"
					+ "getEmail" + "--->" + "getPhones");
			int count = 1;
			while (iterator.hasNext()) {

				EgsdDirectoryItemParseObject egsd = iterator.next();
				// System.out.println( count++ +" "+ egsd.getObjectId()
				// + "---> " + egsd.getDirectoryId()
				// + "--->" + egsd.getParentDirectoryId()
				// + "--->" + egsd.getTitle()
				// + "--->" + egsd.getCaption()
				// + "--->" + egsd.getTimings()
				// + "--->" + egsd.getWebsite()
				// + "--->" + egsd.getEmail()
				// + "--phoneId->" + egsd.getPhones()
				// + "--->" + egsd.getStyleID() +"<--StyleID ");
				String img = "No Image To Display";
				if (egsd.getParseFile("Picture") != null)
					img = egsd.getParseFile("Picture").getUrl();
				// System.out.print(img);
				String styleId = null;
				ParseObject StyleIdPO = egsd.getParseObject("StyleId");
				if (egsd.getParseObject("StyleId") != null)
					styleId = StyleIdPO.getObjectId();
				// System.out.println(styleId);

				/*
				 * if(StyleIdPO.getObjectId()!=null) System.out.println(
				 * "StyleID AT Directory Items"+StyleIdPO.getObjectId());
				 */

				directoryItemObjectsList.add(new EgsdDirectoryItemObjects(egsd.getObjectId(), egsd.getDirectoryId(),
						egsd.getTitle(), egsd.getCaption(), egsd.getDescription(), egsd.getTimings(), egsd.getWebsite(),
						egsd.getEmail(), egsd.getParentDirectoryId(), img, styleId, egsd.getPhones(),
						egsd.getParentDirectoryId(), egsd.getLocationId(), egsd.getCustomizedOrder()));

			}
		} catch (NullPointerException npe) {

		}
		System.out.println(directoryItemObjectsList.toString());

		System.out.println("before adding dir objs");
		mav.addObject("direcObjList", directoryItemObjectsList);
		mav.addObject("subDirObj", directoryItemObjectsList);
		mav.addObject("subsubDirObj", directoryItemObjectsList);
		mav.addObject("DirObjId", directoryItemObjectsList);
		mav.addObject("DiscriptionObjId", directoryItemObjectsList);
		// adding DirectiryItems for editing values
		mav.addObject("showSubDiscriptionObjId", directoryItemObjectsList);
		mav.addObject("showDiscriptionObjId", directoryItemObjectsList);
		mav.addObject("DiscriptionObjForNavBar", directoryItemObjectsList);
		mav.addObject("subDiscriptionObjForNavBar", directoryItemObjectsList);
		// addind directory Items for Adding DirectoryItems
		mav.addObject("locObjForAddDirectoryItems", directoryItemObjectsList);
		mav.addObject("subDiscriptionObjForAddDirItems", directoryItemObjectsList);
		mav.addObject("showSubDiscriptionObjIdForDelete", directoryItemObjectsList);

		System.out.println("aftr adding dir objs");

		System.out.println("in select b4 Phones");


		// redirecting
		mav.addObject("userName", request.getParameter("userName"));
		mav.addObject("user", request.getParameter("user"));
		mav.addObject("tempId", request.getParameter("tempId"));

		if (request.getParameter("userName").equals("Location Admin"))
			mav.setViewName("LocationList");
		if (request.getParameter("userName").equals("CS Admin"))
			mav.setViewName("CSAdminTemplates");

		if (request.getParameter("userName").equals("Super Admin"))
			mav.setViewName("SuperAdminTemplates");
		if (request.getParameter("userName").equals("IT Admin"))
			mav.setViewName("ITAdminTemplates");

		now = Calendar.getInstance();
		System.out.println("end " + dateFormat.format(now.getTime()));

		return mav;
	}

	@RequestMapping(value = "/viewGroups")
	public ModelAndView viewGroups(HttpServletRequest request) {
		final DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");

		System.out.println("User:" + request.getParameter("user"));
		System.out.println("UserName:" + request.getParameter("userName"));
		System.out.println("Temp Id:" + request.getParameter("tempId"));

		mav.clear();

		

		// list of Templates based on temp Id
		ParseQuery<ParseObject> queryForTemplateObjects = ParseQuery.getQuery("Template");
		if( request.getParameter("tempId") !=null )
		queryForTemplateObjects.whereEqualTo("objectId", request.getParameter("tempId"));
		if( request.getAttribute("tempId") !=null )
		queryForTemplateObjects.whereEqualTo("objectId", request.getAttribute("tempId"));

		List<ParseObject> listOfTemplateObjects = null;

		try {
			listOfTemplateObjects = queryForTemplateObjects.find();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		try {
			Iterator<ParseObject> iteratorForTemplateObjects = listOfTemplateObjects.listIterator();
			List<EgsdTemplateObjects> listOfEgsdTemplateObjects = new ArrayList<EgsdTemplateObjects>();

			while (iteratorForTemplateObjects.hasNext()) {

				ParseObject templateObjects = iteratorForTemplateObjects.next();

				listOfEgsdTemplateObjects
						.add(new EgsdTemplateObjects(templateObjects.getObjectId(), templateObjects.getString("Name"),
								templateObjects.getObjectId(), templateObjects.getBoolean("Customized")));

			}

			mav.addObject("listOfEgsdTemplateObjects", listOfEgsdTemplateObjects);
			System.out.println(listOfEgsdTemplateObjects.toString());

		} catch (NullPointerException npe) {

		}

		

		// list of Groups
		Calendar now = Calendar.getInstance();
		System.out.println("start" + dateFormat.format(now.getTime()));
		

		// this is for directory items objects

		ParseQuery<EgsdDirectoryItemParseObject> queryForDirectoryItem = ParseQuery.getQuery("DirectoryItem");
		if (request.getParameter("tempId") != null)
			queryForDirectoryItem.whereEqualTo("LocationId", request.getParameter("tempId"));
		if (request.getAttribute("tempId") != null)
			queryForDirectoryItem.whereEqualTo("LocationId", request.getAttribute("tempId"));

		// queryForDirectoryItem.whereEqualTo("DirectoryID",p.getString("Directories"));
		queryForDirectoryItem.orderByAscending("Title");
		queryForDirectoryItem.limit(1000);
		List<EgsdDirectoryItemParseObject> directoryItemParseObjectsList = null;
		try {
			directoryItemParseObjectsList = queryForDirectoryItem.find();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		List<EgsdDirectoryItemObjects> directoryItemObjectsList = new ArrayList<EgsdDirectoryItemObjects>(300);
		System.out.println("Directory items are loaded:");
		try {
			Iterator<EgsdDirectoryItemParseObject> iterator = directoryItemParseObjectsList.listIterator();
			System.out.println("objectId" + "---> " + "DirectoryId" + "--->" + "getParentDirectoryId" + "--->"
					+ "getTitle" + "--->" + "getCaption" + "--->" + "getTimings" + "--->" + "getWebsite" + "--->"
					+ "getEmail" + "--->" + "getPhones");
			int count = 1;
			while (iterator.hasNext()) {

				EgsdDirectoryItemParseObject egsd = iterator.next();
				// System.out.println( count++ +" "+ egsd.getObjectId()
				// + "---> " + egsd.getDirectoryId()
				// + "--->" + egsd.getParentDirectoryId()
				// + "--->" + egsd.getTitle()
				// + "--->" + egsd.getCaption()
				// + "--->" + egsd.getTimings()
				// + "--->" + egsd.getWebsite()
				// + "--->" + egsd.getEmail()
				// + "--phoneId->" + egsd.getPhones()
				// + "--->" + egsd.getStyleID() +"<--StyleID ");
				String img = "No Image To Display";
				if (egsd.getParseFile("Picture") != null)
					img = egsd.getParseFile("Picture").getUrl();
				// System.out.print(img);
				String styleId = null;
				ParseObject StyleIdPO = egsd.getParseObject("StyleId");
				if (egsd.getParseObject("StyleId") != null)
					styleId = StyleIdPO.getObjectId();
				// System.out.println(styleId);

				/*
				 * if(StyleIdPO.getObjectId()!=null) System.out.println(
				 * "StyleID AT Directory Items"+StyleIdPO.getObjectId());
				 */

				directoryItemObjectsList.add(new EgsdDirectoryItemObjects(egsd.getObjectId(), egsd.getDirectoryId(),
						egsd.getTitle(), egsd.getCaption(), egsd.getDescription(), egsd.getTimings(), egsd.getWebsite(),
						egsd.getEmail(), egsd.getParentDirectoryId(), img, styleId, egsd.getPhones(),
						egsd.getParentDirectoryId(), egsd.getLocationId(), egsd.getCustomizedOrder()));

			}
		} catch (NullPointerException npe) {

		}
		System.out.println(directoryItemObjectsList.toString());

		System.out.println("before adding dir objs");
		mav.addObject("direcObjList", directoryItemObjectsList);
		mav.addObject("subDirObj", directoryItemObjectsList);
		mav.addObject("subsubDirObj", directoryItemObjectsList);
		mav.addObject("DirObjId", directoryItemObjectsList);
		mav.addObject("DiscriptionObjId", directoryItemObjectsList);
		// adding DirectiryItems for editing values
		mav.addObject("showSubDiscriptionObjId", directoryItemObjectsList);
		mav.addObject("showDiscriptionObjId", directoryItemObjectsList);
		mav.addObject("DiscriptionObjForNavBar", directoryItemObjectsList);
		mav.addObject("subDiscriptionObjForNavBar", directoryItemObjectsList);
		// addind directory Items for Adding DirectoryItems
		mav.addObject("locObjForAddDirectoryItems", directoryItemObjectsList);
		mav.addObject("subDiscriptionObjForAddDirItems", directoryItemObjectsList);
		mav.addObject("showSubDiscriptionObjIdForDelete", directoryItemObjectsList);

		System.out.println("aftr adding dir objs");

		System.out.println("in select b4 Phones");


		// redirecting
		mav.addObject("userName", request.getParameter("userName"));
		mav.addObject("user", request.getParameter("user"));
		mav.addObject("tempId", request.getParameter("tempId"));

		if (request.getParameter("userName").equals("Location Admin"))
			mav.setViewName("LocationList");
		if (request.getParameter("userName").equals("CS Admin"))
			mav.setViewName("CSAdminGroups");
		if (request.getParameter("userName").equals("Super Admin"))
			mav.setViewName("SuperAdminGroups");
		if (request.getParameter("userName").equals("IT Admin"))
			mav.setViewName("ITAdminGroups");

		now = Calendar.getInstance();
		System.out.println("end " + dateFormat.format(now.getTime()));

		return mav;
	}

	@RequestMapping(value = "/templates")
	public ModelAndView templates(HttpServletRequest request) {

		System.out.println("User:" + request.getParameter("user"));
		System.out.println("UserName:" + request.getParameter("userName"));

		// displayTemplates(request.getParameter("userName"),
		// request.getParameter("user"));

		// getDataFromParse(request);
		loadtemplates(request);

		mav.addObject("userName", request.getParameter("userName"));
		mav.addObject("user", request.getParameter("user"));

		if (request.getParameter("userName").equals("Location Admin"))
			mav.setViewName("LocationList");

		if (request.getParameter("userName").equals("CS Admin"))
			mav.setViewName("CSAdminTemplates");

		if (request.getParameter("userName").equals("Super Admin"))
			mav.setViewName("SuperAdminTemplates");
		if (request.getParameter("userName").equals("IT Admin"))
			mav.setViewName("SuperAdminTemplates");

		return mav;
	}

	public static void loadtemplates(HttpServletRequest request) {

		mav.clear();

		ParseQuery<ParseObject> queryForLocationAdminWasEmpty = ParseQuery.getQuery("_User");
		queryForLocationAdminWasEmpty.whereEqualTo("user", "Location Admin");
		// queryForLocationAdminWasEmpty.whereEqualTo("locationId", "empty");

		List<ParseObject> listOfEmptyAdmins = null;

		try {
			listOfEmptyAdmins = queryForLocationAdminWasEmpty.find();
		} catch (ParseException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		}
		List<EgsdUserObjects> listOfUserObjects = new ArrayList<EgsdUserObjects>(100);

		try {
			Iterator<ParseObject> iteratorForEmptyAdmins = listOfEmptyAdmins.listIterator();

			while (iteratorForEmptyAdmins.hasNext()) {

				ParseObject parseObjectHavingEmptyAdmins = iteratorForEmptyAdmins.next();

				listOfUserObjects.add(new EgsdUserObjects(parseObjectHavingEmptyAdmins.getObjectId(),
						parseObjectHavingEmptyAdmins.getString("username"), null,
						parseObjectHavingEmptyAdmins.getString("email"), parseObjectHavingEmptyAdmins.getString("user"),
						parseObjectHavingEmptyAdmins.getString("locationId"),
						parseObjectHavingEmptyAdmins.getString("firstname"),
						parseObjectHavingEmptyAdmins.getString("lastname"),
						parseObjectHavingEmptyAdmins.getString("phone")));
			}

		} catch (NullPointerException npe) {

			listOfUserObjects
					.add(new EgsdUserObjects("empty", "Please Add Location Admin", null, null, null, null, null, null,null));

		}

		mav.addObject("listOfEmptyLocationAdmins", listOfUserObjects);

		// list of Templates
		ParseQuery<ParseObject> queryForTemplateObjects = ParseQuery.getQuery("Template");
		queryForTemplateObjects.whereNotEqualTo("type", "group");

		List<ParseObject> listOfTemplateObjects = null;

		try {
			listOfTemplateObjects = queryForTemplateObjects.find();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		try {
			Iterator<ParseObject> iteratorForTemplateObjects = listOfTemplateObjects.listIterator();
			List<EgsdTemplateObjects> listOfEgsdTemplateObjects = new ArrayList<EgsdTemplateObjects>(20);

			while (iteratorForTemplateObjects.hasNext()) {

				ParseObject templateObjects = iteratorForTemplateObjects.next();

				listOfEgsdTemplateObjects
						.add(new EgsdTemplateObjects(templateObjects.getObjectId(), templateObjects.getString("Name"),
								templateObjects.getObjectId(), templateObjects.getBoolean("Customized")));

			}

			mav.addObject("listOfEgsdTemplateObjects", listOfEgsdTemplateObjects);

		} catch (NullPointerException npe) {

		}

		// list of Groups
		ParseQuery<ParseObject> queryForGroupObjects = ParseQuery.getQuery("Template");

		queryForGroupObjects.whereEqualTo("type", "group");

		List<ParseObject> listOfGroupObjects = null;

		try {
			listOfGroupObjects = queryForGroupObjects.find();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		try {
			Iterator<ParseObject> iteratorForGroupObjects = listOfGroupObjects.listIterator();
			List<EgsdTemplateObjects> listOfEgsdGroupObjects = new ArrayList<EgsdTemplateObjects>(20);

			while (iteratorForGroupObjects.hasNext()) {

				ParseObject templateObjects = iteratorForGroupObjects.next();

				listOfEgsdGroupObjects
						.add(new EgsdTemplateObjects(templateObjects.getObjectId(), templateObjects.getString("Name"),
								templateObjects.getObjectId(), templateObjects.getBoolean("Customized")));

			}

			mav.addObject("listOfEgsdGroupObjects", listOfEgsdGroupObjects);

		} catch (NullPointerException npe) {

		}

	}

	@RequestMapping(value = "/hotels")
	public ModelAndView hotels(HttpServletRequest request) {

		System.out.println("User:" + request.getParameter("user"));
		System.out.println("UserName:" + request.getParameter("userName"));

		// displayTemplates(request.getParameter("userName"),
		// request.getParameter("user"));

		// getDataFromParse(request);

		adminLoad(request);

		mav.addObject("userName", request.getParameter("userName"));
		mav.addObject("user", request.getParameter("user"));

		if (request.getParameter("userName").equals("Location Admin"))
			mav.setViewName("LocationList");

		if (request.getParameter("userName").equals("CS Admin"))
			mav.setViewName("CSAdmin");

		if (request.getParameter("userName").equals("Super Admin"))
			mav.setViewName("SuperAdmin");

		if (request.getParameter("userName").equals("IT Admin"))
			mav.setViewName("ITAdmin");

		return mav;
	}

	public void displayTemplates(String UserName, String user) {

		mav.clear();

		ParseQuery<ParseObject> queryForTemplateObjects = ParseQuery.getQuery("Template");

		List<ParseObject> listOfTemplateObjects = null;

		try {
			listOfTemplateObjects = queryForTemplateObjects.find();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		try {
			Iterator<ParseObject> iteratorForTemplateObjects = listOfTemplateObjects.listIterator();
			List<EgsdTemplateObjects> listOfEgsdTemplateObjects = new ArrayList<EgsdTemplateObjects>(20);

			while (iteratorForTemplateObjects.hasNext()) {

				ParseObject templateObjects = iteratorForTemplateObjects.next();

				listOfEgsdTemplateObjects
						.add(new EgsdTemplateObjects(templateObjects.getObjectId(), templateObjects.getString("Name"),
								templateObjects.getObjectId(), templateObjects.getBoolean("Customized")));

			}

			mav.addObject("listOfEgsdTemplateObjects", listOfEgsdTemplateObjects);
			mav.addObject("listOfEgsdTemplateObjectsForAddDirectoryItems", listOfEgsdTemplateObjects);

		} catch (NullPointerException npe) {

		}

		/*
		 * ParseQuery<ParseObject>
		 * queryForDirectory=ParseQuery.getQuery("DirectoryItem");
		 * queryForDirectory.limit(1000);
		 * 
		 * List<ParseObject> listOfDirectoryItems=null;
		 * 
		 * try { listOfDirectoryItems=queryForDirectory.find(); } catch
		 * (ParseException e) { // TODO Auto-generated catch block
		 * e.printStackTrace(); }
		 * 
		 * try{ List<EgsdDirectoryItemObjects> listOfEgsdDirectoryItems=new
		 * ArrayList<EgsdDirectoryItemObjects>(); Iterator<ParseObject>
		 * iteratorForDirectoryItem=listOfDirectoryItems.listIterator();
		 * while(iteratorForDirectoryItem.hasNext()){
		 * 
		 * ParseObject
		 * parseObjectForDirectoryItems=iteratorForDirectoryItem.next();
		 * 
		 * 
		 * 
		 * 
		 * }
		 */

		// HttpServletRequest request=null;

		// getDataFromParse(request);

		/*
		 * }catch(NullPointerException npe){
		 * 
		 * }
		 */

	}

	@RequestMapping(value = "/addChainLocation", headers = "content-type=multipart/*")
	public ModelAndView addChainLocation(MultipartHttpServletRequest request) throws WriterException, IOException {

		System.out.println(request.getParameter("chainId"));

		System.out.println(request.getParameter("Name"));
		System.out.println(request.getParameter("Address1"));
		System.out.println(request.getParameter("Address2"));
		System.out.println(request.getParameter("Street"));
		System.out.println(request.getParameter("Town"));
		System.out.println(request.getParameter("user"));
		System.out.println(request.getParameter("zipcode"));

		ParseObject locationObject = new ParseObject("Location");

		locationObject.put("ParentLocationID", request.getParameter("chainId"));

		locationObject.put("Name", request.getParameter("Name"));
		locationObject.put("Address1", request.getParameter("Address1"));
		locationObject.put("Address2", request.getParameter("Address2"));
		locationObject.put("Street", request.getParameter("Street"));
		locationObject.put("Town", request.getParameter("Town"));
		locationObject.put("zipcode", request.getParameter("zipcode"));
		// locationObject.put("ParentLocationID",
		// request.getParameter("chainId"));
		// locationObject.put("", r);

		try {
			locationObject.save();
		} catch (ParseException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

		// addding directories
		locationObject.put("Directories", locationObject.getObjectId());

		try {
			locationObject.save();
		} catch (ParseException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

		ParseQuery<ParseObject> queryDirectoryItemObjects = ParseQuery.getQuery("DirectoryItem");
		queryDirectoryItemObjects.whereEqualTo("DirectoryID", request.getParameter("chainId"));

		List<ParseObject> listOfParentDirectoryItems = null;

		try {
			listOfParentDirectoryItems = queryDirectoryItemObjects.find();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		Iterator<ParseObject> iteratorOfParentDirectoryItems = listOfParentDirectoryItems.listIterator();

		while (iteratorOfParentDirectoryItems.hasNext()) {

			ParseObject parseObjectOfParentDirectoryItem = iteratorOfParentDirectoryItems.next();

			System.out.println(parseObjectOfParentDirectoryItem.getString("Title"));

			ParseObject directoryItemObject = new ParseObject("DirectoryItem");

			if (parseObjectOfParentDirectoryItem.getString("Title") != null)
				directoryItemObject.put("Title", parseObjectOfParentDirectoryItem.getString("Title"));
			if (parseObjectOfParentDirectoryItem.getString("Caption") != null)
				directoryItemObject.put("Caption", parseObjectOfParentDirectoryItem.getString("Caption"));
			if (parseObjectOfParentDirectoryItem.getString("Description") != null)
				directoryItemObject.put("Description", parseObjectOfParentDirectoryItem.getString("Description"));
			if (parseObjectOfParentDirectoryItem.getString("Timings") != null)
				directoryItemObject.put("Timings", parseObjectOfParentDirectoryItem.getString("Timings"));
			if (parseObjectOfParentDirectoryItem.getString("Website") != null)
				directoryItemObject.put("Website", parseObjectOfParentDirectoryItem.getString("Website"));
			if (parseObjectOfParentDirectoryItem.getString("Email") != null)
				directoryItemObject.put("Email", parseObjectOfParentDirectoryItem.getString("Email"));

			if (parseObjectOfParentDirectoryItem.getParseObject("Picture") != null)
				directoryItemObject.put("Picture", parseObjectOfParentDirectoryItem.getParseObject("Picture"));

			directoryItemObject.put("LocationId", locationObject.getObjectId());
			directoryItemObject.put("DirectoryID", locationObject.getObjectId());

			try {
				directoryItemObject.save();
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			// adding styles to chain directory Items

			ParseQuery<ParseObject> queryForStyleObjects = ParseQuery.getQuery("Style");
			queryForStyleObjects.whereEqualTo("objectId",
					parseObjectOfParentDirectoryItem.getParseObject("StyleId").getObjectId());

			List<ParseObject> listOfDirectoryItemStyleObject = null;

			try {
				listOfDirectoryItemStyleObject = queryForStyleObjects.find();
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			Iterator<ParseObject> iteratorForDirectoryItemStyleObject = listOfDirectoryItemStyleObject.listIterator();

			ParseObject directoryItemStyleObject = iteratorForDirectoryItemStyleObject.next();

			ParseObject directoryItemChainStyleObj = new ParseObject("Style");

			if (directoryItemStyleObject.getString("TitleFont") != null)
				directoryItemChainStyleObj.put("TitleFont", directoryItemStyleObject.getString("TitleFont"));

			if (directoryItemStyleObject.getString("TitleColor") != null)
				directoryItemChainStyleObj.put("TitleColor", directoryItemStyleObject.getString("TitleColor"));

			if (directoryItemStyleObject.getString("TitleFamily") != null)
				directoryItemChainStyleObj.put("TitleFamily", directoryItemStyleObject.getString("TitleFamily"));

			if (directoryItemStyleObject.getString("CaptionFont") != null)
				directoryItemChainStyleObj.put("CaptionFont", directoryItemStyleObject.getString("CaptionFont"));

			if (directoryItemStyleObject.getString("CaptionColor") != null)
				directoryItemChainStyleObj.put("CaptionColor", directoryItemStyleObject.getString("CaptionColor"));

			if (directoryItemStyleObject.getString("CaptionFamily") != null)
				directoryItemChainStyleObj.put("CaptionFamily", directoryItemStyleObject.getString("CaptionFamily"));

			if (directoryItemStyleObject.getString("DescriptionFont") != null)
				directoryItemChainStyleObj.put("DescriptionFont",
						directoryItemStyleObject.getString("DescriptionFont"));

			if (directoryItemStyleObject.getString("DescriptionColor") != null)
				directoryItemChainStyleObj.put("DescriptionColor",
						directoryItemStyleObject.getString("DescriptionColor"));

			if (directoryItemStyleObject.getString("DescriptionFamily") != null)
				directoryItemChainStyleObj.put("DescriptionFamily",
						directoryItemStyleObject.getString("DescriptionFamily"));

			if (directoryItemStyleObject.getString("PhonesFont") != null)
				directoryItemChainStyleObj.put("PhonesFont", directoryItemStyleObject.getString("PhonesFont"));

			if (directoryItemStyleObject.getString("PhonesColor") != null)
				directoryItemChainStyleObj.put("PhonesColor", directoryItemStyleObject.getString("PhonesColor"));

			if (directoryItemStyleObject.getString("PhonesFamily") != null)
				directoryItemChainStyleObj.put("PhonesFamily", directoryItemStyleObject.getString("PhonesFamily"));

			if (directoryItemStyleObject.getString("TimingsFont") != null)
				directoryItemChainStyleObj.put("TimingsFont", directoryItemStyleObject.getString("TimingsFont"));

			if (directoryItemStyleObject.getString("TimingsColor") != null)
				directoryItemChainStyleObj.put("TimingsColor", directoryItemStyleObject.getString("TimingsColor"));

			if (directoryItemStyleObject.getString("TimingsFamily") != null)
				directoryItemChainStyleObj.put("TimingsFamily", directoryItemStyleObject.getString("TimingsFamily"));

			if (directoryItemStyleObject.getString("WebsiteFont") != null)
				directoryItemChainStyleObj.put("WebsiteFont", directoryItemStyleObject.getString("WebsiteFont"));

			if (directoryItemStyleObject.getString("WebsiteColor") != null)
				directoryItemChainStyleObj.put("WebsiteColor", directoryItemStyleObject.getString("WebsiteColor"));

			if (directoryItemStyleObject.getString("WebsiteFamily") != null)
				directoryItemChainStyleObj.put("WebsiteFamily", directoryItemStyleObject.getString("WebsiteFamily"));

			if (directoryItemStyleObject.getString("EmailFont") != null)
				directoryItemChainStyleObj.put("EmailFont", directoryItemStyleObject.getString("EmailFont"));

			if (directoryItemStyleObject.getString("EmailColor") != null)
				directoryItemChainStyleObj.put("EmailColor", directoryItemStyleObject.getString("EmailColor"));

			if (directoryItemStyleObject.getString("EmailFamily") != null)
				directoryItemChainStyleObj.put("EmailFamily", directoryItemStyleObject.getString("EmailFamily"));

			try {
				directoryItemChainStyleObj.save();
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			directoryItemObject.put("StyleId", directoryItemChainStyleObj);

			try {
				directoryItemObject.save();
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			checkChain(parseObjectOfParentDirectoryItem.getObjectId(), directoryItemObject,
					directoryItemObject.getObjectId(), locationObject.getObjectId());

		}

		return new ModelAndView("Sample");
	}

	public static void checkChain(String id, ParseObject parseObject, String DirectoryItemOjectId, String locationId) {

		// System.out.println("In checkChain");
		System.out.println(id);

		ParseQuery<ParseObject> queryToCheckChild = ParseQuery.getQuery("DirectoryItem");
		queryToCheckChild.whereEqualTo("DirectoryID", id);

		List<ParseObject> listOfChildObjects = null;

		try {
			listOfChildObjects = queryToCheckChild.find();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		try {

			Iterator<ParseObject> iteratorForChildObjects = listOfChildObjects.listIterator();

			while (iteratorForChildObjects.hasNext()) {

				ParseObject childObject = iteratorForChildObjects.next();

				System.out.println(childObject.getString("Title") + "This is ChildIrectoryFor:" + id);

				ParseObject childDirectoryObject = new ParseObject("DirectoryItem");

				if (childDirectoryObject.getString("Title") != null || childDirectoryObject.getString("Title") != "")
					childDirectoryObject.put("Title", childObject.getString("Title"));
				if (childDirectoryObject.getString("Description") != null
						|| childDirectoryObject.getString("Description") != "")
					childDirectoryObject.put("Description", childObject.getString("Description"));
				if (childDirectoryObject.getString("Caption") != null
						|| childDirectoryObject.getString("Caption") != "")
					childDirectoryObject.put("Caption", childObject.getString("Caption"));
				if (childDirectoryObject.getString("Timings") != null
						|| childDirectoryObject.getString("Timings") != "")
					childDirectoryObject.put("Timings", childObject.getString("Timings"));
				childDirectoryObject.put("CustomizedOrder", childObject.getInt("CustomizedOrder"));
				
				if (childObject.getParseFile("Picture") != null)
				{
					ParseFile pf = null;
					if (childObject.getParseFile("Picture") != null)
					{
						byte[] taxi = null;
						
						
						try {
							taxi = childObject.getParseFile("Picture").getData();
						} catch (ParseException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
						
						pf = new ParseFile("Picture.png", taxi);
						try {
							pf.save();
						} catch (ParseException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
						childDirectoryObject.put("Picture", pf);
					}
				}

				childDirectoryObject.put("DirectoryID", DirectoryItemOjectId);
				//childDirectoryObject.put("ParentDirectoryId", DirectoryItemOjectId);
				childDirectoryObject.put("LocationId", locationId);
				
				

				try {
					childDirectoryObject.save();
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

				ParseQuery<ParseObject> queryForDirectoryStyleObject = ParseQuery.getQuery("Style");
				queryForDirectoryStyleObject.whereEqualTo("objectId",
						childObject.getParseObject("StyleId").getObjectId());

				List<ParseObject> listOfChildStyle = null;

				try {
					listOfChildStyle = queryForDirectoryStyleObject.find();
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

				Iterator<ParseObject> iteratorForChildStyle = listOfChildStyle.listIterator();

				ParseObject childDirectoryStyles = iteratorForChildStyle.next();

				ParseObject directoryChildStyleObject = new ParseObject("Style");

				if (childDirectoryStyles.getString("TitleFont") != null)
					directoryChildStyleObject.put("TitleFont", childDirectoryStyles.getString("TitleFont"));

				if (childDirectoryStyles.getString("TitleColor") != null)
					directoryChildStyleObject.put("TitleColor", childDirectoryStyles.getString("TitleColor"));

				if (childDirectoryStyles.getString("TitleFamily") != null)
					directoryChildStyleObject.put("TitleFamily", childDirectoryStyles.getString("TitleFamily"));

				if (childDirectoryStyles.getString("CaptionFont") != null)
					directoryChildStyleObject.put("CaptionFont", childDirectoryStyles.getString("CaptionFont"));

				if (childDirectoryStyles.getString("CaptionColor") != null)
					directoryChildStyleObject.put("CaptionColor", childDirectoryStyles.getString("CaptionColor"));

				if (childDirectoryStyles.getString("CaptionFamily") != null)
					directoryChildStyleObject.put("CaptionFamily", childDirectoryStyles.getString("CaptionFamily"));			

				if (childDirectoryStyles.getString("PhonesFont") != null)
					directoryChildStyleObject.put("PhonesFont", childDirectoryStyles.getString("PhonesFont"));

				if (childDirectoryStyles.getString("PhonesColor") != null)
					directoryChildStyleObject.put("PhonesColor", childDirectoryStyles.getString("PhonesColor"));

				if (childDirectoryStyles.getString("PhonesFamily") != null)
					directoryChildStyleObject.put("PhonesFamily", childDirectoryStyles.getString("PhonesFamily"));

				if (childDirectoryStyles.getString("TimingsFont") != null)
					directoryChildStyleObject.put("TimingsFont", childDirectoryStyles.getString("TimingsFont"));

				if (childDirectoryStyles.getString("TimingsColor") != null)
					directoryChildStyleObject.put("TimingsColor", childDirectoryStyles.getString("TimingsColor"));

				if (childDirectoryStyles.getString("TimingsFamily") != null)
					directoryChildStyleObject.put("TimingsFamily", childDirectoryStyles.getString("TimingsFamily"));
				
				if (childDirectoryStyles.getString("PriceFont") != null)
					directoryChildStyleObject.put("PriceFont", childDirectoryStyles.getString("PriceFont"));
				
				if (childDirectoryStyles.getString("PriceColor") != null)
					directoryChildStyleObject.put("PriceColor", childDirectoryStyles.getString("PriceColor"));
				
				if (childDirectoryStyles.getString("PriceFamily") != null)
					directoryChildStyleObject.put("PriceFamily", childDirectoryStyles.getString("PriceFamily"));

				

				directoryChildStyleObject.put("LocationId", locationId);

				try {
					directoryChildStyleObject.save();
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

				childDirectoryObject.put("StyleId", directoryChildStyleObject);

				try {
					childDirectoryObject.save();
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

				// adding phone Items

				ParseQuery<ParseObject> queryForPhoneObjects = ParseQuery.getQuery("Phones");
				queryForPhoneObjects.whereEqualTo("PhoneId", childObject.getObjectId());

				List<ParseObject> listOfPhoneObjects = null;

				try {
					listOfPhoneObjects = queryForPhoneObjects.find();
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

				try {

					Iterator<ParseObject> iteratorForPhoneObjects = listOfPhoneObjects.listIterator();

					while (iteratorForPhoneObjects.hasNext()) {

						ParseObject phoneObject = iteratorForPhoneObjects.next();

						ParseObject newPhoneObject = new ParseObject("Phones");

						if (phoneObject.getString("Ext") != null)
							newPhoneObject.put("Ext", phoneObject.getString("Ext"));
						if (phoneObject.getString("Type") != null)
							newPhoneObject.put("Type", phoneObject.getString("Type"));

						newPhoneObject.put("PhoneId", childDirectoryObject.getObjectId());

						newPhoneObject.put("LocationId", locationId);

						try {
							newPhoneObject.save();
						} catch (ParseException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}

					}

				} catch (NullPointerException npe) {

				}

				// adding menu Items

				
				 ParseQuery<ParseObject>  queryForMenuObjects=ParseQuery.getQuery("Menu");
				 queryForMenuObjects.whereEqualTo("MenuId",childObject.getObjectId());
				  
				  List<ParseObject> listOfMenuObjects=null;
				  
				  try { 
					  
					  listOfMenuObjects=queryForMenuObjects.find(); 
					  } catch(ParseException e) {
						  // TODO Auto-generated catch block
						  e.printStackTrace(); 
						 }
				  
				  
				  try{
				  
				  Iterator<ParseObject> iteratorForMenuObjects=listOfMenuObjects.listIterator();
				  
				  while(iteratorForMenuObjects.hasNext()){
				  
				  ParseObject menuObject=iteratorForMenuObjects.next();
				  
				  ParseObject newMenuObject=new ParseObject("Menu");
				  
				  if(menuObject.getString("Description")!=null || menuObject.getString("Description")!= "")
				  newMenuObject.put("Description", menuObject.getString("Description"));
				  if(menuObject.getString("Price")!=null || menuObject.getString("Price")!= "")
				  newMenuObject.put("Price", menuObject.getString("Price"));
				  
				  newMenuObject.put("MenuId",childDirectoryObject.getObjectId());
				  newMenuObject.put("StyleID",directoryChildStyleObject);
				  
				  newMenuObject.put("LocationId",locationId );
				  
				  try { 
					  newMenuObject.save(); 
					  } catch (ParseException e) { 
					  //TODO Auto-generated catch block e.printStackTrace(); 
					  }
				  
				  }
				  
				  
				  
				  }catch(NullPointerException npe){
				  
				  
				  }
				 

				if (childObject.getString("DirectoryID") != null)
					checkChain(childObject.getObjectId(), parseObject, childDirectoryObject.getObjectId(), locationId);

			}

		} catch (NullPointerException npe) {
			// TODO: handle exception

		}

	}

	@RequestMapping(value = "/addLocation", headers = "content-type=multipart/*")
	public ModelAndView addLocation(MultipartHttpServletRequest request) throws WriterException, IOException {

		// String path=request.getServletContext().getRealPath("/");
		System.out.println(request.getParameter("Name"));
		System.out.println(request.getParameter("Address1"));
		System.out.println(request.getParameter("Address2"));
		System.out.println(request.getParameter("Street"));
		System.out.println(request.getParameter("Town"));
		System.out.println(request.getParameter("user"));
		System.out.println(request.getParameter("zipcode"));
		System.out.println(request.getParameter("description"));

		// System.out.println("templateId:"+request.getParameter("templateId"));
		System.out.println("groupId :" + request.getParameter("groupId"));
		System.out.println("adminId:" + request.getParameter("adminId"));
		// System.out.println("local path:"+ request.getLocalAddr());
		// System.out.println("path info:"+request.getPathInfo());
		// System.out.println("req uri"+request.getRequestURI());
		// String url=request.getContextPath();

		// byte[] logo=request.getParameter("Logo").getBytes();
		// System.out.println(request.getParameter("Logo").getBytes().length);

		String groupname = "";
		String templateCaption = "";
		String templateDesc = "";
		String templateFooterText = "";
		String style = "";
		String style1 = "";
		ParseFile templateLogo = null;
		ParseFile templateImage = null;
		ParseFile templateFooter = null;
		
		// find of Group name
		ParseQuery<ParseObject> queryForGroupName = ParseQuery.getQuery("Template");
		queryForGroupName.orderByAscending("Name");

		queryForGroupName.whereEqualTo("objectId", request.getParameter("groupId"));

		List<ParseObject> listOfGroupName = null;
		ParseObject styleObject1 = new ParseObject("Style");	

		try {
			listOfGroupName = queryForGroupName.find();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		try {
			Iterator<ParseObject> iteratorForGroupObjects = listOfGroupName.listIterator();
			List<EgsdTemplateObjects> listOfEgsdGroupObjects = new ArrayList<EgsdTemplateObjects>(100);

			while (iteratorForGroupObjects.hasNext()) {

				ParseObject templateObjects = iteratorForGroupObjects.next();
				
				System.out.println(templateObjects.getString("hotelCaption"));
				System.out.println(templateObjects.getString("description"));
				System.out.println(templateObjects.getString("footerText"));
				
				if (templateObjects.getString("hotelCaption") != null) {
					templateCaption = templateObjects.getString("hotelCaption");
				} else {
					templateCaption = "";
				}
				
				if (templateObjects.getString("description") != null) {
					templateDesc = templateObjects.getString("description");
				} else {
					templateDesc = "";
				}
				
				if (templateObjects.getString("footerText") != null) {
					templateFooterText = templateObjects.getString("footerText");
				} else {
					templateFooterText = "";
				}
				
				if (templateObjects.getParseFile("templateLogo") != null) {
					templateLogo = templateObjects.getParseFile("templateLogo");
				}
				
				if (templateObjects.getParseFile("templateImage") != null) {
					templateImage = templateObjects.getParseFile("templateImage");
				}
				
				if (templateObjects.getParseFile("templateFooter") != null) {
					templateFooter = templateObjects.getParseFile("templateFooter");
				} 
				
				
				ParseObject StyleIdPO = templateObjects.getParseObject("StyleId");
				
				if (templateObjects.getParseObject("StyleId") != null){
					style = StyleIdPO.getObjectId();
				}
				else
				{
					style = "";
				}
				
				
				if (templateObjects.getString("type").equals("group")) {
					groupname = templateObjects.getString("Name");
				} else {
					groupname = "";
				}
				
				
				

			}

		} catch (NullPointerException npe) {
			groupname = "";
		}
		
		
		if(style!=null&&!style.equals("")){
			ParseQuery<ParseObject> styleIdQuery = ParseQuery.getQuery("Style");
			styleIdQuery.whereEqualTo("objectId", style);
			List<ParseObject> StyleResults = new ArrayList<ParseObject>();
			
			try {
				StyleResults = styleIdQuery.find();
			} catch (ParseException ee) {
				// TODO Auto-generated catch block
				ee.printStackTrace();
			}
			try {
				Iterator<ParseObject> StyleList = StyleResults.listIterator();
				ParseObject styleObject = null;
				ParseObject pp = null;
				while (StyleList.hasNext()) {
					pp = StyleList.next();
								
								
					
					if(pp.getString("hotelTitleColor")!=null&&!pp.getString("hotelTitleColor").equals("")){
						styleObject1.put("hotelTitleColor", pp.getString("hotelTitleColor"));
						 }
					 if(pp.getString("hotelTitleFont")!=null&&!pp.getString("hotelTitleFont").equals("")){
						 styleObject1.put("hotelTitleFont", pp.getString("hotelTitleFont"));
				     }
				     if(pp.getString("hotelTitleFontFamily")!=null&&!pp.getString("hotelTitleFontFamily").equals("")){
				    	 styleObject1.put("hotelTitleFontFamily", pp.getString("hotelTitleFontFamily"));
				     }
				     if(pp.getString("hotelCaptionColor")!=null&&!pp.getString("hotelCaptionColor").equals("")){
				    	 styleObject1.put("hotelCaptionColor", pp.getString("hotelCaptionColor"));
						 }
					 if(pp.getString("hotelCaptionFont")!=null&&!pp.getString("hotelCaptionFont").equals("")){
						 styleObject1.put("hotelCaptionFont", pp.getString("hotelCaptionFont"));
				     }
				     if(pp.getString("hotelCaptionFontFamily")!=null&&!pp.getString("hotelCaptionFontFamily").equals("")){
				    	 styleObject1.put("hotelCaptionFontFamily", pp.getString("hotelCaptionFontFamily"));
				     }
				     
				     if(pp.getString("LocationAddressFont")!=null&&!pp.getString("LocationAddressFont").equals("")){
				    	 styleObject1.put("LocationAddressFont", pp.getString("LocationAddressFont"));
						 }
					 if(pp.getString("LocationAddressFontColor")!=null&&!pp.getString("LocationAddressFontColor").equals("")){
						 styleObject1.put("LocationAddressFontColor", pp.getString("LocationAddressFontColor"));
				     }
				     if(pp.getString("LocationAddressFontFamily")!=null&&!pp.getString("LocationAddressFontFamily").equals("")){
				    	 styleObject1.put("LocationAddressFontFamily", pp.getString("LocationAddressFontFamily"));
				     }     
				     
					
					 if(pp.getString("LocationBackground")!=null&&!pp.getString("LocationBackground").equals("")){
						 styleObject1.put("LocationBackground", pp.getString("LocationBackground"));
						 }
					 if(pp.getString("BrandButtonColor")!=null&&!pp.getString("BrandButtonColor").equals("")){
						 styleObject1.put("BrandButtonColor", pp.getString("BrandButtonColor"));
				     }
				     if(pp.getString("BrandFontColor")!=null&&!pp.getString("BrandFontColor").equals("")){
				    	 styleObject1.put("BrandFontColor", pp.getString("BrandFontColor"));
				     }
				     if(pp.getString("BrandFontFamily")!=null&&!pp.getString("BrandFontFamily").equals("")){
				    	 styleObject1.put("BrandFontFamily", pp.getString("BrandFontFamily"));
				     }
						 
						 if(pp.getString("LocationFooterBackground")!=null&&!pp.getString("LocationFooterBackground").equals("")){
							 styleObject1.put("LocationFooterBackground", pp.getString("LocationFooterBackground"));
						 }
						 if(pp.getString("FooterTextColor")!=null&&!pp.getString("FooterTextColor").equals("")){
							 styleObject1.put("FooterTextColor", pp.getString("FooterTextColor"));
						 }
						 if(pp.getString("footerFont")!=null){
							 styleObject1.put("footerFont", pp.getString("footerFont"));
						 }
						 if(pp.getString("footerCaptionFamily")!=null){
							 styleObject1.put("footerCaptionFamily", pp.getString("footerCaptionFamily"));
						 }
						 
						 try{
							 styleObject1.save();	
							 style1=styleObject1.getObjectId();
						 }
						 catch(Exception ee){
							 style1 = "";
							 ee.printStackTrace();
						 }
				}
				
			}
			catch(Exception estyle){
				estyle.printStackTrace();
			}
			}
		
		

			
		
		ParseFile pf = null;
		ParseFile pf1 = null;
		ParseFile pf2 = null;
		ParseGeoPoint point = null;
		
		ParseObject locationObject = new ParseObject("Location");

		
		locationObject.put("Name", request.getParameter("Name"));
		locationObject.put("GroupSiteId", request.getParameter("siteId"));
		locationObject.put("Address1", request.getParameter("Address1"));
		locationObject.put("Address2", request.getParameter("Address2"));
		locationObject.put("Street", request.getParameter("Street"));
		locationObject.put("Town", request.getParameter("Town"));
		locationObject.put("zipcode", request.getParameter("zipcode"));
		locationObject.put("Country", request.getParameter("country"));
		locationObject.put("hotelCaption", templateCaption);
		locationObject.put("description", templateDesc);
		locationObject.put("footerText", templateFooterText);
		
		String lat = request.getParameter("latitude");
		
		if( !lat.equals("") )
		{
			double latitude =  Double.parseDouble(request.getParameter("latitude"));
			double longitude =  Double.parseDouble(request.getParameter("longitude"));
			point = new ParseGeoPoint(latitude, longitude);
			locationObject.put("Geopoints", point);
		}
		
		

		
		if(style != "")			
		locationObject.put("StyleId", styleObject1);
		
		
		// locationObject.put("description",
		// request.getParameter("description"));

		if (groupname != "") {
			locationObject.put("GroupName", groupname);
		}
		// locationObject.put("ParentLocationID",
		// request.getParameter("chainId"));
		// locationObject.put("", r);
		MultipartFile multiFile = request.getFile("logo");
		String imageType = multiFile.getContentType();
		// just to show that we have actually received the file
		if(request.getFile("logo")!=null){
			try {
				System.out.println("File Length:" + multiFile.getBytes().length);
				System.out.println("File Type:" + multiFile.getContentType());
				String fileName = multiFile.getOriginalFilename();
				System.out.println("File Name:" + fileName);
				if (multiFile.getBytes().length > 0) {
					pf = new ParseFile("logo.jpg", multiFile.getBytes());
					try {
						pf.save();
						locationObject.put("Logo", pf);
					} catch (ParseException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
				else
				{
					if (templateLogo != null)
					{
						byte[] taxi = null;
						
						
						try {
							taxi = templateLogo.getData();
						} catch (ParseException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
						
						templateLogo = new ParseFile("logo.jpg", taxi);
						try {
							templateLogo.save();
						} catch (ParseException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
						locationObject.put("Logo", templateLogo);
					}
				}
			} catch (IOException e2) {
				// TODO Auto-generated catch block
				e2.printStackTrace();
			}
		}
		
		MultipartFile multiFile1 = request.getFile("hotelLogo");
		String imageType1 = multiFile.getContentType();
		// just to show that we have actually received the file
		if(request.getFile("hotelLogo")!=null){
			try {
			System.out.println("File Length:" + multiFile1.getBytes().length);
			System.out.println("File Type:" + multiFile1.getContentType());
			String fileName = multiFile1.getOriginalFilename();
			System.out.println("File Name:" + fileName);
			if (multiFile1.getBytes().length > 0) {
				pf1 = new ParseFile("logo.jpg", multiFile1.getBytes());
				try {
					pf1.save();
					locationObject.put("hotelLogo", pf1);
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			else
			{
				if (templateImage != null)
				{
					byte[] taxi = null;
					
					
					try {
						taxi = templateImage.getData();
					} catch (ParseException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					
					templateImage = new ParseFile("logo.jpg", taxi);
					try {
						templateImage.save();
					} catch (ParseException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					locationObject.put("hotelLogo", templateImage);
				}
			}
		} catch (IOException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		}
	}
		
		
		
		MultipartFile multiFile2 = request.getFile("hotelFooter");
		String imageType2 = multiFile2.getContentType();
		// just to show that we have actually received the file
		if(request.getFile("hotelFooter")!=null){		
			try {
			System.out.println("File Length:" + multiFile2.getBytes().length);
			System.out.println("File Type:" + multiFile2.getContentType());
			String fileName = multiFile2.getOriginalFilename();
			System.out.println("File Name:" + fileName);
			if (multiFile2.getBytes().length > 0) {
				pf2 = new ParseFile("logo.jpg", multiFile2.getBytes());
				try {
					pf2.save();
					locationObject.put("footerImage", pf2);
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}}
			else
			{
				if (templateFooter != null)
				{
					byte[] taxi = null;
					
					
					try {
						taxi = templateFooter.getData();
					} catch (ParseException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					
					templateFooter = new ParseFile("logo.jpg", taxi);
					try {
						templateFooter.save();
					} catch (ParseException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					locationObject.put("footerImage", templateFooter);
				}
			}

			}
		 catch (IOException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		}
		}

		try {
			locationObject.save();
		} catch (ParseException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

		GenerateQRCode qrcode = new GenerateQRCode();
		byte[] res = null;
		try {
			res = qrcode.qrCode(locationObject.getObjectId());
		} catch (WriterException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		pf = new ParseFile("logo.jpg", res);
		
		ParseQuery<ParseObject> queryForLocationAdminDetails = ParseQuery.getQuery("_User");
		queryForLocationAdminDetails.whereEqualTo("objectId", request.getParameter("adminId"));
		

		List<ParseObject> listOfEmptyAdminDetails = null;

		try {
			listOfEmptyAdminDetails = queryForLocationAdminDetails.find();
		} catch (ParseException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		}
		String adminEmail = listOfEmptyAdminDetails.get(0).getString("email");
		String adminName = listOfEmptyAdminDetails.get(0).getString("username");
		
		
		System.out.println(res.length);
		try {
			pf.save();
			locationObject.put("QRCode", pf);
			locationObject.put("Directories", locationObject.getObjectId());
			locationObject.put("GroupId", request.getParameter("adminId"));
			locationObject.put("email", adminEmail);
			locationObject.put("adminName", adminName);
			locationObject.save();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		ParseQuery<ParseObject> queryDefaultDirectoryItemObjects = ParseQuery.getQuery("DirectoryItem");
		if (request.getParameter("groupId") != null)
			queryDefaultDirectoryItemObjects.whereEqualTo("DirectoryID", request.getParameter("groupId"));

		List<ParseObject> listOfDefaultDirectoryItems = null;

		try {
			listOfDefaultDirectoryItems = queryDefaultDirectoryItemObjects.find();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		try {

			Iterator<ParseObject> iteratorForDefaultDirectoryItems = listOfDefaultDirectoryItems.listIterator();

			while (iteratorForDefaultDirectoryItems.hasNext()) {

				ParseObject parseObjectOfParentDirectoryItem = iteratorForDefaultDirectoryItems.next();

				System.out.println(parseObjectOfParentDirectoryItem.getString("Title"));

				ParseObject directoryItemObject = new ParseObject("DirectoryItem");

				if (parseObjectOfParentDirectoryItem.getString("Title") != null)
					directoryItemObject.put("Title", parseObjectOfParentDirectoryItem.getString("Title"));
				if (parseObjectOfParentDirectoryItem.getString("Caption") != null)
					directoryItemObject.put("Caption", parseObjectOfParentDirectoryItem.getString("Caption"));
				if (parseObjectOfParentDirectoryItem.getString("Description") != null)
					directoryItemObject.put("Description", parseObjectOfParentDirectoryItem.getString("Description"));
				if (parseObjectOfParentDirectoryItem.getString("Timings") != null)
					directoryItemObject.put("Timings", parseObjectOfParentDirectoryItem.getString("Timings"));
				
				directoryItemObject.put("CustomizedOrder", parseObjectOfParentDirectoryItem.getInt("CustomizedOrder"));

				ParseFile parseFile = null;
				if (parseObjectOfParentDirectoryItem.getParseFile("Picture") != null)
				{
					byte[] taxi = null;
					
					
					try {
						taxi = parseObjectOfParentDirectoryItem.getParseFile("Picture").getData();
					} catch (ParseException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					
					parseFile = new ParseFile("Picture.png", taxi);
					try {
						parseFile.save();
					} catch (ParseException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					directoryItemObject.put("Picture", parseFile);
				}

				directoryItemObject.put("ParentReferrence", locationObject.getObjectId());
				directoryItemObject.put("LocationId", locationObject.getObjectId());
				directoryItemObject.put("DirectoryID", locationObject.getObjectId());

				try {
					directoryItemObject.save();
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

				// adding styles to chain directory Items

				ParseQuery<ParseObject> queryForStyleObjects = ParseQuery.getQuery("Style");
				queryForStyleObjects.whereEqualTo("objectId",
						parseObjectOfParentDirectoryItem.getParseObject("StyleId").getObjectId());

				List<ParseObject> listOfDirectoryItemStyleObject = null;

				try {
					listOfDirectoryItemStyleObject = queryForStyleObjects.find();
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

				Iterator<ParseObject> iteratorForDirectoryItemStyleObject = listOfDirectoryItemStyleObject
						.listIterator();

				ParseObject directoryItemStyleObject = iteratorForDirectoryItemStyleObject.next();

				ParseObject directoryItemChainStyleObj = new ParseObject("Style");

				if (directoryItemStyleObject.getString("TitleFont") != null)
					directoryItemChainStyleObj.put("TitleFont", directoryItemStyleObject.getString("TitleFont"));
				
				if (directoryItemStyleObject.getString("TitleColor") != null)
					directoryItemChainStyleObj.put("TitleColor", directoryItemStyleObject.getString("TitleColor"));
				
				if (directoryItemStyleObject.getString("TitleFamily") != null)
					directoryItemChainStyleObj.put("TitleFamily", directoryItemStyleObject.getString("TitleFamily"));
				
				if (directoryItemStyleObject.getString("CaptionFont") != null)
					directoryItemChainStyleObj.put("CaptionFont", directoryItemStyleObject.getString("CaptionFont"));
				
				if (directoryItemStyleObject.getString("CaptionColor") != null)
					directoryItemChainStyleObj.put("CaptionColor", directoryItemStyleObject.getString("CaptionColor"));
				
				if (directoryItemStyleObject.getString("CaptionFamily") != null)
					directoryItemChainStyleObj.put("CaptionFamily", directoryItemStyleObject.getString("CaptionFamily"));					

				if (directoryItemStyleObject.getString("TimingsFont") != null)
					directoryItemChainStyleObj.put("TimingsFont", directoryItemStyleObject.getString("TimingsFont"));
				
				if (directoryItemStyleObject.getString("TimingsColor") != null)
					directoryItemChainStyleObj.put("TimingsColor", directoryItemStyleObject.getString("TimingsColor"));
				
				if (directoryItemStyleObject.getString("TimingsFamily") != null)
					directoryItemChainStyleObj.put("TimingsFamily", directoryItemStyleObject.getString("TimingsFamily"));
				
				if (directoryItemStyleObject.getString("PriceFont") != null)
					directoryItemChainStyleObj.put("PriceFont", directoryItemStyleObject.getString("PriceFont"));
				
				if (directoryItemStyleObject.getString("PriceColor") != null)
					directoryItemChainStyleObj.put("PriceColor", directoryItemStyleObject.getString("PriceColor"));
				
				if (directoryItemStyleObject.getString("PriceFamily") != null)
					directoryItemChainStyleObj.put("PriceFamily", directoryItemStyleObject.getString("PriceFamily"));

				directoryItemChainStyleObj.put("LocationId", locationObject.getObjectId());

				try {
					directoryItemChainStyleObj.save();
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

				directoryItemObject.put("StyleId", directoryItemChainStyleObj);

				try {
					directoryItemObject.save();
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				
				
				ParseQuery<ParseObject> queryForPhoneObjects = ParseQuery.getQuery("Phones");
				queryForPhoneObjects.whereEqualTo("PhoneId", parseObjectOfParentDirectoryItem.getObjectId());

				List<ParseObject> listOfPhoneObjects = null;

				try {
					listOfPhoneObjects = queryForPhoneObjects.find();
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

				try {

					Iterator<ParseObject> iteratorForPhoneObjects = listOfPhoneObjects.listIterator();

					while (iteratorForPhoneObjects.hasNext()) {

						ParseObject phoneObject = iteratorForPhoneObjects.next();

						ParseObject newPhoneObject = new ParseObject("Phones");

						if (phoneObject.getString("Ext") != null)
							newPhoneObject.put("Ext", phoneObject.getString("Ext"));
						if (phoneObject.getString("Type") != null)
							newPhoneObject.put("Type", phoneObject.getString("Type"));

						newPhoneObject.put("PhoneId", directoryItemObject.getObjectId());
						newPhoneObject.put("LocationId", locationObject.getObjectId());

						try {
							newPhoneObject.save();
						} catch (ParseException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}

					}

				} catch (NullPointerException npe) {
					npe.printStackTrace();
				}

				
				ParseQuery<ParseObject>  queryForMenuObjects=ParseQuery.getQuery("Menu");
				  queryForMenuObjects.whereEqualTo("MenuId", parseObjectOfParentDirectoryItem.getObjectId());
				  
				  List<ParseObject> listOfMenuObjects=null;
				  
				  try { 
					  listOfMenuObjects=queryForMenuObjects.find(); 
				  } 
				  catch(ParseException e) { 
					  // TODO Auto-generated catch block
					  e.printStackTrace(); 
					  }
				  
				  
				  try{
				  
				  Iterator<ParseObject> iteratorForMenuObjects=listOfMenuObjects.listIterator();
				  
				  while(iteratorForMenuObjects.hasNext()){
				  
				  ParseObject menuObject=iteratorForMenuObjects.next();
				  
				  ParseObject newMenuObject=new ParseObject("Menu");
				  
				  if(menuObject.getString("Description")!=null || menuObject.getString("Description")!= "")
				  newMenuObject.put("Description", menuObject.getString("Description"));
				  if(menuObject.getString("Price")!=null || menuObject.getString("Description")!= "")
				  newMenuObject.put("Price", menuObject.getString("Price"));
				  
				  newMenuObject.put("StyleID",directoryItemChainStyleObj);
				  newMenuObject.put("MenuId",directoryItemObject.getObjectId());
				  newMenuObject.put("LocationId",locationObject.getObjectId());
				  
				  try { 
					  newMenuObject.save(); 
					} catch (ParseException e) { 
				  //TODO Auto-generated catch block e.printStackTrace(); 
					  }
				  
				  }
				  
				  
				  }catch(NullPointerException npe){
				  
				  
				  }
				
				

				checkChain(parseObjectOfParentDirectoryItem.getObjectId(), directoryItemObject,
						directoryItemObject.getObjectId(), locationObject.getObjectId());

			}

		} catch (NullPointerException npe) {

		}

		// cloud code

		HashMap<String, String> params = new HashMap<String, String>();
		params.put("adminId", request.getParameter("adminId"));
		params.put("locationId", locationObject.getObjectId());

		String result = null;

		try {
			result = ParseCloud.callFunction("addingLocationId", params);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			result = "there is error in adding location id";
			e.printStackTrace();
		}
		
		System.out.println(locationObject.getObjectId());
				
		request.setAttribute("locId", locationObject.getObjectId());		
		
		try {
			select(request);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		mav.addObject("userName", request.getParameter("userName"));
		mav.addObject("user", request.getParameter("user"));
		
		if (request.getParameter("userName").equals("Location Admin")) {
			mav.setViewName("LocationAdmin");
		}
		if (request.getParameter("userName").equals("CS Admin")) {
			mav.setViewName("CSAdmin");
		}
		if (request.getParameter("userName").equals("Super Admin")) {
			mav.setViewName("SuperAdmin");
		}
		if (request.getParameter("userName").equals("IT Admin")) {
			mav.setViewName("ITAdmin");
		}
		

		// redirecting to home page
		/*if (request.getParameter("locId") != null) {
			
			request.setAttribute("locId", request.getParameter("locId"));
			
			mav.addObject("userName", request.getParameter("userName"));
			mav.addObject("user", request.getParameter("user"));
			
			try {
				select(request);
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			if (request.getParameter("userName").equals("Location Admin")) {
				mav.setViewName("LocationAdmin");
			}
			if (request.getParameter("userName").equals("CS Admin")) {
				mav.setViewName("CSAdmin");
			}
			if (request.getParameter("userName").equals("Super Admin")) {
				mav.setViewName("SuperAdmin");
			}
			if (request.getParameter("userName").equals("IT Admin")) {
				mav.setViewName("ITAdmin");
			}
			mav.addObject("userName", request.getParameter("userName"));
			mav.addObject("user", request.getParameter("user"));
		}
		else
		{
			
			System.out.println(request.getParameter("tempId"));
			if (request.getParameter("tempId") != null) {
				
				request.setAttribute("tempId", request.getParameter("tempId"));
				
				viewTemplates(request);
				
				mav.addObject("userName", request.getParameter("userName"));
				mav.addObject("user", request.getParameter("user"));
				
				if (request.getParameter("userName").equals("Super Admin"))
					mav.setViewName("SuperAdminTemplates");

				if (request.getParameter("userName").equals("IT Admin"))
					mav.setViewName("ITAdminTemplates");

				if (request.getParameter("userName").equals("CS Admin"))
					mav.setViewName("CSAdminTemplates");

				
			}
			

			else {
				mav.addObject("userName", request.getParameter("userName"));
				mav.addObject("user", request.getParameter("user"));
				adminLoad(request);
				if (request.getParameter("userName").equals("CS Admin")) {
					mav.setViewName("CSHotelList");
				}
				if (request.getParameter("userName").equals("Super Admin")) {
					mav.setViewName("SuperHotelList");
				}
				if (request.getParameter("userName").equals("IT Admin")) {
					mav.setViewName("ITHotelList");
				}
				mav.addObject("userName", request.getParameter("userName"));
				mav.addObject("user", request.getParameter("user"));
			}
			
		}*/
		
		
		return mav;
	}

	@RequestMapping(value = "/defaultTemplate")
	public ModelAndView editDefault(HttpServletRequest request) {

		System.out.println(request.getParameter("user"));
		System.out.println(request.getParameter("userName"));

		// mav.clear();
		getDataFromParse(request);

		ParseQuery<ParseObject> queryForDefaultItemsAtLocation = ParseQuery.getQuery("Template");
		queryForDefaultItemsAtLocation.whereEqualTo("Customized", false);

		List<ParseObject> listOfDefaultItemsInTemplate = null;

		try {
			listOfDefaultItemsInTemplate = queryForDefaultItemsAtLocation.find();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		String locationIdForDefaultTemplate = "";
		List<EgsdTemplateObjects> listOfLocationObjects = new ArrayList<EgsdTemplateObjects>(25);
		try {

			Iterator<ParseObject> iteratorForDefaultItemsAtLocation = listOfDefaultItemsInTemplate.listIterator();

			while (iteratorForDefaultItemsAtLocation.hasNext()) {

				ParseObject defaultTemplateObject = iteratorForDefaultItemsAtLocation.next();

				locationIdForDefaultTemplate = defaultTemplateObject.getObjectId();
				listOfLocationObjects.add(new EgsdTemplateObjects(defaultTemplateObject.getObjectId(),
						defaultTemplateObject.getString("Name"), defaultTemplateObject.getObjectId(),
						defaultTemplateObject.getBoolean("Customized")));

			}

		} catch (NullPointerException npe) {

		}

		mav.addObject("defaultTemplateLocationObject", listOfLocationObjects);

		mav.addObject("userName", request.getParameter("userName"));
		mav.addObject("user", request.getParameter("user"));

		mav.setViewName("SuperTemplates");

		return mav;

	}

	// manage contactInfo

	@RequestMapping(value = "/manageDetails", method = RequestMethod.POST)
	public ModelAndView manageContactInfo(HttpServletRequest request) {

		String manageCount = request.getParameter("manageCount");

		int count = Integer.parseInt(manageCount);

		for (int i = 1; i < count; i++) {
			System.out
					.println(request.getParameter("manageType" + i) + " " + request.getParameter("manageDetails" + i));

			/*
			 * ParseObject contactObject=new ParseObject("Phones");
			 * 
			 * if(request.getParameter("manageType"+i) != null )
			 * contactObject.put("Type", request.getParameter("manageType"+i));
			 * if(request.getParameter("manageDetails"+i) != null )
			 * contactObject.put("Ext",
			 * request.getParameter("manageDetails"+i));
			 * if(request.getParameter("manageDetails"+i) != null ||
			 * request.getParameter("manageType"+i) != null)
			 * contactObject.put("PhoneId", request.getParameter("phoneId"));
			 * contactObject.put("LocationId",
			 * request.getParameter("locationId")); try { contactObject.save();
			 * } catch (ParseException e) { // TODO Auto-generated catch block
			 * e.printStackTrace(); }
			 */

		}

		return mav;

	}

	// adding chain hotel

	@RequestMapping(value = "/addChainHotel", method = RequestMethod.POST)
	public ModelAndView addChainHotel(HttpServletRequest request) {

		System.out.println("groupId:" + request.getParameter("groupId"));
		System.out.println("locationId:" + request.getParameter("locationId"));
		System.out.println("User:" + request.getParameter("user"));
		System.out.println("User Name:" + request.getParameter("userName"));

		// adding Location
		ParseFile pf = null;

		ParseObject locationObject = new ParseObject("Location");

		locationObject.put("ParentLocationID", request.getParameter("locationId"));
		locationObject.put("GroupId", request.getParameter("locationId"));
		locationObject.put("Name", request.getParameter("Name"));
		locationObject.put("Address1", request.getParameter("Address1"));
		locationObject.put("Address2", request.getParameter("Address2"));
		locationObject.put("Street", request.getParameter("Street"));
		locationObject.put("Town", request.getParameter("Town"));
		locationObject.put("zipcode", request.getParameter("zipcode"));
		// locationObject.put("ParentLocationID",
		// request.getParameter("chainId"));
		// locationObject.put("", r);

		try {
			locationObject.save();
		} catch (ParseException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

		GenerateQRCode qrcode = new GenerateQRCode();
		byte[] res = null;
		try {
			res = qrcode.qrCode(locationObject.getObjectId());
		} catch (WriterException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		pf = new ParseFile("logo.jpg", res);
		System.out.println(res.length);
		try {
			pf.save();
			locationObject.put("QRCode", pf);
			locationObject.put("Directories", locationObject.getObjectId());
			locationObject.save();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		ParseQuery<ParseObject> queryDefaultDirectoryItemObjects = ParseQuery.getQuery("DirectoryItem");
		queryDefaultDirectoryItemObjects.whereEqualTo("DirectoryID", request.getParameter("groupId"));

		List<ParseObject> listOfDefaultDirectoryItems = null;

		try {
			listOfDefaultDirectoryItems = queryDefaultDirectoryItemObjects.find();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		try {

			Iterator<ParseObject> iteratorForDefaultDirectoryItems = listOfDefaultDirectoryItems.listIterator();

			while (iteratorForDefaultDirectoryItems.hasNext()) {

				ParseObject parseObjectOfParentDirectoryItem = iteratorForDefaultDirectoryItems.next();

				System.out.println(parseObjectOfParentDirectoryItem.getString("Title"));

				ParseObject directoryItemObject = new ParseObject("DirectoryItem");

				if (parseObjectOfParentDirectoryItem.getString("Title") != null)
					directoryItemObject.put("Title", parseObjectOfParentDirectoryItem.getString("Title"));
				if (parseObjectOfParentDirectoryItem.getString("Caption") != null)
					directoryItemObject.put("Caption", parseObjectOfParentDirectoryItem.getString("Caption"));
				if (parseObjectOfParentDirectoryItem.getString("Description") != null)
					directoryItemObject.put("Description", parseObjectOfParentDirectoryItem.getString("Description"));
				if (parseObjectOfParentDirectoryItem.getString("Timings") != null)
					directoryItemObject.put("Timings", parseObjectOfParentDirectoryItem.getString("Timings"));
				if (parseObjectOfParentDirectoryItem.getString("Website") != null)
					directoryItemObject.put("Website", parseObjectOfParentDirectoryItem.getString("Website"));
				if (parseObjectOfParentDirectoryItem.getString("Email") != null)
					directoryItemObject.put("Email", parseObjectOfParentDirectoryItem.getString("Email"));

				if (parseObjectOfParentDirectoryItem.getParseObject("Picture") != null)
					directoryItemObject.put("Picture", parseObjectOfParentDirectoryItem.getParseObject("Picture"));

				directoryItemObject.put("LocationId", locationObject.getObjectId());
				directoryItemObject.put("DirectoryID", locationObject.getObjectId());

				try {
					directoryItemObject.save();
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

				// adding styles to chain directory Items

				ParseQuery<ParseObject> queryForStyleObjects = ParseQuery.getQuery("Style");
				queryForStyleObjects.whereEqualTo("objectId",
						parseObjectOfParentDirectoryItem.getParseObject("StyleId").getObjectId());

				List<ParseObject> listOfDirectoryItemStyleObject = null;

				try {
					listOfDirectoryItemStyleObject = queryForStyleObjects.find();
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

				Iterator<ParseObject> iteratorForDirectoryItemStyleObject = listOfDirectoryItemStyleObject
						.listIterator();

				ParseObject directoryItemStyleObject = iteratorForDirectoryItemStyleObject.next();

				ParseObject directoryItemChainStyleObj = new ParseObject("Style");

				if (directoryItemStyleObject.getString("TitleFont") != null)
					directoryItemChainStyleObj.put("TitleFont", directoryItemStyleObject.getString("TitleFont"));
				if (directoryItemStyleObject.getString("TitleColor") != null)
					directoryItemChainStyleObj.put("TitleColor", directoryItemStyleObject.getString("TitleColor"));
				if (directoryItemStyleObject.getString("CaptionFont") != null)
					directoryItemChainStyleObj.put("CaptionFont", directoryItemStyleObject.getString("CaptionFont"));
				if (directoryItemStyleObject.getString("CaptionColor") != null)
					directoryItemChainStyleObj.put("CaptionColor", directoryItemStyleObject.getString("CaptionColor"));
				if (directoryItemStyleObject.getString("DescriptionFont") != null)
					directoryItemChainStyleObj.put("DescriptionFont",
							directoryItemStyleObject.getString("DescriptionFont"));
				if (directoryItemStyleObject.getString("DescriptionColor") != null)
					directoryItemChainStyleObj.put("DescriptionColor",
							directoryItemStyleObject.getString("DescriptionColor"));
				if (directoryItemStyleObject.getString("PhonesFont") != null)
					directoryItemChainStyleObj.put("PhonesFont", directoryItemStyleObject.getString("PhonesFont"));
				if (directoryItemStyleObject.getString("PhonesColor") != null)
					directoryItemChainStyleObj.put("PhonesColor", directoryItemStyleObject.getString("PhonesColor"));
				if (directoryItemStyleObject.getString("TimingsFont") != null)
					directoryItemChainStyleObj.put("TimingsFont", directoryItemStyleObject.getString("TimingsFont"));
				if (directoryItemStyleObject.getString("TimingsColor") != null)
					directoryItemChainStyleObj.put("TimingsColor", directoryItemStyleObject.getString("TimingsColor"));
				if (directoryItemStyleObject.getString("WebsiteFont") != null)
					directoryItemChainStyleObj.put("WebsiteFont", directoryItemStyleObject.getString("WebsiteFont"));
				if (directoryItemStyleObject.getString("WebsiteColor") != null)
					directoryItemChainStyleObj.put("WebsiteColor", directoryItemStyleObject.getString("WebsiteColor"));
				if (directoryItemStyleObject.getString("EmailFont") != null)
					directoryItemChainStyleObj.put("EmailFont", directoryItemStyleObject.getString("EmailFont"));
				if (directoryItemStyleObject.getString("EmailColor") != null)
					directoryItemChainStyleObj.put("EmailColor", directoryItemStyleObject.getString("EmailColor"));

				directoryItemChainStyleObj.put("LocationId", locationObject.getObjectId());

				try {
					directoryItemChainStyleObj.save();
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

				directoryItemObject.put("StyleId", directoryItemChainStyleObj);

				try {
					directoryItemObject.save();
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

				// adding phone Items

				ParseQuery<ParseObject> queryForPhoneObjects = ParseQuery.getQuery("Phones");
				queryForPhoneObjects.whereEqualTo("PhoneId", parseObjectOfParentDirectoryItem.getObjectId());

				List<ParseObject> listOfPhoneObjects = null;

				try {
					listOfPhoneObjects = queryForPhoneObjects.find();
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

				try {

					Iterator<ParseObject> iteratorForPhoneObjects = listOfPhoneObjects.listIterator();

					while (iteratorForPhoneObjects.hasNext()) {

						ParseObject phoneObject = iteratorForPhoneObjects.next();

						ParseObject newPhoneObject = new ParseObject("Phones");

						if (phoneObject.getString("Ext") != null)
							newPhoneObject.put("Ext", phoneObject.getString("Ext"));
						if (phoneObject.getString("Type") != null)
							newPhoneObject.put("Type", phoneObject.getString("Type"));

						newPhoneObject.put("PhoneId", directoryItemObject.getObjectId());
						newPhoneObject.put("LocationId", locationObject.getObjectId());
						try {
							newPhoneObject.save();
						} catch (ParseException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}

					}

				} catch (NullPointerException npe) {

				}

				checkChain(parseObjectOfParentDirectoryItem.getObjectId(), directoryItemObject,
						directoryItemObject.getObjectId(), locationObject.getObjectId());

			}

		} catch (NullPointerException npe) {

		}

		// getDataFromParse(request);

		adminLoad(request);

		mav.addObject("userName", request.getParameter("userName"));
		mav.addObject("user", request.getParameter("user"));

		if (request.getParameter("userName").equals("Location Admin"))
			mav.setViewName("LocationAdmin");
		if (request.getParameter("userName").equals("CS Admin"))
			mav.setViewName("CSAdmin");
		if (request.getParameter("userName").equals("Super Admin"))
			mav.setViewName("SuperAdmin");
		if (request.getParameter("userName").equals("IT Admin"))
			mav.setViewName("ITAdmin");

		return mav;
	}

	// adding group

	@RequestMapping(value = "/addGroup", method = RequestMethod.POST)
	public ModelAndView addGroup(HttpServletRequest request) {

		System.out.println("Group Name:" + request.getParameter("groupName"));
		System.out.println("Template Id:" + request.getParameter("templateId"));
		System.out.println("User:" + request.getParameter("user"));
		System.out.println("User Name:" + request.getParameter("userName"));

		// adding Template object
		ParseObject templateObject = new ParseObject("Template");

		templateObject.put("Name", request.getParameter("groupName"));
		templateObject.put("Customized", true);
		templateObject.put("type", "group");

		try {
			templateObject.save();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		templateObject.put("LocationId", templateObject.getObjectId());

		ParseQuery<ParseObject> queryDefaultDirectoryItemObjects = ParseQuery.getQuery("DirectoryItem");
		queryDefaultDirectoryItemObjects.whereEqualTo("DirectoryID", request.getParameter("templateId"));

		List<ParseObject> listOfDefaultDirectoryItems = null;

		try {
			listOfDefaultDirectoryItems = queryDefaultDirectoryItemObjects.find();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		try {

			Iterator<ParseObject> iteratorForDefaultDirectoryItems = listOfDefaultDirectoryItems.listIterator();

			while (iteratorForDefaultDirectoryItems.hasNext()) {

				ParseObject parseObjectOfParentDirectoryItem = iteratorForDefaultDirectoryItems.next();

				System.out.println(parseObjectOfParentDirectoryItem.getString("Title"));

				ParseObject directoryItemObject = new ParseObject("DirectoryItem");

				if (parseObjectOfParentDirectoryItem.getString("Title") != null)
					directoryItemObject.put("Title", parseObjectOfParentDirectoryItem.getString("Title"));
				if (parseObjectOfParentDirectoryItem.getString("Caption") != null)
					directoryItemObject.put("Caption", parseObjectOfParentDirectoryItem.getString("Caption"));
				if (parseObjectOfParentDirectoryItem.getString("Description") != null)
					directoryItemObject.put("Description", parseObjectOfParentDirectoryItem.getString("Description"));
				if (parseObjectOfParentDirectoryItem.getString("Timings") != null)
					directoryItemObject.put("Timings", parseObjectOfParentDirectoryItem.getString("Timings"));
				if (parseObjectOfParentDirectoryItem.getString("Website") != null)
					directoryItemObject.put("Website", parseObjectOfParentDirectoryItem.getString("Website"));
				if (parseObjectOfParentDirectoryItem.getString("Email") != null)
					directoryItemObject.put("Email", parseObjectOfParentDirectoryItem.getString("Email"));
				
				directoryItemObject.put("CustomizedOrder", parseObjectOfParentDirectoryItem.getInt("CustomizedOrder"));
								
				ParseFile parseFile = null;
				if (parseObjectOfParentDirectoryItem.getParseFile("Picture") != null)
				{
					byte[] taxi = null;
					
					
					try {
						taxi = parseObjectOfParentDirectoryItem.getParseFile("Picture").getData();
					} catch (ParseException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					
					parseFile = new ParseFile("Picture.png", taxi);
					try {
						parseFile.save();
					} catch (ParseException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					directoryItemObject.put("Picture", parseFile);
				}
				
				

				directoryItemObject.put("LocationId", templateObject.getObjectId());
				directoryItemObject.put("DirectoryID", templateObject.getObjectId());

				try {
					directoryItemObject.save();
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

				// adding styles to chain directory Items

				ParseQuery<ParseObject> queryForStyleObjects = ParseQuery.getQuery("Style");
				queryForStyleObjects.whereEqualTo("objectId",
						parseObjectOfParentDirectoryItem.getParseObject("StyleId").getObjectId());

				List<ParseObject> listOfDirectoryItemStyleObject = null;

				try {
					listOfDirectoryItemStyleObject = queryForStyleObjects.find();
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

				Iterator<ParseObject> iteratorForDirectoryItemStyleObject = listOfDirectoryItemStyleObject
						.listIterator();

				ParseObject directoryItemStyleObject = iteratorForDirectoryItemStyleObject.next();

				ParseObject directoryItemChainStyleObj = new ParseObject("Style");

				if (directoryItemStyleObject.getString("TitleFont") != null)
					directoryItemChainStyleObj.put("TitleFont", directoryItemStyleObject.getString("TitleFont"));
				if (directoryItemStyleObject.getString("TitleColor") != null)
					directoryItemChainStyleObj.put("TitleColor", directoryItemStyleObject.getString("TitleColor"));
				if (directoryItemStyleObject.getString("TitleFamily") != null)
					directoryItemChainStyleObj.put("TitleFamily", directoryItemStyleObject.getString("TitleFamily"));
				if (directoryItemStyleObject.getString("CaptionFont") != null)
					directoryItemChainStyleObj.put("CaptionFont", directoryItemStyleObject.getString("CaptionFont"));
				if (directoryItemStyleObject.getString("CaptionColor") != null)
					directoryItemChainStyleObj.put("CaptionColor", directoryItemStyleObject.getString("CaptionColor"));
				if (directoryItemStyleObject.getString("CaptionFamily") != null)
					directoryItemChainStyleObj.put("CaptionFamily", directoryItemStyleObject.getString("CaptionFamily"));
				if (directoryItemStyleObject.getString("PhonesFont") != null)
					directoryItemChainStyleObj.put("PhonesFont", directoryItemStyleObject.getString("PhonesFont"));
				if (directoryItemStyleObject.getString("PhonesColor") != null)
					directoryItemChainStyleObj.put("PhonesColor", directoryItemStyleObject.getString("PhonesColor"));
				if (directoryItemStyleObject.getString("TimingsFont") != null)
					directoryItemChainStyleObj.put("TimingsFont", directoryItemStyleObject.getString("TimingsFont"));
				if (directoryItemStyleObject.getString("TimingsColor") != null)
					directoryItemChainStyleObj.put("TimingsColor", directoryItemStyleObject.getString("TimingsColor"));
				if (directoryItemStyleObject.getString("TimingsFamily") != null)
					directoryItemChainStyleObj.put("TimingsFamily", directoryItemStyleObject.getString("TimingsFamily"));
				if (directoryItemStyleObject.getString("priceFont") != null)
					directoryItemChainStyleObj.put("priceFont", directoryItemStyleObject.getString("priceFont"));
				if (directoryItemStyleObject.getString("priceColor") != null)
					directoryItemChainStyleObj.put("priceColor", directoryItemStyleObject.getString("priceColor"));
				if (directoryItemStyleObject.getString("priceFamily") != null)
					directoryItemChainStyleObj.put("priceFamily", directoryItemStyleObject.getString("priceFamily"));
				

				directoryItemChainStyleObj.put("LocationId", templateObject.getObjectId());

				try {
					directoryItemChainStyleObj.save();
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

				directoryItemObject.put("StyleId", directoryItemChainStyleObj);

				try {
					directoryItemObject.save();
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

				// adding phone Items

				ParseQuery<ParseObject> queryForPhoneObjects = ParseQuery.getQuery("Phones");
				queryForPhoneObjects.whereEqualTo("PhoneId", parseObjectOfParentDirectoryItem.getObjectId());

				List<ParseObject> listOfPhoneObjects = null;

				try {
					listOfPhoneObjects = queryForPhoneObjects.find();
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

				try {

					Iterator<ParseObject> iteratorForPhoneObjects = listOfPhoneObjects.listIterator();

					while (iteratorForPhoneObjects.hasNext()) {

						ParseObject phoneObject = iteratorForPhoneObjects.next();

						ParseObject newPhoneObject = new ParseObject("Phones");

						if (phoneObject.getString("Ext") != null)
							newPhoneObject.put("Ext", phoneObject.getString("Ext"));
						if (phoneObject.getString("Type") != null)
							newPhoneObject.put("Type", phoneObject.getString("Type"));

						newPhoneObject.put("PhoneId", directoryItemObject.getObjectId());

						newPhoneObject.put("LocationId", templateObject.getObjectId());
						try {
							newPhoneObject.save();
						} catch (ParseException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}

					}

				} catch (NullPointerException npe) {

				}
				
				
				// adding menu Items

				System.out.println(parseObjectOfParentDirectoryItem.getObjectId());
				  ParseQuery<ParseObject>  queryForMenuObjects=ParseQuery.getQuery("Menu");
				  queryForMenuObjects.whereEqualTo("MenuId", parseObjectOfParentDirectoryItem.getObjectId());
				  
				  List<ParseObject> listOfMenuObjects=null;
				  
				  try { 
					  listOfMenuObjects=queryForMenuObjects.find(); 
				  } 
				  catch(ParseException e) { 
					  // TODO Auto-generated catch block
					  e.printStackTrace(); 
					  }
				  
				  
				  try{
				  
				  Iterator<ParseObject> iteratorForMenuObjects=listOfMenuObjects.listIterator();
				  
				  while(iteratorForMenuObjects.hasNext()){
				  
				  ParseObject menuObject=iteratorForMenuObjects.next();
				  
				  ParseObject newMenuObject=new ParseObject("Menu");
				  
				  if(menuObject.getString("Description")!=null || menuObject.getString("Description")!= "")
				  newMenuObject.put("Description", menuObject.getString("Description"));
				  if(menuObject.getString("Price")!=null || menuObject.getString("Description")!= "")
				  newMenuObject.put("Price", menuObject.getString("Price"));
				  
				  newMenuObject.put("StyleID",directoryItemChainStyleObj);
				  newMenuObject.put("MenuId",directoryItemObject.getObjectId());
				  newMenuObject.put("LocationId",templateObject.getObjectId());
				  
				  try { 
					  newMenuObject.save(); 
					} catch (ParseException e) { 
				  //TODO Auto-generated catch block e.printStackTrace(); 
					  }
				  
				  }
				  
				  
				  }catch(NullPointerException npe){
				  
				  
				  }
				

				checkChain(parseObjectOfParentDirectoryItem.getObjectId(), directoryItemObject,
						directoryItemObject.getObjectId(), templateObject.getObjectId());

			}

		} catch (NullPointerException npe) {

		}

		request.setAttribute("tempId", templateObject.getObjectId());
		
		viewTemplates(request);
		
		mav.addObject("userName", request.getParameter("userName"));
		mav.addObject("user", request.getParameter("user"));
		
		if (request.getParameter("userName").equals("Super Admin"))
			mav.setViewName("SuperAdminGroups");

		if (request.getParameter("userName").equals("IT Admin"))
			mav.setViewName("ITAdminGroups");

		if (request.getParameter("userName").equals("CS Admin"))
			mav.setViewName("CSAdminGroups");
		

		
		/*if (request.getParameter("locId") != null) {
				request.setAttribute("locId", request.getParameter("locId"));
	
				try {
					select(request);
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				mav.addObject("userName", request.getParameter("userName"));
				mav.addObject("user", request.getParameter("user"));
								
				if (request.getParameter("userName").equals("CS Admin")) {
					mav.setViewName("CSAdmin");
				}
				if (request.getParameter("userName").equals("Super Admin")) {
					mav.setViewName("SuperAdmin");
				}
				if (request.getParameter("userName").equals("IT Admin")) {
					mav.setViewName("ITAdmin");
				}
				
		}
		else
		{
			if (request.getParameter("tempId") != null) {
				
				request.setAttribute("tempId", request.getParameter("tempId"));
				
				viewTemplates(request);
				
				mav.addObject("userName", request.getParameter("userName"));
				mav.addObject("user", request.getParameter("user"));
				
				if (request.getParameter("userName").equals("Super Admin"))
					mav.setViewName("SuperAdminTemplates");

				if (request.getParameter("userName").equals("IT Admin"))
					mav.setViewName("ITAdminTemplates");

				if (request.getParameter("userName").equals("CS Admin"))
					mav.setViewName("CSAdminTemplates");

				
			}

			else {
				
				adminLoad(request);
				
				mav.addObject("userName", request.getParameter("userName"));
				mav.addObject("user", request.getParameter("user"));
				
				if (request.getParameter("userName").equals("CS Admin")) {
					mav.setViewName("CSHotelList");
				}
				if (request.getParameter("userName").equals("Super Admin")) {
					mav.setViewName("SuperHotelList");
				}
				if (request.getParameter("userName").equals("IT Admin")) {
					mav.setViewName("ITHotelList");
				}
				
			}
		}*/

		return mav;

	}

	// adding group

	@RequestMapping(value = "/Admin/addGroupHotelList", method = RequestMethod.POST)
	public @ResponseBody String addGroupHotelList(HttpServletRequest request) {

		System.out.println("Group Name:" + request.getParameter("groupName"));
		System.out.println("Template Id:" + request.getParameter("templateId"));
		System.out.println("User:" + request.getParameter("user"));
		System.out.println("User Name:" + request.getParameter("userName"));

		// adding Template object
		ParseObject templateObject = new ParseObject("Template");

		templateObject.put("Name", request.getParameter("groupName"));
		templateObject.put("Customized", true);
		templateObject.put("type", "group");

		try {
			templateObject.save();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		templateObject.put("LocationId", templateObject.getObjectId());

		ParseQuery<ParseObject> queryDefaultDirectoryItemObjects = ParseQuery.getQuery("DirectoryItem");
		queryDefaultDirectoryItemObjects.whereEqualTo("DirectoryID", request.getParameter("templateId"));

		List<ParseObject> listOfDefaultDirectoryItems = null;

		try {
			listOfDefaultDirectoryItems = queryDefaultDirectoryItemObjects.find();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		try {

			Iterator<ParseObject> iteratorForDefaultDirectoryItems = listOfDefaultDirectoryItems.listIterator();

			while (iteratorForDefaultDirectoryItems.hasNext()) {

				ParseObject parseObjectOfParentDirectoryItem = iteratorForDefaultDirectoryItems.next();

				System.out.println(parseObjectOfParentDirectoryItem.getString("Title"));

				ParseObject directoryItemObject = new ParseObject("DirectoryItem");

				if (parseObjectOfParentDirectoryItem.getString("Title") != null)
					directoryItemObject.put("Title", parseObjectOfParentDirectoryItem.getString("Title"));
				if (parseObjectOfParentDirectoryItem.getString("Caption") != null)
					directoryItemObject.put("Caption", parseObjectOfParentDirectoryItem.getString("Caption"));
				if (parseObjectOfParentDirectoryItem.getString("Description") != null)
					directoryItemObject.put("Description", parseObjectOfParentDirectoryItem.getString("Description"));
				if (parseObjectOfParentDirectoryItem.getString("Timings") != null)
					directoryItemObject.put("Timings", parseObjectOfParentDirectoryItem.getString("Timings"));
				if (parseObjectOfParentDirectoryItem.getString("Website") != null)
					directoryItemObject.put("Website", parseObjectOfParentDirectoryItem.getString("Website"));
				if (parseObjectOfParentDirectoryItem.getString("Email") != null)
					directoryItemObject.put("Email", parseObjectOfParentDirectoryItem.getString("Email"));

				if (parseObjectOfParentDirectoryItem.getParseObject("Picture") != null)
					directoryItemObject.put("Picture", parseObjectOfParentDirectoryItem.getParseObject("Picture"));

				directoryItemObject.put("LocationId", templateObject.getObjectId());
				directoryItemObject.put("DirectoryID", templateObject.getObjectId());

				try {
					directoryItemObject.save();
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

				// adding styles to chain directory Items

				ParseQuery<ParseObject> queryForStyleObjects = ParseQuery.getQuery("Style");
				queryForStyleObjects.whereEqualTo("objectId",
						parseObjectOfParentDirectoryItem.getParseObject("StyleId").getObjectId());

				List<ParseObject> listOfDirectoryItemStyleObject = null;

				try {
					listOfDirectoryItemStyleObject = queryForStyleObjects.find();
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

				Iterator<ParseObject> iteratorForDirectoryItemStyleObject = listOfDirectoryItemStyleObject
						.listIterator();

				ParseObject directoryItemStyleObject = iteratorForDirectoryItemStyleObject.next();

				ParseObject directoryItemChainStyleObj = new ParseObject("Style");

				if (directoryItemStyleObject.getString("TitleFont") != null)
					directoryItemChainStyleObj.put("TitleFont", directoryItemStyleObject.getString("TitleFont"));
				if (directoryItemStyleObject.getString("TitleColor") != null)
					directoryItemChainStyleObj.put("TitleColor", directoryItemStyleObject.getString("TitleColor"));
				if (directoryItemStyleObject.getString("CaptionFont") != null)
					directoryItemChainStyleObj.put("CaptionFont", directoryItemStyleObject.getString("CaptionFont"));
				if (directoryItemStyleObject.getString("CaptionColor") != null)
					directoryItemChainStyleObj.put("CaptionColor", directoryItemStyleObject.getString("CaptionColor"));
				if (directoryItemStyleObject.getString("DescriptionFont") != null)
					directoryItemChainStyleObj.put("DescriptionFont",
							directoryItemStyleObject.getString("DescriptionFont"));
				if (directoryItemStyleObject.getString("DescriptionColor") != null)
					directoryItemChainStyleObj.put("DescriptionColor",
							directoryItemStyleObject.getString("DescriptionColor"));
				if (directoryItemStyleObject.getString("PhonesFont") != null)
					directoryItemChainStyleObj.put("PhonesFont", directoryItemStyleObject.getString("PhonesFont"));
				if (directoryItemStyleObject.getString("PhonesColor") != null)
					directoryItemChainStyleObj.put("PhonesColor", directoryItemStyleObject.getString("PhonesColor"));
				if (directoryItemStyleObject.getString("TimingsFont") != null)
					directoryItemChainStyleObj.put("TimingsFont", directoryItemStyleObject.getString("TimingsFont"));
				if (directoryItemStyleObject.getString("TimingsColor") != null)
					directoryItemChainStyleObj.put("TimingsColor", directoryItemStyleObject.getString("TimingsColor"));
				if (directoryItemStyleObject.getString("WebsiteFont") != null)
					directoryItemChainStyleObj.put("WebsiteFont", directoryItemStyleObject.getString("WebsiteFont"));
				if (directoryItemStyleObject.getString("WebsiteColor") != null)
					directoryItemChainStyleObj.put("WebsiteColor", directoryItemStyleObject.getString("WebsiteColor"));
				if (directoryItemStyleObject.getString("EmailFont") != null)
					directoryItemChainStyleObj.put("EmailFont", directoryItemStyleObject.getString("EmailFont"));
				if (directoryItemStyleObject.getString("EmailColor") != null)
					directoryItemChainStyleObj.put("EmailColor", directoryItemStyleObject.getString("EmailColor"));

				directoryItemChainStyleObj.put("LocationId", templateObject.getObjectId());

				try {
					directoryItemChainStyleObj.save();
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

				directoryItemObject.put("StyleId", directoryItemChainStyleObj);

				try {
					directoryItemObject.save();
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

				// adding phone Items

				ParseQuery<ParseObject> queryForPhoneObjects = ParseQuery.getQuery("Phones");
				queryForPhoneObjects.whereEqualTo("PhoneId", parseObjectOfParentDirectoryItem.getObjectId());

				List<ParseObject> listOfPhoneObjects = null;

				try {
					listOfPhoneObjects = queryForPhoneObjects.find();
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

				try {

					Iterator<ParseObject> iteratorForPhoneObjects = listOfPhoneObjects.listIterator();

					while (iteratorForPhoneObjects.hasNext()) {

						ParseObject phoneObject = iteratorForPhoneObjects.next();

						ParseObject newPhoneObject = new ParseObject("Phones");

						if (phoneObject.getString("Ext") != null)
							newPhoneObject.put("Ext", phoneObject.getString("Ext"));
						if (phoneObject.getString("Type") != null)
							newPhoneObject.put("Type", phoneObject.getString("Type"));

						newPhoneObject.put("PhoneId", directoryItemObject.getObjectId());

						newPhoneObject.put("LocationId", templateObject.getObjectId());
						try {
							newPhoneObject.save();
						} catch (ParseException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}

					}

				} catch (NullPointerException npe) {

				}

				checkChain(parseObjectOfParentDirectoryItem.getObjectId(), directoryItemObject,
						directoryItemObject.getObjectId(), templateObject.getObjectId());

			}

		} catch (NullPointerException npe) {

		}

		return "success";

		// getDataFromParse(request);
		/*
		 * adminLoad(request);
		 * 
		 * mav.addObject("userName", request.getParameter("userName"));
		 * mav.addObject("user", request.getParameter("user"));
		 * 
		 * if (request.getParameter("userName").equals("Location Admin"))
		 * mav.setViewName("LocationAdmin"); if
		 * (request.getParameter("userName").equals("CS Admin"))
		 * mav.setViewName("CSAdmin"); if
		 * (request.getParameter("userName").equals("Super Admin"))
		 * 
		 * mav.setViewName("SuperAdmin");
		 * 
		 * 
		 * return mav;
		 */
	}

	
	@RequestMapping(value = "/jstree")
	public String jstree(HttpServletRequest request) throws ParseException {
		String result = "success";
		String source = request.getParameter("sourceElementID");
		String dest = request.getParameter("destinationElementID");
		String src = null;
		String position = request.getParameter("position");
		int oldPosition = 0;	
		System.out.println("source is " + source);
		System.out.println("dest is " + dest);
		
		
		ParseQuery<ParseObject> queryForDirectoryItemsElements;
		List<ParseObject> listOfDirResultsElements = null;
		Iterator<ParseObject> iteratorForDirectoriesElements;
		
		String dirId= "";
		int dirPos = 0;
		try {
			queryForDirectoryItemsElements = ParseQuery.getQuery("DirectoryItem");		
			queryForDirectoryItemsElements.whereEqualTo("objectId", source);
			//queryForDirectoryItems.whereEqualTo("objectId", source);

			try {
				listOfDirResultsElements = queryForDirectoryItemsElements.find();
			} catch (ParseException e2) {
				// TODO Auto-generated catch block
				e2.printStackTrace();
			}
			iteratorForDirectoriesElements = listOfDirResultsElements.listIterator();	
			while (iteratorForDirectoriesElements.hasNext()) {		
				
				ParseObject parseObjectHavingDir = iteratorForDirectoriesElements.next();
				
				dirId = parseObjectHavingDir.getString("DirectoryID");
				src = dirId;
				dirPos = parseObjectHavingDir.getInt("CustomizedOrder");
				
			}
		} catch (NullPointerException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		System.out.println(dirId);
		System.out.println(dirPos);
		
		
		
		ParseQuery<ParseObject> queryForDirectoryItems;
		List<ParseObject> listOfDirResults = null;
		Iterator<ParseObject> iteratorForDirectories;
		
		try {
			queryForDirectoryItems = ParseQuery.getQuery("DirectoryItem");		
			queryForDirectoryItems.whereEqualTo("DirectoryID", dest);
			queryForDirectoryItems.orderByAscending("CustomizedOrder");
			//queryForDirectoryItems.whereEqualTo("objectId", source);

			try {
				listOfDirResults = queryForDirectoryItems.find();
			} catch (ParseException e2) {
				// TODO Auto-generated catch block
				e2.printStackTrace();
			}
			iteratorForDirectories = listOfDirResults.listIterator();	
			while (iteratorForDirectories.hasNext()) {		
				
				ParseObject parseObjectHavingDir = iteratorForDirectories.next();
				
				String objectId = parseObjectHavingDir.getObjectId();
				if(objectId.equalsIgnoreCase(source)){
					oldPosition = parseObjectHavingDir.getInt("CustomizedOrder");
				}
			}
		} catch (NullPointerException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		//if(oldPosition == 0){
/*			if(listOfDirResults != null){
				oldPosition = listOfDirResults.size();	
			}else{
				oldPosition = 0;
			}*/
			
			oldPosition = !src.equals(dest) ? Integer.parseInt(position) : oldPosition;
			int curPos = Integer.parseInt(position);
			
			ParseObject jsTree = ParseObject.createWithoutData("DirectoryItem", source);
			if (dest != null && !dest.equals("")) {
				jsTree.put("DirectoryID", dest);
				//jsTree.put("ParentDirectoryId", dest);
				jsTree.put("CustomizedOrder", curPos);
			}
			try {
				jsTree.save();
			} catch (Exception ee) {
				result = "error";
				ee.printStackTrace();
				
			}
			
			try {
				queryForDirectoryItems = ParseQuery.getQuery("DirectoryItem");		
				queryForDirectoryItems.whereEqualTo("DirectoryID", dest);
				queryForDirectoryItems.orderByAscending("CustomizedOrder");
				listOfDirResults = queryForDirectoryItems.find();

			} catch (ParseException e2) {
				// TODO Auto-generated catch block
				e2.printStackTrace();
			}

		//}
			
	
		try {					

			iteratorForDirectories = listOfDirResults.listIterator();
			while (iteratorForDirectories.hasNext()) {		
				
				ParseObject parseObjectHavingDir = iteratorForDirectories.next();
				
				ParseObject updateOrder = ParseObject.createWithoutData("DirectoryItem", parseObjectHavingDir.getObjectId());				
								
				if(src.equals(dest)){
					int order = parseObjectHavingDir.getInt("CustomizedOrder");
					if(curPos < oldPosition && oldPosition >= order){
						if(curPos <= order && !source.equalsIgnoreCase(parseObjectHavingDir.getObjectId())){
							order = order + 1;
							updateOrder.put("CustomizedOrder", order);
							try {
								updateOrder.save();
							} catch (Exception ee) {
								result = "error";
								ee.printStackTrace();
								
							}
						}
				}
						else if(oldPosition <= order){
								if(curPos >= order && !source.equalsIgnoreCase(parseObjectHavingDir.getObjectId())){
									order = order - 1;
									updateOrder.put("CustomizedOrder", order);
									try {
										updateOrder.save();
									} catch (Exception ee) {
										result = "error";
										ee.printStackTrace();
										
									}
								}
							}						
				}	
				else{
					int order = parseObjectHavingDir.getInt("CustomizedOrder");
						if(order >= Integer.parseInt(position) && !source.equalsIgnoreCase(parseObjectHavingDir.getObjectId())){
							order = order + 1;
							updateOrder.put("CustomizedOrder", order);
							try {
								updateOrder.save();
							} catch (Exception ee) {
								result = "error";
								ee.printStackTrace();
								
							}
						}
					
				}

				}				

		} catch (NullPointerException npe) {

			System.out.println(npe.getMessage());

		}
		
		
		
		ParseQuery<ParseObject> queryForParentDirectoryItems;
		List<ParseObject> listOfParentElements = null;
		Iterator<ParseObject> iteratorParentDirectoriesElements;
		
		if(!src.equals(dest)){
		try {
			queryForParentDirectoryItems = ParseQuery.getQuery("DirectoryItem");		
			queryForParentDirectoryItems.whereEqualTo("DirectoryID", src);
			queryForParentDirectoryItems.orderByAscending("CustomizedOrder");
			//queryForDirectoryItems.whereEqualTo("objectId", source);

			try {
				listOfParentElements = queryForParentDirectoryItems.find();
			} catch (ParseException e2) {
				// TODO Auto-generated catch block
				e2.printStackTrace();
			}
			iteratorParentDirectoriesElements = listOfParentElements.listIterator();	
			while (iteratorParentDirectoriesElements.hasNext()) {		
				
				ParseObject parseObjectHavingDir = iteratorParentDirectoriesElements.next();
				
				ParseObject updateOrder = ParseObject.createWithoutData("DirectoryItem", parseObjectHavingDir.getObjectId());	
				
				int order = parseObjectHavingDir.getInt("CustomizedOrder");
				
				if(dirPos < order){
							order = order - 1;
							updateOrder.put("CustomizedOrder", order);
							try {
								updateOrder.save();
							} catch (Exception ee) {
								result = "error";
								ee.printStackTrace();
								
							}
				}
				
				
			}
		} catch (NullPointerException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		}
		
		return result;
	}

	@RequestMapping(value = "/adminApplication")
	public String adminApplication(HttpServletRequest request) throws ParseException {
		String elementID = request.getParameter("elementID");
		int frontDesk = Integer.parseInt(request.getParameter("frontDesk"));
		int baggage = Integer.parseInt(request.getParameter("baggage"));
		int maidService = Integer.parseInt(request.getParameter("maidService"));
		int emergency = Integer.parseInt(request.getParameter("emergency"));
		String food = request.getParameter("food");
		String taxi = request.getParameter("taxi");
		String localAttractions = request.getParameter("localAttractions");
		String hotelDirectory = request.getParameter("hotelDirectory");

		ParseObject parseObjectForLocation = ParseObject.createWithoutData("Location", elementID);

		if (frontDesk != 0) {
			parseObjectForLocation.put("FrontDesk", frontDesk);
		}
		if (baggage != 0) {
			parseObjectForLocation.put("BellDesk", baggage);
		}
		if (maidService != 0) {
			parseObjectForLocation.put("MaidDesk", maidService);
		}
		if (emergency != 0) {
			parseObjectForLocation.put("Emergency", emergency);
		}
		if (food != null) {
			parseObjectForLocation.put("food", food);
		}
		if (taxi != null) {
			parseObjectForLocation.put("taxi", taxi);
		}
		if (localAttractions != null) {
			parseObjectForLocation.put("localAttractions", localAttractions);
		}
		if (hotelDirectory != null) {
			parseObjectForLocation.put("hotelDirectory", hotelDirectory);
		}

		try {
			parseObjectForLocation.save();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return "";
	}

	/*
	 * @RequestMapping(value = "/addLocation/{locName}") public @ResponseBody
	 * JsonResponse addLocation(@PathVariable("locName") String locName,
	 * BindingResult result ){ JsonResponse res = new JsonResponse(); //
	 * List<CSAdminUser> userList = new ArrayList<CSAdminUser>();
	 * ValidationUtils.rejectIfEmpty(result, "location",
	 * "Location can not be empty.");
	 * 
	 * System.out.println(); if(!result.hasErrors()){
	 * 
	 * res.setStatus("SUCCESS"); }else{ res.setStatus("FAIL");
	 * res.setResult(result.getAllErrors()); }
	 * 
	 * return res; }
	 */

}
