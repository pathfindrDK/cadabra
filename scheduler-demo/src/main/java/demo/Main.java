import java.io.ByteArrayOutputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.io.IOException;
import java.io.FileOutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;

import aliro.bridge.PDF; // Import the renamed PDF class

public class Main {
    public static void main(String[] args) {
        System.out.println("Starting PDF generation...");
        String filePath = args[0]; // Path to the HTML file
        
        if (filePath == null) {
            System.out.println("Please provide the path to the HTML file.");
            return;
        }

        String basePath = filePath.substring(0, filePath.lastIndexOf("/"));

        
        // Generate the timestamp to avoid overwriting files
        String timestamp = new SimpleDateFormat("yyyyMMdd_HHmmss").format(new Date()); // Create a timestamp
        String outputPdfPath = basePath + "generated_output_" + timestamp + ".pdf"; // Output file path with timestamp

        try {
            // Read the file content into a string
            String htmlContent = new String(Files.readAllBytes(Paths.get(filePath)));

            // Generate PDF from HTML string
            ByteArrayOutputStream pdfOutputStream = PDF.htmlToPdfOutputStream(htmlContent, true);

            // Write the ByteArrayOutputStream to a file (PDF) in the generated_files folder
            try (FileOutputStream fileOutputStream = new FileOutputStream(outputPdfPath)) {
                pdfOutputStream.writeTo(fileOutputStream);
                System.out.println("PDF saved to: " + outputPdfPath);
            }

        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}