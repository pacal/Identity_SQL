# Identity SQL generation scripts
SQL Script to generate ASP.Net Identity database and schema

You use to be able to use aspnet_regsql.exe to create the old asp membership database and schema.
However, with  ASP.Net Identity you usually start with the web application template which has Entity Framework. EF will run a migration and create the database and schema. 
If you want to use another ORM  (such as [NPoco] (https://github.com/schotime/NPoco)) for your custom Identity provider (such as [NPoco Identity Provider](https://github.com/pacal/NPoco_Identity_Provider "NPoco_Identity_Provider")), and you want to make use of the schema provided by MS, this is an easy way to boot strap it. 

__Useage:__
This assumes you have some edition of MS Sql server installed (Express/Developer etc..).
 * Load SQL Management Studio
 * Paste in the script
 * Edit the settings commented at the beginning of the script
 * Execute it

