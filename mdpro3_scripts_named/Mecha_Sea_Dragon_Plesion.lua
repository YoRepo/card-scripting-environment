--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 机海龙 蛇颈龙  (ID: 40160226)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Machine
-- Level 5
-- ATK 2300 | DEF 1800
--
-- Effect Text:
-- 自己场上有海龙族怪兽存在的场合，这张卡可以不用解放作召唤。1回合1次，可以通过把自己场上1只水属性怪兽解放，选择对方场上表侧表示存在的1张卡破坏。
--[[ __CARD_HEADER_END__ ]]

--機海竜プレシオン
function c40160226.initial_effect(c)
	--summon with no tribute
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(40160226,0))
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SUMMON_PROC)
	e1:SetCondition(c40160226.ntcon)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(40160226,1))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCost(c40160226.cost)
	e2:SetTarget(c40160226.target)
	e2:SetOperation(c40160226.operation)
	c:RegisterEffect(e2)
end
function c40160226.ntfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_SEASERPENT)
end
function c40160226.ntcon(e,c,minc)
	if c==nil then return true end
	return minc==0 and c:IsLevelAbove(5) and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c40160226.ntfilter,c:GetControler(),LOCATION_MZONE,0,1,nil)
end
function c40160226.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,Card.IsAttribute,1,nil,ATTRIBUTE_WATER) end
	local g=Duel.SelectReleaseGroup(tp,Card.IsAttribute,1,1,nil,ATTRIBUTE_WATER)
	Duel.Release(g,REASON_COST)
end
function c40160226.filter(c)
	return c:IsFaceup()
end
function c40160226.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(1-tp) and c40160226.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c40160226.filter,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c40160226.filter,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c40160226.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
