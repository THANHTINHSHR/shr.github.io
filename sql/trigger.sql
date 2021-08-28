-- Trigger

USE [WEB_SHR_V1]
GO




CREATE TRIGGER TG_INSERT_REVIEW ON REVIEWS AFTER INSERT 
AS
BEGIN
DECLARE @INPUT_PID INT  = (SELECT PRODUCT_ID FROM INSERTED);
DECLARE @SUM INT = (SELECT SUM(RATING) FROM REVIEWS WHERE PRODUCT_ID = @INPUT_PID);
DECLARE @COUNT INT = (SELECT COUNT(RATING) FROM REVIEWS WHERE PRODUCT_ID = @INPUT_PID);

UPDATE PRODUCTS SET RATING =  CEILING (@SUM/@COUNT) WHERE ID = @INPUT_PID;
END
GO

CREATE TRIGGER TG_INSERT_PRODUCT ON PRODUCTS AFTER INSERT 
AS
BEGIN
DECLARE @INPUT_PID INT  = (SELECT ID FROM INSERTED);


UPDATE PRODUCTS SET RATING = 0 WHERE ID = @INPUT_PID;
END
GO
SELECT SUM(RATING) FROM REVIEWS WHERE PRODUCT_ID = 26
SELECT count(RATING) FROM REVIEWS WHERE PRODUCT_ID = 26
SELECT ROUND (28/6,1) 
SELECT FLOOR(28/CONVERT(decimal(1) ,6))
SELECT CEILING (28/6)
DELETE c FROM CART_ITEMS  c WHERE c.user.id = 2


---
USE [WEB_SHR_V1]
GO

/****** Object:  Table [dbo].[REVIEWS]    Script Date: 20/07/2021 9:17:54 SA ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[REVIEWS](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[USER_ID] [int] NULL,
	[PRODUCT_ID] [int] NULL,
	[REVIEW] [nvarchar](max) NULL,
	[CREATE_TIME] [date] NULL,
	[RATING] [int] NULL,
	[IMAGE] [nvarchar](200) NULL,
	[BUY_TIME] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[REVIEWS]  WITH CHECK ADD FOREIGN KEY([PRODUCT_ID])
REFERENCES [dbo].[PRODUCTS] ([ID])
GO

ALTER TABLE [dbo].[REVIEWS]  WITH CHECK ADD FOREIGN KEY([USER_ID])
REFERENCES [dbo].[USERS] ([ID])
GO

DBCC CHECKIDENT (REVIEWS, RESEED, 0)