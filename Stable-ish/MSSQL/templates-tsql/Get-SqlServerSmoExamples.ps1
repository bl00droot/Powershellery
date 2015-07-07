# SQL Server SMO - Cheat sheet
# Author: Scott Sutherland (@_nullbind), 2015 NetSPI
# Description:  
# This file contains basic example of how to grab informition fro SQL Server using
# the SQL Server SDK SMO APIs.
# Requirements:  
# This script require the SMO libraries installed with SQL Server.  They are listed below:
# C:\Program Files\Microsoft SQL Server\110\SDK\Assemblies\Microsoft.SqlServer.Smo.dll
# C:\Program Files\Microsoft SQL Server\110\SDK\Assemblies\Microsoft.SqlServer.SmoExtended.dll
# References:
# https://msdn.microsoft.com/en-us/library/microsoft.sqlserver.management.smo.server.aspx

# Import SMO Libs - required for all examples below
[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SqlServer.Smo") | Out-Null
[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SqlServer.SmoExtended")| Out-Null

# Authenticate - Integrated Windows Auth - works
$srv = new-object ('Microsoft.SqlServer.Management.Smo.Server') "server\instance" 

# Authenticate - SQL Server authentication - mixed mode - works
$srv = new-object ('Microsoft.SqlServer.Management.Smo.Server') "10.1.1.1"
$srv.ConnectionContext.LoginSecure=$false; 
$srv.ConnectionContext.set_Login("user"); 
$srv.ConnectionContext.set_Password("password")  
$srv.Information

# Get version / server information
$srv.Information
$srv.Name
$srv.NetName
$srv.ComputerNamePhysicalNetBIOS
$srv.Version
$srv.VersionMajor
$srv.VersionMinor
$srv.Edition
$srv.EngineEdition
$srv.OSVersion
$srv.DomainInstanceName
$srv.DomainName
$srv.SqlDomainGroup

# Get service informaiton
$srv.ServiceName
$srv.ServiceAccount
$srv.ServiceStartMode
$srv.BrowserServiceAccount

# Get state information
$srv.State
$srv.Status

# Get listener information
$srv.NamedPipesEnabled
$srv.TcpEnabled

# Get directory path information
$srv.RootDirectory
$srv.InstallDataDirectory
$srv.InstallSharedDirectory
$srv.ErrorLogPath
$srv.MasterDBLogPath
$srv.MasterDBPath
$srv.BackupDirectory

# Logins, roles, and privilege information
$srv.ConnectionContext
$srv.LoginMode
$srv.Logins
$srv.Roles
$srv.EnumServerPermissions()

# Window accounts / groups assigned logins in SQL Server
$srv.EnumWindowsUserInfo()
$srv.EnumWindowsUserInfo() | select "account name"
$srv.EnumWindowsDomainGroups()
$srv.EnumWindowsGroupInfo("Domain Admins")

# Credentials / proxy_account
$srv.Credentials
$srv.ProxyAccount

# Databse information
$srv.Databases

# cluster / mirror information
$srv.IsClustered
$srv.ClusterName
$srv.EnumClusterMembersState
$srv.EnumClusterSubnets
$srv.EnumDatabaseMirrorWitnessRoles()

# SQL Server settings
$srv.Configuration
$srv.Settings
$srv.Properties
$srv.Mail
$srv.MailProfile
$srv.Triggers
$srv.AuditLevel
$srv.Audits
$srv.LinkedServers
$srv.Endpoints
$srv.JobServer
$srv.EnumServerAttributes()

# SQL Server enumeration
# https://msdn.microsoft.com/en-us/library/ms210366.aspx
$srv.PingSqlServerVersion("server\Standard")
$srv.PingSqlServerVersion("1.1.1.1",'sa','password')
$SQLSvr = [Microsoft.SqlServer.Management.Smo.SmoApplication]::EnumAvailableSqlServers($true); $SQLSvr | Out-GridView

