--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 白银之迷宫城  (ID: 33407125)
-- Type: Spell / Counter
-- ATK 0 | DEF 0
-- Setcode: 382
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：盖放的「拉比林斯迷宫欢迎」通常陷阱卡由自己发动的场合，可以给那个效果加上以下效果。
-- ●选场上1张卡破坏。
-- ②：自己把「拉比林斯迷宫」卡以外的通常陷阱卡发动的场合才能发动。从自己的手卡·墓地选1只恶魔族怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--白銀の迷宮城
function c33407125.initial_effect(c)
	--Activate
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_ACTIVATE)
	e0:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e0)
	--add effect
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(33407125)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetRange(LOCATION_FZONE)
	e1:SetTargetRange(1,0)
	e1:SetCountLimit(1,33407125)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(33407125,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_CHAINING)
	e2:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_PLAYER_TARGET)
	e2:SetRange(LOCATION_FZONE)
	e2:SetCountLimit(1,33407126)
	e2:SetCondition(c33407125.spcon)
	e2:SetTarget(c33407125.sptg)
	e2:SetOperation(c33407125.spop)
	c:RegisterEffect(e2)
end
function c33407125.spcon(e,tp,eg,ep,ev,re,r,rp)
	local rc=re:GetHandler()
	return rp==tp and not rc:IsSetCard(0x17e) and rc:GetType()==TYPE_TRAP and re:IsHasType(EFFECT_TYPE_ACTIVATE)
end
function c33407125.spfilter(c,e,tp)
	return c:IsRace(RACE_FIEND) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c33407125.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c33407125.spfilter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_GRAVE)
end
function c33407125.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c33407125.spfilter),tp,LOCATION_HAND+LOCATION_GRAVE,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
