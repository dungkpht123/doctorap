package fpt.fa.service;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import fpt.fa.entity.Post;

public interface PostService {
	void create(Post post);
	Post findById(int id);
	List<Post> getListPost();
	void save(Post post);
	void delete(Post post);
	Post findByUrl(String url);
	 // Lấy danh sách bài viết với phân trang, chỉ lấy những bài có status = 1
    Page<Post> getListPostWithPaging(Pageable pageable);
    
    // Lấy danh sách các bài viết với status = 1 và phân trang
    Page<Post> findAllByStatus(int status, Pageable pageable);
}