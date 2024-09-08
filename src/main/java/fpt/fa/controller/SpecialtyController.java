package fpt.fa.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

import fpt.fa.entity.Post;
import fpt.fa.entity.Specialty;
import fpt.fa.service.FileUploadService;
import fpt.fa.service.SpecialtyServices;


@Controller
@RequestMapping("/admin")
public class SpecialtyController {
	@Autowired
	SpecialtyServices services;
	@Autowired
	FileUploadService fileUpload;
	@GetMapping("/SpecialtyAdd")
	public String AddSpecialty(Model model) {
		model.addAttribute("newSpecialty", new Specialty());
		return "Admin/Page/Specialty/Add";
	}
	@PostMapping("/SpecialtyAdd")
	public String addSpecialty(@ModelAttribute("newSpecialty") Specialty specialty,
	                           @RequestParam("file") MultipartFile file,
	                           BindingResult bindingResult,
	                           Model model,
	                           RedirectAttributes redirectAttributes) {
	    if (bindingResult.hasErrors()) {
	        // Handle validation errors
	        return "formPage"; // Redirect to the form page to show errors
	    }
	    try {
	        if (file != null && !file.isEmpty()) {
	            String imageUrl = fileUpload.uploadFile(file);
	            if (imageUrl != null) {
	                specialty.setImage(imageUrl);
	            }
	        }
	        services.Add(specialty); // Ensure this method is available and correctly implemented
	        return "redirect:SpecialtyList"; // Redirect to the list page after successful addition
	    } catch (Exception e) {
	        // Log and handle exception
	        e.printStackTrace();
	        redirectAttributes.addFlashAttribute("error", "An error occurred while uploading the file.");
	        return "redirect:SpecialtyAdd"; // Redirect back to the form page with an error message
	    }
	}

	@GetMapping("/SpecialtyList")
	public String SpecialtyList(Model model,  
	                            @RequestParam(value = "page", defaultValue = "1") int page, 
	                            @RequestParam(value = "size", defaultValue = "6") int size,
	                            @RequestParam(value = "search", required = false) String search) {
	    Page<Specialty> pageListPage;
	    if (search != null && !search.isEmpty()) {
	        pageListPage = services.searchSpecialtiesByName(search, PageRequest.of(page - 1, size));
	        // Nếu không có kết quả tìm kiếm, hiển thị thông báo
	        if (pageListPage.getTotalElements() == 0) {
	            model.addAttribute("noResults", true);
	        }
	    } else {
	        pageListPage = services.getListSpecWithPaging(PageRequest.of(page - 1, size)); 
	    }

	    model.addAttribute("currentPage", page);
	    model.addAttribute("currentSize", size);
	    model.addAttribute("pageList", pageListPage);
	    model.addAttribute("specialtyList", pageListPage.getContent()); // Danh sách chuyên khoa từ phân trang
	    model.addAttribute("search", search); // Đưa giá trị tìm kiếm vào model để giữ lại khi tìm kiếm

	    return "Admin/Page/Specialty/List"; // Trả về view danh sách chuyên khoa
	}

	
	
	@GetMapping("/SpecialtyEdit")
	public String Edit(Model model, @RequestParam(name = "id", required = true) int id) {
		model.addAttribute("editSpecialty", services.FindId(id));
		return "Admin/Page/Specialty/Edit";
	}
	@PostMapping("/SpecialtyEdit")
	public String Edit(@ModelAttribute("editSpecialty") Specialty specialty, Model model, RedirectAttributes redirectAttributes,@RequestParam("file") MultipartFile file,
            BindingResult bindingResult) {
		if (bindingResult.hasErrors()) {
	        // Handle validation errors
	        return "formPage"; // Redirect to the form page to show errors
	    }
	    try {
	        if (file != null ) {
	            String imageUrl = fileUpload.uploadFile(file);
	            if (imageUrl != null ) {
	                specialty.setImage(imageUrl);
	            }
	            
	        }
	        services.edit(specialty); // Ensure this method is available and correctly implemented
	        return "redirect:SpecialtyList"; // Redirect to the list page after successful addition
	    } catch (Exception e) {
	        // Log and handle exception
	        e.printStackTrace();
	        redirectAttributes.addFlashAttribute("error", "An error occurred while uploading the file.");
	        Specialty s = services.FindId(specialty.getId());
        	specialty.setImage(s.getImage());
	        services.edit(specialty);
	        return "redirect:SpecialtyList"; // Redirect back to the form page with an error message
	    }
		
		 
	}
	@GetMapping("/SpecialtyDelete")
	public String Delete(Model model, @RequestParam(name = "id", required = true) int id) {
		model.addAttribute("deleteSpecialty", services.FindId(id));
		return "Admin/Page/Specialty/Delete";
	}
	@PostMapping("/SpecialtyDelete")
	public String Delete(@ModelAttribute("deleteSpecialty") Specialty specialty, Model model, RedirectAttributes redirectAttributes) {
		services.delete(specialty);
		return "redirect: SpecialtyList"; 
	}
	
}
