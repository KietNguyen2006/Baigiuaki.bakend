USE [master]
GO
/****** Object:  Database [HotelDb]    Script Date: 08/04/2025 6:48:39 CH ******/
CREATE DATABASE [HotelDb]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'HotelDb', FILENAME = N'D:\SQL\MSSQL16.SQLEXPRESS\MSSQL\DATA\HotelDb.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'HotelDb_log', FILENAME = N'D:\SQL\MSSQL16.SQLEXPRESS\MSSQL\DATA\HotelDb_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [HotelDb] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [HotelDb].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [HotelDb] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [HotelDb] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [HotelDb] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [HotelDb] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [HotelDb] SET ARITHABORT OFF 
GO
ALTER DATABASE [HotelDb] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [HotelDb] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [HotelDb] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [HotelDb] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [HotelDb] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [HotelDb] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [HotelDb] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [HotelDb] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [HotelDb] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [HotelDb] SET  ENABLE_BROKER 
GO
ALTER DATABASE [HotelDb] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [HotelDb] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [HotelDb] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [HotelDb] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [HotelDb] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [HotelDb] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [HotelDb] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [HotelDb] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [HotelDb] SET  MULTI_USER 
GO
ALTER DATABASE [HotelDb] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [HotelDb] SET DB_CHAINING OFF 
GO
ALTER DATABASE [HotelDb] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [HotelDb] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [HotelDb] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [HotelDb] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [HotelDb] SET QUERY_STORE = ON
GO
ALTER DATABASE [HotelDb] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [HotelDb]
GO
/****** Object:  Table [dbo].[Hotel]    Script Date: 08/04/2025 6:48:39 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Hotel](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Address] [nvarchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RoomType]    Script Date: 08/04/2025 6:48:39 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RoomType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Price] [decimal](18, 2) NOT NULL,
	[HotelId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RoomType]  WITH CHECK ADD FOREIGN KEY([HotelId])
REFERENCES [dbo].[Hotel] ([Id])
ON DELETE CASCADE
GO
/****** Object:  StoredProcedure [dbo].[spAddHotel]    Script Date: 08/04/2025 6:48:39 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 4. STORED PROCEDURE CHO HOTEL
-- a. Thêm khách sạn
CREATE PROCEDURE [dbo].[spAddHotel]
    @Name NVARCHAR(100),
    @Address NVARCHAR(255)
AS
BEGIN
    INSERT INTO Hotel (Name, Address)
    VALUES (@Name, @Address);
    SELECT SCOPE_IDENTITY() as Id; -- Thêm dòng này để trả về Id của hotel vừa tạo
END

GO
/****** Object:  StoredProcedure [dbo].[spAddRoomType]    Script Date: 08/04/2025 6:48:39 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 5. STORED PROCEDURE CHO ROOMTYPE
-- a. Thêm loại phòng
CREATE PROCEDURE [dbo].[spAddRoomType]
    @Name NVARCHAR(100),
    @Price DECIMAL(18,2),
    @HotelId INT
AS
BEGIN
    INSERT INTO RoomType (Name, Price, HotelId)
    VALUES (@Name, @Price, @HotelId);
    SELECT SCOPE_IDENTITY() as Id; -- Thêm dòng này để trả về Id của roomtype vừa tạo
END

GO
/****** Object:  StoredProcedure [dbo].[spDeleteHotel]    Script Date: 08/04/2025 6:48:39 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- e. Xóa khách sạn
CREATE PROCEDURE [dbo].[spDeleteHotel]
    @Id INT
AS
BEGIN
    DELETE FROM Hotel WHERE Id = @Id;
END

GO
/****** Object:  StoredProcedure [dbo].[spDeleteRoomType]    Script Date: 08/04/2025 6:48:39 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- f. Xóa loại phòng
CREATE PROCEDURE [dbo].[spDeleteRoomType]
    @Id INT
AS
BEGIN
    DELETE FROM RoomType WHERE Id = @Id;
END

GO
/****** Object:  StoredProcedure [dbo].[spGetAllHotels]    Script Date: 08/04/2025 6:48:39 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- b. Lấy tất cả khách sạn
CREATE PROCEDURE [dbo].[spGetAllHotels]
AS
BEGIN
    SELECT * FROM Hotel;
END

GO
/****** Object:  StoredProcedure [dbo].[spGetAllRoomTypes]    Script Date: 08/04/2025 6:48:39 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- b. Lấy tất cả loại phòng
CREATE PROCEDURE [dbo].[spGetAllRoomTypes]
AS
BEGIN
    SELECT * FROM RoomType;
END

GO
/****** Object:  StoredProcedure [dbo].[spGetHotelById]    Script Date: 08/04/2025 6:48:39 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- c. Lấy khách sạn theo ID
CREATE PROCEDURE [dbo].[spGetHotelById]
    @Id INT
AS
BEGIN
    SELECT * FROM Hotel WHERE Id = @Id;
END

GO
/****** Object:  StoredProcedure [dbo].[spGetRoomTypeById]    Script Date: 08/04/2025 6:48:39 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- c. Lấy loại phòng theo ID
CREATE PROCEDURE [dbo].[spGetRoomTypeById]
    @Id INT
AS
BEGIN
    SELECT * FROM RoomType WHERE Id = @Id;
END

GO
/****** Object:  StoredProcedure [dbo].[spGetRoomTypesByHotelId]    Script Date: 08/04/2025 6:48:39 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- d. Lấy loại phòng theo HotelId (Thêm stored procedure này)
CREATE PROCEDURE [dbo].[spGetRoomTypesByHotelId]
    @HotelId INT
AS
BEGIN
    SELECT * FROM RoomType WHERE HotelId = @HotelId;
END

GO
/****** Object:  StoredProcedure [dbo].[spUpdateHotel]    Script Date: 08/04/2025 6:48:39 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- d. Cập nhật khách sạn
CREATE PROCEDURE [dbo].[spUpdateHotel]
    @Id INT,
    @Name NVARCHAR(100),
    @Address NVARCHAR(255)
AS
BEGIN
    UPDATE Hotel
    SET Name = @Name,
        Address = @Address
    WHERE Id = @Id;
END

GO
/****** Object:  StoredProcedure [dbo].[spUpdateRoomType]    Script Date: 08/04/2025 6:48:39 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- e. Cập nhật loại phòng
CREATE PROCEDURE [dbo].[spUpdateRoomType]
    @Id INT,
    @Name NVARCHAR(100),
    @Price DECIMAL(18,2),
    @HotelId INT
AS
BEGIN
    UPDATE RoomType
    SET Name = @Name,
        Price = @Price,
        HotelId = @HotelId
    WHERE Id = @Id;
END

GO
USE [master]
GO
ALTER DATABASE [HotelDb] SET  READ_WRITE 
GO
