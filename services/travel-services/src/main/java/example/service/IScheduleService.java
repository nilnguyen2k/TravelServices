package example.service;

import java.util.List;

import example.elasticsearch.ESMSchedule;
import example.entity.ScheduleEntity;
import example.payload.request.CreateScheduleRequest;
import example.payload.request.ScheduleRequest;
import example.payload.response.ScheduleResponse;

public interface IScheduleService {
	ScheduleResponse createSchedule2(ScheduleRequest request, Long serviceId);
	ScheduleResponse createSchedule1(CreateScheduleRequest request);
	
	ScheduleResponse modifySchedule(ScheduleResponse request);
	ScheduleResponse convertToScheduleResponse(ScheduleEntity entity);
	
	List<ESMSchedule> convertToESMSchedule(Long idService);
}
