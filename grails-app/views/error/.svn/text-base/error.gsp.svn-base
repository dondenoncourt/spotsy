<html>
  <head>
	  <title>Spotsylvania Web App Error</title>
	  <style type="text/css">
	  		.message {
	  			border: 1px solid black;
	  			padding: 5px;
	  			background-color:#E9E9E9;
	  		}
	  		.stack {
	  			border: 1px solid black;
	  			padding: 5px;	  		
	  			overflow:auto;
	  			height: 300px;
	  		}
	  		.snippet {
	  			padding: 5px;
	  			background-color:white;
	  			border:1px solid black;
	  			margin:3px;
	  			font-family:courier;
	  		}
	  </style>
  </head>
  
  <body>
    <h1>Spotsylvania Web App Error</h1>
    <p>An error condition has occurred in the application. The web master has been emailed with detailed error information.</p>
    <h2>Error Details</h2>
  	<div class="message">
  		<strong>Message:</strong> ${exception.message?.encodeAsHTML()} <br />
  		<strong>Caused by:</strong> ${exception.cause?.message?.encodeAsHTML()} <br />
  		<strong>Class:</strong> ${exception.className} <br />  		  		
  		<strong>At Line:</strong> [${exception.lineNumber}] <br />  		
  		<strong>Code Snippet:</strong><br />   		
  		<div class="snippet">
  			<g:each var="cs" in="${exception.codeSnippet}"> 
  				${cs?.encodeAsHTML()}<br />  			
  			</g:each>  	
  		</div>	  		
  		<strong>Time:</strong> [${new Date()}] <br />  		
  	</div>
  </body>
</html>