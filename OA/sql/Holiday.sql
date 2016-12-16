USE [db_oa]
GO

/****** Object:  Table [dbo].[holiday]    Script Date: 10/26/2016 13:12:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[holiday](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[proposer] [nvarchar](max) NULL,
	[beginTime] [datetime] NULL,
	[endTime] [datetime] NULL,
	[isCheck] [nvarchar](50) NOT NULL,
	[reson] [nvarchar](400) NULL,
	[checker] [nvarchar](50) NULL,
 CONSTRAINT [PK_holiday] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[holiday] ADD  CONSTRAINT [DF_holiday_isCheck]  DEFAULT (N'no') FOR [isCheck]
GO

