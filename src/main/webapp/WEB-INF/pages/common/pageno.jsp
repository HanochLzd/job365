<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="../common/taglibs.jsp" %>
<nav>
	<ul class="pagination">
		<c:if test="${page.pageNo == 1}" var="syy">
			<li><a title="上一页">上一页</a></li>
		</c:if>
		<c:if test="${!syy}">
			<li><a title="上一页" href="<%=basePath %>sysUser/getSysUsers.do?pageCurrent=${page.pageNo-1 }"><strong>上一页</strong></a></li>
		</c:if>
    <c:choose>
	  <c:when test="${pages < 21}">		
		<c:forEach var="pageNo" begin="1" end="${pages}">
			<li><a href="<%=basePath %>sysUser/getSysUsers.do?pageCurrent=${ pageNo}">	    
					<c:if test="${page.pageNo == pageNo}" var="rsFy">
						<strong>${pageNo}</strong>
					</c:if> 
					<c:if test="${page.pageNo != pageNo}">
                                 ${pageNo}
                    </c:if>
			</a></li>
		</c:forEach>
	  </c:when>
	  <c:otherwise>  
	   <c:forEach var="pageNo" begin="1" end="20">
			<li><a href="<%=basePath %>sysUser/getSysUsers.do?pageCurrent=${ pageNo}">	    
					<c:if test="${page.pageNo == pageNo}" var="rsFy">
						<strong>${pageNo}</strong>
					</c:if> 
					<c:if test="${page.pageNo != pageNo}">
                                 ${pageNo}
                    </c:if>
			</a></li>
		</c:forEach> 

		   <li><a title="尾页">...</a></li>

		<c:if test="${page.pageNo == pages}">
			<li><a title="尾页"><strong>${pages }</strong></a></li>
		</c:if>
		<c:if test="${page.pageNo != pages}">
			<li><a title="尾页" href="<%=basePath%>sysUser/getSysUsers.do?pageCurrent=${pages}">${pages }</a></li>
		</c:if>
	  </c:otherwise>
   </c:choose>
		<c:if test="${page.pageNo == pages}">
			<li><a title="下一页">下一页</a></li>
		</c:if>
		<c:if test="${page.pageNo != pages}">
			<li><a title="下一页" href="<%=basePath%>sysUser/getSysUsers.do?pageCurrent=${page.pageNo+1}"><strong>下一页</strong></a></li>
		</c:if>	
	</ul>
</nav>
        <form action="<%=basePath%>sysUser/getSysUsers.do" method="post">
		    <li>跳转至<input type="number" name="pageCurrent" id="pageCurrent" style="width:3%">页<input type="submit" name="提交" value="跳转"/></li>
		</form>