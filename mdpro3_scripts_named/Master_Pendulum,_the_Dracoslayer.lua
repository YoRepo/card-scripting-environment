--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Master Pendulum, the Dracoslayer  (ID: 75195825)
-- Type: Monster / Normal / Pendulum
-- Attribute: LIGHT
-- Race: Dragon
-- Level: 4
-- ATK 1950 | DEF 0
-- Pendulum Scale: L3 / R3
-- Setcode: 0xc7, 0xf2
-- Scope: OCG / TCG
--
-- Effect Text:
-- Pendulum Scale = 3
-- [ Pendulum Effect ]
-- Once, while this card is in your Pendulum Zone: You can target 1 card in a Pendulum Zone; destroy
-- it.
-- ----------------------------------------
-- [ Monster Effect ]
-- "Luster Pendulum, the Dracoslayer" continues his journey to uncover the secrets of Dragon Alchemy,
-- believing it is the key to dispelling his curse and restoring his memory. His power continues to
-- grow... perhaps the same power used by the Dracofiends?
--[[ __CARD_HEADER_END__ ]]

--竜剣士マスターP
function c75195825.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(75195825,0))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_PZONE)
	e2:SetProperty(EFFECT_FLAG_NO_TURN_RESET+EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1)
	e2:SetTarget(c75195825.sctg)
	e2:SetOperation(c75195825.scop)
	c:RegisterEffect(e2)
end
function c75195825.sctg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_PZONE) end
	if chk==0 then return Duel.IsExistingTarget(nil,tp,LOCATION_PZONE,LOCATION_PZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,nil,tp,LOCATION_PZONE,LOCATION_PZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c75195825.scop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
