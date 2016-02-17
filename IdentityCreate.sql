DECLARE @DBNAME VARCHAR(512)
DECLARE @FILEPATH VARCHAR(1024)
DECLARE  @SQL VARCHAR(max)
---------------------------------------------------------------------------------------
-- Change @DBNAME for database nam and ldf/mdf name on disk
---------------------------------------------------------------------------------------
SET @DBNAME = 'aspnet_NPoco_Identiy_Provider'
---------------------------------------------------------------------------------------
-- CHANGE @FILEPATH to the location where you wish to store the physical sql data files
-- NOTE: Please remember the trailing backslash at the end of the path
---------------------------------------------------------------------------------------
SET @FILEPATH = N'D:\Projects\SQLData\'


SET @SQL = 'CREATE DATABASE [' + @DBNAME + ']
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME =' + '''' + @DBNAME +  '.mdf'  + '''' + ', FILENAME =  ' + ''''  +@FILEPATH + @DBNAME + '.mdf' + '''' + ', SIZE = 3264KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME =' + '''' + @DBNAME + '_log.ldf' + '''' + ', FILENAME = ' + '''' + @FILEPATH + @DBNAME + '_log.ldf' + '''' + ' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)


ALTER DATABASE [' + @DBNAME + '] SET COMPATIBILITY_LEVEL = 120


IF (1 = FULLTEXTSERVICEPROPERTY(''IsFullTextInstalled''))
begin
EXEC [' + @DBNAME + '].[dbo].[sp_fulltext_database] @action = ''enable''
end

ALTER DATABASE [' + @DBNAME + '] SET ANSI_NULL_DEFAULT OFF 

ALTER DATABASE [' + @DBNAME + '] SET ANSI_NULLS OFF 

ALTER DATABASE [' + @DBNAME +'] SET ANSI_PADDING OFF 

ALTER DATABASE [' + @DBNAME + '] SET ANSI_WARNINGS OFF 

ALTER DATABASE [' + @DBNAME +'] SET ARITHABORT OFF 

ALTER DATABASE [' + @DBNAME + '] SET AUTO_CLOSE ON 

ALTER DATABASE [' + @DBNAME + '] SET AUTO_SHRINK OFF 

ALTER DATABASE [' + @DBNAME + '] SET AUTO_UPDATE_STATISTICS ON 

ALTER DATABASE [' + @DBNAME + '] SET CURSOR_CLOSE_ON_COMMIT OFF 

ALTER DATABASE [' + @DBNAME + '] SET CURSOR_DEFAULT  GLOBAL 

ALTER DATABASE [' + @DBNAME + '] SET CONCAT_NULL_YIELDS_NULL OFF 

ALTER DATABASE [' + @DBNAME + '] SET NUMERIC_ROUNDABORT OFF 

ALTER DATABASE [' + @DBNAME + '] SET QUOTED_IDENTIFIER OFF 

ALTER DATABASE [' + @DBNAME + '] SET RECURSIVE_TRIGGERS OFF 

ALTER DATABASE [' + @DBNAME + '] SET  DISABLE_BROKER 

ALTER DATABASE [' + @DBNAME + '] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 

ALTER DATABASE [' + @DBNAME + '] SET DATE_CORRELATION_OPTIMIZATION OFF 

ALTER DATABASE [' + @DBNAME + '] SET TRUSTWORTHY OFF 

ALTER DATABASE [' + @DBNAME + '] SET ALLOW_SNAPSHOT_ISOLATION OFF 

ALTER DATABASE [' + @DBNAME + '] SET PARAMETERIZATION SIMPLE 

ALTER DATABASE [' + @DBNAME + '] SET READ_COMMITTED_SNAPSHOT ON 

ALTER DATABASE [' + @DBNAME + '] SET HONOR_BROKER_PRIORITY OFF 

ALTER DATABASE [' + @DBNAME + '] SET RECOVERY SIMPLE 

ALTER DATABASE [' + @DBNAME + '] SET  MULTI_USER 

ALTER DATABASE [' + @DBNAME + '] SET PAGE_VERIFY CHECKSUM  

ALTER DATABASE [' + @DBNAME + '] SET DB_CHAINING OFF 

ALTER DATABASE [' + @DBNAME + '] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 

ALTER DATABASE [' + @DBNAME + '] SET TARGET_RECOVERY_TIME = 0 SECONDS 

ALTER DATABASE [' + @DBNAME + '] SET DELAYED_DURABILITY = DISABLED 

ALTER DATABASE [' + @DBNAME + '] SET  READ_WRITE 
'

EXEC(@sql)

---- AspNetUsers

SET @SQL= 'CREATE TABLE [' + @DBNAME + '].[dbo].[AspNetUsers](
	[Id] [nvarchar](128) NOT NULL,
	[Email] [nvarchar](256) NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEndDateUtc] [datetime] NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
	[UserName] [nvarchar](256) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]'

EXEC(@SQL)
----- Roles

SET @SQL = 'CREATE TABLE [' + @DBNAME + '].[dbo].[AspNetRoles](
	[Id] [nvarchar](128) NOT NULL,
	[Name] [nvarchar](256) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetRoles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]'

EXEC(@SQL)

-- Roles to users


SET @SQL = '
USE ' + @DBNAME + '
CREATE TABLE [' + @DBNAME + '].[dbo].[AspNetUserRoles](
	[UserId] [nvarchar](128) NOT NULL,
	[RoleId] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUserRoles] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE

ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId]

ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE

ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId]'

EXEC(@SQL)

-- Logins

SET @SQL = '
USE ' + @DBNAME + '
CREATE TABLE [' + @DBNAME + '].[dbo].[AspNetUserLogins](
	[LoginProvider] [nvarchar](128) NOT NULL,
	[ProviderKey] [nvarchar](128) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUserLogins] PRIMARY KEY CLUSTERED 
(
	[LoginProvider] ASC,
	[ProviderKey] ASC,
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]


ALTER TABLE [dbo].[AspNetUserLogins]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE

ALTER TABLE [dbo].[AspNetUserLogins] CHECK CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId]'

EXEC(@SQL)


-- Claims

SET @SQL = '
USE ' + @DBNAME + ' 
CREATE TABLE [' + @DBNAME + '].[dbo].[AspNetUserClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_dbo.AspNetUserClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

ALTER TABLE [dbo].[AspNetUserClaims]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE

ALTER TABLE [dbo].[AspNetUserClaims] CHECK CONSTRAINT [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId]'

EXEC(@SQL)
