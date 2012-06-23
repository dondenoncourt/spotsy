<html>
  <head>
        <title><g:layoutTitle default="Grails" /></title>
        <tooltip:resources/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="Content-Language" content="en-us">
        <meta name="keywords" content="Spotsylvania, county, services, tools, features, government, listing">
        <title>Spotsylvania County Online Account Lookup</title>
        <meta name="description" content="Online Account Lookups, allow you to find how much you owe on your account and your account number so that you can pay your bills online.">
        <link rel="stylesheet" type="text/css" href="<g:createLinkTo dir='css' file='spotsy.css'/>"/>
        <g:javascript library="application" />
    </head>
    <body>
    <%-- 
        <table align="center" border="0" cellpadding="0" cellspacing="0" width="96%">
            <tbody>
              <tr>
                    <td colspan="3" class="tablebordercell" width="100%">
                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                            <tbody><tr>
                                    <td rowspan="3" class="tablebordercell" width="50%">
                                        <img src="${createLinkTo(dir:'images',file:'OnlineServ.jpg')}" alt="" height="108" width="554">
                                    </td>
                                    <td class="tablebordercell" width="50%">&nbsp;</td>
                                </tr>
                                <tr>
                                    <td class="tablebordercell" width="50%">
                                        <form id="search" name="search" action="/search/index.cfm" method="post">
                                            <p align="center">
                                                <label class="topsearchlabel" for="ecmsearchtext">Search :</label>
                                                <input name="ecmsearchtext" maxlength="50" class="textbox" size="13" id="ecmsearchtext" type="text">
                                                <input class="button" value="Go" id="searchbtn" name="searchbtn" type="submit">
                                                <input id="ecmstartingfolder" name="ecmstartingfolder" value="\" type="hidden">
                                                <input id="ecmrecursive" name="ecmrecursive" value="1" type="hidden">
                                                <input id="ecmsearchtype" name="ecmsearchtype" value="AND" type="hidden">
                                            </p>
                                        </form>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="tablebordercell" width="50%">&nbsp;</td>
                                </tr>
                            </tbody></table>
                    </td>
                </tr>
                <tr>
                    <td colspan="3" class="tablebordercell" width="100%">
                        <h5 class="topnavigationlinks">&nbsp;<a class="topnavigationlinks" href="http://www.spotsylvania.va.us/index.cfm">Spotsylvania County Home</a> : <a class="topnavigationlinks" href="http://www.spotsylvania.va.us/onlineservices/">Online Services and Tools</a> : <a class="topnavigationlinks" href="https://www.spotsylvania.va.us/onlineservices/accountlookup/index.cfm">Account Lookup</a></h5>
                    </td>
                </tr>
                <tr>
                    <td class="tablebordercell" valign="top" width="20%">
                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                            <tbody><tr>
                                    <td class="tablebordercell" height="40" width="5%"></td>
                                    <td class="tablebordercell" height="40" width="95%"></td>
                                </tr>
                                <tr>
                                    <td class="tablebordercell" height="40" width="5%"></td>
                                    <td class="tablebordercell" height="40" width="95%">
                                        <p class="sidenavigationlinks"><a href="http://www.spotsylvania.va.us/departments/index.cfm?commlist=1" class="sidenavigationlinks">Boards and Commissions</a></p></td>
                                </tr>
                                <tr>
                                    <td class="tablebordercell" height="40" width="5%"></td>
                                    <td class="tablebordercell" height="40" width="95%">
                                        <p class="sidenavigationlinks"><a href="http://www.spotsylvania.va.us/departments/index.cfm?Courtlist=1" class="sidenavigationlinks">Courts</a></p></td>
                                </tr>
                                <tr>
                                    <td class="tablebordercell" height="40" width="5%"></td>
                                    <td class="tablebordercell" height="40" width="95%">
                                        <p class="sidenavigationlinks"><a href="http://www.spotsylvania.va.us/departments/index.cfm?deptlist=1" class="sidenavigationlinks">Department Listing</a></p></td>
                                </tr>
                                <tr>
                                    <td class="tablebordercell" height="40" width="5%"></td>
                                    <td class="tablebordercell" height="40" width="95%">
                                        <p class="sidenavigationlinks"><a href="http://www.spotsylvania.va.us/countycode/index.cfm" class="sidenavigationlinks">County Code</a></p></td>
                                </tr>
                                <tr>
                                    <td class="tablebordercell" height="40" width="5%"></td>
                                    <td class="tablebordercell" height="40" width="95%">
                                        <p class="sidenavigationlinks"><a class="sidenavigationlinks" href="http://www.spotsylvania.va.us/newcitizeninfo/index.cfm">New Citizen Information</a></p></td>
                                </tr>
                            </tbody></table>
                    </td>
                    <td valign="top" width="1%">
                        <b><img src="${createLinkTo(dir:'images',file:'corner.gif')}" style="vertical-align: text-top;" alt="" border="0" height="50" width="50"></b>
                    </td>
                    <td valign="top" width="79%">

        <g:layoutBody />


        
    </td>
</tr>
<tr>
<td class="tablebordercell" height="79" width="20%">
    <p align="center"><a href="https://www.spotsylvania.va.us/myspotsy/myhome.cfm"><img src="${createLinkTo(dir:'images',file:'myspotsyblue.jpg')}" alt="My Spotsy" border="0" height="37" width="100"></a></p>
</td>
<td height="79" valign="bottom" width="1%">
    <img src="${createLinkTo(dir:'images',file:'Bcorner.gif')}" alt="" style="vertical-align: text-bottom;" height="50" width="50">
</td>
<td height="69" width="79%">

<table border="0" width="100%">
  <tbody><tr>
          <td width="90%">
              <p class="footertext" align="center">
                  <a href="https://www.spotsylvania.va.us/calendar/index.cfm">Calendar</a>
                  |
                  <a href="https://www.spotsylvania.va.us/departments/index.cfm">Departments</a>
                  |
                  <a href="https://www.spotsylvania.va.us/contactus/feedback.cfm">Feedback</a>
                  |
                  <a href="https://www.spotsylvania.va.us/index.cfm">Home</a>
                  |
                  <a href="https://www.spotsylvania.va.us/newsandevents/index.cfm">News and Events</a>
                  <br/>
                  <a href="https://www.spotsylvania.va.us/onlineservices/index.cfm">Online Services</a>
                  |
                  <a href="https://www.spotsylvania.va.us/polls/index.cfm">Polls</a>
                  |
                  <a href="https://www.spotsylvania.va.us/privacypolicy/index.cfm">Privacy Statement</a>
                  |
                  <a href="https://www.spotsylvania.va.us/search/index.cfm">Search</a>
                  |
                  <a href="https://www.spotsylvania.va.us/departments/sitemap.cfm">Site Map</a>
                  <br/>
                  <br/>
                  ©1999-2009 Spotsylvania County Government. All Rights Reserved
              </p>
          </td>
          <td width="10%">
              <p align="right"><a href="http://www.state.va.us/"><img alt="State of Virginia Home Page" src="${createLinkTo(dir:'images',file:'myvirginia100.jpg')}" align="right" border="0" height="37" width="100"></a></p>
          </td>
      </tr>
  </tbody>
</table>
</td>
</tr>
</tbody>
</table>
 --%>
<img src="${createLinkTo(dir:'images',file:'SpotsylvaniaVAHeader.jpg')}" alt="Grails" />
 
        <g:layoutBody />
</body>
</html>