package cn.soft.job.common.pojo.po;

public class Base {

	private Integer id;
	private String baseCode;
	private String codeName;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getBaseCode() {
		return baseCode;
	}

	public void setBaseCode(String baseCode) {
		this.baseCode = baseCode;
	}

	public String getCodeName() {
		return codeName;
	}

	public void setCodeName(String codeName) {
		this.codeName = codeName;
	}

	@Override
	public String toString() {
		return "Base [id=" + id + ", baseCode=" + baseCode + ", codeName=" + codeName + "]";
	}

}
