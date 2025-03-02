USE [master]
GO
/****** Object:  Database [PetiqueSpa]    Script Date: 03/02/2025 21:16:09 ******/
CREATE DATABASE [PetiqueSpa]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'PetiqueSpa', FILENAME = N'/var/opt/mssql/data/PetiqueSpa.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'PetiqueSpa_log', FILENAME = N'/var/opt/mssql/data/PetiqueSpa_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [PetiqueSpa].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [PetiqueSpa] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [PetiqueSpa] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [PetiqueSpa] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [PetiqueSpa] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [PetiqueSpa] SET ARITHABORT OFF 
GO
ALTER DATABASE [PetiqueSpa] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [PetiqueSpa] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [PetiqueSpa] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [PetiqueSpa] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [PetiqueSpa] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [PetiqueSpa] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [PetiqueSpa] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [PetiqueSpa] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [PetiqueSpa] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [PetiqueSpa] SET  ENABLE_BROKER 
GO
ALTER DATABASE [PetiqueSpa] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [PetiqueSpa] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [PetiqueSpa] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [PetiqueSpa] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [PetiqueSpa] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [PetiqueSpa] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [PetiqueSpa] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [PetiqueSpa] SET RECOVERY FULL 
GO
ALTER DATABASE [PetiqueSpa] SET  MULTI_USER 
GO
ALTER DATABASE [PetiqueSpa] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [PetiqueSpa] SET DB_CHAINING OFF 
GO
ALTER DATABASE [PetiqueSpa] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [PetiqueSpa] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [PetiqueSpa] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [PetiqueSpa] SET QUERY_STORE = ON
GO
ALTER DATABASE [PetiqueSpa] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO)
GO
USE [PetiqueSpa]
GO
ALTER DATABASE SCOPED CONFIGURATION SET ACCELERATED_PLAN_FORCING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET ASYNC_STATS_UPDATE_WAIT_AT_LOW_PRIORITY = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET BATCH_MODE_ADAPTIVE_JOINS = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET BATCH_MODE_MEMORY_GRANT_FEEDBACK = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET BATCH_MODE_ON_ROWSTORE = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET DEFERRED_COMPILATION_TV = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET DW_COMPATIBILITY_LEVEL = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION SET DW_UNIFIED_QUERY_OPTIMIZER = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET ELEVATE_ONLINE = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET ELEVATE_RESUMABLE = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET EXEC_QUERY_STATS_FOR_SCALAR_FUNCTIONS = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET GLOBAL_TEMPORARY_TABLE_AUTO_DROP = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET IDENTITY_CACHE = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET INTERLEAVED_EXECUTION_TVF = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET ISOLATE_SECURITY_POLICY_CARDINALITY = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LAST_QUERY_PLAN_STATS = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LIGHTWEIGHT_QUERY_PROFILING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET OPTIMIZE_FOR_AD_HOC_WORKLOADS = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PAUSED_RESUMABLE_INDEX_ABORT_DURATION_MINUTES = 1440;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET ROW_MODE_MEMORY_GRANT_FEEDBACK = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET TSQL_SCALAR_UDF_INLINING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET VERBOSE_TRUNCATION_WARNINGS = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET XTP_PROCEDURE_EXECUTION_STATISTICS = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET XTP_QUERY_EXECUTION_STATISTICS = OFF;
GO
USE [PetiqueSpa]
GO
/****** Object:  Table [dbo].[Admins]    Script Date: 03/02/2025 21:16:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Admins](
	[admin_id] [int] IDENTITY(1,1) NOT NULL,
	[staff_id] [int] NULL,
	[full_name] [varchar](100) NOT NULL,
	[email] [varchar](100) NOT NULL,
	[phone] [varchar](15) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[admin_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Appointments]    Script Date: 03/02/2025 21:16:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Appointments](
	[appointment_id] [int] IDENTITY(1,1) NOT NULL,
	[customer_id] [int] NULL,
	[pet_id] [int] NULL,
	[service_id] [int] NULL,
	[staff_id] [int] NULL,
	[appointment_date] [datetime] NOT NULL,
	[status] [varchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[appointment_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Categories]    Script Date: 03/02/2025 21:16:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[category_id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](255) NOT NULL,
	[description] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[category_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Chat_Messages]    Script Date: 03/02/2025 21:16:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Chat_Messages](
	[message_id] [int] IDENTITY(1,1) NOT NULL,
	[chat_id] [int] NULL,
	[sender_type] [varchar](20) NOT NULL,
	[sender_id] [int] NOT NULL,
	[message] [text] NOT NULL,
	[sent_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[message_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Chats]    Script Date: 03/02/2025 21:16:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Chats](
	[chat_id] [int] IDENTITY(1,1) NOT NULL,
	[customer_id] [int] NULL,
	[staff_id] [int] NULL,
	[created_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[chat_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Customers]    Script Date: 03/02/2025 21:16:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[customer_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NULL,
	[full_name] [varchar](100) NOT NULL,
	[address] [text] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[customer_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Inventory]    Script Date: 03/02/2025 21:16:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Inventory](
	[inventory_id] [int] IDENTITY(1,1) NOT NULL,
	[product_id] [int] NULL,
	[staff_id] [int] NULL,
	[quantity] [int] NOT NULL,
	[type] [varchar](50) NOT NULL,
	[image_url] [varchar](1000) NULL,
	[category_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[inventory_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Order_Details]    Script Date: 03/02/2025 21:16:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order_Details](
	[order_detail_id] [int] IDENTITY(1,1) NOT NULL,
	[order_id] [int] NULL,
	[product_id] [int] NULL,
	[service_id] [int] NULL,
	[quantity] [int] NOT NULL,
	[price] [decimal](10, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[order_detail_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Orders]    Script Date: 03/02/2025 21:16:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[order_id] [int] IDENTITY(1,1) NOT NULL,
	[customer_id] [int] NULL,
	[order_date] [datetime] NULL,
	[total_price] [decimal](10, 2) NOT NULL,
	[status] [varchar](20) NOT NULL,
	[promotion_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[order_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Pets]    Script Date: 03/02/2025 21:16:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pets](
	[pet_id] [int] IDENTITY(1,1) NOT NULL,
	[customer_id] [int] NULL,
	[name] [varchar](255) NOT NULL,
	[type] [varchar](50) NOT NULL,
	[age] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[pet_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Products]    Script Date: 03/02/2025 21:16:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[product_id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](255) NOT NULL,
	[description] [text] NULL,
	[price] [decimal](10, 2) NOT NULL,
	[stock_quantity] [int] NOT NULL,
	[image_url] [varchar](1000) NULL,
	[category_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[product_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Promotion]    Script Date: 03/02/2025 21:16:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Promotion](
	[promotion_id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](255) NOT NULL,
	[description] [text] NULL,
	[discount_type] [varchar](10) NULL,
	[discount_value] [decimal](10, 2) NOT NULL,
	[start_date] [datetime] NOT NULL,
	[end_date] [datetime] NOT NULL,
	[min_order_value] [decimal](10, 2) NULL,
	[max_discount] [decimal](10, 2) NULL,
	[is_active] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[promotion_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Ratings]    Script Date: 03/02/2025 21:16:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ratings](
	[rating_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NULL,
	[service_id] [int] NULL,
	[rating_star] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[rating_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Services]    Script Date: 03/02/2025 21:16:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Services](
	[service_id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](255) NOT NULL,
	[description] [text] NULL,
	[price] [decimal](10, 2) NOT NULL,
	[image_url] [varchar](1000) NULL,
PRIMARY KEY CLUSTERED 
(
	[service_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Staff]    Script Date: 03/02/2025 21:16:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Staff](
	[staff_id] [int] IDENTITY(1,1) NOT NULL,
	[admin_id] [int] NULL,
	[full_name] [varchar](100) NOT NULL,
	[position] [varchar](50) NOT NULL,
	[phone] [varchar](15) NOT NULL,
	[user_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[staff_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Users]    Script Date: 03/02/2025 21:16:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[user_id] [int] IDENTITY(1,1) NOT NULL,
	[username] [varchar](50) NOT NULL,
	[password] [varchar](255) NOT NULL,
	[email] [varchar](100) NOT NULL,
	[phone] [varchar](15) NOT NULL,
	[verification_code] [varchar](255) NULL,
	[is_verified] [tinyint] NULL,
PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Users_Verifications]    Script Date: 03/02/2025 21:16:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users_Verifications](
	[verification_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[email] [varchar](100) NOT NULL,
	[verification_code] [varchar](10) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[verification_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Admins] ON 

INSERT [dbo].[Admins] ([admin_id], [staff_id], [full_name], [email], [phone]) VALUES (1, 1, N'Admin One', N'admin.one@example.com', N'123-456-7890')
INSERT [dbo].[Admins] ([admin_id], [staff_id], [full_name], [email], [phone]) VALUES (2, 2, N'Admin Two', N'admin.two@example.com', N'098-765-4321')
INSERT [dbo].[Admins] ([admin_id], [staff_id], [full_name], [email], [phone]) VALUES (3, 3, N'Admin There', N'admin.there@example.com', N'098-764-4321')
INSERT [dbo].[Admins] ([admin_id], [staff_id], [full_name], [email], [phone]) VALUES (4, 4, N'Admin Four', N'admin.Four@example.com', N'028-764-4321')
SET IDENTITY_INSERT [dbo].[Admins] OFF
SET IDENTITY_INSERT [dbo].[Appointments] ON 

INSERT [dbo].[Appointments] ([appointment_id], [customer_id], [pet_id], [service_id], [staff_id], [appointment_date], [status]) VALUES (2, 3, 3, 2, 2, CAST(N'2025-03-02T11:00:00.000' AS DateTime), N'Confirmed')
INSERT [dbo].[Appointments] ([appointment_id], [customer_id], [pet_id], [service_id], [staff_id], [appointment_date], [status]) VALUES (3, 2, 2, 1, 3, CAST(N'2025-03-03T09:00:00.000' AS DateTime), N'Cancelled')
INSERT [dbo].[Appointments] ([appointment_id], [customer_id], [pet_id], [service_id], [staff_id], [appointment_date], [status]) VALUES (4, 3, 3, 2, 4, CAST(N'2025-03-04T14:00:00.000' AS DateTime), N'Cancelled')
INSERT [dbo].[Appointments] ([appointment_id], [customer_id], [pet_id], [service_id], [staff_id], [appointment_date], [status]) VALUES (7, 2, 2, 1, 3, CAST(N'2025-03-03T09:00:00.000' AS DateTime), N'Confirmed')
INSERT [dbo].[Appointments] ([appointment_id], [customer_id], [pet_id], [service_id], [staff_id], [appointment_date], [status]) VALUES (8, 3, 3, 2, 4, CAST(N'2025-03-04T14:00:00.000' AS DateTime), N'Pending')
INSERT [dbo].[Appointments] ([appointment_id], [customer_id], [pet_id], [service_id], [staff_id], [appointment_date], [status]) VALUES (9, 2, 2, 1, 1, CAST(N'2025-03-01T10:00:00.000' AS DateTime), N'Pending')
INSERT [dbo].[Appointments] ([appointment_id], [customer_id], [pet_id], [service_id], [staff_id], [appointment_date], [status]) VALUES (10, 3, 3, 2, 2, CAST(N'2025-03-02T11:00:00.000' AS DateTime), N'Pending')
INSERT [dbo].[Appointments] ([appointment_id], [customer_id], [pet_id], [service_id], [staff_id], [appointment_date], [status]) VALUES (11, 2, 2, 1, 3, CAST(N'2025-03-03T09:00:00.000' AS DateTime), N'Pending')
SET IDENTITY_INSERT [dbo].[Appointments] OFF
SET IDENTITY_INSERT [dbo].[Customers] ON 

INSERT [dbo].[Customers] ([customer_id], [user_id], [full_name], [address]) VALUES (2, 34, N'John Doe', N'123 Main St')
INSERT [dbo].[Customers] ([customer_id], [user_id], [full_name], [address]) VALUES (3, 35, N'Jane Smith', N'456 Elm St')
SET IDENTITY_INSERT [dbo].[Customers] OFF
SET IDENTITY_INSERT [dbo].[Inventory] ON 

INSERT [dbo].[Inventory] ([inventory_id], [product_id], [staff_id], [quantity], [type], [image_url], [category_id]) VALUES (1, 66, 2, 80, N'FOOdd', N'https://tse2.mm.bing.net/th?id=OIP.UuycboXCFZxKcgkakkjjsgHaHa&pid=Api', NULL)
INSERT [dbo].[Inventory] ([inventory_id], [product_id], [staff_id], [quantity], [type], [image_url], [category_id]) VALUES (2, 67, 2, 100, N'KOLAGICA', N'https://danhgiaxe.edu.vn/upload/2025/01/meme-bua-038.webp', NULL)
INSERT [dbo].[Inventory] ([inventory_id], [product_id], [staff_id], [quantity], [type], [image_url], [category_id]) VALUES (4, 69, 4, 100, N'KO', N'https://anhnghethuatvietnam2022.com/wp-content/uploads/2024/11/meme-dong-y-15.webp', NULL)
INSERT [dbo].[Inventory] ([inventory_id], [product_id], [staff_id], [quantity], [type], [image_url], [category_id]) VALUES (5, 80, 3, 100, N'KIEN', N'https://cdn11.dienmaycholon.vn/filewebdmclnew/public/userupload/files/Image%20FP_2024/meme-hai-31.jpg', NULL)
INSERT [dbo].[Inventory] ([inventory_id], [product_id], [staff_id], [quantity], [type], [image_url], [category_id]) VALUES (6, 79, 4, 100, N'LOL', N'https://lh7-rt.googleusercontent.com/docsz/AD_4nXdOZAVWpQG_4p9bqAfHjRxZZk98j9G1ccjZn7X0flncxv_6kZsgM7ul_y1ErbEr7d7ineH4jrr8bQMto8-2C5cgyQdCaGIyMO95k9VSCjRJgIVcUDI1znruF3HSPzGey2uXQagIghcNonUwuHBDgKvfUbcH?key=tE_qip6BHPL4g00JXL_X6Q', NULL)
SET IDENTITY_INSERT [dbo].[Inventory] OFF
SET IDENTITY_INSERT [dbo].[Pets] ON 

INSERT [dbo].[Pets] ([pet_id], [customer_id], [name], [type], [age]) VALUES (2, 2, N'Buddy', N'Dog', 3)
INSERT [dbo].[Pets] ([pet_id], [customer_id], [name], [type], [age]) VALUES (3, 3, N'Mittens', N'Cat', 2)
SET IDENTITY_INSERT [dbo].[Pets] OFF
SET IDENTITY_INSERT [dbo].[Products] ON 

INSERT [dbo].[Products] ([product_id], [name], [description], [price], [stock_quantity], [image_url], [category_id]) VALUES (66, N'SmartHeart Dog Food', N'Nutritious dry food for dogs, lamb and rice flavor', CAST(150000.00 AS Decimal(10, 2)), 50, N'https://tse2.mm.bing.net/th?id=OIP.UuycboXCFZxKcgkakkjjsgHaHa&pid=Api', NULL)
INSERT [dbo].[Products] ([product_id], [name], [description], [price], [stock_quantity], [image_url], [category_id]) VALUES (67, N'Whiskas Cat Food', N'Wet food with full nutrients, keeping cats healthy', CAST(120000.00 AS Decimal(10, 2)), 40, N'https://tse2.mm.bing.net/th?id=OIP.9TCC8bRZGqXqEj8SxD1yNgHaHa&pid=Api', NULL)
INSERT [dbo].[Products] ([product_id], [name], [description], [price], [stock_quantity], [image_url], [category_id]) VALUES (68, N'Royal Canin Cat Food', N'Dry food for adult cats, supports digestion', CAST(180000.00 AS Decimal(10, 2)), 35, N'https://tse3.mm.bing.net/th?id=OIP.dTr8C9oVUwGZ5dVm9BrjLAHaHa&pid=Api', NULL)
INSERT [dbo].[Products] ([product_id], [name], [description], [price], [stock_quantity], [image_url], [category_id]) VALUES (69, N'Pedigree Dry Dog Food', N'Boosts immune system and strengthens bones', CAST(160000.00 AS Decimal(10, 2)), 60, N'https://tse2.mm.bing.net/th?id=OIP.jbkW9gVY1jxP9z9U4mh2XAHaHa&pid=Api', NULL)
INSERT [dbo].[Products] ([product_id], [name], [description], [price], [stock_quantity], [image_url], [category_id]) VALUES (70, N'Me-O Cat Pate', N'Delicious, nutritious pate that is easy to digest', CAST(90000.00 AS Decimal(10, 2)), 70, N'https://tse4.mm.bing.net/th?id=OIP.ZJhBDlK46If8_5Aw89xFBAHaHa&pid=Api', NULL)
INSERT [dbo].[Products] ([product_id], [name], [description], [price], [stock_quantity], [image_url], [category_id]) VALUES (71, N'Rubber Bone Chew Toy', N'Keeps dogs entertained and strengthens teeth', CAST(50000.00 AS Decimal(10, 2)), 80, N'https://tse1.mm.bing.net/th?id=OIP.hLr0dME_6W0A_aZJzHf0AwHaHa&pid=Api', NULL)
INSERT [dbo].[Products] ([product_id], [name], [description], [price], [stock_quantity], [image_url], [category_id]) VALUES (72, N'Feather Spring Toy for Cats', N'Enhances movement and natural hunting instinct', CAST(40000.00 AS Decimal(10, 2)), 90, N'https://tse3.mm.bing.net/th?id=OIP.qut0qI7EBgihXV51lfDdkwHaHa&pid=Api', NULL)
INSERT [dbo].[Products] ([product_id], [name], [description], [price], [stock_quantity], [image_url], [category_id]) VALUES (73, N'Plastic Ball Toy for Cats', N'Fun and durable toy for playful cats', CAST(30000.00 AS Decimal(10, 2)), 100, N'https://tse2.mm.bing.net/th?id=OIP.OlGfmbVWvQ5lZJHJuRhjGQHaHa&pid=Api', NULL)
INSERT [dbo].[Products] ([product_id], [name], [description], [price], [stock_quantity], [image_url], [category_id]) VALUES (74, N'Plush Toy for Dogs', N'Soft, safe for chewing and playing', CAST(70000.00 AS Decimal(10, 2)), 60, N'https://tse1.mm.bing.net/th?id=OIP.u57G71YOyXf8apRP6aI8qAHaHa&pid=Api', NULL)
INSERT [dbo].[Products] ([product_id], [name], [description], [price], [stock_quantity], [image_url], [category_id]) VALUES (75, N'Tug Rope Toy for Dogs', N'Strengthens jaw muscles and provides exercise', CAST(55000.00 AS Decimal(10, 2)), 75, N'https://tse3.mm.bing.net/th?id=OIP.xA9oHCT4qRUwMF-jmXb94gHaHa&pid=Api', NULL)
INSERT [dbo].[Products] ([product_id], [name], [description], [price], [stock_quantity], [image_url], [category_id]) VALUES (76, N'Stainless Steel Pet Cage', N'Durable cage, ideal for transportation', CAST(350000.00 AS Decimal(10, 2)), 30, N'https://tse2.mm.bing.net/th?id=OIP.Z43dedd2sKSNsVEvbY0D2AHaHa&pid=Api', NULL)
INSERT [dbo].[Products] ([product_id], [name], [description], [price], [stock_quantity], [image_url], [category_id]) VALUES (77, N'Plastic Cat Carrier', N'Lightweight, easy to assemble, well-ventilated', CAST(250000.00 AS Decimal(10, 2)), 40, N'https://tse1.mm.bing.net/th?id=OIP.LNdcO0g1KixUXRJZseE5twHaHa&pid=Api', NULL)
INSERT [dbo].[Products] ([product_id], [name], [description], [price], [stock_quantity], [image_url], [category_id]) VALUES (78, N'Large Dog Metal Cage', N'Spacious design, suitable for large dogs', CAST(500000.00 AS Decimal(10, 2)), 20, N'https://tse4.mm.bing.net/th?id=OIP.QZLh_AWVCJ6fwxz0X5ptVwHaHa&pid=Api', NULL)
INSERT [dbo].[Products] ([product_id], [name], [description], [price], [stock_quantity], [image_url], [category_id]) VALUES (79, N'Wooden Cat Cage', N'Made from natural wood, stylish and durable', CAST(450000.00 AS Decimal(10, 2)), 25, N'https://tse3.mm.bing.net/th?id=OIP.JXKxHVqLzr_y1yOAWz8dSgHaHa&pid=Api', NULL)
INSERT [dbo].[Products] ([product_id], [name], [description], [price], [stock_quantity], [image_url], [category_id]) VALUES (80, N'Backpack Pet Carrier', N'Easy to carry your cat on trips', CAST(300000.00 AS Decimal(10, 2)), 50, N'https://tse2.mm.bing.net/th?id=OIP.oOQqP5GzXxHDFJQ3OaMfNwHaHa&pid=Api', NULL)
INSERT [dbo].[Products] ([product_id], [name], [description], [price], [stock_quantity], [image_url], [category_id]) VALUES (81, N'SOS Pet Shampoo', N'Cleans, deodorizes, and maintains fur health', CAST(120000.00 AS Decimal(10, 2)), 60, N'https://tse1.mm.bing.net/th?id=OIP.8D7MgeQeYe3z65j5z-GIzQHaHa&pid=Api', NULL)
INSERT [dbo].[Products] ([product_id], [name], [description], [price], [stock_quantity], [image_url], [category_id]) VALUES (82, N'Joyce & Dolls Pet Shampoo', N'Pleasant scent, makes fur soft and shiny', CAST(130000.00 AS Decimal(10, 2)), 55, N'https://tse1.mm.bing.net/th?id=OIP.5nC-EHyAq9w6YgMcPD5RQAHaHa&pid=Api', NULL)
INSERT [dbo].[Products] ([product_id], [name], [description], [price], [stock_quantity], [image_url], [category_id]) VALUES (83, N'Olive Essence Pet Shampoo', N'Reduces shedding, protects pet skin', CAST(110000.00 AS Decimal(10, 2)), 70, N'https://tse3.mm.bing.net/th?id=OIP.mL6zrDW7N2-j9MgpqweUHgHaHa&pid=Api', NULL)
INSERT [dbo].[Products] ([product_id], [name], [description], [price], [stock_quantity], [image_url], [category_id]) VALUES (84, N'Trixie Dog Shampoo', N'Moisturizes skin and keeps fur healthy', CAST(140000.00 AS Decimal(10, 2)), 45, N'https://tse1.mm.bing.net/th?id=OIP.VaNqX-5Vr9EvjUQSwLWhpgHaHa&pid=Api', NULL)
INSERT [dbo].[Products] ([product_id], [name], [description], [price], [stock_quantity], [image_url], [category_id]) VALUES (85, N'Bio Lovely Cat Shampoo', N'Herbal shampoo for relaxation and smooth fur', CAST(125000.00 AS Decimal(10, 2)), 65, N'https://tse3.mm.bing.net/th?id=OIP.Ou9rwQdMfTVcGqfI86fO6QHaHa&pid=Api', NULL)
SET IDENTITY_INSERT [dbo].[Products] OFF
SET IDENTITY_INSERT [dbo].[Promotion] ON 

INSERT [dbo].[Promotion] ([promotion_id], [name], [description], [discount_type], [discount_value], [start_date], [end_date], [min_order_value], [max_discount], [is_active]) VALUES (2, N'Spring Discount', N'Limited-time spring offer', N'fixed', CAST(50000.00 AS Decimal(10, 2)), CAST(N'2025-03-01T00:00:00.000' AS DateTime), CAST(N'2025-03-15T00:00:00.000' AS DateTime), CAST(300000.00 AS Decimal(10, 2)), NULL, 1)
INSERT [dbo].[Promotion] ([promotion_id], [name], [description], [discount_type], [discount_value], [start_date], [end_date], [min_order_value], [max_discount], [is_active]) VALUES (3, N'VIP Member Offer', N'Exclusive discount for VIP members', N'percent', CAST(15.00 AS Decimal(10, 2)), CAST(N'2025-05-01T00:00:00.000' AS DateTime), CAST(N'2025-05-31T00:00:00.000' AS DateTime), CAST(500000.00 AS Decimal(10, 2)), CAST(100000.00 AS Decimal(10, 2)), 1)
INSERT [dbo].[Promotion] ([promotion_id], [name], [description], [discount_type], [discount_value], [start_date], [end_date], [min_order_value], [max_discount], [is_active]) VALUES (4, N'Black Friday Deal', N'Biggest sale of the year!', N'fixed', CAST(100000.00 AS Decimal(10, 2)), CAST(N'2025-11-29T00:00:00.000' AS DateTime), CAST(N'2025-11-30T00:00:00.000' AS DateTime), CAST(400000.00 AS Decimal(10, 2)), NULL, 1)
SET IDENTITY_INSERT [dbo].[Promotion] OFF
SET IDENTITY_INSERT [dbo].[Services] ON 

INSERT [dbo].[Services] ([service_id], [name], [description], [price], [image_url]) VALUES (1, N'Grooming', N'Full grooming service', CAST(50.00 AS Decimal(10, 2)), N'https://i0.wp.com/www.latrobevetgroup.com.au/wp-content/uploads/2019/11/grooming.jpg?fit=612%2C612&ssl=1')
INSERT [dbo].[Services] ([service_id], [name], [description], [price], [image_url]) VALUES (2, N'Vaccination', N'Annual vaccination', CAST(30.00 AS Decimal(10, 2)), N'https://media.vov.vn/sites/default/files/styles/large/public/2021-10/20191229_153912_152342_tiem-nhac-lai-cum.max-800x800.jpg')
SET IDENTITY_INSERT [dbo].[Services] OFF
SET IDENTITY_INSERT [dbo].[Staff] ON 

INSERT [dbo].[Staff] ([staff_id], [admin_id], [full_name], [position], [phone], [user_id]) VALUES (1, 1, N'Alice Johnson', N'Staff cashier', N'123-456-7890', 34)
INSERT [dbo].[Staff] ([staff_id], [admin_id], [full_name], [position], [phone], [user_id]) VALUES (2, 2, N'KevinK', N'Staff sales', N'098-765-4321', 35)
INSERT [dbo].[Staff] ([staff_id], [admin_id], [full_name], [position], [phone], [user_id]) VALUES (3, 3, N'Bob Marley', N'Staff Consultant', N'092-765-4321', 36)
INSERT [dbo].[Staff] ([staff_id], [admin_id], [full_name], [position], [phone], [user_id]) VALUES (4, 4, N'Cartier', N'Staff warehouse', N'092-892-123', 37)
SET IDENTITY_INSERT [dbo].[Staff] OFF
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([user_id], [username], [password], [email], [phone], [verification_code], [is_verified]) VALUES (34, N'Long', N'd4f1e363', N'longla853@gmail.com', N'0837155363', NULL, 1)
INSERT [dbo].[Users] ([user_id], [username], [password], [email], [phone], [verification_code], [is_verified]) VALUES (35, N'TLong', N'14c89636', N'longlvhce182295@fpt.edu.vn', N'09865531263', NULL, 1)
INSERT [dbo].[Users] ([user_id], [username], [password], [email], [phone], [verification_code], [is_verified]) VALUES (36, N'kien99', N'be32', N'tranphantrungkien2004@gmail.com', N'0968996036', NULL, 1)
INSERT [dbo].[Users] ([user_id], [username], [password], [email], [phone], [verification_code], [is_verified]) VALUES (37, N'kien88', N'c9d5', N'kien50890@gmail.com', N'098977889', N'528049', 0)
SET IDENTITY_INSERT [dbo].[Users] OFF
/****** Object:  Index [UQ__Admins__1963DD9D4B6E8737]    Script Date: 03/02/2025 21:16:10 ******/
ALTER TABLE [dbo].[Admins] ADD UNIQUE NONCLUSTERED 
(
	[staff_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__Admins__AB6E6164EF1050F1]    Script Date: 03/02/2025 21:16:10 ******/
ALTER TABLE [dbo].[Admins] ADD UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__Admins__B43B145F524FEB42]    Script Date: 03/02/2025 21:16:10 ******/
ALTER TABLE [dbo].[Admins] ADD UNIQUE NONCLUSTERED 
(
	[phone] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__Categori__72E12F1B41F92752]    Script Date: 03/02/2025 21:16:10 ******/
ALTER TABLE [dbo].[Categories] ADD UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ__Customer__B9BE370E0A19DD02]    Script Date: 03/02/2025 21:16:10 ******/
ALTER TABLE [dbo].[Customers] ADD UNIQUE NONCLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__Staff__B43B145F2084DC66]    Script Date: 03/02/2025 21:16:10 ******/
ALTER TABLE [dbo].[Staff] ADD UNIQUE NONCLUSTERED 
(
	[phone] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ__Staff__B9BE370EF3CD53F5]    Script Date: 03/02/2025 21:16:10 ******/
ALTER TABLE [dbo].[Staff] ADD UNIQUE NONCLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__Users__AB6E6164D01DF7DD]    Script Date: 03/02/2025 21:16:10 ******/
ALTER TABLE [dbo].[Users] ADD UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__Users__B43B145F87116379]    Script Date: 03/02/2025 21:16:10 ******/
ALTER TABLE [dbo].[Users] ADD UNIQUE NONCLUSTERED 
(
	[phone] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__Users_Ve__AB6E616496C2842F]    Script Date: 03/02/2025 21:16:10 ******/
ALTER TABLE [dbo].[Users_Verifications] ADD UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ__Users_Ve__B9BE370EA8FA779C]    Script Date: 03/02/2025 21:16:10 ******/
ALTER TABLE [dbo].[Users_Verifications] ADD UNIQUE NONCLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Chat_Messages] ADD  DEFAULT (getdate()) FOR [sent_at]
GO
ALTER TABLE [dbo].[Chats] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[Orders] ADD  DEFAULT (getdate()) FOR [order_date]
GO
ALTER TABLE [dbo].[Promotion] ADD  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT ((0)) FOR [is_verified]
GO
ALTER TABLE [dbo].[Appointments]  WITH CHECK ADD FOREIGN KEY([customer_id])
REFERENCES [dbo].[Customers] ([customer_id])
GO
ALTER TABLE [dbo].[Appointments]  WITH CHECK ADD FOREIGN KEY([pet_id])
REFERENCES [dbo].[Pets] ([pet_id])
GO
ALTER TABLE [dbo].[Appointments]  WITH CHECK ADD FOREIGN KEY([service_id])
REFERENCES [dbo].[Services] ([service_id])
GO
ALTER TABLE [dbo].[Appointments]  WITH CHECK ADD FOREIGN KEY([staff_id])
REFERENCES [dbo].[Staff] ([staff_id])
GO
ALTER TABLE [dbo].[Chat_Messages]  WITH CHECK ADD FOREIGN KEY([chat_id])
REFERENCES [dbo].[Chats] ([chat_id])
GO
ALTER TABLE [dbo].[Chats]  WITH CHECK ADD FOREIGN KEY([customer_id])
REFERENCES [dbo].[Customers] ([customer_id])
GO
ALTER TABLE [dbo].[Chats]  WITH CHECK ADD FOREIGN KEY([staff_id])
REFERENCES [dbo].[Staff] ([staff_id])
GO
ALTER TABLE [dbo].[Customers]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([user_id])
GO
ALTER TABLE [dbo].[Inventory]  WITH CHECK ADD FOREIGN KEY([product_id])
REFERENCES [dbo].[Products] ([product_id])
GO
ALTER TABLE [dbo].[Inventory]  WITH CHECK ADD FOREIGN KEY([staff_id])
REFERENCES [dbo].[Staff] ([staff_id])
GO
ALTER TABLE [dbo].[Inventory]  WITH CHECK ADD  CONSTRAINT [fk_inventory_category] FOREIGN KEY([category_id])
REFERENCES [dbo].[Categories] ([category_id])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Inventory] CHECK CONSTRAINT [fk_inventory_category]
GO
ALTER TABLE [dbo].[Order_Details]  WITH CHECK ADD FOREIGN KEY([order_id])
REFERENCES [dbo].[Orders] ([order_id])
GO
ALTER TABLE [dbo].[Order_Details]  WITH CHECK ADD FOREIGN KEY([product_id])
REFERENCES [dbo].[Products] ([product_id])
GO
ALTER TABLE [dbo].[Order_Details]  WITH CHECK ADD FOREIGN KEY([service_id])
REFERENCES [dbo].[Services] ([service_id])
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD FOREIGN KEY([customer_id])
REFERENCES [dbo].[Customers] ([customer_id])
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Promotion] FOREIGN KEY([promotion_id])
REFERENCES [dbo].[Promotion] ([promotion_id])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Promotion]
GO
ALTER TABLE [dbo].[Pets]  WITH CHECK ADD FOREIGN KEY([customer_id])
REFERENCES [dbo].[Customers] ([customer_id])
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [fk_products_category] FOREIGN KEY([category_id])
REFERENCES [dbo].[Categories] ([category_id])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [fk_products_category]
GO
ALTER TABLE [dbo].[Ratings]  WITH CHECK ADD FOREIGN KEY([service_id])
REFERENCES [dbo].[Services] ([service_id])
GO
ALTER TABLE [dbo].[Ratings]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([user_id])
GO
ALTER TABLE [dbo].[Staff]  WITH CHECK ADD FOREIGN KEY([admin_id])
REFERENCES [dbo].[Admins] ([admin_id])
GO
ALTER TABLE [dbo].[Staff]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([user_id])
GO
ALTER TABLE [dbo].[Users_Verifications]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([user_id])
GO
ALTER TABLE [dbo].[Promotion]  WITH CHECK ADD CHECK  (([discount_type]='fixed' OR [discount_type]='percent'))
GO
ALTER TABLE [dbo].[Ratings]  WITH CHECK ADD CHECK  (([rating_star]>=(1) AND [rating_star]<=(5)))
GO
USE [master]
GO
ALTER DATABASE [PetiqueSpa] SET  READ_WRITE 
GO
