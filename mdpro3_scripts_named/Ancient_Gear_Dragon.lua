--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 古代的机械龙  (ID: 75892194)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Machine
-- Level 5
-- ATK 500 | DEF 2500
-- Setcode: 7
--
-- Effect Text:
-- 这张卡不能特殊召唤。这个卡名的②的效果1回合只能使用1次。
-- ①：自己场上的怪兽不存在的场合或者只有机械族·地属性怪兽的场合，这张卡可以不用解放作召唤。
-- ②：对方把魔法·陷阱卡的效果发动时，把自己的手卡·场上（表侧表示）1只机械族怪兽或者卡组1只「古代的机械巨人」送去墓地才能发动。那个效果无效。
--[[ __CARD_HEADER_END__ ]]

--古代の機械竜
local s,id,o=GetID()
function s.initial_effect(c)
	aux.AddCodeList(c,83104731)
	--
	local e0=Effect.CreateEffect(c)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetCode(EFFECT_SPSUMMON_CONDITION)
	e0:SetValue(aux.FALSE)
	c:RegisterEffect(e0)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SUMMON_PROC)
	e1:SetCondition(s.ntcon)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,1))
	e2:SetCategory(CATEGORY_DISABLE)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_CHAINING)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,id+o)
	e2:SetCondition(s.discon)
	e2:SetCost(s.discost)
	e2:SetTarget(s.distg)
	e2:SetOperation(s.disop)
	c:RegisterEffect(e2)
end
function s.cfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_MACHINE) and c:IsAttribute(ATTRIBUTE_EARTH)
end
function s.ntcon(e,c,minc)
	if c==nil then return true end
	local tp=c:GetControler()
	return minc==0 and c:IsLevelAbove(5) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and (Duel.IsExistingMatchingCard(s.cfilter,tp,LOCATION_MZONE,0,1,nil)
			and not Duel.IsExistingMatchingCard(aux.NOT(s.cfilter),tp,LOCATION_MZONE,0,1,nil)
			or not Duel.IsExistingMatchingCard(nil,tp,LOCATION_MZONE,0,1,nil))
end
function s.discon(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) then return false end
	return ep==1-tp
		and re:IsActiveType(TYPE_SPELL+TYPE_TRAP) and Duel.IsChainNegatable(ev)
end
function s.cgfilter(c)
	return (c:IsRace(RACE_MACHINE) and c:IsLocation(LOCATION_HAND+LOCATION_MZONE)
		or c:IsCode(83104731) and c:IsLocation(LOCATION_DECK))
		and c:IsAbleToGraveAsCost() and c:IsFaceupEx()
end
function s.discost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.cgfilter,tp,LOCATION_HAND+LOCATION_MZONE+LOCATION_DECK,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,s.cgfilter,tp,LOCATION_HAND+LOCATION_MZONE+LOCATION_DECK,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function s.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,eg,1,0,0)
end
function s.disop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateEffect(ev)
end
