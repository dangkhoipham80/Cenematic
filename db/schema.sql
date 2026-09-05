-- CENEMATIC schema + seed data.
-- Exported from SQL Server Management Studio, converted to UTF-8 and made
-- self-contained (creates the database if it does not exist).
IF DB_ID(N'CENEMATIC') IS NULL
    CREATE DATABASE [CENEMATIC];
GO
USE [CENEMATIC]
GO
/****** Object:  Table [dbo].[accesspermission]    Script Date: 13/08/2024 11:48:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[accesspermission](
	[id_permission] [varchar](50) NOT NULL,
	[id_account] [varchar](255) NULL,
	[id_role] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_permission] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[account]    Script Date: 13/08/2024 11:48:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[account](
	[id_account] [varchar](255) NOT NULL,
	[avatar] [nvarchar](255) NULL,
	[accountname] [nvarchar](50) NULL,
	[firstname] [nvarchar](20) NULL,
	[lastname] [nvarchar](20) NULL,
	[gender] [nvarchar](50) NULL,
	[address] [nvarchar](255) NULL,
	[phonenumber] [char](10) NULL,
	[yearofbirth] [date] NULL,
	[email] [varchar](50) NULL,
	[receive_email] [bit] NULL,
	[password] [nvarchar](50) NULL,
	[verificationcode] [varchar](10) NULL,
	[effectivetime] [datetime] NULL,
	[authentication] [bit] NULL,
	[isAdmin] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_account] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[bill]    Script Date: 13/08/2024 11:48:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bill](
	[id_bill] [varchar](50) NOT NULL,
	[id_account] [varchar](255) NULL,
	[datecreated] [date] NULL,
	[totalmoney] [float] NULL,
	[status] [bit] NULL,
	[timecreated] [time](7) NULL,
	[id_ticket] [varchar](50) NOT NULL,
 CONSTRAINT [PK_ticketbill] PRIMARY KEY CLUSTERED 
(
	[id_bill] ASC,
	[id_ticket] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cinema]    Script Date: 13/08/2024 11:48:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cinema](
	[id_cinema] [varchar](50) NOT NULL,
	[cinemaname] [nvarchar](50) NULL,
	[address] [nvarchar](100) NULL,
	[status] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_cinema] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cinemaroom]    Script Date: 13/08/2024 11:48:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cinemaroom](
	[id_cinemaroom] [varchar](50) NOT NULL,
	[id_cinema] [varchar](50) NULL,
	[id_roomcategory] [varchar](50) NULL,
	[roomname] [nvarchar](50) NULL,
	[status] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_cinemaroom] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[comment]    Script Date: 13/08/2024 11:48:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[comment](
	[id_comment] [varchar](50) NOT NULL,
	[id_movie] [varchar](50) NULL,
	[id_account] [varchar](255) NULL,
	[content] [nvarchar](255) NULL,
	[status] [bit] NULL,
	[datecomment] [datetime] NULL,
	[rating] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_comment] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[movie]    Script Date: 13/08/2024 11:48:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[movie](
	[id_movie] [varchar](50) NOT NULL,
	[moviename] [nvarchar](100) NULL,
	[director] [nvarchar](50) NULL,
	[actor] [nvarchar](255) NULL,
	[language] [nvarchar](50) NULL,
	[trailer] [nvarchar](255) NULL,
	[agelimit] [nvarchar](50) NULL,
	[coverimage] [varchar](255) NULL,
	[category] [nvarchar](50) NULL,
	[nationalorigin] [nvarchar](50) NULL,
	[effectivedatefrom] [date] NULL,
	[effectivedateto] [date] NULL,
	[status] [bit] NULL,
	[summary] [nvarchar](max) NULL,
	[Duration] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_movie] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[movie_moviecategory]    Script Date: 13/08/2024 11:48:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[movie_moviecategory](
	[id_category] [varchar](50) NOT NULL,
	[id_movie] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_category] ASC,
	[id_movie] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[moviecategory]    Script Date: 13/08/2024 11:48:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[moviecategory](
	[id_category] [varchar](50) NOT NULL,
	[categoryname] [nvarchar](50) NULL,
	[status] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_category] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[moviescreeningsession]    Script Date: 13/08/2024 11:48:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[moviescreeningsession](
	[id_moviescreeningsession] [varchar](50) NOT NULL,
	[id_movie] [varchar](50) NULL,
	[id_cinemaroom] [varchar](50) NULL,
	[screeningdate] [date] NULL,
	[starttime] [time](7) NULL,
	[endtime] [time](7) NULL,
	[status] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_moviescreeningsession] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[role]    Script Date: 13/08/2024 11:48:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[role](
	[id_role] [varchar](50) NOT NULL,
	[role] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_role] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[roomcategory]    Script Date: 13/08/2024 11:48:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[roomcategory](
	[id_roomcategory] [varchar](50) NOT NULL,
	[roomname] [nvarchar](50) NULL,
	[status] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_roomcategory] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[seat]    Script Date: 13/08/2024 11:48:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[seat](
	[id_seat] [varchar](50) NOT NULL,
	[id_seatcategory] [varchar](50) NULL,
	[id_cinemaroom] [varchar](50) NULL,
	[row] [char](1) NULL,
	[column] [int] NULL,
	[status] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_seat] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[seatcategory]    Script Date: 13/08/2024 11:48:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[seatcategory](
	[id_seatcategory] [varchar](50) NOT NULL,
	[categoryname] [nvarchar](50) NULL,
	[status] [bit] NULL,
	[price] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_seatcategory] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ticket]    Script Date: 13/08/2024 11:48:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ticket](
	[id_ticket] [varchar](50) NOT NULL,
	[id_moviescreeningsession] [varchar](50) NULL,
	[id_seat] [varchar](50) NULL,
	[status] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_ticket] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[accesspermission] ([id_permission], [id_account], [id_role]) VALUES (N'AP001', N'1', N'R002')
INSERT [dbo].[accesspermission] ([id_permission], [id_account], [id_role]) VALUES (N'AP002', N'2', N'R002')
INSERT [dbo].[accesspermission] ([id_permission], [id_account], [id_role]) VALUES (N'AP003', N'3', N'R001')
GO
INSERT [dbo].[account] ([id_account], [avatar], [accountname], [firstname], [lastname], [gender], [address], [phonenumber], [yearofbirth], [email], [receive_email], [password], [verificationcode], [effectivetime], [authentication], [isAdmin]) VALUES (N'1', NULL, N'HuyQuang1234', N'Phan', N'Huy', N'Male', N'null', N'0938383833', CAST(N'2004-05-01' AS Date), N'johndoe@example.com', 1, N'huy123', NULL, NULL, NULL, 0)
INSERT [dbo].[account] ([id_account], [avatar], [accountname], [firstname], [lastname], [gender], [address], [phonenumber], [yearofbirth], [email], [receive_email], [password], [verificationcode], [effectivetime], [authentication], [isAdmin]) VALUES (N'1718794632915', N'Screenshot 2024-06-18 194129.png', N'user6', N'Nguyen', N'Thinh1', N'Male', N'kkkkkkk', N'0909097895', CAST(N'2024-06-08' AS Date), N'nsn15102004@gmail.com

', 0, N'+CNxn6nvbqUoRtzWHq3zMKE8hbk=', N'764779', CAST(N'2024-06-20T00:00:00.000' AS DateTime), 1, 0)
INSERT [dbo].[account] ([id_account], [avatar], [accountname], [firstname], [lastname], [gender], [address], [phonenumber], [yearofbirth], [email], [receive_email], [password], [verificationcode], [effectivetime], [authentication], [isAdmin]) VALUES (N'1719206344673', N'Screenshot 2024-06-20 160714.png', N'user7', N'Tran', N'Duy', N'Male', N'854/26, Kinh Dương Vương, Phường An Lạc, Quận Bình Tân', N'0909053536', CAST(N'2024-06-13' AS Date), N'phuy613717737@gmail.com', 0, N'vAx0xzoFW31VzvnkfsXd12owLNQ=', N'785291', CAST(N'2024-06-25T00:00:00.000' AS DateTime), 1, NULL)
INSERT [dbo].[account] ([id_account], [avatar], [accountname], [firstname], [lastname], [gender], [address], [phonenumber], [yearofbirth], [email], [receive_email], [password], [verificationcode], [effectivetime], [authentication], [isAdmin]) VALUES (N'1719207664666', N'Screenshot 2024-06-20 213648.png', N'user8', N'a7', N'cris', N'Male', N'854/50, Kinh Dương Vương, Phường An Lạc, Quận Bình Tân', N'0909063635', CAST(N'2024-06-28' AS Date), N'phuy61371@gmail.com', 0, N'vAx0xzoFW31VzvnkfsXd12owLNQ=', N'716041', CAST(N'2024-06-25T00:00:00.000' AS DateTime), 1, NULL)
INSERT [dbo].[account] ([id_account], [avatar], [accountname], [firstname], [lastname], [gender], [address], [phonenumber], [yearofbirth], [email], [receive_email], [password], [verificationcode], [effectivetime], [authentication], [isAdmin]) VALUES (N'1720656768610', NULL, N'tenkhac', N'hai', N'duc', NULL, N'Æ°defgrdthyjuki', N'0123456789', NULL, N'namnsse184542@fpt.edu.vn', 0, N'vAx0xzoFW31VzvnkfsXd12owLNQ=', N'116241', CAST(N'2024-07-12T00:00:00.000' AS DateTime), 1, NULL)
INSERT [dbo].[account] ([id_account], [avatar], [accountname], [firstname], [lastname], [gender], [address], [phonenumber], [yearofbirth], [email], [receive_email], [password], [verificationcode], [effectivetime], [authentication], [isAdmin]) VALUES (N'2', NULL, N'SonNam', N'Nguyen', N'Nam', N'Male', NULL, N'0987654321', CAST(N'2004-04-15' AS Date), N'janesmith@example.com', 1, N'nam123', NULL, NULL, NULL, 0)
INSERT [dbo].[account] ([id_account], [avatar], [accountname], [firstname], [lastname], [gender], [address], [phonenumber], [yearofbirth], [email], [receive_email], [password], [verificationcode], [effectivetime], [authentication], [isAdmin]) VALUES (N'3', N'img/avatar1.png', N'JonnyDang', N'Johnny', N'Bob', N'Male', N'null', N'0987644321', CAST(N'2004-04-15' AS Date), N'phuy613719@gmail.com', 1, N'vAx0xzoFW31VzvnkfsXd12owLNQ=', NULL, NULL, NULL, 1)
INSERT [dbo].[account] ([id_account], [avatar], [accountname], [firstname], [lastname], [gender], [address], [phonenumber], [yearofbirth], [email], [receive_email], [password], [verificationcode], [effectivetime], [authentication], [isAdmin]) VALUES (N'4', N'img/Movie1.jpg', N'HuyQuang1', N'Phan', N'Huy', N'Male', N'kkkkkkkkk', N'0938383835', CAST(N'2004-05-01' AS Date), N'huypqse@gmail.com', 1, N'huy123', N'879312', CAST(N'2024-06-15T00:00:00.000' AS DateTime), 1, 0)
GO
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720151684542', N'1718794632915', CAST(N'2024-07-05' AS Date), 90000, 0, CAST(N'10:54:44.4766667' AS Time), N'1720151685131')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720151684679', N'1718794632915', CAST(N'2024-07-05' AS Date), 90000, 0, CAST(N'10:54:44.4466667' AS Time), N'1720151684655')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720252796054', N'3', CAST(N'2024-07-06' AS Date), 160000, 0, CAST(N'14:59:55.8266667' AS Time), N'1720252796219')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720252796612', N'3', CAST(N'2024-07-06' AS Date), 160000, 0, CAST(N'14:59:55.7900000' AS Time), N'1720252795785')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720252892303', N'3', CAST(N'2024-07-06' AS Date), 90000, 0, CAST(N'15:01:31.5400000' AS Time), N'1720252891732')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720252892442', N'3', CAST(N'2024-07-06' AS Date), 90000, 0, CAST(N'15:01:31.5066667' AS Time), N'1720252891596')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720254855194', NULL, CAST(N'2024-07-06' AS Date), 160000, 0, CAST(N'15:34:14.8766667' AS Time), N'1720254855793')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720254930706', NULL, CAST(N'2024-07-06' AS Date), 90000, 0, CAST(N'15:35:30.4866667' AS Time), N'1720254931168')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720255069375', NULL, CAST(N'2024-07-06' AS Date), 90000, 0, CAST(N'15:37:48.9833333' AS Time), N'1720255069811')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720262805131', N'1718794632915', CAST(N'2024-07-06' AS Date), 45000, 0, CAST(N'17:46:44.9566667' AS Time), N'1720262805407')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720262830804', N'1718794632915', CAST(N'2024-07-06' AS Date), 45000, 0, CAST(N'17:47:09.9200000' AS Time), N'1720262829960')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720276952045', N'1718794632915', CAST(N'2024-07-06' AS Date), 90000, 0, CAST(N'21:42:31.7933333' AS Time), N'1720276952180')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720276952602', N'1718794632915', CAST(N'2024-07-06' AS Date), 90000, 0, CAST(N'21:42:31.8333333' AS Time), N'1720276952023')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720325760555', N'1718794632915', CAST(N'2024-07-07' AS Date), 200000, 0, CAST(N'11:16:00.1833333' AS Time), N'1720325761043')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720325760910', N'1718794632915', CAST(N'2024-07-07' AS Date), 200000, 0, CAST(N'11:16:00.1500000' AS Time), N'1720325760462')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720332299687', N'1718794632915', CAST(N'2024-07-07' AS Date), 90000, 0, CAST(N'13:04:58.9800000' AS Time), N'1720332299103')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720332299870', N'1718794632915', CAST(N'2024-07-07' AS Date), 90000, 0, CAST(N'13:04:58.9466667' AS Time), N'1720332298949')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720332530320', N'1718794632915', CAST(N'2024-07-07' AS Date), 160000, 0, CAST(N'13:08:50.2133333' AS Time), N'1720332530241')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720332530320', N'1718794632915', CAST(N'2024-07-07' AS Date), 160000, 0, CAST(N'13:08:50.2466667' AS Time), N'1720332530900')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720333440768', N'1718794632915', CAST(N'2024-07-07' AS Date), 90000, 1, CAST(N'13:24:00.0333333' AS Time), N'1720333440571')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720333440768', N'1718794632915', CAST(N'2024-07-07' AS Date), 90000, 1, CAST(N'13:23:59.9966667' AS Time), N'1720333440628')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720334961643', N'3', CAST(N'2024-07-07' AS Date), 90000, 0, CAST(N'13:49:21.4800000' AS Time), N'1720334961525')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720334961643', N'3', CAST(N'2024-07-07' AS Date), 90000, 0, CAST(N'13:49:21.5200000' AS Time), N'1720334961692')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720338612019', N'1718794632915', CAST(N'2024-07-07' AS Date), 225000, 1, CAST(N'14:50:11.3800000' AS Time), N'1720338611368')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720338612019', N'1718794632915', CAST(N'2024-07-07' AS Date), 225000, 1, CAST(N'14:50:11.3500000' AS Time), N'1720338611911')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720338612019', N'1718794632915', CAST(N'2024-07-07' AS Date), 225000, 1, CAST(N'14:50:11.3200000' AS Time), N'1720338611987')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720604606421', N'1718794632915', CAST(N'2024-07-10' AS Date), 90000, 1, CAST(N'16:43:25.8000000' AS Time), N'1720604606309')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720604606421', N'1718794632915', CAST(N'2024-07-10' AS Date), 90000, 1, CAST(N'16:43:25.7633333' AS Time), N'1720604606321')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720608681798', N'1718794632915', CAST(N'2024-07-10' AS Date), 90000, 1, CAST(N'17:51:21.8500000' AS Time), N'1720608682431')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720608681798', N'1718794632915', CAST(N'2024-07-10' AS Date), 90000, 1, CAST(N'17:51:21.8833333' AS Time), N'1720608682776')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720608864043', N'1718794632915', CAST(N'2024-07-10' AS Date), 90000, 1, CAST(N'17:54:23.5666667' AS Time), N'1720608863793')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720608864043', N'1718794632915', CAST(N'2024-07-10' AS Date), 90000, 1, CAST(N'17:54:23.5966667' AS Time), N'1720608864280')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720612217979', N'3', CAST(N'2024-07-10' AS Date), 90000, 1, CAST(N'18:50:17.6133333' AS Time), N'1720612217903')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720612217979', N'3', CAST(N'2024-07-10' AS Date), 90000, 1, CAST(N'18:50:17.6533333' AS Time), N'1720612218613')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720657914933', N'1718794632915', CAST(N'2024-07-11' AS Date), 720000, 1, CAST(N'07:31:54.6433333' AS Time), N'1720657914783')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720657914933', N'1718794632915', CAST(N'2024-07-11' AS Date), 720000, 1, CAST(N'07:31:54.6700000' AS Time), N'1720657914787')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720657914933', N'1718794632915', CAST(N'2024-07-11' AS Date), 720000, 1, CAST(N'07:31:54.6966667' AS Time), N'1720657914855')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720657914933', N'1718794632915', CAST(N'2024-07-11' AS Date), 720000, 1, CAST(N'07:31:54.8100000' AS Time), N'1720657914912')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720657914933', N'1718794632915', CAST(N'2024-07-11' AS Date), 720000, 1, CAST(N'07:31:54.8366667' AS Time), N'1720657915096')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720657914933', N'1718794632915', CAST(N'2024-07-11' AS Date), 720000, 1, CAST(N'07:31:54.7566667' AS Time), N'1720657915337')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720657914933', N'1718794632915', CAST(N'2024-07-11' AS Date), 720000, 1, CAST(N'07:31:54.6133333' AS Time), N'1720657915379')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720657914933', N'1718794632915', CAST(N'2024-07-11' AS Date), 720000, 1, CAST(N'07:31:54.7833333' AS Time), N'1720657915524')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720657914933', N'1718794632915', CAST(N'2024-07-11' AS Date), 720000, 1, CAST(N'07:31:54.7266667' AS Time), N'1720657915667')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720657945309', N'1718794632915', CAST(N'2024-07-11' AS Date), 720000, 1, CAST(N'07:32:25.1666667' AS Time), N'1720657945243')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720657945309', N'1718794632915', CAST(N'2024-07-11' AS Date), 720000, 1, CAST(N'07:32:25.1966667' AS Time), N'1720657945296')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720657945309', N'1718794632915', CAST(N'2024-07-11' AS Date), 720000, 1, CAST(N'07:32:25.1366667' AS Time), N'1720657945474')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720657945309', N'1718794632915', CAST(N'2024-07-11' AS Date), 720000, 1, CAST(N'07:32:25.2266667' AS Time), N'1720657945670')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720657945309', N'1718794632915', CAST(N'2024-07-11' AS Date), 720000, 1, CAST(N'07:32:25.3433333' AS Time), N'1720657945688')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720657945309', N'1718794632915', CAST(N'2024-07-11' AS Date), 720000, 1, CAST(N'07:32:25.2866667' AS Time), N'1720657945791')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720657945309', N'1718794632915', CAST(N'2024-07-11' AS Date), 720000, 1, CAST(N'07:32:25.3133333' AS Time), N'1720657946001')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720657945309', N'1718794632915', CAST(N'2024-07-11' AS Date), 720000, 1, CAST(N'07:32:25.2533333' AS Time), N'1720657946049')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720657945309', N'1718794632915', CAST(N'2024-07-11' AS Date), 720000, 1, CAST(N'07:32:25.3700000' AS Time), N'1720657946340')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720657973770', N'1718794632915', CAST(N'2024-07-11' AS Date), 720000, 1, CAST(N'07:32:53.4466667' AS Time), N'1720657973464')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720657973770', N'1718794632915', CAST(N'2024-07-11' AS Date), 720000, 1, CAST(N'07:32:53.5333333' AS Time), N'1720657973564')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720657973770', N'1718794632915', CAST(N'2024-07-11' AS Date), 720000, 1, CAST(N'07:32:53.3033333' AS Time), N'1720657973580')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720657973770', N'1718794632915', CAST(N'2024-07-11' AS Date), 720000, 1, CAST(N'07:32:53.3333333' AS Time), N'1720657973741')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720657973770', N'1718794632915', CAST(N'2024-07-11' AS Date), 720000, 1, CAST(N'07:32:53.3600000' AS Time), N'1720657974116')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720657973770', N'1718794632915', CAST(N'2024-07-11' AS Date), 720000, 1, CAST(N'07:32:53.3900000' AS Time), N'1720657974184')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720657973770', N'1718794632915', CAST(N'2024-07-11' AS Date), 720000, 1, CAST(N'07:32:53.4766667' AS Time), N'1720657974194')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720657973770', N'1718794632915', CAST(N'2024-07-11' AS Date), 720000, 1, CAST(N'07:32:53.4166667' AS Time), N'1720657974350')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720657973770', N'1718794632915', CAST(N'2024-07-11' AS Date), 720000, 1, CAST(N'07:32:53.5066667' AS Time), N'1720657974472')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720658113580', N'1718794632915', CAST(N'2024-07-11' AS Date), 720000, 1, CAST(N'07:35:13.0233333' AS Time), N'1720658113244')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720658113580', N'1718794632915', CAST(N'2024-07-11' AS Date), 720000, 1, CAST(N'07:35:13.2300000' AS Time), N'1720658113256')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720658113580', N'1718794632915', CAST(N'2024-07-11' AS Date), 720000, 1, CAST(N'07:35:13.2566667' AS Time), N'1720658113351')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720658113580', N'1718794632915', CAST(N'2024-07-11' AS Date), 720000, 1, CAST(N'07:35:13.1733333' AS Time), N'1720658113432')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720658113580', N'1718794632915', CAST(N'2024-07-11' AS Date), 720000, 1, CAST(N'07:35:13.0833333' AS Time), N'1720658113674')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720658113580', N'1718794632915', CAST(N'2024-07-11' AS Date), 720000, 1, CAST(N'07:35:13.0533333' AS Time), N'1720658113718')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720658113580', N'1718794632915', CAST(N'2024-07-11' AS Date), 720000, 1, CAST(N'07:35:13.1466667' AS Time), N'1720658113753')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720658113580', N'1718794632915', CAST(N'2024-07-11' AS Date), 720000, 1, CAST(N'07:35:13.2000000' AS Time), N'1720658114018')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720658113580', N'1718794632915', CAST(N'2024-07-11' AS Date), 720000, 1, CAST(N'07:35:13.1100000' AS Time), N'1720658114054')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720658143251', N'1718794632915', CAST(N'2024-07-11' AS Date), 720000, 1, CAST(N'07:35:43.0233333' AS Time), N'1720658143289')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720658143251', N'1718794632915', CAST(N'2024-07-11' AS Date), 720000, 1, CAST(N'07:35:43.2033333' AS Time), N'1720658143291')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720658143251', N'1718794632915', CAST(N'2024-07-11' AS Date), 720000, 1, CAST(N'07:35:43.1133333' AS Time), N'1720658143338')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720658143251', N'1718794632915', CAST(N'2024-07-11' AS Date), 720000, 1, CAST(N'07:35:43.2600000' AS Time), N'1720658143398')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720658143251', N'1718794632915', CAST(N'2024-07-11' AS Date), 720000, 1, CAST(N'07:35:43.0566667' AS Time), N'1720658143467')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720658143251', N'1718794632915', CAST(N'2024-07-11' AS Date), 720000, 1, CAST(N'07:35:43.0800000' AS Time), N'1720658143634')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720658143251', N'1718794632915', CAST(N'2024-07-11' AS Date), 720000, 1, CAST(N'07:35:43.2300000' AS Time), N'1720658143788')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720658143251', N'1718794632915', CAST(N'2024-07-11' AS Date), 720000, 1, CAST(N'07:35:43.1733333' AS Time), N'1720658143833')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720658143251', N'1718794632915', CAST(N'2024-07-11' AS Date), 720000, 1, CAST(N'07:35:43.1433333' AS Time), N'1720658144088')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720658156258', N'1718794632915', CAST(N'2024-07-11' AS Date), 720000, 0, CAST(N'07:35:56.0800000' AS Time), N'1720658156263')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720658156258', N'1718794632915', CAST(N'2024-07-11' AS Date), 720000, 0, CAST(N'07:35:56.1366667' AS Time), N'1720658156291')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720658156258', N'1718794632915', CAST(N'2024-07-11' AS Date), 720000, 0, CAST(N'07:35:56.0200000' AS Time), N'1720658156332')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720658156258', N'1718794632915', CAST(N'2024-07-11' AS Date), 720000, 0, CAST(N'07:35:56.0500000' AS Time), N'1720658156482')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720658156258', N'1718794632915', CAST(N'2024-07-11' AS Date), 720000, 0, CAST(N'07:35:56.1933333' AS Time), N'1720658156661')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720658156258', N'1718794632915', CAST(N'2024-07-11' AS Date), 720000, 0, CAST(N'07:35:56.2200000' AS Time), N'1720658156859')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720658156258', N'1718794632915', CAST(N'2024-07-11' AS Date), 720000, 0, CAST(N'07:35:56.1666667' AS Time), N'1720658156993')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720658156258', N'1718794632915', CAST(N'2024-07-11' AS Date), 720000, 0, CAST(N'07:35:56.1100000' AS Time), N'1720658157058')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720658156258', N'1718794632915', CAST(N'2024-07-11' AS Date), 720000, 0, CAST(N'07:35:56.2466667' AS Time), N'1720658157174')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720695460115', N'1718794632915', CAST(N'2024-07-11' AS Date), 90000, 0, CAST(N'17:57:39.9766667' AS Time), N'1720695460513')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720695460115', N'1718794632915', CAST(N'2024-07-11' AS Date), 90000, 0, CAST(N'17:57:39.9466667' AS Time), N'1720695460566')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720695585715', N'1718794632915', CAST(N'2024-07-11' AS Date), 90000, 0, CAST(N'17:59:44.9933333' AS Time), N'1720695585248')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720695585715', N'1718794632915', CAST(N'2024-07-11' AS Date), 90000, 0, CAST(N'17:59:45.0266667' AS Time), N'1720695585525')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720700231253', N'3', CAST(N'2024-07-11' AS Date), 45000, 0, CAST(N'19:17:10.8600000' AS Time), N'1720700230894')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720706370903', N'1718794632915', CAST(N'2024-07-11' AS Date), 225000, 1, CAST(N'20:59:30.6100000' AS Time), N'1720706370824')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720706370903', N'1718794632915', CAST(N'2024-07-11' AS Date), 225000, 1, CAST(N'20:59:30.6400000' AS Time), N'1720706370998')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720706370903', N'1718794632915', CAST(N'2024-07-11' AS Date), 225000, 1, CAST(N'20:59:30.6700000' AS Time), N'1720706371385')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720707899479', N'1718794632915', CAST(N'2024-07-11' AS Date), 90000, 1, CAST(N'21:24:58.8566667' AS Time), N'1720707899315')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'1720707899479', N'1718794632915', CAST(N'2024-07-11' AS Date), 90000, 1, CAST(N'21:24:58.8866667' AS Time), N'1720707899429')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'B001', N'1', CAST(N'2023-05-15' AS Date), 45000, 0, CAST(N'10:00:00' AS Time), N'T001')
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'B002', N'2', CAST(N'2023-05-15' AS Date), 45000, 0, CAST(N'20:00:00' AS Time), N'T002')
GO
INSERT [dbo].[bill] ([id_bill], [id_account], [datecreated], [totalmoney], [status], [timecreated], [id_ticket]) VALUES (N'B003', N'2', CAST(N'2023-05-15' AS Date), 45000, 0, CAST(N'23:00:00' AS Time), N'T003')
GO
INSERT [dbo].[cinema] ([id_cinema], [cinemaname], [address], [status]) VALUES (N'C001', N'Vincom Cinema', N'216 Võ Văn Ngân, Bình Thọ, Thủ Đức, Thành phố Hồ Chí Minh', 1)
INSERT [dbo].[cinema] ([id_cinema], [cinemaname], [address], [status]) VALUES (N'C002', N'Aeon Cinema', N'AEON-Bình Dương Canary 77 Thuận An, Đại lộ Bình Dương, Thuận Giao, Thuận An, Bình Dương', 0)
INSERT [dbo].[cinema] ([id_cinema], [cinemaname], [address], [status]) VALUES (N'C003', N'Cinestar Cinema', N'Làng Đại Học Quốc Gia, Thành Phố Hồ Chí Minh', 0)
GO
INSERT [dbo].[cinemaroom] ([id_cinemaroom], [id_cinema], [id_roomcategory], [roomname], [status]) VALUES (N'R1', N'C001', N'RC001', N'3D Room ', 1)
INSERT [dbo].[cinemaroom] ([id_cinemaroom], [id_cinema], [id_roomcategory], [roomname], [status]) VALUES (N'R2', N'C001', N'RC002', N'Standard Room', 0)
GO
INSERT [dbo].[comment] ([id_comment], [id_movie], [id_account], [content], [status], [datecomment], [rating]) VALUES (N'3526f7e9-8c7e-4b71-adf9-725f5826de37', N'MOV021', N'1718794632915', N'phim như cứt', 1, CAST(N'2024-07-11T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[comment] ([id_comment], [id_movie], [id_account], [content], [status], [datecomment], [rating]) VALUES (N'bd654f51-7ab6-4492-a6cc-494d06b20fce', N'MOV002', N'3', N'cool movie', 1, CAST(N'2024-07-11T00:00:00.000' AS DateTime), 5)
GO
INSERT [dbo].[movie] ([id_movie], [moviename], [director], [actor], [language], [trailer], [agelimit], [coverimage], [category], [nationalorigin], [effectivedatefrom], [effectivedateto], [status], [summary], [Duration]) VALUES (N'MOV001', N'Avengers: Endgame', N'Anthony Russo, Joe Russo', N'Robert Downey Jr., Chris Evans, Mark Ruffalo', N'English', N'https://www.youtube.com/watch?v=TcMBFSGVi1c', N'13+', N'img/Movie1.jpg', N'Action', N'USA', CAST(N'2019-04-26' AS Date), CAST(N'2020-04-25' AS Date), 1, N'After the devastating events of Avengers: Infinity War (2018), the universe is in ruins. With the help of remaining allies, the Avengers assemble once more in order to reverse Thanos'' actions and restore balance to the universe.', 120)
INSERT [dbo].[movie] ([id_movie], [moviename], [director], [actor], [language], [trailer], [agelimit], [coverimage], [category], [nationalorigin], [effectivedatefrom], [effectivedateto], [status], [summary], [Duration]) VALUES (N'MOV002', N'Toy Story 4', N'Josh Cooley', N'Tom Hanks, Tim Allen', N'English', N'https://youtube.com/watch?v=wmiIUN-7qhE&t=1s', N'13+', N'img/Movie2.jpg', N'Animation', N'USA', CAST(N'2019-06-21' AS Date), CAST(N'2020-06-20' AS Date), 1, N'Toy Story is a franchise more intrinsically linked to Trevor''s heart than any other piece of art on this planet, and Toy Story 4 mercilessly eviscerated everything about it that he loved from the plot to the characters, to the themes and messaging.', 120)
INSERT [dbo].[movie] ([id_movie], [moviename], [director], [actor], [language], [trailer], [agelimit], [coverimage], [category], [nationalorigin], [effectivedatefrom], [effectivedateto], [status], [summary], [Duration]) VALUES (N'MOV003', N'The Lion King', N'Jon Favreau', N'Donald Glover, Beyoncé, Seth Rogen', N'English', N'https://www.youtube.com/watch?v=7TavVZMewpY', N'13+', N'img/Movie3.jpg', N'Adventure', N'USA', CAST(N'2019-07-19' AS Date), CAST(N'2020-07-18' AS Date), 1, N'The Lion King (original English title: The Lion King) is a 2019 American musical film directed and produced by Jon Favreau, with a script by Jeff Nathanson and directed by Walt Disney Pictures. manufacturer. This is a computer-animated remake of Disney''s 1994 traditionally animated film of the same name.', 120)
INSERT [dbo].[movie] ([id_movie], [moviename], [director], [actor], [language], [trailer], [agelimit], [coverimage], [category], [nationalorigin], [effectivedatefrom], [effectivedateto], [status], [summary], [Duration]) VALUES (N'MOV004', N'Joker', N'Todd Phillips', N'Joaquin Phoenix, Robert De Niro', N'English', N'https://www.youtube.com/watch?v=xy8aJw1vYHo', N'13+', N'img/Movie4.jpg', N'Drama', N'USA', CAST(N'2019-10-04' AS Date), CAST(N'2020-10-03' AS Date), 1, N'During the 1980s, a failed stand-up comedian is driven insane and turns to a life of crime and chaos in Gotham City while becoming an infamous psychopathic crime figure.', 120)
INSERT [dbo].[movie] ([id_movie], [moviename], [director], [actor], [language], [trailer], [agelimit], [coverimage], [category], [nationalorigin], [effectivedatefrom], [effectivedateto], [status], [summary], [Duration]) VALUES (N'MOV005', N'Frozen II', N'Chris Buck, Jennifer Lee', N'Kristen Bell, Idina Menzel', N'English', N'https://www.youtube.com/watch?v=Zi4LMpSDccc', N'13+', N'img/Movie5.jpg', N'Animation', N'USA', CAST(N'2019-11-22' AS Date), CAST(N'2020-11-21' AS Date), 1, N'Frozen II is a 2019 American animated fantasy film that was produced by Walt Disney Animation Studios. It is the sequel to the hit 2013 film Frozen and takes place four years after the death of Elsa''s parents. The film follows Elsa as she embarks on a journey to explore the dark, enchanted forest where her mother died, and to find an ancient, mystical relic that has the power to bring her parents back to life', 120)
INSERT [dbo].[movie] ([id_movie], [moviename], [director], [actor], [language], [trailer], [agelimit], [coverimage], [category], [nationalorigin], [effectivedatefrom], [effectivedateto], [status], [summary], [Duration]) VALUES (N'MOV006', N'Spider-Man: Far from Home', N'Jon Watts', N'Tom Holland, Samuel L. Jackson', N'English', N'https://www.youtube.com/watch?v=Nt9L1jCKGnE', N'13+', N'img/Movie6.jpg', N'Action', N'USA', CAST(N'2019-07-02' AS Date), CAST(N'2020-07-01' AS Date), 1, N'Spider-Man: Far from Home is a 2019 American superhero film based on the Marvel Comics character Spider-Man. The movie follows Peter Parker, a teenager who gets sent to an exchange program in Norway and must navigate the challenges of adolescence while also dealing with new powers. Directed by Jon Watts and starring Tom Holland as Spider-Man, the film was a critical and commercial success, grossing over $1.1 billion worldwide.', 120)
INSERT [dbo].[movie] ([id_movie], [moviename], [director], [actor], [language], [trailer], [agelimit], [coverimage], [category], [nationalorigin], [effectivedatefrom], [effectivedateto], [status], [summary], [Duration]) VALUES (N'MOV007', N'Parasite', N'Bong Joon Ho', N'Kang-ho Song, Lee Sun-kyun', N'Korean', N'https://www.youtube.com/watch?v=5xH0HfJHsaY', N'13+', N'img/Movie7.jpg', N'Drama', N'South Korea', CAST(N'2019-05-30' AS Date), CAST(N'2020-05-29' AS Date), 1, N'Parasites are organisms that live in or on other organisms and obtain their nutrients from their host. They can differ in size, shape, and behavior. There are many types of parasites that can affect humans, including worms, ticks, fleas, and mites. These parasites can spread by contaminated food and water, direct contact with infected individuals, and through vectors such as mosquitoes and rodents. Symptoms can vary greatly and can include itching, rash, nausea, and diarrhea. Prevention measures include using insect repellents, washing hands frequently, and avoiding water sources contaminated with parasites', 120)
INSERT [dbo].[movie] ([id_movie], [moviename], [director], [actor], [language], [trailer], [agelimit], [coverimage], [category], [nationalorigin], [effectivedatefrom], [effectivedateto], [status], [summary], [Duration]) VALUES (N'MOV008', N'1917', N'Sam Mendes', N'Dean-Charles Chapman, George MacKay', N'English', N'https://www.youtube.com/watch?v=YqNYrYUiMfg', N'13+', N'img/Movie8.jpg', N'Drama', N'UK', CAST(N'2019-12-25' AS Date), CAST(N'2020-12-24' AS Date), 1, N'April 6th, 1917. As an infantry battalion assembles to wage war deep in enemy territory, two soldiers are assigned to race against time and deliver a message that will stop 1,600 men from walking straight into a deadly trap.', 120)
INSERT [dbo].[movie] ([id_movie], [moviename], [director], [actor], [language], [trailer], [agelimit], [coverimage], [category], [nationalorigin], [effectivedatefrom], [effectivedateto], [status], [summary], [Duration]) VALUES (N'MOV009', N'Knives Out', N'Rian Johnson', N'Daniel Craig, Chris Evans', N'English', N'https://www.youtube.com/watch?v=qGqiHJTsRkQ', N'13+', N'img/Movie9.jpg', N'Comedy', N'USA', CAST(N'2019-11-27' AS Date), CAST(N'2020-11-26' AS Date), 1, N'Knives Out is a 2019 American murder mystery film directed by Rian Johnson. The film stars Daniel Craig as Detective Benoit Blanc, who investigates the death of a wealthy family patriarch. The film received critical acclaim for its sharp writing, strong performances, and clever twists. It was nominated for several awards, including Best Picture at the 92nd Academy Awards.', 120)
INSERT [dbo].[movie] ([id_movie], [moviename], [director], [actor], [language], [trailer], [agelimit], [coverimage], [category], [nationalorigin], [effectivedatefrom], [effectivedateto], [status], [summary], [Duration]) VALUES (N'MOV010', N'Once Upon a Time in Hollywood', N'Quentin Tarantino', N'Leonardo DiCaprio, Brad Pitt', N'English', N'https://www.youtube.com/watch?v=ELeMaP8EPAA', N'13+', N'img/Movie10.jpg', N'Comedy', N'USA', CAST(N'2019-07-26' AS Date), CAST(N'2020-07-25' AS Date), 1, N'"Once Upon a Time in Hollywood" is a 2019 film directed by Quentin Tarantino. The film is set in 1969 and follows a Western actor, Rick Dalton (played by Leonardo DiCaprio), and his stunt double, Cliff Booth (played by Brad Pitt), as they navigate the changing landscape of the Hollywood film industry. Sydney Sweeney, an actress, appears in the film as a young actress named Margot Robbie', 120)
INSERT [dbo].[movie] ([id_movie], [moviename], [director], [actor], [language], [trailer], [agelimit], [coverimage], [category], [nationalorigin], [effectivedatefrom], [effectivedateto], [status], [summary], [Duration]) VALUES (N'MOV011', N'Inside Out 2', N'Amy Poehler', N'Phyllis Smith, Lewis Black', N'English', N'https://www.youtube.com/watch?v=L4DrolmDxmw', N'13+', N'img/Movie11.jpg', N'Adventure', N'USA', CAST(N'2024-06-13' AS Date), CAST(N'2024-06-12' AS Date), 0, N'Inside Out 2 will return to a new part of the mind of teenage girl Riley. One day, the headquarters was suddenly destroyed to make way for something completely new: A new emotion! Happiness, Sadness, Anger, Fear and Disgust must "welcome" the appearance of a new emotion called Anxiety. And it looks like she didnt just appear alone.', 120)
INSERT [dbo].[movie] ([id_movie], [moviename], [director], [actor], [language], [trailer], [agelimit], [coverimage], [category], [nationalorigin], [effectivedatefrom], [effectivedateto], [status], [summary], [Duration]) VALUES (N'MOV012', N'AVATAR: The Way of Water', N'James Cameron', N'Sam Worthington, Zoe Saldana', N'English', N'https://www.youtube.com/watch?v=a8Gx8wiNbs8', N'13+', N'img/Movie12.jpg', N'Adventure', N'USA', CAST(N'2022-07-13' AS Date), CAST(N'2023-06-12' AS Date), 0, N'The story of “Avatar: Flow of Water” is set 10 years after the events of the first part. The film tells the story of Jake Sullys (played by Sam Worthington) new family and the troubles that follow and the tragedy they endure when the human side invades the planet Pandora.', 120)
INSERT [dbo].[movie] ([id_movie], [moviename], [director], [actor], [language], [trailer], [agelimit], [coverimage], [category], [nationalorigin], [effectivedatefrom], [effectivedateto], [status], [summary], [Duration]) VALUES (N'MOV013', N'Deadpool and Wolverine', N'Shawn Levy', N'Ryan Reynolds, Hugh Jackman', N'English', N'https://www.youtube.com/watch?v=uJMCNJP2ipI', N'16+', N'img/Movie13.jpg', N'Comedy', N'USA', CAST(N'2024-07-26' AS Date), CAST(N'2025-06-13' AS Date), 0, N'The film will see Deadpool and Wolverine crossing the multiverse in an attempt to save the MCU. With the main characters Wade Wilson aka Deadpool (Ryan Reynolds) and Logan aka Wolverine (Hugh Jackman), it promises to bring an unprecedented explosive experience on screen.', 120)
INSERT [dbo].[movie] ([id_movie], [moviename], [director], [actor], [language], [trailer], [agelimit], [coverimage], [category], [nationalorigin], [effectivedatefrom], [effectivedateto], [status], [summary], [Duration]) VALUES (N'MOV014', N'Venom: The Last Dance', N'Kelly Marcel', N'Tom Hardy, Juno Temple', N'English', N'https://www.youtube.com/watch?v=qGqiHJTsRkQ', N'16+', N'img/Movie14.jpg', N'Action', N'USA', CAST(N'2024-11-10' AS Date), CAST(N'2025-11-09' AS Date), 0, N'In Venom: The Last Dance, Tom Hardy returns as Venom, one of Marvels greatest and most complex characters, for the final film in the trilogy. Eddie and Venom are on the run. Hunted by both of their worlds and with the net closing in, the duo are forced into a devastating decision that will bring the curtains down on Venom and Eddie\s last dance.', 120)
INSERT [dbo].[movie] ([id_movie], [moviename], [director], [actor], [language], [trailer], [agelimit], [coverimage], [category], [nationalorigin], [effectivedatefrom], [effectivedateto], [status], [summary], [Duration]) VALUES (N'MOV015', N'Bad Boys: Ride or Die 2024', N'Chris Bremner', N'Will Smith, Martin Lawrence', N'English', N'https://www.youtube.com/watch?v=hRFY_Fesa9Q&t=1s', N'16+', N'img/Movie15.jpg', N'Action', N'USA', CAST(N'2024-06-07' AS Date), CAST(N'2025-06-06' AS Date), 0, N'This summer, the worlds favorite bad boys return with their iconic combination of heart-pounding action and outrageous humor. But something is different this time: this time the best people Miami has got are on the run.', 120)
INSERT [dbo].[movie] ([id_movie], [moviename], [director], [actor], [language], [trailer], [agelimit], [coverimage], [category], [nationalorigin], [effectivedatefrom], [effectivedateto], [status], [summary], [Duration]) VALUES (N'MOV016', N'Despicable Me 4', N'Chris Renaud', N'Steve Carell, Kristen Wiig', N'English', N'https://www.youtube.com/watch?v=JnynPtxEY5M', N'13+', N'img/Movie16.jpg', N'Adventure', N'USA', CAST(N'2024-07-05' AS Date), CAST(N'2025-06-07' AS Date), 0, N'The crazy and funny adventures of Gru and his family, of course, indispensable the group of clumsy "golden bananas" - Minions! Following the events of Despicable Me 3 (2017), Gru has now reformed and limited his participation in illegal activities. In addition to his wife Lucy Wilde and adopted daughters Margo, Edith, and Agnes, Grus family now also welcomes a new member, Gru Junior - his first son. However, Grus familys safety is quickly threatened when his old enemy Maxime Le Mal escapes from prison, planning to take revenge and settle his old debt with Gru. Accompanying Maxime is also his lover Valentina. Therefore, Gru is forced to stand up to face the enemy to protect his family and the Minions. When Maxime Le Mal discovers Grus whereabouts, Silas Ramsbottom - former director of the Anti-Villains League - recklessly uses super essence to create super agents. Of course, the Minions became the first testers. With a resounding success, the "normal" Minion suddenly transformed into a Mega Minion with a super silly shape but possessing boundless abilities.', 120)
INSERT [dbo].[movie] ([id_movie], [moviename], [director], [actor], [language], [trailer], [agelimit], [coverimage], [category], [nationalorigin], [effectivedatefrom], [effectivedateto], [status], [summary], [Duration]) VALUES (N'MOV017', N'Sonic the Hedgehog 2', N'Jeff Fowler', N'Ben Schwartz, Idris Elba', N'English', N'https://www.youtube.com/watch?v=G5kzUpWAusI', N'13+', N'img/Movie17.jpg', N'Animation', N'South Korea', CAST(N'2022-04-15' AS Date), CAST(N'2023-05-14' AS Date), 0, N'An old enemy returns with an opponent of equal strength, what should Sonic do?', 120)
INSERT [dbo].[movie] ([id_movie], [moviename], [director], [actor], [language], [trailer], [agelimit], [coverimage], [category], [nationalorigin], [effectivedatefrom], [effectivedateto], [status], [summary], [Duration]) VALUES (N'MOV018', N'Spider-Man: Across The Spider-Verse', N'Joaquim Dos Santos', N'Shameik Moore, Jake Johnson', N'English', N'https://www.youtube.com/watch?v=cqGjhVJWtEg', N'13+', N'img/Movie18.jpg', N'Drama', N'USA', CAST(N'2023-06-01' AS Date), CAST(N'2024-05-31' AS Date), 0, N'Miles Morales reappears in the sequel to the Oscar-winning animated blockbuster - Spider-Man: Across the Spider-Verse. After meeting Gwen Stacy again, the friendly Spider-Man from Brooklyn must travel through the multiverse and meet a group of Spider-Men responsible for protecting parallel worlds. But when the superhero team clashes over how to handle a new threat, Miles is forced to pit himself against the other Spider-Men and redefine what it means to be a hero so he can save the ones he loves most.', 120)
INSERT [dbo].[movie] ([id_movie], [moviename], [director], [actor], [language], [trailer], [agelimit], [coverimage], [category], [nationalorigin], [effectivedatefrom], [effectivedateto], [status], [summary], [Duration]) VALUES (N'MOV019', N'IT: Chapter 2', N'Andy Muschietti', N'James McAvoy, Bill Skarsgard', N'English', N'https://www.youtube.com/watch?v=xhJ5P7Up3jA&t=1s', N'16+', N'img/Movie19.jpg', N'Animation', N'USA', CAST(N'2019-09-06' AS Date), CAST(N'2020-09-05' AS Date), 0, N'After eliminating Pennywise the clown from town, the Losers Club members have now grown up and moved away. And then, an unexpected phone call brings them back! At the end of part one, the Loser Club group consisting of seven friends Bill, Ben, Beverly, Richie, Mike, Eddie, Stanley... were lucky to defeat the evil clown who specializes in kidnapping children Pennywise. However, the Loser Club knows that the clown will return. They made a vow that if Pennywise appeared again, they would all return to destroy him. And twenty-seven years have passed. The boys and girls have now grown up and have experienced half their lives. Loser Club still follows their promise to return to their hometown. However, things are no longer the same as before. The group of friends has been apart for too long and is not as close as before. The fear in them is also greater, when they are all approximately forty years old. And most importantly, the clown has become much stronger.', 120)
INSERT [dbo].[movie] ([id_movie], [moviename], [director], [actor], [language], [trailer], [agelimit], [coverimage], [category], [nationalorigin], [effectivedatefrom], [effectivedateto], [status], [summary], [Duration]) VALUES (N'MOV020', N'April, Come She Will', N'Yuki Saito', N'Mori Nana, Nagasawa Masami', N'Japanese', N'https://www.youtube.com/watch?v=Eij4XfBOg54', N'16+', N'img/Movie20.jpg', N'Comedy', N'Japan', CAST(N'2024-05-17' AS Date), CAST(N'2025-05-16' AS Date), 0, N'Fujishiro Shun (Satoh Takeru) is preparing to get married. One day in April, Fujishiro suddenly received a letter from Iyoda Haru (Mori Nana), his first love 10 years ago. At the same time, Fujishiros fiancée Sakamoto Yayoi (Nagasawa Masami) suddenly disappears. Fujishiro begins his journey to find the person he loves, with scenes spanning across Tokyo, Uyuni (Bolivia), Prague (Czech Republic), Iceland and other countries around the world.', 120)
INSERT [dbo].[movie] ([id_movie], [moviename], [director], [actor], [language], [trailer], [agelimit], [coverimage], [category], [nationalorigin], [effectivedatefrom], [effectivedateto], [status], [summary], [Duration]) VALUES (N'MOV021', N'TRANSFORMERS: Rise Of The Beasts', N'Steven Caple Jr.', N'Duong T? Qu?nh, Ron Perlman, Dominique Fishback', N'English', N'https://www.youtube.com/watch?v=itnqEauWQZM', N'16+', N'img/Movie21.jpg', N'Sci-Fi', N'USA', CAST(N'2023-06-09' AS Date), CAST(N'2024-06-08' AS Date), 1, N'Transformers: Rise Of The Beasts is set in 1994, the time after Bumblebee appeared. As the title indicates, this film is based on the extremely popular Beast Wars series in the 1990s. This is also the first time a new group of robots appears, capable of turning themselves into animals instead of cars. as before.', 120)
INSERT [dbo].[movie] ([id_movie], [moviename], [director], [actor], [language], [trailer], [agelimit], [coverimage], [category], [nationalorigin], [effectivedatefrom], [effectivedateto], [status], [summary], [Duration]) VALUES (N'MOV022', N'John Wick: Chapter 4', N'Chad Stahelski', N'Keanu Reeves, Laurence Fishburne, George Georgiou', N'English', N'https://www.youtube.com/watch?v=qEVUtrk8_B4', N'16+', N'img/Movie22.jpg', N'Sci-Fi', N'USA', CAST(N'2023-03-24' AS Date), CAST(N'2024-03-23' AS Date), 1, N'John Wick uncovers a path to defeating The High Table. But before he can earn his freedom, Wick must face off against a new enemy with powerful alliances across the globe and forces that turn old friends into foes.', 120)
INSERT [dbo].[movie] ([id_movie], [moviename], [director], [actor], [language], [trailer], [agelimit], [coverimage], [category], [nationalorigin], [effectivedatefrom], [effectivedateto], [status], [summary], [Duration]) VALUES (N'MOV023', N'Oppenheimer', N'Christopher Nolan', N'Cillian Murphy, Robert Downey Jr., Emily Blunt', N'English', N'https://www.youtube.com/watch?v=uYPbbksJxIg', N'16+', N'img/Movie23.jpg', N'Sci-Fi', N'USA', CAST(N'2023-08-11' AS Date), CAST(N'2024-08-10' AS Date), 0, N'With the central character being J. Robert Oppenheimer, the theoretical physicist who headed the Los Alamos laboratory, during World War II. He played a key role in the Manhattan Project, pioneered the quest to develop nuclear weapons, and is considered one of the "fathers of the atomic bomb."', 120)
INSERT [dbo].[movie] ([id_movie], [moviename], [director], [actor], [language], [trailer], [agelimit], [coverimage], [category], [nationalorigin], [effectivedatefrom], [effectivedateto], [status], [summary], [Duration]) VALUES (N'MOV024', N'Aquaman and the Lost Kingdom', N'James Wan', N'Amber Heard, Patrick Wilson, Nicole Kidman', N'English', N'https://www.youtube.com/watch?v=UGc5Tzz19UY', N'16+', N'img/Movie24.jpg', N'Sci-Fi', N'USA', CAST(N'2023-12-22' AS Date), CAST(N'2024-12-21' AS Date), 0, N'Aquaman and the Lost Kingdom is a sequel to 2018''s Aquaman when Arthur ascends to the throne of Atlantis. Now, Arthur Curry has become a father who takes care of his children every day and rules over the vast Atlantis region. However, the old enemy will never leave the sea king in peace. Thanks to the help of technology, Black Manta rose again with more terrible power than before. Unable to fight alone, Arthur had to ask for help from another enemy - his half-brother Orm. Together against a common enemy, can this pair of brothers who are inseparable from each other be able to mend their relationship?', 120)
GO
INSERT [dbo].[movie_moviecategory] ([id_category], [id_movie]) VALUES (N'MC001', N'MOV001')
INSERT [dbo].[movie_moviecategory] ([id_category], [id_movie]) VALUES (N'MC002', N'MOV002')
INSERT [dbo].[movie_moviecategory] ([id_category], [id_movie]) VALUES (N'MC003', N'MOV003')
INSERT [dbo].[movie_moviecategory] ([id_category], [id_movie]) VALUES (N'MC004', N'MOV004')
INSERT [dbo].[movie_moviecategory] ([id_category], [id_movie]) VALUES (N'MC005', N'MOV005')
INSERT [dbo].[movie_moviecategory] ([id_category], [id_movie]) VALUES (N'MC006', N'MOV006')
GO
INSERT [dbo].[moviecategory] ([id_category], [categoryname], [status]) VALUES (N'MC001', N'Action', 1)
INSERT [dbo].[moviecategory] ([id_category], [categoryname], [status]) VALUES (N'MC002', N'Animation', 1)
INSERT [dbo].[moviecategory] ([id_category], [categoryname], [status]) VALUES (N'MC003', N'Adventure', 1)
INSERT [dbo].[moviecategory] ([id_category], [categoryname], [status]) VALUES (N'MC004', N'Comedy', 1)
INSERT [dbo].[moviecategory] ([id_category], [categoryname], [status]) VALUES (N'MC005', N'Drama', 1)
INSERT [dbo].[moviecategory] ([id_category], [categoryname], [status]) VALUES (N'MC006', N'Sci-Fi', 1)
GO
INSERT [dbo].[moviescreeningsession] ([id_moviescreeningsession], [id_movie], [id_cinemaroom], [screeningdate], [starttime], [endtime], [status]) VALUES (N'MS0013', N'MOV001', N'R1', CAST(N'2024-07-01' AS Date), CAST(N'11:00:00' AS Time), CAST(N'13:00:00' AS Time), 1)
INSERT [dbo].[moviescreeningsession] ([id_moviescreeningsession], [id_movie], [id_cinemaroom], [screeningdate], [starttime], [endtime], [status]) VALUES (N'MSS001', N'MOV001', N'R1', CAST(N'2024-07-01' AS Date), CAST(N'09:00:00' AS Time), CAST(N'11:00:00' AS Time), 1)
INSERT [dbo].[moviescreeningsession] ([id_moviescreeningsession], [id_movie], [id_cinemaroom], [screeningdate], [starttime], [endtime], [status]) VALUES (N'MSS002', N'MOV002', N'R1', CAST(N'2024-07-01' AS Date), CAST(N'11:00:00' AS Time), CAST(N'13:00:00' AS Time), 1)
INSERT [dbo].[moviescreeningsession] ([id_moviescreeningsession], [id_movie], [id_cinemaroom], [screeningdate], [starttime], [endtime], [status]) VALUES (N'MSS003', N'MOV003', N'R1', CAST(N'2024-07-01' AS Date), CAST(N'13:00:00' AS Time), CAST(N'15:00:00' AS Time), 1)
INSERT [dbo].[moviescreeningsession] ([id_moviescreeningsession], [id_movie], [id_cinemaroom], [screeningdate], [starttime], [endtime], [status]) VALUES (N'MSS004', N'MOV004', N'R1', CAST(N'2024-07-01' AS Date), CAST(N'15:00:00' AS Time), CAST(N'17:00:00' AS Time), 1)
INSERT [dbo].[moviescreeningsession] ([id_moviescreeningsession], [id_movie], [id_cinemaroom], [screeningdate], [starttime], [endtime], [status]) VALUES (N'MSS005', N'MOV005', N'R1', CAST(N'2024-07-01' AS Date), CAST(N'18:00:00' AS Time), CAST(N'20:00:00' AS Time), 1)
INSERT [dbo].[moviescreeningsession] ([id_moviescreeningsession], [id_movie], [id_cinemaroom], [screeningdate], [starttime], [endtime], [status]) VALUES (N'MSS006', N'MOV006', N'R1', CAST(N'2024-07-01' AS Date), CAST(N'20:00:00' AS Time), CAST(N'22:00:00' AS Time), 1)
INSERT [dbo].[moviescreeningsession] ([id_moviescreeningsession], [id_movie], [id_cinemaroom], [screeningdate], [starttime], [endtime], [status]) VALUES (N'MSS007', N'MOV007', N'R1', CAST(N'2024-07-02' AS Date), CAST(N'09:00:00' AS Time), CAST(N'11:00:00' AS Time), 1)
INSERT [dbo].[moviescreeningsession] ([id_moviescreeningsession], [id_movie], [id_cinemaroom], [screeningdate], [starttime], [endtime], [status]) VALUES (N'MSS008', N'MOV008', N'R1', CAST(N'2024-07-02' AS Date), CAST(N'11:00:00' AS Time), CAST(N'13:00:00' AS Time), 1)
INSERT [dbo].[moviescreeningsession] ([id_moviescreeningsession], [id_movie], [id_cinemaroom], [screeningdate], [starttime], [endtime], [status]) VALUES (N'MSS009', N'MOV009', N'R1', CAST(N'2024-07-02' AS Date), CAST(N'13:00:00' AS Time), CAST(N'15:00:00' AS Time), 1)
INSERT [dbo].[moviescreeningsession] ([id_moviescreeningsession], [id_movie], [id_cinemaroom], [screeningdate], [starttime], [endtime], [status]) VALUES (N'MSS010', N'MOV010', N'R1', CAST(N'2024-07-02' AS Date), CAST(N'15:00:00' AS Time), CAST(N'17:00:00' AS Time), 1)
INSERT [dbo].[moviescreeningsession] ([id_moviescreeningsession], [id_movie], [id_cinemaroom], [screeningdate], [starttime], [endtime], [status]) VALUES (N'MSS011', N'MOV021', N'R1', CAST(N'2024-07-02' AS Date), CAST(N'18:00:00' AS Time), CAST(N'20:00:00' AS Time), 1)
INSERT [dbo].[moviescreeningsession] ([id_moviescreeningsession], [id_movie], [id_cinemaroom], [screeningdate], [starttime], [endtime], [status]) VALUES (N'MSS012', N'MOV022', N'R1', CAST(N'2024-07-02' AS Date), CAST(N'20:00:00' AS Time), CAST(N'22:00:00' AS Time), 1)
GO
INSERT [dbo].[role] ([id_role], [role]) VALUES (N'R001', N'Admin')
INSERT [dbo].[role] ([id_role], [role]) VALUES (N'R002', N'User')
GO
INSERT [dbo].[roomcategory] ([id_roomcategory], [roomname], [status]) VALUES (N'RC001', N'3D', 1)
INSERT [dbo].[roomcategory] ([id_roomcategory], [roomname], [status]) VALUES (N'RC002', N'Standard', 0)
GO
INSERT [dbo].[seat] ([id_seat], [id_seatcategory], [id_cinemaroom], [row], [column], [status]) VALUES (N'A0', N'SC001', N'R1', N'A', 0, 1)
INSERT [dbo].[seat] ([id_seat], [id_seatcategory], [id_cinemaroom], [row], [column], [status]) VALUES (N'A1', N'SC001', N'R1', N'A', 1, 1)
INSERT [dbo].[seat] ([id_seat], [id_seatcategory], [id_cinemaroom], [row], [column], [status]) VALUES (N'A2', N'SC001', N'R1', N'A', 2, 1)
INSERT [dbo].[seat] ([id_seat], [id_seatcategory], [id_cinemaroom], [row], [column], [status]) VALUES (N'A3', N'SC001', N'R1', N'A', 3, 1)
INSERT [dbo].[seat] ([id_seat], [id_seatcategory], [id_cinemaroom], [row], [column], [status]) VALUES (N'A4', N'SC001', N'R1', N'A', 4, 1)
INSERT [dbo].[seat] ([id_seat], [id_seatcategory], [id_cinemaroom], [row], [column], [status]) VALUES (N'A5', N'SC001', N'R1', N'A', 5, 1)
INSERT [dbo].[seat] ([id_seat], [id_seatcategory], [id_cinemaroom], [row], [column], [status]) VALUES (N'A6', N'SC001', N'R1', N'A', 6, 1)
INSERT [dbo].[seat] ([id_seat], [id_seatcategory], [id_cinemaroom], [row], [column], [status]) VALUES (N'A7', N'SC001', N'R1', N'A', 7, 1)
INSERT [dbo].[seat] ([id_seat], [id_seatcategory], [id_cinemaroom], [row], [column], [status]) VALUES (N'A8', N'SC001', N'R1', N'A', 8, 1)
INSERT [dbo].[seat] ([id_seat], [id_seatcategory], [id_cinemaroom], [row], [column], [status]) VALUES (N'A9', N'SC001', N'R1', N'A', 9, 1)
INSERT [dbo].[seat] ([id_seat], [id_seatcategory], [id_cinemaroom], [row], [column], [status]) VALUES (N'B0', N'SC001', N'R1', N'B', 0, 1)
INSERT [dbo].[seat] ([id_seat], [id_seatcategory], [id_cinemaroom], [row], [column], [status]) VALUES (N'B1', N'SC001', N'R1', N'B', 1, 1)
INSERT [dbo].[seat] ([id_seat], [id_seatcategory], [id_cinemaroom], [row], [column], [status]) VALUES (N'B2', N'SC001', N'R1', N'B', 2, 1)
INSERT [dbo].[seat] ([id_seat], [id_seatcategory], [id_cinemaroom], [row], [column], [status]) VALUES (N'B3', N'SC001', N'R1', N'B', 3, 1)
INSERT [dbo].[seat] ([id_seat], [id_seatcategory], [id_cinemaroom], [row], [column], [status]) VALUES (N'B4', N'SC001', N'R1', N'B', 4, 1)
INSERT [dbo].[seat] ([id_seat], [id_seatcategory], [id_cinemaroom], [row], [column], [status]) VALUES (N'B5', N'SC001', N'R1', N'B', 5, 1)
INSERT [dbo].[seat] ([id_seat], [id_seatcategory], [id_cinemaroom], [row], [column], [status]) VALUES (N'B6', N'SC001', N'R1', N'B', 6, 1)
INSERT [dbo].[seat] ([id_seat], [id_seatcategory], [id_cinemaroom], [row], [column], [status]) VALUES (N'B7', N'SC001', N'R1', N'B', 7, 1)
INSERT [dbo].[seat] ([id_seat], [id_seatcategory], [id_cinemaroom], [row], [column], [status]) VALUES (N'B8', N'SC001', N'R1', N'B', 8, 1)
INSERT [dbo].[seat] ([id_seat], [id_seatcategory], [id_cinemaroom], [row], [column], [status]) VALUES (N'B9', N'SC001', N'R1', N'B', 9, 1)
INSERT [dbo].[seat] ([id_seat], [id_seatcategory], [id_cinemaroom], [row], [column], [status]) VALUES (N'C0', N'SC001', N'R1', N'C', 0, 1)
INSERT [dbo].[seat] ([id_seat], [id_seatcategory], [id_cinemaroom], [row], [column], [status]) VALUES (N'C1', N'SC001', N'R1', N'C', 1, 1)
INSERT [dbo].[seat] ([id_seat], [id_seatcategory], [id_cinemaroom], [row], [column], [status]) VALUES (N'C2', N'SC001', N'R1', N'C', 2, 1)
INSERT [dbo].[seat] ([id_seat], [id_seatcategory], [id_cinemaroom], [row], [column], [status]) VALUES (N'C3', N'SC001', N'R1', N'C', 3, 1)
INSERT [dbo].[seat] ([id_seat], [id_seatcategory], [id_cinemaroom], [row], [column], [status]) VALUES (N'C4', N'SC001', N'R1', N'C', 4, 1)
INSERT [dbo].[seat] ([id_seat], [id_seatcategory], [id_cinemaroom], [row], [column], [status]) VALUES (N'C5', N'SC001', N'R1', N'C', 5, 1)
INSERT [dbo].[seat] ([id_seat], [id_seatcategory], [id_cinemaroom], [row], [column], [status]) VALUES (N'C6', N'SC001', N'R1', N'C', 6, 1)
INSERT [dbo].[seat] ([id_seat], [id_seatcategory], [id_cinemaroom], [row], [column], [status]) VALUES (N'C7', N'SC001', N'R1', N'C', 7, 1)
INSERT [dbo].[seat] ([id_seat], [id_seatcategory], [id_cinemaroom], [row], [column], [status]) VALUES (N'C8', N'SC001', N'R1', N'C', 8, 1)
INSERT [dbo].[seat] ([id_seat], [id_seatcategory], [id_cinemaroom], [row], [column], [status]) VALUES (N'C9', N'SC001', N'R1', N'C', 9, 1)
INSERT [dbo].[seat] ([id_seat], [id_seatcategory], [id_cinemaroom], [row], [column], [status]) VALUES (N'D0', N'SC002', N'R1', N'D', 0, 1)
INSERT [dbo].[seat] ([id_seat], [id_seatcategory], [id_cinemaroom], [row], [column], [status]) VALUES (N'D1', N'SC002', N'R1', N'D', 1, 1)
INSERT [dbo].[seat] ([id_seat], [id_seatcategory], [id_cinemaroom], [row], [column], [status]) VALUES (N'D2', N'SC002', N'R1', N'D', 2, 1)
INSERT [dbo].[seat] ([id_seat], [id_seatcategory], [id_cinemaroom], [row], [column], [status]) VALUES (N'D3', N'SC002', N'R1', N'D', 3, 1)
INSERT [dbo].[seat] ([id_seat], [id_seatcategory], [id_cinemaroom], [row], [column], [status]) VALUES (N'D4', N'SC002', N'R1', N'D', 4, 1)
INSERT [dbo].[seat] ([id_seat], [id_seatcategory], [id_cinemaroom], [row], [column], [status]) VALUES (N'D5', N'SC002', N'R1', N'D', 5, 1)
INSERT [dbo].[seat] ([id_seat], [id_seatcategory], [id_cinemaroom], [row], [column], [status]) VALUES (N'D6', N'SC002', N'R1', N'D', 6, 1)
INSERT [dbo].[seat] ([id_seat], [id_seatcategory], [id_cinemaroom], [row], [column], [status]) VALUES (N'D7', N'SC002', N'R1', N'D', 7, 1)
INSERT [dbo].[seat] ([id_seat], [id_seatcategory], [id_cinemaroom], [row], [column], [status]) VALUES (N'D8', N'SC002', N'R1', N'D', 8, 1)
INSERT [dbo].[seat] ([id_seat], [id_seatcategory], [id_cinemaroom], [row], [column], [status]) VALUES (N'D9', N'SC002', N'R1', N'D', 9, 1)
INSERT [dbo].[seat] ([id_seat], [id_seatcategory], [id_cinemaroom], [row], [column], [status]) VALUES (N'E0', N'SC002', N'R1', N'E', 0, 1)
INSERT [dbo].[seat] ([id_seat], [id_seatcategory], [id_cinemaroom], [row], [column], [status]) VALUES (N'E1', N'SC002', N'R1', N'E', 1, 1)
INSERT [dbo].[seat] ([id_seat], [id_seatcategory], [id_cinemaroom], [row], [column], [status]) VALUES (N'E2', N'SC002', N'R1', N'E', 2, 1)
INSERT [dbo].[seat] ([id_seat], [id_seatcategory], [id_cinemaroom], [row], [column], [status]) VALUES (N'E3', N'SC002', N'R1', N'E', 3, 1)
INSERT [dbo].[seat] ([id_seat], [id_seatcategory], [id_cinemaroom], [row], [column], [status]) VALUES (N'E4', N'SC002', N'R1', N'E', 4, 1)
INSERT [dbo].[seat] ([id_seat], [id_seatcategory], [id_cinemaroom], [row], [column], [status]) VALUES (N'E5', N'SC002', N'R1', N'E', 5, 1)
INSERT [dbo].[seat] ([id_seat], [id_seatcategory], [id_cinemaroom], [row], [column], [status]) VALUES (N'E6', N'SC002', N'R1', N'E', 6, 1)
INSERT [dbo].[seat] ([id_seat], [id_seatcategory], [id_cinemaroom], [row], [column], [status]) VALUES (N'E7', N'SC002', N'R1', N'E', 7, 1)
INSERT [dbo].[seat] ([id_seat], [id_seatcategory], [id_cinemaroom], [row], [column], [status]) VALUES (N'E8', N'SC002', N'R1', N'E', 8, 1)
INSERT [dbo].[seat] ([id_seat], [id_seatcategory], [id_cinemaroom], [row], [column], [status]) VALUES (N'E9', N'SC002', N'R1', N'E', 9, 1)
INSERT [dbo].[seat] ([id_seat], [id_seatcategory], [id_cinemaroom], [row], [column], [status]) VALUES (N'F0', N'SC002', N'R1', N'F', 0, 1)
INSERT [dbo].[seat] ([id_seat], [id_seatcategory], [id_cinemaroom], [row], [column], [status]) VALUES (N'F1', N'SC002', N'R1', N'F', 1, 1)
INSERT [dbo].[seat] ([id_seat], [id_seatcategory], [id_cinemaroom], [row], [column], [status]) VALUES (N'F2', N'SC002', N'R1', N'F', 2, 1)
INSERT [dbo].[seat] ([id_seat], [id_seatcategory], [id_cinemaroom], [row], [column], [status]) VALUES (N'F3', N'SC002', N'R1', N'F', 3, 1)
INSERT [dbo].[seat] ([id_seat], [id_seatcategory], [id_cinemaroom], [row], [column], [status]) VALUES (N'F4', N'SC002', N'R1', N'F', 4, 1)
INSERT [dbo].[seat] ([id_seat], [id_seatcategory], [id_cinemaroom], [row], [column], [status]) VALUES (N'F5', N'SC002', N'R1', N'F', 5, 1)
INSERT [dbo].[seat] ([id_seat], [id_seatcategory], [id_cinemaroom], [row], [column], [status]) VALUES (N'F6', N'SC002', N'R1', N'F', 6, 1)
INSERT [dbo].[seat] ([id_seat], [id_seatcategory], [id_cinemaroom], [row], [column], [status]) VALUES (N'F7', N'SC002', N'R1', N'F', 7, 1)
INSERT [dbo].[seat] ([id_seat], [id_seatcategory], [id_cinemaroom], [row], [column], [status]) VALUES (N'F8', N'SC002', N'R1', N'F', 8, 1)
INSERT [dbo].[seat] ([id_seat], [id_seatcategory], [id_cinemaroom], [row], [column], [status]) VALUES (N'F9', N'SC002', N'R1', N'F', 9, 1)
INSERT [dbo].[seat] ([id_seat], [id_seatcategory], [id_cinemaroom], [row], [column], [status]) VALUES (N'G0', N'SC003', N'R1', N'G', 0, 1)
INSERT [dbo].[seat] ([id_seat], [id_seatcategory], [id_cinemaroom], [row], [column], [status]) VALUES (N'G1', N'SC003', N'R1', N'G', 1, 1)
INSERT [dbo].[seat] ([id_seat], [id_seatcategory], [id_cinemaroom], [row], [column], [status]) VALUES (N'G2', N'SC003', N'R1', N'G', 2, 1)
INSERT [dbo].[seat] ([id_seat], [id_seatcategory], [id_cinemaroom], [row], [column], [status]) VALUES (N'G3', N'SC003', N'R1', N'G', 3, 1)
INSERT [dbo].[seat] ([id_seat], [id_seatcategory], [id_cinemaroom], [row], [column], [status]) VALUES (N'G4', N'SC003', N'R1', N'G', 4, 1)
INSERT [dbo].[seat] ([id_seat], [id_seatcategory], [id_cinemaroom], [row], [column], [status]) VALUES (N'G5', N'SC003', N'R1', N'G', 5, 1)
INSERT [dbo].[seat] ([id_seat], [id_seatcategory], [id_cinemaroom], [row], [column], [status]) VALUES (N'G6', N'SC003', N'R1', N'G', 6, 1)
INSERT [dbo].[seat] ([id_seat], [id_seatcategory], [id_cinemaroom], [row], [column], [status]) VALUES (N'G7', N'SC003', N'R1', N'G', 7, 1)
INSERT [dbo].[seat] ([id_seat], [id_seatcategory], [id_cinemaroom], [row], [column], [status]) VALUES (N'G8', N'SC003', N'R1', N'G', 8, 1)
INSERT [dbo].[seat] ([id_seat], [id_seatcategory], [id_cinemaroom], [row], [column], [status]) VALUES (N'G9', N'SC003', N'R1', N'G', 9, 1)
INSERT [dbo].[seat] ([id_seat], [id_seatcategory], [id_cinemaroom], [row], [column], [status]) VALUES (N'H0', N'SC003', N'R1', N'H', 0, 1)
INSERT [dbo].[seat] ([id_seat], [id_seatcategory], [id_cinemaroom], [row], [column], [status]) VALUES (N'H1', N'SC003', N'R1', N'H', 1, 1)
INSERT [dbo].[seat] ([id_seat], [id_seatcategory], [id_cinemaroom], [row], [column], [status]) VALUES (N'H2', N'SC003', N'R1', N'H', 2, 1)
INSERT [dbo].[seat] ([id_seat], [id_seatcategory], [id_cinemaroom], [row], [column], [status]) VALUES (N'H3', N'SC003', N'R1', N'H', 3, 1)
INSERT [dbo].[seat] ([id_seat], [id_seatcategory], [id_cinemaroom], [row], [column], [status]) VALUES (N'H4', N'SC003', N'R1', N'H', 4, 1)
INSERT [dbo].[seat] ([id_seat], [id_seatcategory], [id_cinemaroom], [row], [column], [status]) VALUES (N'H5', N'SC003', N'R1', N'H', 5, 1)
INSERT [dbo].[seat] ([id_seat], [id_seatcategory], [id_cinemaroom], [row], [column], [status]) VALUES (N'H6', N'SC003', N'R1', N'H', 6, 1)
INSERT [dbo].[seat] ([id_seat], [id_seatcategory], [id_cinemaroom], [row], [column], [status]) VALUES (N'H7', N'SC003', N'R1', N'H', 7, 1)
INSERT [dbo].[seat] ([id_seat], [id_seatcategory], [id_cinemaroom], [row], [column], [status]) VALUES (N'H8', N'SC003', N'R1', N'H', 8, 1)
INSERT [dbo].[seat] ([id_seat], [id_seatcategory], [id_cinemaroom], [row], [column], [status]) VALUES (N'H9', N'SC003', N'R1', N'H', 9, 1)
GO
INSERT [dbo].[seatcategory] ([id_seatcategory], [categoryname], [status], [price]) VALUES (N'SC001', N'VIP', 1, 100000)
INSERT [dbo].[seatcategory] ([id_seatcategory], [categoryname], [status], [price]) VALUES (N'SC002', N'Regular', 1, 45000)
INSERT [dbo].[seatcategory] ([id_seatcategory], [categoryname], [status], [price]) VALUES (N'SC003', N'Economy', 1, 80000)
GO
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720151684655', N'MS0013', N'D4', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720151685131', N'MS0013', N'D5', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720252795785', N'MSS005', N'G4', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720252796219', N'MSS005', N'G5', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720252891596', N'MS0013', N'E4', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720252891732', N'MS0013', N'E5', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720254855793', NULL, N'G4', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720254931168', NULL, N'E3', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720255069811', NULL, N'E3', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720262805407', N'MS0013', N'F4', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720262829960', N'MS0013', N'F4', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720276952023', N'MSS001', N'F5', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720276952180', N'MSS001', N'E5', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720325760462', N'MSS003', N'C4', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720325761043', N'MSS003', N'C5', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720332298949', N'MSS004', N'D4', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720332299103', N'MSS004', N'D5', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720332530241', N'MSS004', N'G4', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720332530900', N'MSS004', N'G5', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720333440571', N'MSS003', N'D5', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720333440628', N'MSS003', N'D4', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720334961525', N'MSS004', N'E4', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720334961692', N'MSS004', N'E5', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720338611368', N'MSS008', N'G5', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720338611911', N'MSS008', N'E5', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720338611987', N'MSS008', N'C5', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720604606309', N'MS0013', N'E5', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720604606321', N'MS0013', N'E4', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720608682431', N'MS0013', N'E4', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720608682776', N'MS0013', N'E5', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720608863793', N'MSS006', N'E4', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720608864280', N'MSS006', N'E5', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720612217903', N'MSS009', N'E4', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720612218613', N'MSS009', N'E5', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720657914783', N'MS0013', N'G1', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720657914787', N'MS0013', N'G2', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720657914855', N'MS0013', N'G3', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720657914912', N'MS0013', N'G7', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720657915096', N'MS0013', N'G8', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720657915337', N'MS0013', N'G5', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720657915379', N'MS0013', N'G0', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720657915524', N'MS0013', N'G6', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720657915667', N'MS0013', N'G4', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720657945243', N'MS0013', N'G1', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720657945296', N'MS0013', N'G2', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720657945474', N'MS0013', N'G0', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720657945670', N'MS0013', N'G3', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720657945688', N'MS0013', N'G7', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720657945791', N'MS0013', N'G5', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720657946001', N'MS0013', N'G6', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720657946049', N'MS0013', N'G4', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720657946340', N'MS0013', N'G8', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720657973464', N'MS0013', N'G5', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720657973564', N'MS0013', N'G8', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720657973580', N'MS0013', N'G0', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720657973741', N'MS0013', N'G1', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720657974116', N'MS0013', N'G2', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720657974184', N'MS0013', N'G3', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720657974194', N'MS0013', N'G6', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720657974350', N'MS0013', N'G4', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720657974472', N'MS0013', N'G7', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720658113244', N'MS0013', N'G0', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720658113256', N'MS0013', N'G7', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720658113351', N'MS0013', N'G8', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720658113432', N'MS0013', N'G5', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720658113674', N'MS0013', N'G2', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720658113718', N'MS0013', N'G1', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720658113753', N'MS0013', N'G4', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720658114018', N'MS0013', N'G6', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720658114054', N'MS0013', N'G3', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720658143289', N'MS0013', N'G0', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720658143291', N'MS0013', N'G6', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720658143338', N'MS0013', N'G3', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720658143398', N'MS0013', N'G8', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720658143467', N'MS0013', N'G1', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720658143634', N'MS0013', N'G2', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720658143788', N'MS0013', N'G7', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720658143833', N'MS0013', N'G5', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720658144088', N'MS0013', N'G4', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720658156263', N'MS0013', N'G2', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720658156291', N'MS0013', N'G4', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720658156332', N'MS0013', N'G0', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720658156482', N'MS0013', N'G1', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720658156661', N'MS0013', N'G6', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720658156859', N'MS0013', N'G7', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720658156993', N'MS0013', N'G5', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720658157058', N'MS0013', N'G3', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720658157174', N'MS0013', N'G8', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720695460513', N'MSS001', N'F4', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720695460566', N'MSS001', N'E4', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720695585248', N'MSS001', N'E4', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720695585525', N'MSS001', N'F4', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720700230894', N'MS0013', N'F5', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720706370824', N'MSS011', N'B3', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720706370998', N'MSS011', N'E3', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720706371385', N'MSS011', N'H3', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720707899315', N'MSS001', N'E3', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'1720707899429', N'MSS001', N'F3', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'T001', N'MSS001', N'S001', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'T002', N'MSS002', N'S002', 1)
GO
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'T003', N'MSS003', N'S003', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'T004', N'MSS004', N'S004', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'T005', N'MSS005', N'S005', 1)
INSERT [dbo].[ticket] ([id_ticket], [id_moviescreeningsession], [id_seat], [status]) VALUES (N'T006', N'MSS006', N'S006', 1)
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__account__622BF0C2952E3CCF]    Script Date: 13/08/2024 11:48:28 ******/
ALTER TABLE [dbo].[account] ADD UNIQUE NONCLUSTERED 
(
	[phonenumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__account__AB6E616461BE78C9]    Script Date: 13/08/2024 11:48:28 ******/
ALTER TABLE [dbo].[account] ADD UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__account__CE805C73F20B32A8]    Script Date: 13/08/2024 11:48:28 ******/
ALTER TABLE [dbo].[account] ADD UNIQUE NONCLUSTERED 
(
	[accountname] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__cinema__751C8E5478DA6E4D]    Script Date: 13/08/2024 11:48:28 ******/
ALTER TABLE [dbo].[cinema] ADD UNIQUE NONCLUSTERED 
(
	[address] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__moviecat__1A0D12CEC7D4B2C9]    Script Date: 13/08/2024 11:48:28 ******/
ALTER TABLE [dbo].[moviecategory] ADD UNIQUE NONCLUSTERED 
(
	[categoryname] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__seatcate__1A0D12CE2D983D9E]    Script Date: 13/08/2024 11:48:28 ******/
ALTER TABLE [dbo].[seatcategory] ADD UNIQUE NONCLUSTERED 
(
	[categoryname] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[accesspermission]  WITH CHECK ADD FOREIGN KEY([id_account])
REFERENCES [dbo].[account] ([id_account])
GO
ALTER TABLE [dbo].[accesspermission]  WITH CHECK ADD FOREIGN KEY([id_role])
REFERENCES [dbo].[role] ([id_role])
GO
ALTER TABLE [dbo].[bill]  WITH CHECK ADD FOREIGN KEY([id_account])
REFERENCES [dbo].[account] ([id_account])
GO
ALTER TABLE [dbo].[bill]  WITH CHECK ADD  CONSTRAINT [FK_idticket] FOREIGN KEY([id_ticket])
REFERENCES [dbo].[ticket] ([id_ticket])
GO
ALTER TABLE [dbo].[bill] CHECK CONSTRAINT [FK_idticket]
GO
ALTER TABLE [dbo].[cinemaroom]  WITH CHECK ADD FOREIGN KEY([id_cinema])
REFERENCES [dbo].[cinema] ([id_cinema])
GO
ALTER TABLE [dbo].[cinemaroom]  WITH CHECK ADD FOREIGN KEY([id_roomcategory])
REFERENCES [dbo].[roomcategory] ([id_roomcategory])
GO
ALTER TABLE [dbo].[comment]  WITH CHECK ADD FOREIGN KEY([id_account])
REFERENCES [dbo].[account] ([id_account])
GO
ALTER TABLE [dbo].[comment]  WITH CHECK ADD FOREIGN KEY([id_movie])
REFERENCES [dbo].[movie] ([id_movie])
GO
ALTER TABLE [dbo].[movie_moviecategory]  WITH CHECK ADD FOREIGN KEY([id_category])
REFERENCES [dbo].[moviecategory] ([id_category])
GO
ALTER TABLE [dbo].[movie_moviecategory]  WITH CHECK ADD FOREIGN KEY([id_movie])
REFERENCES [dbo].[movie] ([id_movie])
GO
ALTER TABLE [dbo].[moviescreeningsession]  WITH CHECK ADD FOREIGN KEY([id_cinemaroom])
REFERENCES [dbo].[cinemaroom] ([id_cinemaroom])
GO
ALTER TABLE [dbo].[moviescreeningsession]  WITH CHECK ADD FOREIGN KEY([id_movie])
REFERENCES [dbo].[movie] ([id_movie])
GO
ALTER TABLE [dbo].[seat]  WITH CHECK ADD FOREIGN KEY([id_cinemaroom])
REFERENCES [dbo].[cinemaroom] ([id_cinemaroom])
GO
ALTER TABLE [dbo].[seat]  WITH CHECK ADD FOREIGN KEY([id_seatcategory])
REFERENCES [dbo].[seatcategory] ([id_seatcategory])
GO
ALTER TABLE [dbo].[ticket]  WITH CHECK ADD FOREIGN KEY([id_moviescreeningsession])
REFERENCES [dbo].[moviescreeningsession] ([id_moviescreeningsession])
GO
ALTER TABLE [dbo].[comment]  WITH CHECK ADD CHECK  (([rating]>=(1) AND [rating]<=(5)))
GO
