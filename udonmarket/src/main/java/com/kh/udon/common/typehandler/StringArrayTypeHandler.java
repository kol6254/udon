package com.kh.udon.common.typehandler;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.ibatis.type.JdbcType;
import org.apache.ibatis.type.MappedJdbcTypes;
import org.apache.ibatis.type.MappedTypes;
import org.apache.ibatis.type.TypeHandler;

@MappedTypes(String[].class)
@MappedJdbcTypes(JdbcType.VARCHAR)
public class StringArrayTypeHandler 
	implements TypeHandler<String[]>{

	@Override
	public void setParameter(PreparedStatement ps, 
							 int columnIndex, 
							 String[] parameter, 
							 JdbcType jdbcType) throws SQLException {
		if(parameter != null) {
			String value = String.join(",", parameter);
			ps.setString(columnIndex, value);
		}
		else {
			ps.setString(columnIndex, "");
		}
	}

	@Override
	public String[] getResult(ResultSet rs, String columnName) throws SQLException {
		String str = rs.getString(columnName);
		return str != null ? str.split(",") : null;
	}

	@Override
	public String[] getResult(ResultSet rs, int columnIndex) throws SQLException {
		String str = rs.getString(columnIndex);
		return str != null ? str.split(",") : null;
	}

	@Override
	public String[] getResult(CallableStatement cs, int columnIndex) throws SQLException {
		String str = cs.getString(columnIndex);
		return str != null ? str.split(",") : null;
	}

}
