--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:46
-- Source DB: cards.cdb
-- Card: Karakuri Spider  (ID: 45688586)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Machine
-- Level: 2
-- ATK 400 | DEF 500
-- Setcode: 0x11
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card attacks a DARK monster, destroy the attack target after damage calculation.
--[[ __CARD_HEADER_END__ ]]

--カラクリ蜘蛛
function c45688586.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(45688586,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLED)
	e1:SetTarget(c45688586.target)
	e1:SetOperation(c45688586.operation)
	c:RegisterEffect(e1)
end
function c45688586.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	if chk==0 then return c==Duel.GetAttacker() and bc and bc:IsAttribute(ATTRIBUTE_DARK) end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,bc,1,0,0)
end
function c45688586.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	if bc:IsRelateToBattle() then
		Duel.Destroy(bc,REASON_EFFECT)
	end
end
