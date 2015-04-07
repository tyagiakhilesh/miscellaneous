package in.akhilesh.practice.xml;

import javax.xml.stream.XMLStreamConstants;
import javax.xml.stream.XMLStreamException;
import javax.xml.stream.XMLStreamReader;
import java.util.Stack;

/**
 * Created by akhilesh on 4/7/15.
 */
public class XMLPrinter {

    public final String TAB = "\t";

    public String process(XMLStreamReader reader) {
        final Stack<String> tabsStack = new Stack<String>();
        final StringBuilder response = new StringBuilder();

        try {
            for (int event = reader.next(); XMLStreamConstants.END_DOCUMENT != event; event = reader.next()) {
                switch (event) {

                    case XMLStreamConstants.START_ELEMENT:
                        final String tagName = reader.getLocalName();
                        final String toPrint = "<" + tagName + ">";
                        //insert into stack before appending anything to response
                        tabsStack.push(tagName);
                        response.append(createTabbedString(tabsStack, toPrint + System.lineSeparator()));
                        break;

                    case XMLStreamConstants.END_ELEMENT:
                        final String closedTag = tabsStack.peek();
                        response.append(System.lineSeparator() + createTabs(tabsStack) +
                                "</" + closedTag + ">" + System.lineSeparator());
                        tabsStack.pop();
                        break;

                    case XMLStreamConstants.CHARACTERS:
                        response.append(TAB + createTabbedString(tabsStack,reader.getText()));
                        break;

                    default:
                        break;
                }
            }
        } catch (XMLStreamException e) {
            e.printStackTrace();
        }
        return response.toString();
    }

    private String createTabs(final Stack<String> tabsStack) {
        final StringBuilder sb = new StringBuilder();
        for (final String s : tabsStack) {
            sb.append(TAB);
        }
        return sb.toString();
    }

    private String createTabbedString(final Stack<String> stack, final String msg) {
        return createTabs(stack) + msg;
    }
}
