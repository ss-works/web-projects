<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="s" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
    <head>
        <title>CMC | ${user.firstName} ${user.lastName}</title>


        <link rel="stylesheet" type="text/css"
              href="${pageContext.request.contextPath}/resources/css/redmond/jquery-ui-1.8.23.custom.css" />
        <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/images/favicon.ico"/>
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/styles.css" />


        <script type="text/javascript" language="javascript" src="${pageContext.request.contextPath}/resources/js/drop.js"></script>
        <script type="text/javascript" language="javascript" src="${pageContext.request.contextPath}/resources/js/jquery.js"></script>
        <script type="text/javascript" language="javascript" src="${pageContext.request.contextPath}/resources/js/popup-tips.js"></script>
        <script type="text/javascript" language="javascript" src="${pageContext.request.contextPath}/resources/js/jquery.tipsy.js"></script>
        <script
        type="text/javascript" language="javascript" src="${pageContext.request.contextPath}/resources/js/jquery-ui-1.8.22.custom.min.js"></script>
        <script type="text/javascript" language="javascript" src="${pageContext.request.contextPath}/resources/js/app.js"></script>

    </head>
    <body>

        <input type="hidden" id="fbProfileViewHidden" value="${pageContext.request.contextPath}" />

        <div id="body">
            <div class="logo" style="position: relative;top: 5px; left: 15px;">
                <a href="${pageContext.request.contextPath}/avtar"><img src="${pageContext.request.contextPath}/resources/images/CMC_LOGO.jpg" alt="" style="border-color:#312e25 ;zIndex:600" /></a>
            </div>

            <div class="menu_nav">
                <ul>
                    <li class="active"><a href="${pageContext.request.contextPath}/avtar">Home</a></li>
                    <li><a href="${pageContext.request.contextPath}/sign-in/out">Sign Out</a></li>
                </ul>
                <div class="clr"></div>
            </div>

            <div class="wrapper">
                <div id="body1" class="col"> 
                    <!--Begin Prediction Module-->
                    <div class="heading-review">
                        <div class="prdktr"> <img src="https://graph.facebook.com/<c:out value="${fbUser.id}"/>/picture" width="60" height="60" alt="Geoff Rego" title="Geoff Rego" /><span style="margin: 5px;border: 5px; "></span>
                        </div>
                        <form id="prdkt-compose-form" style="float:left; margin:15px 0 0 5px;">
                            <label class="title" style="width:371px;"><span id="firstNameText">${fbUser.firstName}</span>&nbsp;<span id="lastNameText" >${fbUser.lastName}</span></label>

                            <input type="hidden" value="${student.enrollmentNumber}" id="userId" />

                        </form>
                        <div class="name">
                            <s:message code="lbl.avatar.dateOfBirth"/><div id="dateOfBirthText" style="position: absolute;left: 180px;top: 71px;"><fmt:formatDate  dateStyle="default"  pattern="dd-MM-yyyy" value="${student.dateOfBirth}"/></div>
                            <div style="position: relative;float: right;">
                                <s:message code="lbl.avatar.gender"/><div id="genderText"style="position: absolute;top: 0px;left: 60px;">${fbUser.gender}</div>
                            </div>
                        </div>
                        <div class="m600-v-head"></div>
                    </div>
                    <!--Begin View Header-->
                    <div class="container">
                        <ul class="options tabs2">
                            <li id="listOne" class="active"><a href="#tab1">Update Status</a></li>


                        </ul>

                        <div class="tab_container2">

                            <sf:form modelAttribute="faceBookStatusForm" action="${pageContext.request.contextPath}/social/updteStatus" id="fbForm">
                                <div id="tab1" class="tab_content2">
                                    <div class="st-blocked2">
                                        <div class="st-blocked" style="z-index: 810;">
                                            <sf:textarea class="tags" cols="5" rows="6" id="updateFbStatusText" path="statusMessage"></sf:textarea>
                                        </div>
                                        <div class="st-blocked">
                                            <label for="tags"><br/></label>
                                            <a class="button-h" href="#" id="submitForUpdateFbStatus"><span>Post</span></a>
                                            <a class="button-h" href="${pageContext.request.contextPath}/avtar" id="cancelForUpdateFbStatus"><span>Cancel</span></a>
                                        </div>
                                        <div id="ajax_loading_fbStatus">
                                            <img  src="${pageContext.request.contextPath}/resources/images/spinner.gif"><span><s:message code="lbl.txt.Processing"/></span></img>
                                        </div>

                                        <div id="postStatusResponseDiv">
                                            <span class="postStatusResponseDiv"> Message Posted Successfully </span>
                                        </div>
                                        <div id="redirectPostStatusDiv">
                                            <span class="postStatusResponseDiv">Wait Until It Redirect...</span>
                                        </div>
                                    </div>
                                </div>

                            </sf:form>      
                        </div>
                    </div>

                    <!--End Pridikt Module-->

                    <!--Begin Pridikt Module-->
                    <div>
                        <div class="clear"></div>
                        <br /><br /><br /><br /><br /><br /><br />
                    </div>
                    <!--End Pridikt Module--> 


                </div>
                <div id="body2" class="col">

                    <div class="right-nav">
                        <ul>
                            <li class="current"><a href="${pageContext.request.contextPath}/avtar/update-profile">My Profile</a></li>
                        </ul>
                    </div>
                    <br />
                </div>

            </div>
            <div class="clear"></div>



        </div>
        <div id="footer">
            <div class="wrapper">
                <div id="footer1" class="col"> <span class="linkgroup">About Us</span>
                    <ul>
                        <li><a href="http://www.cmcltd.com/">Our Company</a></li>
                        <li><a href="team.html">Our Team</a></li>
                    </ul>
                </div>
                <div id="footer2" class="col"> <span class="linkgroup">Support</span>
                    <ul>
                        <li><a href="help.html">Help Center</a></li>
                    </ul>
                </div>
                <div id="footer3" class="col"> <span class="linkgroup">Follow Us</span>
                    <ul>
                        <li><a href="pridikt-on-twitter.html">Twitter</a></li>
                        <li><a href="pridikt-on-facebook.html">Facebook</a></li>
                    </ul>
                </div>
            </div>
        </div>

    </body>
</html>