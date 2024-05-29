Potrebno napraviti bazu u SQL Serveru koja se zove YUchat

USE [YUchat]  
  
GO  
  
CREATE TABLE [dbo].[tbl_Users](  
  
[ID] [int] IDENTITY(1,1) NOT NULL,  
[UserName] [varchar](50) NULL,  
[Email] [varchar](50) NULL,  
[Password] [varchar](50) NULL,  
[Photo] [varchar](50) NULL,  
  
CONSTRAINT [PK_tbl_Users] PRIMARY KEY CLUSTERED  
(  
  [ID] ASC  
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]  
  
) ON [PRIMARY]  
  
insert into [dbo].[tbl_Users] (UserName,Email,Password)values('admin','admin@admin.com','12345'); 
