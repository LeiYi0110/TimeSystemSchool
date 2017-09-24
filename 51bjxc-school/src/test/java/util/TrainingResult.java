package util;

public class TrainingResult {
	
	
	public int getSubjectID() {
		return subjectID;
	}
	public void setSubjectID(int subjectID) {
		this.subjectID = subjectID;
	}
	public float getHours() {
		return hours;
	}
	public void setHours(float hours) {
		this.hours = hours;
	}
	public float getMileages() {
		return mileages;
	}
	public void setMileages(float mileages) {
		this.mileages = mileages;
	}
	public String getResult() {
		return result;
	}
	public void setResult(String result) {
		this.result = result;
	}
	public String getJudge() {
		return judge;
	}
	public void setJudge(String judge) {
		this.judge = judge;
	}
	private int subjectID;
	private float hours;
	private float mileages;
	private String result;
	private String judge;
}
