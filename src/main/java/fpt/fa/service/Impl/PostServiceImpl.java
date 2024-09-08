package fpt.fa.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service; // Add this import

import fpt.fa.entity.Post;
import fpt.fa.repositories.PostRepository;
import fpt.fa.service.PostService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
@Service // Add this annotation to make it a Spring bean
public class PostServiceImpl implements PostService {
 
    @Autowired
    PostRepository repository;
    
    @Override
    public void save(Post post) {
        repository.save(post);
    }
    
    @Override
    public void create(Post post) {
        repository.save(post);
    }

    @Override
    public void delete(Post post) {
        repository.delete(post);
    }

    @Override
    public Post findById(int id) {
        return repository.findById(id).orElse(null);
    }

    @Override
    public List<Post> getListPost() {
        return repository.findAll();
    }

    public Post findByUrl(String url) {
        return repository.findByUrl(url);  // Lấy bài viết dựa trên URL
    }
    
    @Override
    public Page<Post> getListPostWithPaging(Pageable pageable) {
        return repository.findAll(pageable);
    }

    @Override
    public Page<Post> findAllByStatus(int status, Pageable pageable) {
        return repository.findByStatus(status, pageable);
    }

	}
