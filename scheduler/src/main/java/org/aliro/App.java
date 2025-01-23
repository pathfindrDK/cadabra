package org.aliro;


import aliro.bridge.PDF; // Import the renamed PDF class
import java.io.ByteArrayOutputStream;
import java.io.FileReader;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.io.IOException;

public class App {
    public static void main(String[] args) {
        String filePath = "/workspaces/cadabra/test.html"; // Add path to HTML file.
         try {
            String htmlContent = new String(Files.readAllBytes(Paths.get(filePath)));
            // Generate PDF from HTML string    
            ByteArrayOutputStream pdfOutputStream = PDF.htmlToPdfOutputStream(htmlContent, true);
        } catch (IOException e) {
            System.out.println("An error occurred: " + e.getMessage());
            e.printStackTrace();
        }
        
    }
}