--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Rescueroid  (ID: 24311595)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Machine
-- Level: 6
-- ATK 1600 | DEF 1800
-- Setcode: 0x16
-- Scope: OCG / TCG
--
-- Effect Text:
-- When a "roid" monster you control is destroyed by battle and sent to the GY: You can return that
-- monster to the hand.
-- You must control this face-up card on the field to activate and to resolve this effect.
--[[ __CARD_HEADER_END__ ]]

--レスキューロイド
function c24311595.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(24311595,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetTarget(c24311595.target)
	e1:SetOperation(c24311595.activate)
	c:RegisterEffect(e1)
end
function c24311595.filter(c,tp)
	return c:IsLocation(LOCATION_GRAVE) and c:IsReason(REASON_BATTLE) and c:IsPreviousControler(tp)
		and c:IsSetCard(0x16) and c:IsAbleToHand()
end
function c24311595.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local g=eg:Filter(c24311595.filter,nil,tp)
		e:SetLabelObject(g:GetFirst())
		return g:GetCount()~=0
	end
	Duel.SetTargetCard(e:GetLabelObject())
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,e:GetLabelObject(),1,0,0)
end
function c24311595.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if e:GetHandler():IsRelateToEffect(e) and tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end
