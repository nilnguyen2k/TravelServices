package example.payload.response;

public class ForgotPasswordResponse {
	
	private String resetPasswordToken;

	public ForgotPasswordResponse(String resetPasswordToken) {
		this.resetPasswordToken = resetPasswordToken;
	}

	public String getResetPasswordToken() {
		return resetPasswordToken;
	}

	public void setResetPasswordToken(String resetPasswordToken) {
		this.resetPasswordToken = resetPasswordToken;
	}
	
}
