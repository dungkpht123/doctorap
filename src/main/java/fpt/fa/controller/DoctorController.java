package fpt.fa.controller;
 
import fpt.fa.entity.Doctor;
import fpt.fa.entity.Specialty;
import fpt.fa.enums.AccountRole;
import fpt.fa.service.DoctorService;
import fpt.fa.service.SpecialtyServices;
 
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
 
import java.util.List;
 
@Controller
public class DoctorController {
 
    @Autowired
    private DoctorService doctorService;
    @Autowired
    private SpecialtyServices specialtyService;
 
    @RequestMapping(value = "admin/doctors", method = RequestMethod.GET)
    public String showDoctorsList(Model model) {
        List<Doctor> doctors = doctorService.getAllDoctors();
        model.addAttribute("doctors", doctors);
        return "Admin/Page/Doctor/ListDoctor";
    }
    @GetMapping("admin/doctors/update/{id}")
    public String showUpdateDoctorForm(@PathVariable("id") int id, Model model) {
        Doctor doctor = doctorService.getDoctorById(id);
        List<Specialty> specialtyList = specialtyService.getAllSpecialties();
 
        if (doctor == null) {
            model.addAttribute("errorMsg", "Không tìm thấy thông tin bác sĩ.");
            return "redirect:/doctors";
        }
        model.addAttribute("doctor", doctor);
        model.addAttribute("specialtyList", specialtyList);
        return "Admin/Page/Doctor/UpdateDoctor";
    }
 
    @PostMapping("admin/doctors/update")
    public String updateDoctor(@ModelAttribute("doctor") Doctor doctor, Model model) {
        try {
            Doctor existingDoctor = doctorService.getDoctorById(doctor.getId());
 
            if (existingDoctor == null) {
                model.addAttribute("errorMsg", "Không tìm thấy thông tin bác sĩ.");
                return "redirect:/doctors";
            }
 
            // Cập nhật các thông tin của bác sĩ
            existingDoctor.setSpecialty(doctor.getSpecialty());
            existingDoctor.setExperience(doctor.getExperience());
            existingDoctor.setQualifications(doctor.getQualifications());
 
            doctorService.updateDoctor(existingDoctor);
 
            model.addAttribute("successMsg", "Cập nhật thông tin bác sĩ thành công.");
            return "redirect:/admin/doctors";
        } catch (Exception e) {
            model.addAttribute("errorMsg", "Đã xảy ra lỗi khi cập nhật thông tin.");
            model.addAttribute("doctor", doctor);
            return "Admin/Page/Doctor/UpdateDoctor";
        }
    }
}
 