package fpt.fa.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import fpt.fa.entity.Post;
import fpt.fa.service.FileUploadService;
import fpt.fa.service.PostService;
import fpt.fa.service.SpecialtyServices;

import javax.validation.Valid;
import java.io.IOException;
import java.util.List;

@Controller
@RequestMapping("/admin")
public class PostController {

    @Autowired
    private PostService service;

    @Autowired
    private SpecialtyServices specialtyService;

    @Autowired
    private FileUploadService fileUploadService;

    @RequestMapping(value = "/Post/create", method = RequestMethod.GET)
    public String createPostForm(Model model) {
        model.addAttribute("specialtyList", specialtyService.ShowSpecialtyList());
        model.addAttribute("post", new Post());
        return "Admin/Page/Posts/CreatePost";
    }

    @RequestMapping(value = "/Post/create", method = RequestMethod.POST)
    public String createPost(@Valid @ModelAttribute Post post,
            @RequestParam("file") MultipartFile file,
            BindingResult bindingResult,
            Model model,
            RedirectAttributes redirectAttributes) {
		if (bindingResult.hasErrors()) {
			model.addAttribute("specialtyList", specialtyService.ShowSpecialtyList()); // To populate the dropdown again
			return "Admin/Page/Posts/CreatePost";
		}

		try {
	        String imageUrl = fileUploadService.uploadFile(file);
			if (imageUrl != null) {
				post.setImageUrl(imageUrl);
			}

			service.save(post);
			redirectAttributes.addFlashAttribute("successMessage", "Tạo bài viết thành công");
			return "redirect: list";
		} catch (IOException e) {
			model.addAttribute("error", "File upload failed: " + e.getMessage());
			model.addAttribute("specialtyList", specialtyService.ShowSpecialtyList()); // To populate the dropdown again
			return "Admin/Page/Posts/CreatePost";
		} catch (Exception e) {
			model.addAttribute("error", e.getMessage());
			model.addAttribute("specialtyList", specialtyService.ShowSpecialtyList()); // To populate the dropdown again
			return "Admin/Page/Posts/CreatePost";
		}
	}
    
    @RequestMapping(value = "Post/list", method = RequestMethod.GET)
    public String listPost(Model model, 
                           @RequestParam(value = "page", defaultValue = "1") int page, 
                           @RequestParam(value = "size", defaultValue = "4") int size) {
        // Lấy danh sách bài viết với phân trang
        Page<Post> pageList = service.getListPostWithPaging(PageRequest.of(page - 1, size));
        
        // Đặt các thuộc tính vào model để sử dụng trong JSP
        model.addAttribute("currentPage", page);
        model.addAttribute("currentSize", size);
        model.addAttribute("pageList", pageList);
        model.addAttribute("postList", pageList.getContent()); // Lấy danh sách bài viết từ phân trang
        model.addAttribute("specialtyList", specialtyService.ShowSpecialtyList()); // Nếu cần hiển thị danh sách chuyên khoa
       
        return "Admin/Page/Posts/ListPost"; // Trả về view danh sách bài viết
    }
    
    
    // Hiển thị form chỉnh sửa
    @RequestMapping(value = "Post/edit/{id}", method = RequestMethod.GET)
    public String showEditForm(@PathVariable("id") int id, Model model) {
        Post post = service.findById(id);
        if (post == null) {
            return "redirect:/Post/list"; // Hoặc một trang lỗi nếu không tìm thấy bài viết
        }

        model.addAttribute("post", post);
        model.addAttribute("specialtyList", specialtyService.ShowSpecialtyList());
        return "Admin/Page/Posts/EditPost";
    }

    // Xử lý cập nhật bài viết
    @RequestMapping(value = "Post/edit", method = RequestMethod.POST)
    public String updatePost(@Valid @ModelAttribute Post post,
                             @RequestParam("file") MultipartFile file,
                             BindingResult bindingResult,
                             Model model,
                             RedirectAttributes redirectAttributes) {
        if (bindingResult.hasErrors()) {
            model.addAttribute("specialtyList", specialtyService.ShowSpecialtyList()); // Để làm mới dropdown
            return "Admin/Page/Posts/EditPost";
        }

        try {
            if (!file.isEmpty()) {
                String imageUrl = fileUploadService.uploadFile(file);
                if (imageUrl != null) {
                    post.setImageUrl(imageUrl);
                }
            }
            service.save(post);
            redirectAttributes.addFlashAttribute("successMessage", "Cập nhật bài viết thành công");
            return "redirect: list"; // Hoặc một trang khác sau khi cập nhật
        } catch (IOException e) {
            model.addAttribute("error", "File upload failed: " + e.getMessage());
            model.addAttribute("specialtyList", specialtyService.ShowSpecialtyList()); // Để làm mới dropdown
            return "Admin/Page/Posts/EditPost";
        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
            model.addAttribute("specialtyList", specialtyService.ShowSpecialtyList()); // Để làm mới dropdown
            return "Admin/Page/Posts/EditPost";
        }
    }
    @RequestMapping(value = "Post/delete", method = RequestMethod.GET)
    public String deletePost(Model model,@RequestParam("idd") int idd) {
        try {
            Post post = service.findById(idd);

            if (post != null) {
            	service.delete(post);
                model.addAttribute("successMessage", "Post deleted successfully");
            } else {
                model.addAttribute("error", "Post not found");
                
            }
        } catch (Exception e) {
            model.addAttribute("error", "An error occurred while deleting the post");
            e.printStackTrace(); // Log the exception for further investigation
        }
        return "redirect: list";
         // Adjust the redirection path as needed
    }


}