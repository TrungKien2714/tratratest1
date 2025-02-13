<%--
    Document   : AddAccount
    Created on : Feb 11, 2025, 1:40:27 PM
    Author     : Aus TUF GAMAING
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en" xml:lang="en">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Add Account</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <link href="css/styles.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    </head>
    <body>
    <body class="sb-nav-fixed">
        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark" aria-label="Main Navigation">
            <!-- Navbar Brand-->
            <a class="navbar-brand ps-3" href="adminDashboard.jsp">Welcome, Admin</a>
            <!-- Sidebar Toggle-->
            <button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle" href="#!"><i class="fas fa-bars"></i></button>
            <!-- Navbar Search-->
            <form class="d-none d-md-inline-block form-inline ms-auto me-0 me-md-3 my-2 my-md-0">
                <div class="input-group">
                    <input class="form-control" type="text" placeholder="Search for..." aria-label="Search for..." aria-describedby="btnNavbarSearch" />
                    <button class="btn btn-primary" id="btnNavbarSearch" type="button"><i class="fas fa-search"></i></button>
                </div>
            </form>
            <!-- Navbar-->
            <ul class="navbar-nav ms-auto ms-md-0 me-3 me-lg-4">
                <li class="nav-item dropdown">
                    <button class="btn btn-link nav-link dropdown-toggle" id="navbarDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="fas fa-user fa-fw"></i>
                    </button>                    
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                        <li><a class="dropdown-item" href="#!">Settings</a></li>
                        <li><a class="dropdown-item" href="#!">Activity Log</a></li>
                        <li><hr class="dropdown-divider" /></li>
                        <li><a class="dropdown-item" href="#!">Logout</a></li>
                    </ul>
                </li>
            </ul>
        </nav>
        <div id="layoutSidenav">
            <div id="layoutSidenav_nav">
                <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
                    <div class="sb-sidenav-menu">
                        <div class="nav">
                            <div class="sb-sidenav-menu-heading">Core</div>
                            <a class="nav-link" href="AdminDashboard">
                                <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                                Dashboard
                            </a>
                            <a class="nav-link" href="AccountList">
                                <div class="sb-nav-link-icon"><i class="fas fa-user fa-fw"></i></div>
                                Account List
                            </a>
                            <a class="nav-link" href="AdminDashboard">
                                <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                                Revenue Report
                            </a>
                        </div>
                    </div>
                </nav>
            </div>
            <div id="layoutSidenav_content">
                <main class="container" style="padding-top: 50px; padding-bottom: 50px">
                    <div class="row d-flex justify-content-center align-items-center">
                        <div class="col-12 col-md-8 col-lg-6 col-xl-5">
                            <div class="card bg-dark text-white" style="border-radius: 1rem;">
                                <div class="card-body p-4 text-center">
                                    <div class="mb-md-1 mt-md-4 pb-5">
                                        <form method="POST" action="AddAccount">
                                            <h2 class="fw-bold mb-2 text-uppercase">Add a new Account</h2>
                                            <div class="form-outline form-white mb-4">
                                                <input value="${requestScope.email}" type="email" name="email" id="email" class="form-control form-control-lg" required/>
                                                <label class="form-label" for="email">Email</label>
                                                <p style="color: red"><c:out value="${requestScope.error}"/></p>
                                            </div>

                                            <div class="form-outline form-white mb-4">
                                                <input value="${requestScope.phonenumber}" type="number" name="phonenumber" id="phonenumber" class="form-control form-control-lg" required/>
                                                <label class="form-label" for="phonenumber">Phone Number</label>
                                            </div>
                                            <div class="form-outline form-white mb-4">
                                                <input value="${requestScope.fullname}" type="text" name="fullname" id="fullname" class="form-control form-control-lg" required/>
                                                <label class="form-label" for="fullname">Full Name</label>
                                            </div>
                                            <div class="form-outline form-white mb-4">
                                                <input value="${requestScope.password}" type="password" name="password" id="password" class="form-control form-control-lg" required/>
                                                <label class="form-label" for="password">Password</label>
                                            </div>
                                            <div class="form-outline form-white mb-4">
                                                <select name="role" class="form-select" aria-label="Default select example" required>
                                                    <option value="" ${requestScope.role eq '' ? 'selected' : ''}>Select role</option>
                                                    <option value="Manager" ${requestScope.role eq 'Manager' ? 'selected' : ''}>Manager</option>
                                                    <option value="Seller" ${requestScope.role eq 'Seller' ? 'selected' : ''}>Seller</option>
                                                    <option value="Staff" ${requestScope.role eq 'Staff' ? 'selected' : ''}>Staff</option>
                                                    <option value="Customer" ${requestScope.role eq 'Customer' ? 'selected' : ''}>Customer</option>
                                                </select>
                                            </div>
                                            <button class="btn btn-outline-light btn-lg px-5" type="submit">Add</button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="js/scripts.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
        <script src="js/datatables-simple-demo.js"></script>
    </body>
</html>
