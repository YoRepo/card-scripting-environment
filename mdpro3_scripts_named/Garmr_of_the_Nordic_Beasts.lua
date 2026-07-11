--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Garmr of the Nordic Beasts  (ID: 88283496)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Beast
-- Level: 4
-- ATK 800 | DEF 1900
-- Setcode: 0x6042
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card battles a Level 4 or lower monster, after damage calculation: You can return that
-- monster to the hand.
--[[ __CARD_HEADER_END__ ]]

--極星獣ガルム
function c88283496.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(88283496,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLED)
	e1:SetCondition(c88283496.retcon)
	e1:SetTarget(c88283496.rettg)
	e1:SetOperation(c88283496.retop)
	c:RegisterEffect(e1)
end
function c88283496.retcon(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	if tc==e:GetHandler() then tc=Duel.GetAttackTarget() end
	if not tc then return false end
	e:SetLabelObject(tc)
	return tc:IsLevelBelow(4) and not tc:IsStatus(STATUS_BATTLE_DESTROYED)
end
function c88283496.rettg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetLabelObject():IsAbleToHand() end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,e:GetLabelObject(),0,0,0)
end
function c88283496.retop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetLabelObject():IsRelateToBattle() then
		Duel.SendtoHand(e:GetLabelObject(),nil,REASON_EFFECT)
	end
end
