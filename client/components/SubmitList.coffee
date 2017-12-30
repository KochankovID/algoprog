React = require('react')
moment = require('moment')
FontAwesome = require('react-fontawesome')

import Table from 'react-bootstrap/lib/Table'
import Modal from 'react-bootstrap/lib/Modal'
import Button from 'react-bootstrap/lib/Button'
import Tabs from 'react-bootstrap/lib/Tabs'
import Tab from 'react-bootstrap/lib/Tab'

import Submit from './Submit'
import SubmitForm from './SubmitForm'
import SubmitListTable from './SubmitListTable'

import ConnectedComponent from '../lib/ConnectedComponent'

import outcomeToText from '../lib/outcomeToText'

import styles from './SubmitList.css'

OpenSubmit = (props) ->
    <Modal show={true} onHide={props.close} dialogClassName={styles.modal}>
        <Modal.Body>
            <Submit submit={props.submit}/>
        </Modal.Body>

        <Modal.Footer>
            <Button bsStyle="primary" onClick={props.close}>Закрыть</Button>
        </Modal.Footer>
    </Modal>

problemId = (props) ->
    props.material._id.substring(1)

class SubmitList extends React.Component
    constructor: (props) ->
        super(props)
        @state = {}
        @openSubmit = @openSubmit.bind(this)
        @closeSubmit = @closeSubmit.bind(this)

    openSubmit: (submit) ->
        (e) =>
            e.preventDefault()
            @setState
                openSubmit: submit

    closeSubmit: () ->
        @setState
            openSubmit: null

    render:  () ->
        if not @props.myUser?._id
            return null
        <div>
            <SubmitForm problemId={problemId(@props)} reloadSubmitList={@props.handleReload}/>
            {
            if @state.openSubmit?._id
                <OpenSubmit submit={@state.openSubmit} close={@closeSubmit}/>
            }
            <h4>Попытки <Button onClick={@props.handleReload}>{"\u200B"}<FontAwesome name="refresh"/></Button></h4>
            <p>Не обновляйте страницу; список посылок обновляется автоматически.</p>
            {
            if @props.data?.length
                <SubmitListTable submits={@props.data} handleSubmitClick={@openSubmit} />
            else
                <p>Посылок по этой задаче еще не было</p>
            }
        </div>

options =
    urls: (props) ->
        if props?.myUser?._id
            return {data: "submits/#{props.myUser._id}/#{props.material._id}"}
        return {}

    timeout: 20 * 1000

myUserOptions =
    urls: (props) ->
        return {"myUser"}

    timeout: 20 * 1000

export default ConnectedComponent(ConnectedComponent(SubmitList, options), myUserOptions)
