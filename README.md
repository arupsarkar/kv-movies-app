# kv-movies-app

[![Build Status](https://travis-ci.org/arupsarkar/kv-movies-app.svg?branch=master)]

Salesforce Movies App

Development Workflow using **CumulusCI**

Please refer to [CumulusCi documentation](http://cumulusci.readthedocs.io/en/latest/tutorial.html#part-1-installing-cumulusci) for reference. Link to CumulusCi documentation.

#### **NOTE:**  Please do not forget to connect to salesforce before running any tasks like deploy, else it wil give an error.
` cci org connect <org_name> `

#### IDE
**[Sublime Text 3](https://www.sublimetext.com/)**

#### Package for IDE
**[MavensMate](https://github.com/joeferraro/MavensMate-SublimeText)**

#### Prerequisite for MavensMate for Sublime
**[MavensMate App for mac](https://github.com/joeferraro/mavensmate-desktop/releases)**
at the time of documenting this setup the version of available was [MavensMate-Desktop-0.0.11-beta.7.dmg](https://github.com/joeferraro/MavensMate-Desktop/releases/download/v0.0.11-beta.7/MavensMate-Desktop-0.0.11-beta.7.dmg)

### Development workflow

1. Start the Mavensmate App, connect to your salesforce org.
2. Create a new Apex Class using menu ` MavensMate -> Metadata -> New Apex Class `
3. Save the file, it will directly get saved to the developer org. Ensure all compilations and syntax is correct.
4. Check in to github to a feature org.

### cci tasks for development

###### cci task run retrieve_src --org dev
###### cci task run retrieve_packaged --org dev
###### cci task run deploy --org dev


### Salesforce DX IDE
1. ** [VS Code](https://code.visualstudio.com/)
2. ** [Salesforce DX Extension](https://marketplace.visualstudio.com/items?itemName=salesforce.salesforcedx-vscode)


Development is done in traditional developer org, rest feature, beta is done using scratch orgs.
