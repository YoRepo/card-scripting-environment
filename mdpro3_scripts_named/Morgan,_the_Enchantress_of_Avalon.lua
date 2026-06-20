--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 阿瓦隆的魔女 摩根  (ID: 24027078)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Spellcaster
-- Level 3
-- ATK 1300 | DEF 1600
--
-- Effect Text:
-- 这个卡名的效果1回合只能使用1次。
-- ①：自己场上有「圣骑士」怪兽以及「圣剑」装备魔法卡存在，对方把魔法·陷阱·怪兽的效果发动时，把这张卡从手卡送去墓地才能发动。选自己场上1张「圣剑」装备魔法卡破坏，那个发动无效。
--[[ __CARD_HEADER_END__ ]]

--アヴァロンの魔女モルガン
function c24027078.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(24027078,0))
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_CHAINING)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,24027078)
	e1:SetCondition(c24027078.condition)
	e1:SetCost(c24027078.cost)
	e1:SetTarget(c24027078.target)
	e1:SetOperation(c24027078.operation)
	c:RegisterEffect(e1)
end
function c24027078.filter1(c)
	return c:IsFaceup() and c:IsSetCard(0x107a)
end
function c24027078.filter2(c)
	return c:IsFaceup() and c:IsSetCard(0x207a) and c:IsType(TYPE_EQUIP)
end
function c24027078.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp and Duel.IsChainNegatable(ev)
		and Duel.IsExistingMatchingCard(c24027078.filter1,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsExistingMatchingCard(c24027078.filter2,tp,LOCATION_ONFIELD,0,1,nil)
end
function c24027078.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c24027078.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(c24027078.filter2,tp,LOCATION_ONFIELD,0,nil)
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c24027078.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectMatchingCard(tp,c24027078.filter2,tp,LOCATION_ONFIELD,0,1,1,nil)
	if #g>0 and Duel.Destroy(g,REASON_EFFECT)~=0 then
		Duel.NegateActivation(ev)
	end
end
