--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Hyper Hammerhead  (ID: 2671330)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Dinosaur
-- Level: 4
-- ATK 1500 | DEF 1200
-- Scope: OCG / TCG
--
-- Effect Text:
-- At the end of the Damage Step, if an opponent's monster that battled this card is not destroyed:
-- Return that opponent's monster to the hand.
--[[ __CARD_HEADER_END__ ]]

--ハイパーハンマーヘッド
function c2671330.initial_effect(c)
	--return hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(2671330,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_DAMAGE_STEP_END)
	e1:SetCondition(c2671330.retcon)
	e1:SetTarget(c2671330.rettg)
	e1:SetOperation(c2671330.retop)
	c:RegisterEffect(e1)
end
function c2671330.retcon(e,tp,eg,ep,ev,re,r,rp)
	local t=e:GetHandler():GetBattleTarget()
	e:SetLabelObject(t)
	return aux.dsercon(e,tp,eg,ep,ev,re,r,rp) and t and t:IsRelateToBattle()
end
function c2671330.rettg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,e:GetLabelObject(),1,0,0)
end
function c2671330.retop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetLabelObject():IsRelateToBattle() then
		Duel.SendtoHand(e:GetLabelObject(),nil,REASON_EFFECT)
	end
end
