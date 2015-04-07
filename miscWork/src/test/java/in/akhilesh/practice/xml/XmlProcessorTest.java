package in.akhilesh.practice.xml;

import org.junit.Before;
import org.junit.Test;

import javax.xml.stream.XMLInputFactory;
import javax.xml.stream.XMLStreamException;
import javax.xml.stream.XMLStreamReader;
import java.io.FileNotFoundException;
import java.io.FileReader;

/**
 * Created by akhilesh on 4/7/15.
 */
public class XmlProcessorTest {

    private XMLStreamReader reader;

    @Before
    public void setup() throws FileNotFoundException, XMLStreamException {
        reader = XMLInputFactory.newInstance().createXMLStreamReader(
                new FileReader("/home/akhilesh/Personal/src/test/java/standalone.xml")
        );
    }

    @Test
    public void testXMLPrinter() {
        final String result = new XMLPrinter().process(reader);
        System.out.println(result);
    }

}
