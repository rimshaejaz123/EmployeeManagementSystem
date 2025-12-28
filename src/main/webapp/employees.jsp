<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Employees - EMS</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>

<div class="dashboard-container">
    
    <div class="sidebar">
        <h3><i class="fa-solid fa-clock"></i> Dashboard</h3>
        
        <a href="dashboard-hr" class="menu-item"><i class="fa-solid fa-house"></i> Dashboard</a>
        <a href="employees" class="menu-item active"><i class="fa-solid fa-users"></i> Employees</a>
        <a href="departments" class="menu-item"><i class="fa-solid fa-sitemap"></i> Departments</a>
        <a href="salaries" class="menu-item"><i class="fa-solid fa-money-bill-wave"></i> Salaries</a>
        <a href="notices" class="menu-item"><i class="fa-solid fa-circle-exclamation"></i> Issue Notices</a>
        <a href="leaves" class="menu-item"><i class="fa-solid fa-calendar-xmark"></i> Leaves</a>
        <a href="attendances" class="menu-item"><i class="fa-solid fa-clipboard-user"></i> Attendances</a>
        <a href="recruitment" class="menu-item"><i class="fa-solid fa-user-plus"></i> Recruitment</a>
        <a href="profile" class="menu-item"><i class="fa-solid fa-id-badge"></i> HR Profiles</a>
        
        <form action="auth" method="POST" style="margin-top: auto;">
            <input type="hidden" name="action" value="logout">
            <button type="submit" class="menu-item" style="border:none; background:none; cursor:pointer; width:100%;">
                <i class="fa-solid fa-right-from-bracket"></i> Logout
            </button>
        </form>
    </div>

    <div class="main-content">
        
        <div class="page-header">
            <h1 style="font-size: 28px;">Employee Management System</h1>
            <a href="add_employee.jsp" class="btn-add"><i class="fa-solid fa-plus"></i> Add New Employee</a>
        </div>

        <input type="text" id="searchInput" onkeyup="searchTable()" placeholder="Search employees..." 
               style="padding: 10px; width: 300px; border: 1px solid #ccc; border-radius: 5px; margin-bottom: 10px;">

        <div class="emp-container">
            <div class="emp-header-row">
                <div class="header-cell text-left">Name / Email</div>
                <div class="header-cell">Job Role</div>
                <div class="header-cell">Department</div>
                <div class="header-cell">Joined Date</div>
                <div class="header-cell">Actions</div>
            </div>

            <c:forEach var="emp" items="${empList}">
                <div class="emp-row">
                    <div class="emp-cell text-left">
                        <strong>${emp.name}</strong><br>
                        <span style="font-size:12px; color:#666;">${emp.email}</span>
                    </div>
                    <div class="emp-cell">
                        ${emp.designation}<br>
                        <span style="font-size:12px; color:#888;">${emp.type}</span>
                    </div>
                    <div class="emp-cell">
                        <span style="background:#e3f2fd; color:#1976d2; padding:4px 8px; border-radius:4px; font-size:12px;">${emp.department}</span>
                    </div>
                    <div class="emp-cell" style="font-size:13px;">${emp.joinDate}</div>
                    
                    <div class="emp-cell">
                        <a href="id-card?id=${emp.id}" target="_blank" class="action-btn" style="color:#e65100; border-color:#e65100;" title="Generate ID Card">
                            <i class="fa-solid fa-id-card"></i> ID
                        </a>
                        
                        <a href="#" class="action-btn">View</a>
                        
                        <form action="employees" method="POST" style="display:inline;" onsubmit="return confirm('Are you sure you want to delete this employee?');">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="id" value="${emp.id}">
                            <button type="submit" class="action-btn" style="color:red; border-color:red;">Delete</button>
                        </form>
                    </div>
                </div>
            </c:forEach>
            
            <c:if test="${empty empList}">
                <p style="text-align:center; padding:20px;">No employees found.</p>
            </c:if>
        </div>
    </div>
</div>

<script>
    function searchTable() {
        var input = document.getElementById("searchInput");
        var filter = input.value.toUpperCase();
        var container = document.querySelector(".emp-container");
        var rows = container.getElementsByClassName("emp-row");

        for (var i = 0; i < rows.length; i++) {
            var textContent = rows[i].innerText || rows[i].textContent;
            if (textContent.toUpperCase().indexOf(filter) > -1) {
                rows[i].style.display = "";
            } else {
                rows[i].style.display = "none";
            }
        }
    }
</script>

</body>
</html>