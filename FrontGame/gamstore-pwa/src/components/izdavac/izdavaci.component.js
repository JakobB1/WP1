import React, { Component } from "react";
import { Container, Table } from "react-bootstrap";
import IzdavacDataService from "../..//services/izdavac.service";


export default class Izdavaci extends Component{

    constructor(props){
        super(props);
        this.dohvatiIzdavaci = this.dohvatiIzdavaci.bind(this);

        this.state = {
            izdavaci: []
        };

    }

    componentDidMount(){
        this.dohvatiIzdavaci();
    }

    async dohvatiIzdavaci(){

        await IzdavacDataService.get()
        .then(response => {
            this.setState({
                izdavaci: response.data
            });
            console.log(response.data);
        })
        .catch(e =>{
            console.log(e);
        });
    }


    render(){

        const { izdavaci } = this.state;

        return (
            <Container>
                <a href="/izdavaci/dodaj" className="btn btn-success gumb">
                    Dodaj novog izdavaca
                </a>

                <Table strict bordered hover responsive>
                    <thead>
                        <tr>
                            <th>Naziv</th>
                            <th>Drzava</th>
                            <th>Web Stranica</th>
                            <th>Akcija</th>
                        </tr>
                    </thead>
                    <tbody>
                        { izdavaci && izdavaci.map((izdavac,index) => (

                            <tr key={index}>
                                <td>{izdavac.naziv}</td>
                                <td>{izdavac.drzava}</td>
                                <td>{izdavac.webStranica}</td>
                                <td></td>
                            </tr>

                        ))}
                    </tbody>
                </Table>





            </Container>
            

        );
    }
}