--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 蛛母蜘蛛  (ID: 17021204)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Insect
-- Level 6
-- ATK 2300 | DEF 1200
--
-- Effect Text:
-- 自己墓地存在的怪兽只有昆虫族的场合，这张卡可以把对方场上表侧守备表示存在的2只怪兽送去墓地，从手卡特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--マザー・スパイダー
function c17021204.initial_effect(c)
	--spsummon proc
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c17021204.spcon)
	e1:SetTarget(c17021204.sptg)
	e1:SetOperation(c17021204.spop)
	c:RegisterEffect(e1)
end
function c17021204.spfilter(c)
	return c:IsPosition(POS_FACEUP_DEFENSE) and c:IsAbleToGraveAsCost()
end
function c17021204.cfilter(c)
	return c:GetRace()~=RACE_INSECT
end
function c17021204.check(tp)
	local g=Duel.GetMatchingGroup(Card.IsType,tp,LOCATION_GRAVE,0,nil,TYPE_MONSTER)
	return g:GetCount()~=0 and not g:IsExists(c17021204.cfilter,1,nil)
end
function c17021204.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c17021204.spfilter,c:GetControler(),0,LOCATION_MZONE,2,nil)
		and c17021204.check(c:GetControler())
end
function c17021204.sptg(e,tp,eg,ep,ev,re,r,rp,chk,c)
	local g=Duel.GetMatchingGroup(c17021204.spfilter,tp,0,LOCATION_MZONE,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local sg=g:CancelableSelect(tp,2,2,nil)
	if sg then
		sg:KeepAlive()
		e:SetLabelObject(sg)
		return true
	else return false end
end
function c17021204.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=e:GetLabelObject()
	Duel.SendtoGrave(g,REASON_SPSUMMON)
	g:DeleteGroup()
end
