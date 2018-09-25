package cn.soft.job.common.pojo.po;

public class FileDownMode implements java.io.Serializable {

	private static final long serialVersionUID = 1L;

	private String filePath;

	private String saveName;

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	public String getSaveName() {
		return saveName;
	}

	public void setSaveName(String saveName) {
		this.saveName = saveName;
	}

}
