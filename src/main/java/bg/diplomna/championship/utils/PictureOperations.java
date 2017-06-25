package bg.diplomna.championship.utils;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;

import javax.servlet.ServletContext;

import org.springframework.web.multipart.MultipartFile;

public class PictureOperations {

	public static void deletePicture(String imageName,ServletContext context) {
		if (!imageName.equals("default.jpeg")) {
			String folderPath = context.getRealPath("/") + "\\images\\";
			File picture = new File(folderPath + imageName);
			picture.delete();
		}
	}
	
	public static String getContextPath(ServletContext context){
		return context.getRealPath("/") + "\\img\\";
	}

	public static String getImageName(MultipartFile image,String firstName,String lastName){
		String imageName;
		if (image.getOriginalFilename().equals("")) {
			imageName = "default.jpg";
		} else {
			int dot = image.getOriginalFilename().indexOf(".");
			String ext = image.getOriginalFilename().substring(dot, image.getOriginalFilename().length());
			imageName = firstName + lastName + ext;
		}
		return imageName;
	}
	
	public static void savePicture(String filePath,MultipartFile image) {
		
		try {
			// Initializing the streams
			InputStream inputStream = null;
			OutputStream outputStream = null;

			// If our file has data in it
			if (image.getSize() > 0) {
				// We are pointing the input stream to it
				inputStream = image.getInputStream();

				// Getting a new filePath with the input file name and we
				// are pointing the output stream there
				outputStream = new FileOutputStream(filePath);

				// Logging
				System.out.println("======New file entry=====");
				System.out.println(image.getOriginalFilename());
				System.out.println("=============");

				// We are getting the buffer ready for transmitting data
				int readBytes = 0;
				byte[] buffer = new byte[8192];
				while ((readBytes = inputStream.read(buffer, 0, 8192)) != -1) {
					System.out.println("===Process====");
					outputStream.write(buffer, 0, readBytes);
				}

				// Closing the streams
				outputStream.close();
				inputStream.close();

			}
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}
