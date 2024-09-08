/*
 * package fpt.fa.service;
 * 
 * import org.springframework.beans.factory.annotation.Autowired; import
 * org.springframework.stereotype.Service; import
 * org.springframework.web.multipart.MultipartFile;
 * 
 * import javax.servlet.ServletContext; import java.io.File; import
 * java.io.IOException;
 * 
 * @Service public class FileUploadService {
 * 
 * private static final String[] ALLOWED_IMAGE_EXTENSIONS = { "jpg", "jpeg",
 * "png", "gif" };
 * 
 * @Autowired private ServletContext servletContext;
 * 
 * public String uploadFile(MultipartFile file) throws Exception { if
 * (file.isEmpty()) { throw new Exception("No file uploaded"); }
 * 
 * String fileName = file.getOriginalFilename(); if (fileName == null ||
 * fileName.isEmpty()) { throw new Exception("File name is empty"); }
 * 
 * String fileExtension = getFileExtension(fileName);
 * 
 * if (isAllowedImageExtension(fileExtension)) { // Use ServletContext to get
 * the absolute path String uploadPath =
 * servletContext.getRealPath("/uploads/images"); File uploadDir = new
 * File(uploadPath); if (!uploadDir.exists()) { uploadDir.mkdirs(); }
 * 
 * File targetFile = new File(uploadDir, fileName); try {
 * file.transferTo(targetFile); } catch (IOException e) { throw new
 * IOException("Failed to save file: " + e.getMessage()); }
 * 
 * return "/uploads/images/" + fileName; } else { throw new
 * Exception("Invalid file type: " + fileExtension); } }
 * 
 * private String getFileExtension(String fileName) { int lastDotIndex =
 * fileName.lastIndexOf('.'); if (lastDotIndex > 0 && lastDotIndex <
 * fileName.length() - 1) { return fileName.substring(lastDotIndex +
 * 1).toLowerCase(); } return ""; }
 * 
 * private boolean isAllowedImageExtension(String extension) { for (String
 * allowedExtension : ALLOWED_IMAGE_EXTENSIONS) { if
 * (allowedExtension.equals(extension)) { return true; } } return false; } }
 */

package fpt.fa.service;

import java.io.File;
import java.io.IOException;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public class FileUploadService {

    private static final String[] ALLOWED_IMAGE_EXTENSIONS = { "jpg", "jpeg", "png", "gif" };
    
    // Đường dẫn tuyệt đối nơi tệp sẽ được lưu
    private static final String ABSOLUTE_UPLOAD_DIR = "D:\\Nam_Cuoi\\TTTN\\code moi\\New folder\\fix bug\\src\\main\\webapp\\uploads\\images";

    public String uploadFile(MultipartFile file) throws Exception {
        if (file.isEmpty()) {
            throw new Exception("Không có tệp được tải lên");
        }

        String fileName = file.getOriginalFilename();
        if (fileName == null || fileName.isEmpty()) {
            throw new Exception("Tên tệp trống");
        }

        String fileExtension = getFileExtension(fileName);
        System.out.println("Đuôi tệp: " + fileExtension);

        if (isAllowedImageExtension(fileExtension)) {
            String uploadPath = ABSOLUTE_UPLOAD_DIR;
            System.out.println("Đường dẫn thư mục tải lên: " + uploadPath);

            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                boolean created = uploadDir.mkdirs();
                System.out.println("Thư mục đã được tạo: " + created);
                if (!created) {
                    throw new IOException("Không thể tạo thư mục tải lên: " + uploadPath);
                }
            }

            File targetFile = new File(uploadDir, fileName);
            System.out.println("Đường dẫn tệp mục tiêu: " + targetFile.getAbsolutePath());

            try {
                file.transferTo(targetFile);
                System.out.println("Tệp đã được tải lên thành công.");
            } catch (IOException e) {
                System.err.println("Lưu tệp không thành công: " + e.getMessage());
                e.printStackTrace();
                throw e;
            }

            return "/uploads/images/" + fileName;
        } else {
            throw new Exception("Loại tệp không hợp lệ: " + fileExtension);
        }
    }

    private String getFileExtension(String fileName) {
        int lastDotIndex = fileName.lastIndexOf('.');
        if (lastDotIndex > 0 && lastDotIndex < fileName.length() - 1) {
            return fileName.substring(lastDotIndex + 1).toLowerCase();
        }
        return "";
    }

    private boolean isAllowedImageExtension(String extension) {
        for (String allowedExtension : ALLOWED_IMAGE_EXTENSIONS) {
            if (allowedExtension.equals(extension)) {
                return true;
            }
        }
        return false;
    }
}
