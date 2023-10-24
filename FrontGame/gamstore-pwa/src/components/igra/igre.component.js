import React, { Component } from "react";
import IgraDataService from "../../services/igra.service";
import Container from 'react-bootstrap/Container';
import Table from 'react-bootstrap/Table';
import Button from 'react-bootstrap/Button';
import { Link } from "react-router-dom";
import { FaEdit } from 'react-icons/fa';
import { FaTrash } from 'react-icons/fa';
import { Modal } from 'react-bootstrap';
import moment from "moment/moment";


export default class Igre extends Component {
  constructor(props) {
    super(props);
    this.dohvatiIgre = this.dohvatiIgre.bind(this);

    this.state = {
      igre: [],
      prikaziModal: false
    };
  }

  otvoriModal = () => this.setState({ prikaziModal: true });
  zatvoriModal = () => this.setState({ prikaziModal: false });


  componentDidMount() {
    this.dohvatiIgre();
  }
  dohvatiIgre() {
    IgraDataService.getAll()
      .then(response => {
        this.setState({
          igre: response.data
        });
        console.log(response);
      })
      .catch(e => {
        console.log(e);
      });
  }

  async obrisiIgra(sifra){
    
    const odgovor = await IgraDataService.delete(sifra);
    if(odgovor.ok){
     this.dohvatiIgre();
    }else{
     this.otvoriModal();
    }
    
   }

  render() {
    const { igre} = this.state;
    return (

    <Container>
      <a href="/igre/dodaj" className="btn btn-success gumb">Dodaj novu igru</a>
      <Table striped bordered hover responsive>
              <thead>
                <tr>
                  <th>Naziv</th>
                  <th>Izdavac</th>
                  <th>Zanr</th>
                  <th>Cijena</th>
                  <th>Dobna granica</th>
                  <th>Datum izlaska</th>
                  <th>Akcija</th>
                </tr>
              </thead>
              <tbody>
              {igre && igre.map((i,index) => (
                
                <tr key={index}>
                  <td>{i.naziv}</td>
                  <td className="izdavac">{i.izdavac} </td>
                  <td className="zanr">{i.zanr} </td>
                  <td className="cijena">{i.cijena}</td>
                  <td className="dobnaGranica">{i.dobnaGranica}</td>
                  <td className="datumIzlaska">
                    {i.datumIzlaska==null ? "Nije definirano" :
                    moment.utc(i.datumIzlaska).format("DD. MM. YYYY. HH:mm")}
                  </td>
                  <td>
                                    <Link className="btn btn-primary gumb"
                                    to={`/igre/${i.sifra}`}>
                                        <FaEdit />
                                    </Link>

                                    <Button variant="danger" className="gumb"
                                    onClick={()=>this.obrisiIgra(i.sifra)}>
                                        <FaTrash />
                                    </Button>
                                </td>
                </tr>
                ))
              }
              </tbody>
             
            </Table>     

             <Modal show={this.state.prikaziModal} onHide={this.zatvoriModal}>
              <Modal.Header closeButton>
                <Modal.Title>Greška prilikom brisanja</Modal.Title>
              </Modal.Header>
              <Modal.Body>Igra ima izdavace.</Modal.Body>
              <Modal.Footer>
                <Button variant="secondary" onClick={this.zatvoriModal}>
                  Zatvori
                </Button>
              </Modal.Footer>
            </Modal>

    </Container>

    );
    
        }
}
