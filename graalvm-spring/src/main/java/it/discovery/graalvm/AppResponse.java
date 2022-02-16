package it.discovery.graalvm;

public class AppResponse {
    private String text;

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public AppResponse(String text) {
        this.text = text;
    }

    public AppResponse() {
    }
}
