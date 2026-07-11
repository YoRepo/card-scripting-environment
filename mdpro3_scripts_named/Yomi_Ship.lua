--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:48
-- Source DB: cards.cdb
-- Card: Yomi Ship  (ID: 51534754)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Aqua
-- Level: 3
-- ATK 800 | DEF 1400
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card is destroyed by battle and sent to the GY: Destroy the monster that destroyed this
-- card.
--[[ __CARD_HEADER_END__ ]]

--黄泉へ渡る船
function c51534754.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(51534754,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCondition(c51534754.condition)
	e1:SetTarget(c51534754.target)
	e1:SetOperation(c51534754.operation)
	c:RegisterEffect(e1)
end
function c51534754.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_GRAVE) and e:GetHandler():IsReason(REASON_BATTLE)
		and e:GetHandler():GetReasonCard():IsRelateToBattle()
end
function c51534754.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local rc=e:GetHandler():GetReasonCard()
	Duel.SetTargetCard(rc)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,rc,1,0,0)
end
function c51534754.operation(e,tp,eg,ep,ev,re,r,rp)
	local rc=Duel.GetFirstTarget()
	if rc:IsRelateToEffect(e) then
		Duel.Destroy(rc,REASON_EFFECT)
	end
end
