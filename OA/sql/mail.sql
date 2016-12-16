USE [db_oa]
GO

/****** Object:  Table [dbo].[mail]    Script Date: 10/26/2016 13:17:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[mail](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[sender] [nvarchar](50) NULL,
	[addressee] [nvarchar](50) NULL,
	[title] [nvarchar](50) NULL,
	[context] [nvarchar](500) NULL,
	[accessories] [nvarchar](50) NULL,
	[sendTime] [datetime] NULL,
	[isReade] [bit] NULL,
	[isDelete] [bit] NULL,
 CONSTRAINT [PK_mail] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

