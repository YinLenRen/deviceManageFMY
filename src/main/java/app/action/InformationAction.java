package app.action;

import java.io.FileNotFoundException;
import java.io.IOException;

public interface InformationAction {
    void findAllInformation() throws IOException;
    void findInformationById() throws IOException;
    void addInformationFromJquery() throws IOException;
    void showInformationByIdFromWebPortol() throws IOException;
    void showInformationByIdFromAppPortol() throws IOException;
    void deleteInformation();
}
