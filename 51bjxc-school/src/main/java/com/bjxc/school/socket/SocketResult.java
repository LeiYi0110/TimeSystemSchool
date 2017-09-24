package com.bjxc.school.socket;

public class SocketResult {
	
	private String content;
	private String inscode;

    public SocketResult() {
    }

    public SocketResult(String content, String inscode) {
        this.content = content;
        this.inscode = inscode;
    }

    public String getContent() {
        return content;
    }
    
    public String getInscode() {
        return inscode;
    }
    
    

}
