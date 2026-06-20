--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 天雷之双风神 息那  (ID: 12197223)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Dragon
-- Level 9
-- ATK 2900 | DEF 1500
--
-- Effect Text:
-- 这个卡名的①的效果1回合只能使用1次。
-- ①：自己场上有风属性怪兽存在，对方把魔法·陷阱·怪兽的效果发动时才能发动。这张卡从手卡特殊召唤。那之后，那个对方的效果种类的以下效果适用。
-- ●怪兽：「天雷之双风神 息那」以外的场上的表侧表示怪兽全部回到手卡。
-- ●魔法·陷阱：场上的魔法·陷阱卡全部回到手卡。
-- ②：这张卡1回合只有1次不会被战斗破坏。
--[[ __CARD_HEADER_END__ ]]

--天雷ノ双風神 シーナ
local s,id,o=GetID()
function s.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_CHAINING)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,id)
	e1:SetCondition(s.spcon)
	e1:SetTarget(s.sptg)
	e1:SetOperation(s.spop)
	c:RegisterEffect(e1)
	--battle indes
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e2:SetCountLimit(1)
	e2:SetValue(s.valcon)
	c:RegisterEffect(e2)
end
function s.cfilter(c)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_WIND)
end
function s.spcon(e,tp,eg,ep,ev,re,r,rp)
	return rp==1-tp
		and Duel.IsExistingMatchingCard(s.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function s.thfilter(c,res)
	if c:IsCode(id) and c:IsLocation(LOCATION_MZONE) then return false end
	return (res and c:IsFaceup() and c:IsType(TYPE_MONSTER)
		or not res and c:IsType(TYPE_SPELL+TYPE_TRAP)) and c:IsAbleToHand()
end
function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local res=re:IsActiveType(TYPE_MONSTER)
	if chk==0 then
		return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
			and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
			and Duel.IsExistingMatchingCard(s.thfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil,res)
	end
	local g=Duel.GetMatchingGroup(s.thfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil,res)
	if res then
		e:SetLabel(1)
	else
		e:SetLabel(0)
	end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,g:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
end
function s.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToChain() and Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)~=0 then
		local res=false
		if e:GetLabel()==1 then res=true end
		local g=Duel.GetMatchingGroup(s.thfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil,res)
		if g:GetCount()>0 then
			Duel.BreakEffect()
			Duel.SendtoHand(g,nil,REASON_EFFECT)
		end
	end
end
function s.valcon(e,re,r,rp)
	return bit.band(r,REASON_BATTLE)~=0
end
