from lxml import etree
import StringIO

class Xsd:

def read_xsd(type):
    xsd_file = etree.parse(open("../xsd_files/CFDI_32.xsd"))
    xml_schema = etree.XMLSchema(xsd_file)
    return xml_schema.elements()
