--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 雷电金刚  (ID: 93151201)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Beast
-- Level 4
-- ATK 1800 | DEF 1000
--
-- Effect Text:
-- 这张卡给与对方基本分战斗伤害时，把自己场上表侧表示存在的光属性怪兽数量的卡从对方卡组上面送去墓地。
--[[ __CARD_HEADER_END__ ]]

--ボルテック・コング
function c93151201.initial_effect(c)
	--discard deck
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(93151201,0))
	e2:SetCategory(CATEGORY_DECKDES)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_BATTLE_DAMAGE)
	e2:SetCondition(c93151201.condition)
	e2:SetTarget(c93151201.target)
	e2:SetOperation(c93151201.operation)
	c:RegisterEffect(e2)
end
function c93151201.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp
end
function c93151201.filter(c)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_LIGHT)
end
function c93151201.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local ct=Duel.GetMatchingGroupCount(c93151201.filter,tp,LOCATION_MZONE,0,nil)
	Duel.SetOperationInfo(0,CATEGORY_DECKDES,0,0,1-tp,ct)
end
function c93151201.operation(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetMatchingGroupCount(c93151201.filter,tp,LOCATION_MZONE,0,nil)
	Duel.DiscardDeck(1-tp,ct,REASON_EFFECT)
end
