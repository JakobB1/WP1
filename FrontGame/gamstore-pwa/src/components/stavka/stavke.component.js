import React, { Component } from "react";
import StavkaDataService from "../../services/stavka.service";
import Container from 'react-bootstrap/Container';
import Table from 'react-bootstrap/Table';
import Button from 'react-bootstrap/Button';
import { Link } from "react-router-dom";
import { FaEdit } from 'react-icons/fa';
import { FaTrash } from 'react-icons/fa';
import { Modal } from 'react-bootstrap';
import moment from "moment/moment";


export default class Stavke extends Component {
  constructor(props) {
    super(props);
    this.dohvatiStavke = this.dohvatiStavke.bind(this);

    this.state = {
      stavke: [],
      prikaziModal: false
    };
  }

  otvoriModal = () => this.setState({ prikaziModal: true });
  zatvoriModal = () => this.setState({ prikaziModal: false });


  componentDidMount() {
    this.dohvatiStavke();
  }
  dohvatiStavke() {
    StavkaDataService.get()
      .then(response => {
        this.setState({
          stavke: response.data
        });
        console.log(response);
      })
      .catch(e => {
        console.log(e);
      });
  }

  async obrisiStavka(sifra){
    
    const odgovor = await StavkaDataService.delete(sifra);
    if(odgovor.ok){
     this.dohvatiStavke();
    }else{
     this.otvoriModal();
    }
    
   }

  render() {
    const { stavke} = this.state;
    return (

    <Container>
      <a href="/stavke/dodaj" className="btn btn-success gumb">Dodaj novu stavku</a>
      <Table striped bordered hover responsive>
              <thead>
                <tr>
                    <th>Broj stavke</th>
                    <th>Igra</th>
                    <th>Narudzba</th>
                    <th>Kolicina</th>
                    <th>Akcija</th>
                </tr>
              </thead>
              <tbody>
              {stavke && stavke.map((s,index) => (
                
                <tr key={index}>
                    <td className="sifra">{s.sifra} </td>
                    <td className="korisnik">{s.korisnik} </td>
                    <td className="narudzba">{s.narudzba} </td>
                    <td className="kolicina">{s.kolicina}</td>
                  
                  <td>
                                    <Link className="btn btn-primary gumb"
                                    to={`/stavke/${s.sifra}`}>
                                        <FaEdit />
                                    </Link>

                                    <Button variant="danger" className="gumb"
                                    onClick={()=>this.obrisiStavka(s.sifra)}>
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
              <Modal.Body>Stavka ima narudzbe i igre.</Modal.Body>
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
