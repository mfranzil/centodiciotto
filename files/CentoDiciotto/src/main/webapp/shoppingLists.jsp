<%-- 
    Document   : shoppingLists
    Created on : May 19, 2019
    Author     : Stefano Chirico &lt;stefano dot chirico at unitn dot it&gt;
--%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:catch var="ex">
    <!DOCTYPE html>
    <html>
    <head>
        <title>Lab 12: Shopping lists shared with ${user.firstName} ${user.lastName}</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css" crossorigin="anonymous">
        <link rel="stylesheet" href="../css/floating-labels.css">
    </head>
    <body>
    <div class="container-fluid">
        <div class="card border-primary">
            <div class="card-header bg-primary text-white">
                <h5 class="card-title float-left">Shopping Lists</h5>
                <div class="btn-group float-right" role="group">
                    <button type="button" class="btn btn-outline-light bg-light text-primary btn-sm float-right"
                            data-target="<c:url context="${contextPath}" value="/restricted/export2PDF?id=${user.id}" />">
                        <a href="<c:url context="${contextPath}" value="/restricted/export2PDF?id=${user.id}" />"
                           class="far fa-file-pdf fa-2x" aria-hidden="true"></a>
                    </button>
                    <button type="button" class="btn btn-outline-light bg-light text-primary btn-sm float-right"
                            data-toggle="modal" data-target="#editDialog">
                        <span class="fas fa-plus" aria-hidden="true"></span>
                    </button>
                </div>
            </div>
            <div class="card-body">
                The following table lists all the shopping-lists shared with &quot;${user.firstName} ${user.lastName}&quot;.<br>
            </div>

            <!-- Shopping Lists cards -->
            <div id="accordion">
                <c:choose>
                <c:when test="${empty shoppingLists}">
                    <div class="card">
                        <div class="card-body">
                            This collection is empty.
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                <jsp:scriptlet>

                                                        int index = 1;

                </jsp:scriptlet>
                <c:forEach var="shoppingList" items="${shoppingLists}">
                <div class="card">
                    <div class="card-header" id="heading<%=index%>">
                        <h5 class="mb-0">
                            <button class="btn btn-link" data-toggle="collapse" data-target="#collapse${index}"
                                    aria-expanded="true" aria-controls="collapse${index}">
                                    ${shoppingList.name}
                            </button>
                            <div class="float-right"><a
                                    href="<c:url context="${contextPath}" value="/restricted/edit.shopping.list.html?id=${shoppingList.id}" />"
                                    class="fas fa-pen-square"
                                    title="edit &quot;${shoppingList.name}&quot; shopping list" data-toggle="modal"
                                    data-target="#editDialog" data-shopping-list-id="${shoppingList.id}"
                                    data-shopping-list-name="${shoppingList.name}"
                                    data-shopping-list-description="${shoppingList.description}"></a></div>
                        </h5>
                    </div>
                    <div id="collapse${index}" class="collapse<%=(index == 1 ? " show" : "")%>"
                         aria-labelledby="heading<%=(index++)%>" data-parent="#accordion">
                        <div class="card-body">
                                ${shoppingList.description}
                        </div>
                    </div>
                </div>
            </div>
            </c:forEach>
            </c:otherwise>
            </c:choose>
            <div class="card-footer">
                <span class="float-left">Copyright &copy; 2019 - Stefano Chirico</span>
                <c:choose>
                    <c:when test="${sessionScope.user.email eq 'stefano.chirico@unitn.it'}">
                        <a class="float-right" href="users.html">
                            <button type="button" class="btn btn-primary btn-sm">Go to Users List</button>
                        </a>
                    </c:when>
                    <c:otherwise>
                        <a class="float-right" href="logout.handler">
                            <button type="button" class="btn btn-primary btn-sm">Logout</button>
                        </a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
    <!-- Modal -->
    <form action="shopping.lists.handler" method="POST">
        <div class="modal fade" id="editDialog" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h3 class="modal-title" id="titleLabel">Create new Shopping List</h3>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                                aria-hidden="true">&times;</span></button>
                    </div>
                    <div class="modal-body">
                        <input type="hidden" name="idUser" value="${user.id}">
                        <input type="hidden" name="idShoppingList" id="idShoppingList">
                        <div class="form-label-group">
                            <input type="text" name="name" id="name" class="form-control" placeholder="Name" required
                                   autofocus>
                            <label for="name">Name</label>
                        </div>
                        <div class="form-label-group">
                            <input type="text" name="description" id="description" class="form-control"
                                   placeholder="Description" required>
                            <label for="description">Description</label>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button id="editDialogSubmit" type="submit" class="btn btn-primary">Create</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    </div>
                </div>
            </div>
        </div>
    </form>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.1/moment.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    <script type="text/javascript">
        $(function () {
            $("#editDialog").on("show.bs.modal", function (e) {
                var target = $(e.relatedTarget);
                var shoppingListId = target.data("shopping-list-id");
                if (shoppingListId !== undefined) {
                    var shoppingListName = target.data("shopping-list-name");
                    var shoppingListDescription = target.data("shopping-list-description");

                    $("#titleLabel").html("Edit Shopping List (" + shoppingListId + ")");
                    $("#editDialogSubmit").html("Update");
                    $("#idShoppingList").val(shoppingListId);
                    $("#name").val(shoppingListName);
                    $("#description").val(shoppingListDescription);
                } else {
                    $("#titleLabel").html("Create new Shopping List");
                    $("#editDialogSubmit").html("Create");
                    $("#name").val("");
                    $("#description").val("");
                }
            });
        });
    </script>
    </body>
    </html>
</c:catch>
<c:if test="${not empty ex}">
    <jsp:scriptlet>

                response.sendError(500, ((Exception) pageContext.getAttribute("ex")).getMessage());

    </jsp:scriptlet>
</c:if>
