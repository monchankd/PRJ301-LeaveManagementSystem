<%-- Menu navigation --%>
<a href="dashboard" class="tab-btn">Home</a>
<a href="submitLeaveRequest" class="tab-btn">Submit Leave Request</a>
<a href="leaveHistory" class="tab-btn">Leave History</a>
<c:if test="${user.role == 'admin' || user.role == 'Division Leader' || user.role == 'Team Leader'}">
    <a href="approveLeave" class="nav-btn">Approve</a>
</c:if>
<c:if test="${user.role == 'Division Leader'}">
    <a href="agenda" class="nav-btn">Agenda</a>
</c:if>
<a href="profile" class="nav-btn">Profile</a> 