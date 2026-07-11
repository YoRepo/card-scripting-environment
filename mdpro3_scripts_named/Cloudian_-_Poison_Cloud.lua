--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Cloudian - Poison Cloud  (ID: 83982270)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Fiend
-- Level: 3
-- ATK 0 | DEF 1000
-- Setcode: 0x18
-- Scope: OCG / TCG
--
-- Effect Text:
-- When this card is destroyed by battle and sent to the Graveyard, if it was face-up at the start of
-- the Damage Step: Destroy the monster that destroyed it, and if you do, inflict 800 damage to your
-- opponent.
--[[ __CARD_HEADER_END__ ]]

--雲魔物－ポイズン・クラウド
function c83982270.initial_effect(c)
	--destroy&damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(83982270,0))
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCondition(c83982270.condition)
	e1:SetTarget(c83982270.target)
	e1:SetOperation(c83982270.operation)
	c:RegisterEffect(e1)
end
function c83982270.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsLocation(LOCATION_GRAVE) and c:IsReason(REASON_BATTLE) and c:IsPreviousPosition(POS_FACEUP)
end
function c83982270.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,e:GetHandler():GetBattleTarget(),1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,800)
end
function c83982270.operation(e,tp,eg,ep,ev,re,r,rp)
	local bc=e:GetHandler():GetBattleTarget()
	if bc:IsFaceup() and bc:IsRelateToBattle() and Duel.Destroy(bc,REASON_EFFECT)~=0 then
		Duel.Damage(1-tp,800,REASON_EFFECT)
	end
end
