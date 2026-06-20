--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 魔轰神 亚申维尔  (ID: 12235475)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Fiend
-- Level 4
-- ATK 1600 | DEF 1200
-- Setcode: 53
--
-- Effect Text:
-- ①：这张卡进行战斗的那次伤害计算时1次，把1张手卡送去墓地才能发动。这张卡的攻击力只在那次伤害计算时上升600。
--[[ __CARD_HEADER_END__ ]]

--魔轟神アシェンヴェイル
function c12235475.initial_effect(c)
	--attack up
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(12235475,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e1:SetCondition(c12235475.con)
	e1:SetCost(c12235475.cost)
	e1:SetOperation(c12235475.op)
	c:RegisterEffect(e1)
end
function c12235475.con(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:GetFlagEffect(12235475)==0 and (Duel.GetAttacker()==c or Duel.GetAttackTarget()==c)
end
function c12235475.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToGraveAsCost,tp,LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToGraveAsCost,tp,LOCATION_HAND,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
	e:GetHandler():RegisterFlagEffect(12235475,RESET_PHASE+PHASE_DAMAGE_CAL,0,1)
end
function c12235475.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE_CAL)
	e1:SetValue(600)
	c:RegisterEffect(e1)
end
