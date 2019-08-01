<%-- 
    Document   : users
    Created on : May 19, 2019
    Author     : Stefano Chirico &lt;stefano dot chirico at unitn dot it&gt;
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:catch var="ex">
    <!DOCTYPE html>
    <html>
    <head>
        <title>Users List</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdn.datatables.net/1.10.18/css/dataTables.bootstrap4.min.css">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css">
        <link rel="stylesheet" href="../css/floating-labels.css">
    </head>
    <body>
    <div class="container-fluid">
        <c:if test="${not empty emailSent}">
            <c:choose>
                <c:when test="${emailSent eq true}">
                    <div class="alert alert-success alert-dismissible" role="alert">
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span
                                aria-hidden="true">&times;</span></button>
                        E-mail <strong>correctly</strong> sent!
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="alert alert-danger alert-dismissible" role="alert">
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span
                                aria-hidden="true">&times;</span></button>
                        <strong>Error!</strong> Failed to send the e-mail: ${emailError}.
                    </div>
                </c:otherwise>
            </c:choose>
        </c:if>
        <div class="card border-primary">
            <div class="card-header bg-primary text-white">
                <h5 class="card-title">Users</h5>
            </div>
            <div class="card-body">
                The following table lists all the users of the application.<br>
                For each user, you can see the count of shopping-lists shared with him.<br>
                Clicking on the envelop icon, you can write and send an email to the &quot;selected&quot; user.<br>
                Clicking on the number of shopping-lists, you can show the collection of shopping-lists shared with the
                &quot;selected&quot; user.<br>
                You can edit your personal information clicking on the pen icon you can see next to your user.
            </div>

            <!-- Table -->
            <div class="table-responsive">
                <table id="usersTable" class="table table-sm table-hover table-striped">
                    <thead>
                    <tr>
                        <th>Email</th>
                        <th>First name</th>
                        <th>Last name</th>
                        <th>Shopping Lists</th>
                        <th></th>
                    </tr>
                    </thead>
                    <tbody>
                    </tbody>
                    <tfoot>
                    <tr>
                        <th>Email</th>
                        <th>First name</th>
                        <th>Last name</th>
                        <th>Shopping Lists</th>
                        <th></th>
                    </tr>
                    </tfoot>
                </table>
            </div>

            <div class="card-footer"><span class="float-left">Copyright &copy; 2019 - Stefano Chirico</span><a
                    href="<c:url context="${contextPath}" value="/restricted/logout.handler" />" class="float-right">
                <button type="button" class="btn btn-primary btn-sm">Logout</button>
            </a></div>
        </div>
    </div>

    <!-- Edit User Dialog -->
    <form action="<c:url context="${contextPath}" value="/restricted/user.handler" />" method="POST"
          enctype="multipart/form-data">
        <div class="modal fade" id="editUserModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title" id="myModalLabel">Configure ${sessionScope.user.email}</h4>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                                aria-hidden="true"><i class="fas fa-window-close red-window-close"></i></span></button>
                    </div>
                    <div class="modal-body">
                        <input type="hidden" name="idUser" value="${sessionScope.user.id}">
                        <div class="form-label-group">
                            <input type="file" name="avatar" id="avatar" placeholder="Avatar"
                                   value="${sessionScope.user.avatarPath}">
                            <label for="avatar">Avatar</label>
                            <img src="${avatarPath}" class="img-thumbnail">
                        </div>
                        <div class="form-label-group">
                            <input type="text" name="lastname" id="lastname" class="form-control"
                                   placeholder="Last name" value="${sessionScope.user.lastName}" required autofocus>
                            <label for="lastname">Last name</label>
                        </div>
                        <div class="form-label-group">
                            <input type="text" name="firstname" id="firstname" class="form-control"
                                   placeholder="First name" value="${sessionScope.user.firstName}" required>
                            <label for="firstname">Name</label>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-primary">Save</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    </div>
                </div>
            </div>
        </div>
    </form>

    <!-- Send Email Dialog -->
    <form action="<c:url context="${contextPath}" value="/restricted/sendMail.handler" />" method="POST">
        <input type="hidden" id="userId" name="userId">
        <div class="modal fade" id="sendMailDialog" tabindex="-1" role="dialog" aria-labelledby="sendMailDialogLabel">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title" id="sendMailDialogLabel">Email to:</h4>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                                aria-hidden="true"><i class="fas fa-window-close red-window-close"></i></span></button>
                    </div>
                    <div class="modal-body">
                        <div class="form-label-group">
                            <input type="text" class="form-control" id="subject" name="subject" placeholder="Subject"
                                   autofocus required>
                            <label for="subject">Subject</label>
                        </div>
                        <label for="message">Message</label>
                        <textarea id="message" name="message" class="form-control" rows="3" required></textarea>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-primary">Send</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    </div>
                </div>
            </div>
        </div>
    </form>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.18/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.18/js/dataTables.bootstrap4.min.js"></script>
    <script>
        $(function () {
            var contextPath = "${contextPath}";
            $("#usersTable").dataTable({
                //"processing": true,
                "serverSide": true,
                "ajax": "services/users",
                "columns": [
                    {
                        "data": "email",
                        "render": function (data, type, row, meta) {
                            return "<a href=\"" + contextPath + "/restricted/sendEmail.html?id=" + row.id + "\" title=\"email user\" data-toggle=\"modal\" data-target=\"#sendMailDialog\" data-user-id=\"" + row.id + "\" data-user-address=\"" + row.email + "\" data-user-lastname=\"" + row.lastName + "\" data-user-firstname=\"" + row.firstName + "\">" + row.email + "</a>";
                        }
                    },
                    {"data": "firstName"},
                    {"data": "lastName"},
                    {
                        "data": "shoppingListsCount",
                        "render": function (data, type, row, meta) {
                            return "<a href=\"" + contextPath + "/restricted/shopping.lists.html?id=" + row.id + "\"><span class=\"badge badge-primary badge-pill\">" + row.shoppingListsCount + "</span></a>";
                        }
                    },
                    {
                        "data": "id",
                        "render": function (data, type, row, meta) {
                            return "<a href=\"" + contextPath + "/restricted/editUser.html?id=" + row.id + "\" title=\"edit user\" data-toggle=\"modal\" data-target=\"#editUserModal\"><i class=\"fas fa-pen-square fa-lg\"></i></a>";
                        }
                    }
                ]
            });

            $('#sendMailDialog').on('show.bs.modal', function (e) {
                var button = $(e.relatedTarget);
                var userId = button.data('user-id');
                if (userId !== undefined) {
                    var userAddress = button.data('user-address');

                    $('#sendMailDialogLabel').html('Email to: ' + userAddress);
                    $('#userId').val(userId);
                }
            });

            $(".alert-dismissible").fadeTo(2000, 500).slideUp(500, function () {
                $(".alert-dismissible").alert('close');
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