@page 
{		
	size: 21.0cm 29.7cm;  
	margin-top:3.9cm;	
	margin-bottom:2.5cm;
	margin-left:3.1cm;
	margin-right:1.7cm;
	
	@bottom-left 
	{
		content: element(footer) !important;	
	}
	
	@top-right
	{
		content: element(header) !important;
	}
				
}

		
div.header
{
	display: block;			
	position: running(header) !important;
	padding-top:40px;
	padding-right:20px;		
}

div.footer 
{
	display: block;			
	position: running(footer) !important;	
	font-size:7pt;
	padding-top:8px;
	padding-left:18px;
	height:100px;
}		

body
{
	font-family: 'Helvetica Neue Roman' , Arial, Helvetica, sans-serif !important;
	font-size:10pt;
}
	
.top_line
{
	padding-top:1.0cm;
}

.address_ddp
{
	font-size:7pt;	
}

.address
{
	width: 7cm;
}

.content
{
	padding-top:0.2cm;
	padding-left:10px;	
}

.date
{
	margin-top:0.7cm;
}

.contact
{
	margin-top:1.2cm;
}

.subject
{
	margin-top:2.6cm;
	font-size:10pt;
	font-weight: bold;
}

.quoteText
{
	margin-top:0.5cm;
	margin-bottom:0.4cm;
}

.table
{
	min-height: 7cm;
}

.sum
{
	padding:0 5px 2px 0!important;
	maring:0 !important;
	line-height: 14pt;
}

.nullRow
{
	height: 15px;
}

.table thead 
{
	display: table-header-group;
}

.pageBreak
{
	page-break-inside:avoid;	
}

.Leistung
{
	text-align: left;
	padding-left:5px;
}

.users td
{
	padding-right: 4.7cm;
}

.ComplimentaryClose
{
	margin-top: 0.3cm;
}

.fooText
{
	line-height: 14pt;
}
