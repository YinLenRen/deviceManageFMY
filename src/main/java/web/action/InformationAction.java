package web.action;

import java.io.FileNotFoundException;
import java.io.IOException;

public interface InformationAction {
    String addInformation() throws IOException;
    String updateInformation() throws IOException;
}
