# testdb1 - Rename a table

### Prerequisites
1. **Visual studio 2022** with **Sql Server Data Tools** <sup style="font-size: 0.5em;">[1](#usef1)</sup>
1. **Microsoft Sql Server**

### Testing this locally
Before submitting our code we can test all the changes locally using these steps:
1. Be sure you have installed sql server locally (let's say the server name is **localhost**)
2. Build the project
3. go to **bin/debug** folder and here run in cmd:
    >SqlPackage.exe /Action:Publish /SourceFile:"testdb1.dacpac" /TargetServerName:"**localhost**" /TargetDatabaseName:"testdb1" /TargetTrustServerCertificate:True

### How to rename a table <sup style="font-size: 0.5em;">[2](#usef1)</sup>
1. install **Sql Server Data Tools** for **Visual Studio**
2. open the database solution
3. in Visual Studio open **View** -> **SQL Server Object Explorer** and select the name of the current project
4. find the table you want to rename, right click on it and select **Refactor** -> **Rename**. Enter the new name and then click **Ok** and then **Apply**.
5. this will generate a **.refactorlog** file that contains info about the renaming, something like this (for this example **Tab2** is the new name):

```xml
<?xml version="1.0" encoding="utf-8"?>
<Operations Version="1.0" xmlns="http://schemas.microsoft.com/sqlserver/dac/Serialization/2012/02"> 
  <Operation Name="Rename Refactor" Key="430ab371-5dfd-41c8-83b2-c7ab030b1380" ChangeDateTime="05/27/2025 14:04:02">
    <Property Name="ElementName" Value="[dbo].[Tab]" />
    <Property Name="ElementType" Value="SqlTable" />
    <Property Name="ParentElementName" Value="[dbo]" />
    <Property Name="ParentElementType" Value="SqlSchema" />
    <Property Name="NewName" Value="[Tab2]" />
  </Operation>
</Operations>
```

6. you need to include the generated **.reactorlog** file the solution and also in the **.sqlproj** file by adding a new **ItemGroup**, ie:

```xml
 <ItemGroup>
   <RefactorLog Include="myproj.refactorlog" />
 </ItemGroup>
 ```
 where **myproj** in our case is **testdb1**

7. we can test this locally using the [previously described method](#testing-this-locally)
<br>
<br>
<br>
<br>
<hr>

#### Useful links
<div id="usef1">1. <a href="https://dev.to/dealeron/the-ssdt-refactor-log-4jk6">dev.to - The SSDT Refactor Log</a></div>
<div id="usef2">2. <a href="https://www.microsoft.com/en-us/download/details.aspx?id=42313">Install <b>Microsoft SQL Server Data Tools</b> </a></div>
