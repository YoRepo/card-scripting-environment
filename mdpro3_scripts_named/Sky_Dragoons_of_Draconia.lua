--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Sky Dragoons of Draconia  (ID: 68182934)
-- Type: Monster / Normal / Pendulum
-- Attribute: WIND
-- Race: Winged Beast
-- Level: 5
-- ATK 2200 | DEF 200
-- Pendulum Scale: L7 / R7
-- Scope: OCG / TCG
--
-- Effect Text:
-- Pendulum Scale = 7
-- [ Pendulum Effect ]
-- Once per turn, when a Normal Monster you control inflicts battle damage to your opponent: You can
-- target 1 card on the field; destroy it.
-- ----------------------------------------
-- [ Monster Effect ]
-- Rumored as being formed to invade the neutral, floating Sky-State of Cxulub, these mounted air
-- troops of the Draconia Empire have prompted bordering nations to strengthen their security.
--[[ __CARD_HEADER_END__ ]]

--ドラコニアの翼竜騎兵
function c68182934.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BATTLE_DAMAGE)
	e2:SetRange(LOCATION_PZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1)
	e2:SetCondition(c68182934.descon)
	e2:SetTarget(c68182934.destg)
	e2:SetOperation(c68182934.desop)
	c:RegisterEffect(e2)
end
function c68182934.descon(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	return ep~=tp and tc:IsControler(tp) and tc:IsType(TYPE_NORMAL)
end
function c68182934.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() end
	if chk==0 then return Duel.IsExistingTarget(aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c68182934.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
