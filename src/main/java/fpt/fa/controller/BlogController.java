package fpt.fa.controller;

import fpt.fa.entity.Post;
import fpt.fa.service.PostService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class BlogController {

    @Autowired
    private PostService postService;

    // Method to list all blogs with status = 1
    @GetMapping("/bai-viet")
    public String listBlogs(@RequestParam(defaultValue = "0") int page,
                            @RequestParam(defaultValue = "6") int size,
                            Model model) {

        Pageable pageable = PageRequest.of(page, size);
        
        // Chỉ lấy các bài viết có status = 1
        Page<Post> blogPage = postService.findAllByStatus(1, pageable);

        model.addAttribute("blogs", blogPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", blogPage.getTotalPages());

        return "Doctor/Page/Post/Posts";
    }

    // Method to view the details of a blog post
    @GetMapping("/bai-viet/{id}")
    public String blogDetail(@PathVariable int id, Model model) {
        Post post = postService.findById(id);
        
        // Chỉ hiện chi tiết bài viết nếu status = 1
        if (post != null && post.getStatus() == 1) {
            model.addAttribute("blog", post);
            return "Doctor/Page/Post/PostDetail";
        } else {
            // Nếu bài viết không tồn tại hoặc status khác 1, chuyển hướng về danh sách bài viết
            return "redirect:/bai-viet";
        }
    }
}
