package example.exception;

import java.util.Date;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.context.request.WebRequest;

@RestControllerAdvice
public class ServiceControllerAdvice {
	@ExceptionHandler(value = ServiceException.class)
	@ResponseStatus(HttpStatus.BAD_REQUEST)
	public ErrorMessage handleServiceException(ServiceException ex, WebRequest request) {
		return new ErrorMessage(HttpStatus.BAD_REQUEST.value(), new Date(), ex.getMessage(), request.getDescription(false));
	}
}
