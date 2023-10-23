import React, { Component } from "react";
import KorisnikDataService from "../../services/korisnik.service";
import Container from 'react-bootstrap/Container';
import Row from 'react-bootstrap/Row';
import Col from 'react-bootstrap/Col';
import Card from 'react-bootstrap/Card';
import Button from 'react-bootstrap/Button';
import { Link } from "react-router-dom";
import { FaEdit } from 'react-icons/fa';
import { FaTrash } from 'react-icons/fa';
import { Modal } from 'react-bootstrap';


export default class Korisnici extends Component {
  constructor(props) {
    super(props);

    this.state = {
      Korisnici: [],
      prikaziModal: false
    };
  }



  otvoriModal = () => this.setState({ prikaziModal: true });
  zatvoriModal = () => this.setState({ prikaziModal: false });

  componentDidMount() {
    this.dohvatiKorisnici();
  }
  dohvatiKorisnici() {
    KorisnikDataService.getAll()
      .then(response => {
        this.setState({
          korisnici: response.data
        });
      })
      .catch(e => {
        console.log(e);
      });
  }

  async obrisiKorisnik(sifra){
    
    const odgovor = await KorisnikDataService.delete(sifra);
    if(odgovor.ok){
     this.dohvatiKorisnici();
    }else{
      this.otvoriModal();
    }
    
   }

  render() {
    const { korisnici} = this.state;
    return (

    <Container>
      <a href="/korisnici/dodaj" className="btn btn-success gumb">Dodaj novog korisnika</a>
    <Row>
      { korisnici && korisnici.map((k) => (
           
           <Col key={k.sifra} sm={12} lg={3} md={3}>

              <Card style={{ width: '18rem' }}>
              <Card.Img variant="top" src={k.slika} />
                <Card.Body>
                  <Card.Title>{k.ime} {k.prezime}</Card.Title>
                  <Card.Text>
                    {k.email}
                  </Card.Text>
                  <Row>
                      <Col>
                      <Link className="btn btn-primary gumb" to={`/korisnici/${k.sifra}`}><FaEdit /></Link>
                      </Col>
                      <Col>
                      <Button variant="danger" className="gumb"  onClick={() => this.obrisiKorisnik(k.sifra)}><FaTrash /></Button>
                      </Col>
                    </Row>
                </Card.Body>
              </Card>
            </Col>
          ))
      }
      </Row>


      <Modal show={this.state.prikaziModal} onHide={this.zatvoriModal}>
              <Modal.Header closeButton>
                <Modal.Title>Greška prilikom brisanja</Modal.Title>
              </Modal.Header>
              <Modal.Body>Korisnik se nalazi na jednoj ili više narudžbi i ne može se obrisati.</Modal.Body>
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
