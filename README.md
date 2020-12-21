# vosshub-dl

vosshub-dl is a tool to download files from <http://vosshub.com>.


## Usage

```
./vosshub-dl --search 'XH20A101' --resolve-all --download-all --create-symlinks
```


## Theory of operation

Downloading a file from VossHub involves the following steps:

- **Search**: You enter a search term, for example _XH20A101_ into the search
  bar, and the browser navigates to <http://vosshub.com/products/search/XH20A101>.
  The server returns a HTML page with all search results:

 | Category  | Brand      | Model                                 |  Source Code |
 |-----------|------------|---------------------------------------|--------------|
 | TFT-LCD   | TELEFUNKEN | 17MB110 20270L VG T.FUNKEN XH20A101   |  Readme.txt  |
 |           |            |                                       |  apm         |
 |           |            |                                       |  3.10.23     |
 |           |            |                                       |  ...         |
 | TFT-LCD   | TELEFUNKEN | 17MB110 20270L VG T.FUNKEN XH20A101-W |  Readme.txt  |
 |           |            |                                       |  apm         |
 |           |            |                                       |  ...         |


 Each search result consists of a category, brand, and model, as well as a list
 of files.


- **Resolving the download URL**: Each file in the source code column consists
  of a file ID, a product ID, and a name.

  When you click the link, you are presented with a warranty disclaimer, a
  request to enter a note, and a download button. When the download button is
  clicked, a POST request is made to the current page, with the following form data:

  - `form[agree]` = 1
  - `form[purpose]` = 1
  - `form[note]` = something
  - `form[download]` =
  - `form[file]` = (insert file ID here)
  - `form[product]` = (insert product ID here)
  - `form[_token]` = (a session-specific predefined value contained in the search result page)

  The server responds with a redirect to a file such as
  `http://vosshub.com/files/d8bd2b5cd394699376be8a99f7243800.docx`.

  The following requirements apply:

  - The URL must start with `http://vosshub.com/products/search/`;
    `http://vosshub.com/products/search` does not work.
  - The `form[purpose]`, `form[product]`, and `form[file]` form fields must be
    provided.


- **Downloading the file**: With knowledge of the file URL from the previous
  step, it can be downloaded at any time.

  Note that in order to generate a good name, the name displayed on the search
  result page (for example _sha2_) and the extension of the download location
  (_/files/ca32d8295b1f37a8bf558b72ea3360df.7z_) can be combined.
