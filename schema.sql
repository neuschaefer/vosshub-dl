-- SPDX-License-Identifier: MIT

-- Models, the primary results in the search page
CREATE TABLE IF NOT EXISTS models (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	category varchar(100) NOT NULL,
	brand varchar(100) NOT NULL,
	model varchar(100) NOT NULL,
	UNIQUE(category, brand, model)
);

-- Downloads, as they appear in the "Source Code" column on the search page
-- NOTE: (modelid, name) is not unique. For example, live555 appears twice in
--       the file listing for "17MB97 43277DLBN VESTEL 43FA7000T"
CREATE TABLE IF NOT EXISTS downloads (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	modelid INTEGER NOT NULL,
	fileid INTEGER NOT NULL,
	productid INTEGER NOT NULL,
	name INTEGER NOT NULL,
	UNIQUE(modelid, fileid, productid, name)
);

-- Actual downloadable files. Files are assumed to be uniquely identified by
-- their fileid from the downloads table.
CREATE TABLE IF NOT EXISTS files (
	id INTEGER PRIMARY KEY,
	location varchar(100)
);
