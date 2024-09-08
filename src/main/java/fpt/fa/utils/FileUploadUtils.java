package fpt.fa.utils;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

@Service
public class FileUploadUtils {

    private static final String[] ALLOWED_IMAGE_EXTENSIONS = { "jpg", "jpeg", "png", "gif" };
    private static final String UPLOAD_DIRECTORY = "uploads/images";

    public String uploadFile(HttpServletRequest request) throws Exception {
        String imageUrl = null;

        if (ServletFileUpload.isMultipartContent(request)) {
            FileItemFactory factory = new DiskFileItemFactory();
            ServletFileUpload upload = new ServletFileUpload(factory);

            List<FileItem> items = upload.parseRequest(request);

            for (FileItem item : items) {
                if (!item.isFormField()) {
                    String fileName = item.getName();
                    String fileExtension = getFileExtension(fileName);

                    if (isAllowedImageExtension(fileExtension)) {
                        File uploadDir = new File(UPLOAD_DIRECTORY);
                        if (!uploadDir.exists()) {
                            uploadDir.mkdirs();
                        }

                        File file = new File(uploadDir, fileName);
                        try (InputStream inputStream = item.getInputStream()) {
                            FileUtils.copyInputStreamToFile(inputStream, file);
                        }

                        imageUrl = UPLOAD_DIRECTORY + "/" + fileName;
                    } else {
                        throw new Exception("Invalid file type: " + fileExtension);
                    }
                }
            }
        } else {
            throw new Exception("The request is not multipart");
        }

        return imageUrl;
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
