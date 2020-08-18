import java.io.*;
import java.net.ServerSocket;
import java.net.Socket;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class ImageServer {

    static int counter = 1;
    static String imagePath = "";

    static OutputStream os;
    static InputStream is;

    public static void main(String[] args) throws IOException {
//        int port = Integer.parseInt(args[0]);
        int port = 5000;
        ServerSocket serverSocket = new ServerSocket(port);

        Socket socket = serverSocket.accept();
        System.out.println("connected..........");

        os = socket.getOutputStream();
        is = socket.getInputStream();

        Thread read = new Thread(() -> {
            while (true) {
                int size = Integer.parseInt(readHeaderMsg()); //reading bytes from the stream => here size of image is read
                byte[] buf = new byte[size];                  //create a buffer of the image size
                System.out.println("Header msg :" + size);

                readMsg(buf);   //read image in form of bytes
                saveFile(buf);  //save image into the specified directory

            }
        });
        read.start();
    }

    private static void saveFile(byte[] buf) {
        try {
            String fileName = generateFileName();   //generate file name using system time
            //save the file in the specified path
            FileOutputStream fos = new FileOutputStream(new File(imagePath + fileName + "_" + counter + ".jpg"));
            //write the file:
            fos.write(buf, 0, buf.length);
            System.out.println("file saved: image " + counter);
            fos.flush();    //flush the file to clear the internal buffer
            fos.close();    //close the file to remove any file pointer cause read/write error
            counter++;
        } catch (IOException e) {
            System.out.println("Exception in saving file");
        }

    }

// method to read image in the form of bytes from the stream 
    private static void readMsg(byte[] buf) {
        try {
            int d = 0;
            for (int i = 0; i < buf.length; ) {   //bytes will be read upto the size read from readHeaderMsg method
                if (is.available() > 0) {
                    buf[i] = (byte) is.read();
                    i++;
                }
            }
            return;
        } catch (IOException e) {
            System.out.println("Exception in read Msg");
        }
    }

// method to read size of image file
    private static String readHeaderMsg() {
        String msg = "";
        try {
            while (true) {
                if (is.available() > 0) {
                    int d = 0;
                    while ((d = is.read()) != '&') {  // read upto '&' charcter is found in the stream
                        msg = msg + (char) d;
                    }
                    break;
                }
            }
        } catch (IOException e) {
            System.out.println("Exception in Header Msg");
        }
        return msg;
    }

//method to create filename using system time
    private static String generateFileName() {
        DateTimeFormatter df = DateTimeFormatter.ofPattern("HHmmss");
        LocalDateTime now = LocalDateTime.now();
        return df.format(now);
    }
}

