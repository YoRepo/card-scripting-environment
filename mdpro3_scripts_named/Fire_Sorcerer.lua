--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 火焰巫师  (ID: 27132350)
-- Type: Monster / Effect / Toon
-- Attribute: FIRE
-- Race: Spellcaster
-- Level 4
-- ATK 1000 | DEF 1500
--
-- Effect Text:
-- 反转：自己的手卡随机选2张除外。对方受到800分的伤害。
--[[ __CARD_HEADER_END__ ]]

--ファイヤーソーサラー
function c27132350.initial_effect(c)
	--flip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(27132350,0))
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetCost(c27132350.cost)
	e1:SetTarget(c27132350.target)
	e1:SetOperation(c27132350.operation)
	c:RegisterEffect(e1)
end
function c27132350.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToRemoveAsCost,tp,LOCATION_HAND,0,2,nil) end
	local g=Duel.GetMatchingGroup(Card.IsAbleToRemoveAsCost,tp,LOCATION_HAND,0,nil)
	local rg=g:RandomSelect(tp,2)
	Duel.Remove(rg,POS_FACEUP,REASON_COST)
end
function c27132350.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(800)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,800)
end
function c27132350.operation(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
