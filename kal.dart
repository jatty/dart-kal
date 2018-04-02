#!/usr/bin/env dart

	// print (ostern.toString().split(' ')[0]);

void main(List<String> args) {
        str wd = ["Mo", "Di", "Mi", "Do", "Fr", "Sa", "So"];
	int year, month, day;
	int a, b, c, d, e, m, n;
        str type = "";

	if (args.length > 0) {
		year = int.parse(args[0]);
	} else {
		year = new DateTime.now().year;
	}
        if (args.length > 1) {
		type = args[1];
        } else {
		type = "all";
	}

	// Gauss
	if (year < 1583 || year > 2299) {
		print ("Error: Year out of range");
		return 1;
	}
	else if (year < 1700) { m = 22; n = 2; }
	else if (year < 1800) { m = 23; n = 3; }
	else if (year < 1900) { m = 23; n = 4; }
	else if (year < 2100) { m = 24; n = 5; }
	else if (year < 2200) { m = 24; n = 6; }
	else                  { m = 25; n = 0; }

	a = year % 19; b = year % 4; c = year % 7;
	d = (19 * a + m) % 30;
	e = (2 * b + 4 * c + 6 * d + n) % 7;
	day = 22 + d + e;
	month = 3;
	if (day > 31) {
		day -= 31;
		month++;
	}
	if (day == 26 && month == 4)
		day = 19;
	else if (day == 25 && month == 4 && d == 28 && e == 6 && a > 10)
		day = 18;
	// Workaround gegen Sommerzeitunstimmigkeiten bei DateTime.add: 5 Uhr als Uhrzeit
	DateTime ostern = new DateTime(year, month, day, 5, 0, 0);
	Map<String, String> daten = new Map();

	// Feste Jahrestermine
	daten = {
		new DateTime(year, 1, 1): "Neujahr",
		new DateTime(year, 1, 6): "Hl. Drei Könige",
		new DateTime(year, 5, 1): "Maifeiertag",
		new DateTime(year, 8, 15): "Mariä Himmelfahrt",
		new DateTime(year, 10, 3): "Tag der deutschen Einheit",
		new DateTime(year, 11, 1): "Allerheiligen",
		new DateTime(year, 12, 24): "Hl. Abend",
		new DateTime(year, 12, 25): "1. Weihnachtsfeiertag",
		new DateTime(year, 12, 26): "2. Weihnachtsfeiertag",
	};
	// Ostertermine
        Str Feiertag = ["Rosenmontag", "Faschingsdienstag", "Aschermittwoch", "Palmsonntag", "Karfreitag", "Ostersonntag", "Ostermontag", "Christi Himmelfahrt", "Pfingstsonntag", "Pfingstmontag", "Fronleichnam"];
	Str Feiertagoffset = [-48, -47, -46, -7, -2, 0, 1, 39, 49, 50, 60];
        for (int i = 0; i < Feiertag.length; i++)
		daten[ostern.add(new Duration(days: Feiertagoffset[i]))] = Feiertag[i];
	// Muttertag ist der zweite Sonntag im Mai (seit 2008 auch an Pfingstsonntag)
	for (int i = 1, j = 0; i < 15; i++) {
		DateTime muttertag = new DateTime(year, 5, i, 5, 0, 0);
		if (muttertag.weekday == DateTime.SUNDAY) {
			if (++j == 2) {
				daten[muttertag] = "Muttertag";
				break;
			}
		}
	}
	// Buß- und Bettag ist am Mittwoch zwischen 16. und 22. November
	for (int i = 22; i >= 16; i--) {
		DateTime bussundbettag = new DateTime(year, 11, i, 5, 0, 0);
		if (bussundbettag.weekday == DateTime.WEDNESDAY) {
			daten[bussundbettag] = "Buß- und Bettag";
			break;
		}
	}
        int type2 = 1;
        List liste = [];
        str Daten = "";
	for (int i in daten.keys.toList()..sort()) {
                if (type.toLowerCase() == daten[i].toLowerCase() || type == "all") {
			// dt. Schreibweise
			var day = i.day; var month = i.month; var year = i.year;
			day = day.toString(); if (day.length == 1) day = "0" + day;
			month = month.toString(); if (month.length == 1) month = "0" + month;
			Daten = "${daten[i]}: ${wd[i.weekday-1]}, $day.$month.$year";
			if (type2 == 1)
				print (Daten);
			else
				liste.add(Daten);
			// ISO-Schreibweise
			// print ("${wd[i.weekday-1]} ${i.toString().split(' ')[0]} ${daten[i]}");
		}
	}
        if (type2 == 2) {
		liste.sort();
		for (str i in liste) print(i);
	}
        return 0;
}
