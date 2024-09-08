package fpt.fa.controller;

import fpt.fa.enums.AccountRole;
import fpt.fa.service.AccountService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/reports")
public class ReportsController {

    @Autowired
    private AccountService accountService;

    @GetMapping("/dailyByRole")
    public Map<String, Object> getDailyUserCountsByRole(
            @RequestParam(value = "startDate", required = false) String startDateStr,
            @RequestParam(value = "endDate", required = false) String endDateStr,
            @RequestParam(value = "role", defaultValue = "ROLE_USER") AccountRole role) {

        Map<String, Object> response = new HashMap<>();

        LocalDate startDate;
        LocalDate endDate;

        if (startDateStr != null && endDateStr != null) {
            startDate = LocalDate.parse(startDateStr);
            endDate = LocalDate.parse(endDateStr);
        } else {
            // Get the earliest registration date and the current date
            startDate = accountService.getEarliestRegistrationDate();
            endDate = LocalDate.now();
        }

        Map<String, Long> dailyUserCounts = accountService.getDailyUserCountsByRole(startDate, endDate, role);
        response.put("dailyUserCounts", dailyUserCounts);

        // Calculate total number of users by role
        long totalUsersByRole = accountService.getTotalNumberOfUsersByRole(role);
        response.put("totalUsersByRole", totalUsersByRole);

        return response;
    }
}
