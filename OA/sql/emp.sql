USE [db_oa]
GO

/****** Object:  Table [dbo].[employee]    Script Date: 10/26/2016 13:16:33 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[employee](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[account] [nvarchar](50) NULL,
	[password] [nvarchar](50) NULL,
	[name] [nvarchar](50) NULL,
	[age] [int] NULL,
	[sex] [nvarchar](50) NULL,
	[tel] [nvarchar](50) NULL,
	[address] [nvarchar](50) NULL,
	[manager] [bit] NULL,
 CONSTRAINT [PK_employee] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

