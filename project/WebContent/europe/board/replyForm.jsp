<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>��� ���:D</title>
<style type="text/css">
	table{
		margin:3%;
		margin-left:auto;
		margin-right:auto;
		width:100%;
		height: 50;
	}
	table th{
		text-align: center;
		border-radius:25px;
		border:2px solid white;
	}
	h4{
		margin-top:5%;
		text-align: center;
	}
</style>
</head>
<body>
<h4>Write Reply</h4>
<form action="reply.do?bsection=${param.bsection}&bnum=${param.bnum}&id=${login}" method="post">
    <table>
        <tr style="background-color: #f9cdad;">
            <th colspan="2">�ۼ���&nbsp;&nbsp;${login}</th>
        </tr>
        <tr>
            <th>�� ��</th>
            <td>
                <textarea name="comment" rows="5" style="width:100%"></textarea>            
            </td>        
        </tr>
 
        <tr align="center" valign="middle">
            <td colspan="5">
                <input type="reset" value="���" onclick="javascript:history.go(-1)">
                <input type="submit" value="���" >            
            </td>
        </tr>
    </table>    
    </form>
    
</body>
</html>