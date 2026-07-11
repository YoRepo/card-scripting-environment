--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Divine Knight Ishzark  (ID: 57902462)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Warrior
-- Level: 6
-- ATK 2300 | DEF 1800
-- Scope: OCG / TCG
--
-- Effect Text:
-- After damage calculation, when this card destroys a monster by battle: Banish that monster.
--[[ __CARD_HEADER_END__ ]]

--聖導騎士イシュザーク
function c57902462.initial_effect(c)
	--remove
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(57902462,0))
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLED)
	e1:SetCondition(c57902462.condition)
	e1:SetTarget(c57902462.target)
	e1:SetOperation(c57902462.operation)
	c:RegisterEffect(e1)
end
function c57902462.condition(e,tp,eg,ep,ev,re,r,rp)
	local bc=e:GetHandler():GetBattleTarget()
	return bc and bc:IsStatus(STATUS_BATTLE_DESTROYED)
end
function c57902462.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local bc=e:GetHandler():GetBattleTarget()
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,bc,1,0,0)
end
function c57902462.operation(e,tp,eg,ep,ev,re,r,rp)
	local bc=e:GetHandler():GetBattleTarget()
	if bc:IsRelateToBattle() then
		Duel.Remove(bc,POS_FACEUP,REASON_EFFECT)
	end
end
