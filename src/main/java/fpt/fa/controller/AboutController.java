package fpt.fa.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import fpt.fa.entity.Post;
import fpt.fa.service.PostService;  

@Controller
public class AboutController {

    @Autowired
    private PostService postService;

    @RequestMapping(value = "/{url}", method = RequestMethod.GET)
    public String aboutUsPage(@PathVariable("url") String url, Model model) {
        Post post = postService.findByUrl(url);
        if (post != null && post.getStatus() == 1) {
            model.addAttribute("post", post);
            return "Doctor/Page/about";
        } else {
            return "Doctor/error/404"; 
        }
    }
}
