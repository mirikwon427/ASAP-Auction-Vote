<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp"%>

<style>
th, td {
	text-align: center !important; /* 텍스트를 왼쪽 정렬합니다. */
}

label {
	cursor: pointer !important;
}
</style>
<script>
  
$(document).ready(function() {
    
	   $("#divWrite").on("click", function() {
	     	document.bbsForm.nbSeq.value="";
	     	document.bbsForm.action ="/admin/adminNoticeWrite";
	     	document.bbsForm.submit();
	   });
	   
	   $("#btnSearch").on("click",function(){
			document.bbsForm.nbSeq.value="";	
		    document.bbsForm.searchType.value=$("#_searchType").val();
			document.bbsForm.searchValue.value=$("#_searchValue").val();
			document.bbsForm.curPage.value="1";
			document.bbsForm.action="/admin/adminNoticeBoard";
			document.bbsForm.submit();
		});
	});
	//공지사항 상세보기
	function fn_view(nbSeq)		
	{
		document.bbsForm.nbSeq.value= nbSeq;
		document.bbsForm.action="/admin/adminNoticeView";
		document.bbsForm.submit();
	}

	//공지사항 수정
	function fn_update(nbSeq)		
	{
		document.bbsForm.nbSeq.value= nbSeq;
		document.bbsForm.action="/admin/adminNoticeUpdate";
		document.bbsForm.submit();
	}

	//공지사항 삭제
	function fn_delete(value)		
	{
		Swal.fire({
			title: '게시물을 삭제하시겠습니까?',
			icon: 'warning',
			showCancelButton: true,
			confirmButtonColor: '#3085d6',
			cancelButtonColor: '#d33',
			confirmButtonText: '확인',
			cancelButtonText: '취소'
	    }).then((result) => {
			if (result.isConfirmed) {
				$.ajax({
					type:"POST",
					url:"/admin/adminNoticeDelete",
					data:{
						nbSeq:value
					},
					dataType:"JSON",
					beforeSend:function(xhr)
					{
						xhr.setRequestHeader("AJAX", "true");
					},
					success:function(response)
					{
						if(response.code == 0)
						{
							Swal.fire({
								title: '게시물이 삭제되었습니다.', 
								icon: 'success'
							}).then(function(){
								location.href = "/admin/adminNoticeBoard";
							})
						}
						else if(response.code == 404)
						{
							Swal.fire({
								title: '해당 게시물을 찾을 수 없습니다.', 
								icon: 'warning'
							}).then(function(){
								location.href = "/admin/adminNoticeBoard";
							})
						}
						else if(response.code == 403)
						{
							Swal.fire('본인 글이 아니므로 삭제할 수 없습니다.', '', 'warning');
						}
						else if(response.code == 400)
						{
							Swal.fire('파라미터 값이 올바르지 않습니다.', '', 'warning');
						}
						else
						{
							Swal.fire('게시물 삭제 중 오류가 발생하였습니다.', '', 'error');
						}
					},
					error(xhr, status, error)
					{
						icia.common.error(error);
					}
				});
			}
		})
	}

	//공지사항 페이징
	function fn_list(curPage)
	{
		document.bbsForm.nbSeq.value="";	
		document.bbsForm.curPage.value = curPage;
		document.bbsForm.action="/admin/adminNoticeBoard";
		document.bbsForm.submit();
	}
  </script>
</head>



<body>
<body>
	<div class="container-scroller">
		<!-- partial:/partials/_navbar.html -->
		<%@ include file="/WEB-INF/views/include/navigation.jsp"%>
		<!-- partial -->
		<div class="container-fluid page-body-wrapper">
			<!-- partial:/partials/_sidebar.html -->
			<nav class="sidebar sidebar-offcanvas" id="sidebar">
				<ul class="nav">
					<li class="nav-item nav-category" style="margin-bottom: 10px;"></li>
					<li class="nav-item"><a class="nav-link"
						href="/admin/userList"> <span class="icon-bg"><i
								class="mdi mdi-settings menu-icon"></i></span> <span class="menu-title">회원</span>
					</a></li>
					<li class="nav-item"><a class="nav-link"
						href="/admin/voteUpload"> <span class="icon-bg"><i
								class="mdi mdi-settings menu-icon"></i></span> <span class="menu-title">투표</span>
					</a></li>
					<li class="nav-item"><a class="nav-link"
						data-toggle="collapse" href="#ui-basic1" aria-expanded="false"
						aria-controls="ui-basic"> <span class="icon-bg"><i
								class="mdi mdi-settings menu-icon"></i></span> <span class="menu-title">경매</span>
							<i class="menu-arrow"></i>
					</a>
						<div class="collapse" id="ui-basic1">
							<ul class="nav flex-column sub-menu">
								<li class="nav-item"><a class="nav-link"
									href="/admin/adminAuction">경매 업로드</a></li>
								<li class="nav-item"><a class="nav-link"
									href="/admin/adminAucCurList">경매 입찰내역</a></li>
								<li class="nav-item"><a class="nav-link"
									href="/admin/adminAucBuyPriceList">경매 낙찰내역</a></li>
							</ul>
						</div></li>
					<li class="nav-item"><a class="nav-link"
						data-toggle="collapse" href="#ui-basic2" aria-expanded="false"
						aria-controls="ui-basic"> <span class="icon-bg"><i
								class="mdi mdi-settings menu-icon"></i></span> <span class="menu-title">이벤트
								경매</span> <i class="menu-arrow"></i>
					</a>
						<div class="collapse" id="ui-basic2">
							<ul class="nav flex-column sub-menu">
								<li class="nav-item"><a class="nav-link"
									href="/admin/aucEvent">이벤트경매 관리</a></li>
								<li class="nav-item"><a class="nav-link"
									href="/admin/aeCur">이벤트경매 입찰내역</a></li>
							</ul>
						</div></li>

					<li class="nav-item"><a class="nav-link"
						data-toggle="collapse" href="#ui-basic3" aria-expanded="false"
						aria-controls="ui-basic"> <span class="icon-bg"><i
								class="mdi mdi-settings menu-icon"></i></span> <span class="menu-title">상품
								및 결제 관리</span> <i class="menu-arrow"></i>
					</a>
						<div class="collapse" id="ui-basic3">
							<ul class="nav flex-column sub-menu">
								<li class="nav-item"><a class="nav-link"
									href="/admin/product">상품 관리</a></li>
								<li class="nav-item"><a class="nav-link"
									href="/admin/payList">결제 내역</a></li>
							</ul>
						</div></li>
					<li class="nav-item"><a class="nav-link"
						data-toggle="collapse" href="#ui-basic4" aria-expanded="false"
						aria-controls="ui-basic"> <span class="icon-bg"><i
								class="mdi mdi-settings menu-icon"></i></span> <span class="menu-title">게시판</span>
							<i class="menu-arrow"></i>
					</a>
						<div class="collapse" id="ui-basic4">
							<ul class="nav flex-column sub-menu">
								<li class="nav-item"><a class="nav-link"
									href="/admin/adminNoticeBoard">공지사항 게시판</a></li>
								<li class="nav-item"><a class="nav-link"
									href="/admin/adminQnaBoard">문의사항 게시판</a></li>
							</ul>
						</div></li>
					<li class="nav-item sidebar-user-actions" style="margin-top: 30px;">
						<div class="user-details">
							<div class="d-flex justify-content-between align-items-center">
								<div>
									<div class="d-flex align-items-center">
										<div class="sidebar-profile-img" style="margin-top: -10px;">
											<i class="mdi mdi-account-star" style="font-size: 20px;"></i>
										</div>
										<div class="sidebar-profile-text">
											<p class="mb-1" style="color: white;">${gnbAdmId }</p>
										</div>
									</div>
								</div>
							</div>
						</div>
					</li>
					<li class="nav-item sidebar-user-actions">
						<div class="sidebar-user-menu">
							<a href="/user/logOut" class="nav-link"><i
								class="mdi mdi-logout menu-icon"></i> <span class="menu-title">로그아웃</span></a>
						</div>
					</li>
				</ul>
			</nav>

			<!-- partial -->
			<div class="main-panel">
				<div class="content-wrapper">
					<div class="page-header"></div>


					<div class="row">
						<div class="col-lg-12 grid-margin stretch-card">
							<div class="card">
								<div class="card-body">
									<h4 class="card-title">공지사항 게시판 관리</h4>

									<div class="form-group"
										style="display: flex; margin-bottom: 10px;">
										<select id="_searchType" name="_searchType"
											class="form-control bg-transparent border-1"
											style="width: 100px; height: 46px; margin-top: 1px; margin-right: 5px;">
											<option value="">조회 항목</option>
											<option value="1"
												<c:if test = '${searchType eq "1"}'>selected</c:if>>제목</option>
											<option value="2"
												<c:if test = '${searchType eq "2"}'>selected</c:if>>내용</option>
										</select>

										<div class="search-field d-none d-xl-block"
											style="margin-bottom: 10px; flex: 1;">
											<div class="input-group-prepend bg-transparent"
												style="width: 500px !important;">

												<input type="text"
													class="form-control bg-transparent border-1"
													style="font-size: 0.8rem; width: 15rem; height: 3rem; margin-right: 5px;"
													id="_searchValue" name="_searchValue"
													value="${searchValue }">
												<div id="btnSearch"
													class="input-group-prepend bg-transparent">
													<i
														class="input-group-text bg-transparent border-1 mdi mdi-magnify"></i>
												</div>
											</div>
										</div>
										<div style="margin-right: 20px; margin-top: 10px">
											<input type="button" id="divWrite" class="btn btn-primary"
												value="글쓰기">
										</div>
									</div>


									<table class="table table-striped">
										<thead>
											<tr>
												<th>번호</th>
												<th>관리자 아이디</th>
												<th>제목</th>
												<th>등록일</th>
												<th></th>
											</tr>
										</thead>
										<tbody>
											<c:if test="${!empty list}">
												<c:set var="startNum" value="${paging.startNum}" />
												<c:forEach var="noticeBoard" items="${list}"
													varStatus="status">
													<tr>
														<td>${startNum}</td>
														<td>${noticeBoard.admId}</td>
														<td><a href="javascript:void(0)"
															onclick="fn_view(${noticeBoard.nbSeq})"
															style="color: #0062ff;"> <span> <c:out
																		value="${noticeBoard.nbTitle}" />
															</span>
														</a></td>
														<td>${noticeBoard.regDate}</td>
														<td><c:if test="${gnbAdmId eq noticeBoard.admId }">
																<label class="badge badge-warning"
																	onclick="fn_update(${noticeBoard.nbSeq})">수정</label>
															</c:if> &nbsp; <label class="badge badge-danger"
															onclick="fn_delete(${noticeBoard.nbSeq})">삭제</label></td>
													</tr>
													<c:set var="startNum" value="${startNum-1}"></c:set>
												</c:forEach>
											</c:if>
										</tbody>
									</table>


									<!-- 여기부 터 -->

									<div class="mt-3"
										style="display: flex; justify-content: center;">
										<!-- 페이징 샘플 시작 -->
										<c:if test="${!empty paging}">
											<!--  이전 블럭 시작 -->
											<c:if test="${paging.prevBlockPage gt 0}">
												<a href="javascript:void(0)" class="btn btn-primary"
													onclick="fn_list(${paging.prevBlockPage})" title="이전 블럭">&laquo;</a>
											</c:if>
											<div style="width: 4px;"></div>
											<!--  이전 블럭 종료 -->
											<span> <!-- 페이지 시작 --> <c:forEach var="i"
													begin="${paging.startPage}" end="${paging.endPage}">
													<c:choose>
														<c:when test="${i ne curPage}">
															<a href="javascript:void(0)" class="btn btn-primary"
																onclick="fn_list(${i})" style="font-size: 14px;">${i}</a>
														</c:when>
														<c:otherwise>
															<h class="btn btn-primary"
																style="font-size:14px; font-weight:bold;">${i}</h>
														</c:otherwise>
													</c:choose>
												</c:forEach> <!-- 페이지 종료 -->
											</span>
											<div style="width: 4px;"></div>
											<!--  다음 블럭 시작 -->
											<c:if test="${paging.nextBlockPage gt 0}">
												<a href="javascript:void(0)" class="btn btn-primary"
													onclick="fn_list(${paging.nextBlockPage})" title="다음 블럭">&raquo;</a>
											</c:if>
											<!--  다음 블럭 종료 -->
										</c:if>
										<!-- 페이징 샘플 종료 -->
									</div>
									<form name="bbsForm" id="bbsForm" method="post">
										<input type="hidden" name="nbSeq" value="" /> <input
											type="hidden" name="searchType" value="${searchType}" /> <input
											type="hidden" name="searchValue" value="${searchValue}" /> <input
											type="hidden" name="curPage" value="${curPage}" />
									</form>
								</div>
							</div>
						</div>
					</div>
					<!-- content-wrapper ends -->
				</div>
				<!-- main-panel ends -->
			</div>
			<!-- page-body-wrapper ends -->
		</div>
		<!-- container-scroller -->
	</div>
	<!-- plugins:js -->
	<script src="/resources/vendors/js/vendor.bundle.base.js"></script>
	<!-- endinject -->
	<!-- Plugin js for this page -->
	<!-- End plugin js for this page -->
	<!-- inject:js -->
	<script src="/resources/js/off-canvas.js"></script>
	<script src="/resources/js/hoverable-collapse.js"></script>
	<script src="/resources/js/misc.js"></script>
	<!-- endinject -->
	<!-- Custom js for this page -->
	<!-- End custom js for this page -->
</body>